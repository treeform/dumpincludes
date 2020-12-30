# See where your exe size comes from.

Sometimes it is surprising where most of the code in your exe comes from. Simply use this tool to list out where:

Build this project by running `nimble install` in the repo directory.

Compile your program with `--debugger:native`

```
nim c --debugger:native .\tests\helloword.nim
```

```
dumpincludes -f:helloworld.exe
```

```
Sections:
  code .......................................................................... 87,640 bytes
  data .......................................................................... 87,920 bytes
  debug ...................................................................... 1,400,641 bytes
Imports:
  C:/Users/me/.choosenim/toolchains/nim-#devel/lib/system/excpt.nim ............. 17,403 bytes
  C:/Users/me/.choosenim/toolchains/nim-#devel/lib/system/alloc.nim ............. 10,630 bytes
  C:/Users/me/.choosenim/toolchains/nim-#devel/lib/system/gc.nim ................. 6,753 bytes
  C:/Users/me/.choosenim/toolchains/nim-#devel/lib/system/arithmetics.nim ........ 4,067 bytes
  C:/Users/me/.choosenim/toolchains/nim-#devel/lib/system/cellseqs_v1.nim ........ 2,605 bytes
  C:/Users/me/.choosenim/toolchains/nim-#devel/lib/system/comparisons.nim ........ 1,960 bytes
  C:/Users/me/.choosenim/toolchains/nim-#devel/lib/system/cellsets.nim ........... 1,592 bytes
  C:/Users/me/.choosenim/toolchains/nim-#devel/lib/system/avltree.nim ............ 1,383 bytes
  C:/Users/me/.choosenim/toolchains/nim-#devel/lib/system/sysstr.nim ............. 1,372 bytes
  C:/Users/me/.choosenim/toolchains/nim-#devel/lib/system/gc_common.nim ............ 941 bytes
  C:/Users/me/.choosenim/toolchains/nim-#devel/lib/system/io.nim ................... 846 bytes
  C:/Users/me/.choosenim/toolchains/nim-#devel/lib/system/strmantle.nim ............ 814 bytes
  C:/Users/me/.choosenim/toolchains/nim-#devel/lib/system/osalloc.nim .............. 806 bytes
  C:/Users/me/.choosenim/toolchains/nim-#devel/lib/system/memory.nim ............... 775 bytes
  C:/Users/me/.choosenim/toolchains/nim-#devel/lib/system.nim ...................... 568 bytes
  C:/Users/me/.choosenim/toolchains/nim-#devel/lib/system/fatal.nim ................ 479 bytes
  C:/Users/me/.choosenim/toolchains/nim-#devel/lib/system/dyncalls.nim ............. 346 bytes
  C:/Users/me/.choosenim/toolchains/nim-#devel/lib/std/private/miscdollars.nim ..... 247 bytes
  C:/Users/me/.choosenim/toolchains/nim-#devel/lib/system/iterators_1.nim .......... 166 bytes
  C:/Users/me/.choosenim/toolchains/nim-#devel/lib/system/mmdisp.nim ............... 138 bytes
  C:/Users/me/.choosenim/toolchains/nim-#devel/lib/system/indexerrors.nim ........... 95 bytes
  C:/Users/me/.choosenim/toolchains/nim-#devel/lib/system/chcks.nim ................. 68 bytes
  C:/Users/me/.choosenim/toolchains/nim-#devel/lib/system/ansi_c.nim ................ 65 bytes
  C:/Users/me/.choosenim/toolchains/nim-#devel/lib/system/iterators.nim ............. 50 bytes
  C:/p/dumpincludes/tests/helloword.nim ............................................. 37 bytes
  C:/Users/me/.choosenim/toolchains/nim-#devel/lib/system/atomics.nim ............... 35 bytes
  C:/Users/me/.choosenim/toolchains/nim-#devel/lib/system/memalloc.nim ............... 9 bytes
  C:/Users/me/.choosenim/toolchains/nim-#devel/lib/system/integerops.nim ............. 2 bytes
  other ......................................................................... 33,388 byte
```

Also works when linking with `.c`, `.cpp`, or using `.h` imports!

Make sure `objdump` utility from gcc is in your path.
