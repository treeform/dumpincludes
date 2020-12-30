import osproc, strutils, tables, os, cligen, strformat

const objDumpPath = "objdump"

proc dots(n: int): string =
  for i in 0 ..< n:
    result.add(".")

proc fmti(n: int, align = 0): string =
  let s = $n
  var s2 = ""
  for i, c in s:
    if i != 0 and (s.len - i) mod 3 == 0:
      s2.add ','
    s2.add(c)
  while (result.len + s2.len + 1) < align:
    result.add(".")
  if (result.len + s2.len) < align:
    result.add(" ")
  result.add(s2)

proc main(file: string) =
  if not fileExists(file):
    raise newException(ValueError, "File " & file & " does not exist")

  let (sectionsOutput, _) = execCmdEx(objDumpPath & " -h " & file)

  var
    textSize = 0
    dataSize = 0
    debugSize = 0
  for line in sectionsOutput.split("\n"):
    if " ." in line:
      let arr = line.splitWhitespace()
      if arr[1] == ".text":
        textSize += parseHexInt(arr[2])
      elif arr[1].startsWith(".debug"):
        debugSize += parseHexInt(arr[2])
      else:
        dataSize += parseHexInt(arr[2])

  let (output, _) = execCmdEx(objDumpPath & " -dl " & file)

  #writeFile("output.txt", output)
  #let output = readFile("output.txt")
  #let fileSize = readFile(file).len

  var
    path: string
    startAddr = 0
    endAddr = 0

    moduleCounts: CountTable[string]

  for line in output.split("\n"):
    if not line.startsWith("  "):
      if path.len > 0:
        let bytes = endAddr - startAddr
        var path = path.rsplit(":", 1)[0]
        #for std
        #if "lib/system" in path:
        #  path = path[path.find("lib/system") .. ^1]
        let moduleName = path #.lastPathPart
        if moduleName.splitFile().ext.len > 0 and not moduleName.endsWith(")") and not moduleName.endsWith(">"):
          moduleCounts.inc(moduleName, bytes)
      path = ""
      if ":" in line: # and (".nim" in line or ".c" in line or ".cpp" in line):
        path = line
      startAddr = 0
      endAddr = 0
    else:
      try:
        let value = parseHexInt(line.split(":", 1)[0].strip())
        if startAddr == 0:
          startAddr = value
        endAddr = value
      except ValueError:
        discard

  var w = 40
  for moduleName, bytes in moduleCounts.pairs:
    w = max(w, moduleName.len + 1)

  echo "Sections:"
  echo &"  code {fmti(textSize, w+8-4)} bytes"
  echo &"  data {fmti(dataSize, w+8-4)} bytes"
  echo &"  debug {fmti(debugSize, w+8-5)} bytes"

  echo "Imports:"
  moduleCounts.sort()
  var accountedFor = 0
  for moduleName, bytes in moduleCounts.pairs:
    echo &"  {moduleName} {fmti(bytes, w+8-moduleName.len)} bytes"
    accountedFor += bytes

  echo &"  other {fmti(textSize - accountedFor, w+8-5)} bytes"



  if moduleCounts.len == 0:
    echo "Was ", file, " compiled with --debugger:native?"

dispatch(main)
