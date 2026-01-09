# SPDX-FileCopyrightText: 2026 Nico Rikken <nico.rikken@fsfe.org>
#
# SPDX-License-Identifier: CC0-1.0

import sys
from srt_equalizer import srt_equalizer

input_srt_file = sys.argv[1]
equalized_srt_file = sys.argv[2]

print("Input:", input_srt_file)
print("Output:", equalized_srt_file)

srt_equalizer.equalize_srt_file(input_srt_file, equalized_srt_file, 42, method='halving')
