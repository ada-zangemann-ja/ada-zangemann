#!/usr/bin/env bash

# SPDX-FileCopyrightText: 2024 Nico Rikken <nico.rikken@fsfe.org>
# SPDX-FileCopyrightText: 2024 Petter Reinholdtsen <pere@hungry.com>
#
# SPDX-License-Identifier: CC0-1.0

# Uncomment to help debugging this script
# set -o xtrace

scripts_path="$(dirname "${0}")"

if [[ -z ${1} ]] || [[ -n ${2} ]] ; then
    echo "This script will generate a pdf from the provided Scribus file." >&2
    echo "Provide the input scribus filename as argument." >&2
    echo "The resulting pdf file will have the same name and will overwrite existing files." >&2
    echo "Usage: ./to_pdf.sh fr-screen.sla" >&2
    exit 1
fi

# TODO: Hide GUI using xvfb-run or work-in-progress https://gitlab.freedesktop.org/ofourdan/xwayland-run

scribus --no-splash -g -py "${scripts_path}/scribus_pdf.py" -- "${1}"
