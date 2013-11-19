import sys
import glob
import subprocess
import argparse
import os

""" Usage: python ./run.py [input dir] [output dir]"""

parser = argparse.ArgumentParser(description='Make awesome graphs')

parser.add_argument('--i', default=".", help="input directory containing the cachegrind files")
parser.add_argument('--o', default=".", help="output directory to generate the diagram into")

args = parser.parse_args()

if args.o == ".":
	args.o = args.i

if not os.path.exists(args.o):
	os.makedirs(args.o)

subprocess.call(["Rscript", "./visualization/all.r", args.i, args.o])