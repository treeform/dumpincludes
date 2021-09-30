# DumpIncludes - See where your exe size comes from.

`nimble install dumpincludes`

![Github Actions](https://github.com/treeform/dumpincludes/workflows/Github%20Actions/badge.svg)

[API reference](https://nimdocs.com/treeform/dumpincludes)

## About

Sometimes it's surprising where most of the code in your executable comes from.
Simply use this tool to list out which module contributes how many bytes.

Nim and the C compiler strips out much of unused code in modules, so its hard to guess just from module line count on how big of a contributor it is. You might think this module is huge, but in really you only use one function and most of it gets compiled out.

On the other hand, in Nim you can also use macros, templates and generics to generate a lot of code. Sometimes the number of permutations can generate code that is very large. You might think its a little 5 line template, but it calls itself recursively creating megabytes of code.

And sometimes modules import other modules and they imports other modules, so you just don't know what really ends up getting compiled in.

This tool lets you see exactly whats in your executable.

Get this tool by running `nimble install dumpincludes`.

Compile your program with `-d:release --debugger:native` to get debugging symbols:

```sh
nim c -d:release --debugger:native tests/helloworld.nim
```

```sh
dumpincludes -f:helloworld.exe
```

```
Sections:
  code ............................................................................ 60,776 bytes
  data ............................................................................ 82,452 bytes
  debug ........................................................................ 1,496,400 bytes
Imports:
  C:/Users/me/.choosenim/toolchains/nim-#devel/lib/system/alloc.nim .............. 8,481 bytes
  C:/Users/me/.choosenim/toolchains/nim-#devel/lib/system/gc.nim ................. 5,599 bytes
  C:/Users/me/.choosenim/toolchains/nim-#devel/lib/system/avltree.nim ............ 4,125 bytes
  C:/Users/me/.choosenim/toolchains/nim-#devel/lib/system/cellseqs_v1.nim ........ 1,568 bytes
  C:/Users/me/.choosenim/toolchains/nim-#devel/lib/system/sysstr.nim ............. 1,558 bytes
  C:/Users/me/.choosenim/toolchains/nim-#devel/lib/system/excpt.nim .............. 1,199 bytes
  C:/Users/me/.choosenim/toolchains/nim-#devel/lib/system/cellsets.nim ........... 1,187 bytes
  C:/Users/me/.choosenim/toolchains/nim-#devel/lib/system/memory.nim ............... 923 bytes
  C:/Users/me/.choosenim/toolchains/nim-#devel/lib/system.nim ...................... 768 bytes
  C:/Users/me/.choosenim/toolchains/nim-#devel/lib/system/strmantle.nim ............ 678 bytes
  C:/Users/me/.choosenim/toolchains/nim-#devel/lib/system/osalloc.nim .............. 621 bytes
  C:/Users/me/.choosenim/toolchains/nim-#devel/lib/system/io.nim ................... 488 bytes
  C:/Users/me/.choosenim/toolchains/nim-#devel/lib/system/gc_common.nim ............ 414 bytes
  C:/Users/me/.choosenim/toolchains/nim-#devel/lib/system/iterators_1.nim .......... 405 bytes
  C:/Users/me/.choosenim/toolchains/nim-#devel/lib/system/arithmetics.nim .......... 362 bytes
  C:/Users/me/.choosenim/toolchains/nim-#devel/lib/system/fatal.nim ................ 323 bytes
  C:/Users/me/.choosenim/toolchains/nim-#devel/lib/system/dyncalls.nim ............. 285 bytes
  C:/Users/me/.choosenim/toolchains/nim-#devel/lib/system/indexerrors.nim ........... 70 bytes
  C:/Users/me/.choosenim/toolchains/nim-#devel/lib/system/ansi_c.nim ................ 60 bytes
  C:/Users/me/.choosenim/toolchains/nim-#devel/lib/system/mmdisp.nim ................ 50 bytes
  C:/Users/me/.choosenim/toolchains/nim-#devel/lib/std/private/miscdollars.nim ...... 38 bytes
  C:/Users/me/.choosenim/toolchains/nim-#devel/lib/system/atomics.nim ............... 19 bytes
  C:/Users/me/.choosenim/toolchains/nim-#devel/lib/system/chcks.nim ................. 19 bytes
  C:/Users/me/.choosenim/toolchains/nim-#devel/lib/system/memalloc.nim .............. 17 bytes
  C:/Users/me/.choosenim/toolchains/nim-#devel/lib/system/assertions.nim ............ 13 bytes
  C:/Users/me/Documents/GitHub/dumpincludes/tests/helloworld.nim .................... 12 bytes
  C:/Users/me/.choosenim/toolchains/nim-#devel/lib/system/iterators.nim .............. 9 bytes
  C:/Users/me/.choosenim/toolchains/nim-#devel/lib/system/comparisons.nim ............ 3 bytes
  C:/Users/me/.choosenim/toolchains/nim-#devel/lib/system/integerops.nim ............. 2 bytes
  other ........................................................................... 31,480 bytes
```

Also works when linking with `.c`, `.cpp`, or using `.h` includes!

Make sure `objdump` utility from gcc/llvm is in your path. Does not work with VCC.
