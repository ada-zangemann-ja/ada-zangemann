#!/usr/bin/env bash

# SPDX-FileCopyrightText: 2024 Nico Rikken <nico.rikken@fsfe.org>
#
# SPDX-License-Identifier: CC0-1.0

# Uncomment to help debugging this script
# set -o xtrace

# Helper script to compare images in the book folder with the previously
# generated images in the compare-base folder. The script outputs images in the
# compare-results folder, including a .metrics file describing the number of
# alternate pixels and a .status file storing the exit state of the ImageMagick
# compare command.

if ! [[ -x "$(command -v compare)" ]] ; then
    echo "Ensure that ImageMagick is installed." >&2
    exit 1
fi

filename_pattern='^([a-zA-Z]+-[a-z]+)-([0-9]+)\.png$'

# Ensure output directory exists
mkdir -p compare-result

for filename in "${@}" ; do

    base=$(basename $filename)

    if [[ ! ${base} =~ ${filename_pattern} ]] ; then
        echo "Filename ${base} didn't match expected pattern. Skipping." >&2
        continue
    fi

    # Run the compare command to generate a comparison image and store the
    # metrics in a .metrics file
    compare "${base}" "compare-base/${base}" -verbose -metric AE "compare-result/${base}" &> compare-result/${base/.png/.metrics}

    # Save the exit status in a .status file
    echo "$?" > compare-result/${base/.png/.status}

done
