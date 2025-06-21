#!/usr/bin/env bash

# SPDX-FileCopyrightText: 2024 Nico Rikken <nico.rikken@fsfe.org>
#
# SPDX-License-Identifier: CC0-1.0

# Uncomment to help debugging this script
# set -o xtrace

cd "$(dirname "${0}")"  # Operate relative to this script

if [[ -z ${1} ]] || [[ -n ${3} ]] ; then
    echo "This script will create a new directory structure for a language." >&2
    echo "Optionally a source language can be provided to start from an existing translation." >&2
    echo "Provide the new language to create in language[_territory] pattern like en, pt_PT" >&2
    echo "Usage:   ./new_language.sh <new-language> <source-language>" >&2
    echo "Example: ./new_language.sh da" >&2
    echo "Example: ./new_language.sh da pt_PT" >&2
    exit 1
fi

language_pattern='^([a-z]+)(_[A-Z]+)?$'

if [[ ${1} =~ $language_pattern ]] ; then
    new_lang="${1}"
else
    echo "Destination language didn't match language[_territory] pattern like en, pt_PT" >&2
    exit 1
fi

if [[ -n ${2} ]] && [[ ${2} =~ $language_pattern ]] ; then
    src_lang="${2}"
else
    echo "Source language didn't match language[_territory] pattern like en, pt_PT" >&2
    exit 1
fi

text_file="../texts/Ada_Zangemann-${new_lang}.txt"
capitals_dir="../illustrations/Capitals-${new_lang}"
illustrations_dir="../illustrations/${new_lang}"
book_dir="../Book/${new_lang}"
presentations_dir="../Presentations/${new_lang}"

# NOTE: symbolic links are resolved relative to the link location

if [[ -n ${src_lang} ]] ; then
    # Copy from existing language
    cp "../texts/Ada_Zangemann-${src_lang}.txt" "${text_file}"
    cp -r "../illustrations/Capitals-${src_lang}/." "${capitals_dir}"
    cp -r "../illustrations/${src_lang}/." "${illustrations_dir}"
    cp -r "../Book/${src_lang}/." "${book_dir}"
    cp -r "../Presentations/${src_lang}/." "${presentations_dir}"
    # Remove links which need to be replaced
    rm "${book_dir}/Ada_Zangemann-${src_lang}.txt"
    rm "${book_dir}/Capitals"
    rm "${book_dir}/images"
    rm "${presentations_dir}/images"
else
    # Create an empty structure
    touch "${text_file}"
    mkdir -p "${capitals_dir}"
    mkdir -p "${illustrations_dir}"
    mkdir -p "${book_dir}"
    mkdir -p "${presentations_dir}"
    # Create generic links
    ln -s ../../scripts/Makefile "${book_dir}/Makefile"
    ln -s ../../scripts/to_reading.pl "${book_dir}/to_reading.pl"
    ln -s ../../scripts/to_scribus.pl "${book_dir}/to_scribus.pl"
    ln -s ../template-coverhard.sla "${book_dir}/template-coverhard.sla"
    ln -s ../template-coversoft.sla "${book_dir}/template-coversoft.sla"
    ln -s ../template-print.sla "${book_dir}/template-print.sla"
    ln -s ../template-screen.sla "${book_dir}/template-screen.sla"
fi

# Create links specific for the language
ln -s "../../texts/Ada_Zangemann-${new_lang}.txt" "${book_dir}/Ada_Zangemann-${new_lang}.txt"
ln -s "../../illustrations/Capitals-${new_lang}" "${book_dir}/Capitals"
ln -s "../../illustrations/${new_lang}" "${book_dir}/images"
ln -s "../../illustrations/${new_lang}" "${presentations_dir}/images"

echo "Done creating the file structure. See documentation for further advice." >&2
