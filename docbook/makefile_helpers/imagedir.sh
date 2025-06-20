#!/usr/bin/env bash

# SPDX-FileCopyrightText: 2025 Nico Rikken <nico.rikken@fsfe.org>
#
# SPDX-License-Identifier: CC0-1.0

# Uncomment to help debugging this script
# set -o xtrace

LANG="$1"

cd "$(dirname "${0}")"  # Operate relative to this script

DEST="../build/${LANG}/images/illustrations"
mkdir -p ${DEST}

cd "${DEST}"

SRC="../../../../images/illustrations/"

case ${LANG} in
    # NOTE: edgecases and LTR language can be handled here
    *)
        # First link left-to-right images as fallback: ada-p40-41.ltr.png > ada-p40-41.png
        find "${SRC}" -iname "*.ltr.png"     -exec bash -c "ln -f -s {} \$( file=\$(basename {} ); echo \"\${file/.ltr./.}\")" \;
        # Override language-specific images: ada-p40-41.de.png > ada-p40-41.png
        find "${SRC}" -iname "*.${LANG}.png" -exec bash -c "ln -f -s {} \$( file=\$(basename {} ); echo \"\${file/.${LANG}./.}\")" \;
        ;;
esac
