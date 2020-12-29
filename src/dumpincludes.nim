import osproc, strutils, tables, os, cligen

const objDumpPath = "objdump"

proc dots(n: int): string =
  for i in 0 ..< n:
    result.add(".")

proc main(file: string) =
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
        let moduleName = path.rsplit(":", 1)[0].lastPathPart
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

  moduleCounts.sort()
  var accountedFor = 0
  for moduleName, bytes in moduleCounts.pairs:
    echo moduleName, " ", dots(40 - moduleName.len), " ", align($bytes, 8), " bytes"
    accountedFor += bytes

  echo "other ", dots(40 - 5), " ", align($(textSize - accountedFor), 8), " bytes"

  echo "sections:"
  echo "code ", dots(40 - 4), " ", align($textSize, 8), " bytes"
  echo "data ", dots(40 - 4), " ", align($dataSize, 8), " bytes"
  echo "debug ", dots(40 - 5), " ", align($debugSize, 8), " bytes"

  if moduleCounts.len == 0:
    echo "Was ", file, " compiled with --debugger:native?"

dispatch(main)
