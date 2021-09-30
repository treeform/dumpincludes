version     = "0.0.1"
author      = "Andre von Houck"
description = "See where your exe size comes from."
license     = "MIT"

srcDir = "src"

bin = @["dumpincludes"]

requires "nim >= 1.2.2"
requires "cligen >= 1.3.2"
