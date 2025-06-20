#!/usr/bin/env bash

# SPDX-FileCopyrightText: 2024 Nico Rikken <nico.rikken@fsfe.org>
#
# SPDX-License-Identifier: CC0-1.0

# Uncomment to help debugging this script
# set -o xtrace

# Helper script to create a base set of images to compare against. Additionally
# some information some information on the repository state is stored as a
# reminder where the compare-base originates from.

# Ensure output directory exists
mkdir -p compare-base

# Copy provided filenames to the compare-base folder.
for filename in "$@" ; do
    cp "$filename" compare-base/
done

# Store repository information
date > compare-base/creation.log
git log -n 1 >> compare-base/creation.log
git status >> compare-base/creation.log
