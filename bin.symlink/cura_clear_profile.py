#!/usr/bin/env python

import sys
from optparse import OptionParser
import ConfigParser

USAGE = "Usage: %prog [-o|--out] <profile_file>"

PRESERVE_OPTIONS = [
    "print_temperature",
    "print_temperature2",
    "print_temperature3",
    "print_temperature4",
    "print_bed_temperature",
    "filament_diameter",
    "filament_diameter2",
    "filament_diameter3",
    "filament_diameter4",
    "filament_flow",
    "cool_min_layer_time",
    "fan_enabled",
    "fan_full_height",
    "fan_speed",
    "fan_speed_max",
    "cool_min_feedrate",
    "cool_head_lift"
]

if __name__ == "__main__":
    parser = OptionParser(usage=USAGE)
    parser.add_option("-o", "--out", dest="outfile", default="stdout", help="Filename to output to. [default: %default]", metavar="OUTFILE")
    parser.add_option("-i", "--inplace", action="store_true", dest="inplace", default=False, help="Modify input file in place")

    (options, args) = parser.parse_args()

    if len(args) != 1:
        parser.print_help()
        sys.exit(1)

    config = ConfigParser.ConfigParser()
    cleanconfig = ConfigParser.ConfigParser()
    cleanconfig.add_section("profile")

    config.read(args[0])

    F = sys.stdout

    if options.inplace:
        F = open(args[0], "w")
    elif options.outfile != "stdout":
        F = open(options.outfile, "w")

    if not "profile" in config.sections():
        print "%s is not a valid Cura configuration file." % args[0]
        F.close()
        sys.exit(1)

    for option in config.options("profile"):
        if option in PRESERVE_OPTIONS:
            cleanconfig.set("profile", option, config.get("profile", option))

    cleanconfig.write(F)
    F.close()

