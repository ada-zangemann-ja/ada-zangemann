#!/usr/bin/env bash

# SPDX-FileCopyrightText: 2024 Nico Rikken <nico.rikken@fsfe.org>
#
# SPDX-License-Identifier: CC0-1.0

# Uncomment to help debugging this script
# set -o xtrace

# Create empty summary file
> compare-result/differences.log

# Collect status information
for file in compare-result/*.status ; do
    status=$(<"${file}")
    if [[ ${status} -ne 0 ]] ; then
        echo "${file/.status/.png}" >> compare-result/differences.log
    fi
done

# Print summary and return corresponding exit code
diff_count=$(wc -l compare-result/differences.log | cut -f1 -d ' ')

if [[ $diff_count -gt 0 ]] ; then
    echo "Found $diff_count images with differences:"
    cat compare-result/differences.log
    exit 1
else
    echo "No differences found."
    exit 0
fi
