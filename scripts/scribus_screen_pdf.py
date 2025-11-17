# SPDX-FileCopyrightText: 2024-2025 Nico Rikken <nico.rikken@fsfe.org>
#
# SPDX-License-Identifier: CC0-1.0

"""Scribus_pdf script

This script is to be run in Scribus and automates the pdf output.

It can be called from the commandline:

scribus -g -py scribus_pdf.py -- en-screen.sla
"""

from pathlib import Path

import scribus

if scribus.haveDoc():
    sla_path = scribus.getDocName()
    pdf_path = Path(sla_path).with_suffix(".screen.pdf")
    print(f"Writing to: {pdf_path}")
    pdf = scribus.PDFfile()
    pdf.useDocBleeds = False
    pdf.cropMarks = False
    pdf.file = str(pdf_path)
    pdf.save()
else:
    print(f"Couldn't load Scribus file. Did you provide it as an argument?")
