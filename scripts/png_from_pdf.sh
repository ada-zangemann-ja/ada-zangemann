#!/usr/bin/env bash

# SPDX-FileCopyrightText: 2024 Nico Rikken <nico.rikken@fsfe.org>
#
# SPDX-License-Identifier: CC0-1.0

# Uncomment to help debugging this script
# set -o xtrace

PPI=150

if ! [[ -x "$(command -v pdftoppm)" ]] ; then
    echo "Ensure that pdftoppm is installed." >&2
    exit 1
fi

if [[ -z ${1} ]] || [[ -n ${3} ]] ; then
    echo "This script will generate a .png file from one of the pages of a pdf."
    echo "Provide the png filename that needs to be created." >&2
    echo "Usage:   ./png-from-pdf.sh [language]-[variant]-[page-number].png" >&2
    echo "Example: ./png-from-pdf.sh en-print-08.png" >&2
    exit 1
fi

filename_pattern='^([a-zA-Z_]+-[a-z]+)-([0-9]+)\.png$'

if [[ ${1} =~ $filename_pattern ]] ; then
    dest_filename="${1}"
    base="${BASH_REMATCH[1]}"
    pdf="${base}.pdf"
    page="${BASH_REMATCH[2]}"
else
    echo "Filename didn't match expected pattern." >&2
    exit 1
fi

if [[ ! -f ${pdf} ]] ; then
    echo "Couldn't find the pdf file \"${pdf}\", to generate this .png from. Generate the .pdf file and check the provided filename." >&2
    exit 1
fi

pdftoppm "${pdf}" "${base}" -png -rx "${PPI}" -ry "${PPI}" -f "${page}" -l "${page}"
