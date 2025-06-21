#!/usr/bin/env bash

# SPDX-FileCopyrightText: 2022 Luca Bonissi
# SPDX-FileCopyrightText: 2025 Nico Rikken
#
# SPDX-License-Identifier: CC0-1.0

lang=$1

if [ "$lang" = "" ]; then
  echo "Usage: $0 <lang_code> (example: en for English)"
  exit
fi

mkdir -p $lang
../scripts/to_reading.pl ../texts/Ada_Zangemann-$lang.txt | ../scripts/wrapada.pl  > $lang/ada-zangemann-reading.$lang.txt ; ../scripts/to_reading.pl ../texts/Ada_Zangemann-$lang.txt 1 | ../scripts/wrapada.pl  > $lang/ada-zangemann.$lang.txt

