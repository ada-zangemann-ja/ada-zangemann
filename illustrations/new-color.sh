#!/usr/bin/env bash

# SPDX-FileCopyrightText: 2024 Nico Rikken <nico.rikken@fsfe.org>
#
# SPDX-License-Identifier: CC0-1.0

# Uncomment to help debugging this script
# set -o xtrace

cd "$(dirname "${0}")"  # Operate in the illustrations directory

if ! [[ -x "$(command -v convert)" ]] ; then
    echo "Ensure that ImageMagick is installed so the 'convert' command is available." >&2
    exit 1
fi

if [[ -z ${1} ]] || [[ -n ${3} ]] ; then
    echo "This script will generate the transparent and opaque capitals."
    echo "Provide the png filename that needs to be created." >&2
    echo "Usage:   ./new-color.sh [base-character]-[color-name].png" >&2
    echo "Example: ./new-color.sh A-red2.png" >&2
    exit 1
fi

filename_pattern='^([a-zA-Z]+)-([a-z0-9]+)\.png$'

if [[ ${1} =~ $filename_pattern ]] ; then
    dest_filename="${1}"
    capital="${BASH_REMATCH[1]}"
    color="${BASH_REMATCH[2]}"
else
    echo "Filename didn't match expected pattern." >&2
    exit 1
fi

# Look for starting point in the Capitals_transparent directory.
src_filename="$(ls -t "Capitals_transparent/${capital}"-*.png | tail -n 1)" # Oldest file for this capital

if [[ -z ${src_filename} ]] ; then
    echo "Couldn't find the base character, ensure it is present in the Capitals_transparent directory" >&2
    exit 1
fi

case ${color} in
    brown    ) fg_color="#b79b55" bg_color="#ffffff";;
    cyan     ) fg_color="#5cb2d4" bg_color="#ffffff";;
    fucsia   ) fg_color="#d70071" bg_color="#ffffff";;
    green    ) fg_color="#6cba81" bg_color="#ffffff";;
    lightcyan) fg_color="#93ccd3" bg_color="#ffffff";;
    olive    ) fg_color="#bcc85a" bg_color="#ffffff";;
    pink     ) fg_color="#f5b6cd" bg_color="#ffffff";;
    red1     ) fg_color="#e75156" bg_color="#fdf08d";;
    red2     ) fg_color="#e64f55" bg_color="#ffffff";;
    red3     ) fg_color="#e74c5b" bg_color="#ffffff";;
    violet   ) fg_color="#81579a" bg_color="#ffffff";;
    yellow   ) fg_color="#f8d66a" bg_color="#ffffff";;
    yellow2  ) fg_color="#fddd66" bg_color="#71aaa4";;
esac

if [[ -z ${fg_color} ]] ; then
    echo "Unable to match color to known colors." >&2
    exit 1
fi

convert -fill "${fg_color}" -colorize 100,100,100 "${src_filename}" "Capitals_transparent/${dest_filename}"
convert -fill "${fg_color}" -colorize 100,100,100 -background "${bg_color}" -layers flatten "${src_filename}" "Capitals_opaque/${dest_filename}"

src_license="${src_filename}.license"

if ! [[ -f ${src_license} ]] ; then
    echo "Couldn't copy '.license' file because source file doesn't have one." >&2
    echo "Please ensure the source file and newly created file include copyright and license information." >&2
    exit 0
else
    cp "${src_license}" "Capitals_transparent/${dest_filename}.license"
    cp "${src_license}" "Capitals_opaque/${dest_filename}.license"
fi
