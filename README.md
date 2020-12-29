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
excpt.nim ...............................    17403 bytes
alloc.nim ...............................    10630 bytes
gc.nim ..................................     6753 bytes
arithmetics.nim .........................     4067 bytes
cellseqs_v1.nim .........................     2605 bytes
comparisons.nim .........................     1960 bytes
cellsets.nim ............................     1592 bytes
avltree.nim .............................     1383 bytes
sysstr.nim ..............................     1372 bytes
gc_common.nim ...........................      941 bytes
io.nim ..................................      846 bytes
strmantle.nim ...........................      814 bytes
osalloc.nim .............................      806 bytes
memory.nim ..............................      775 bytes
system.nim ..............................      568 bytes
fatal.nim ...............................      479 bytes
dyncalls.nim ............................      346 bytes
miscdollars.nim .........................      247 bytes
iterators_1.nim .........................      166 bytes
mmdisp.nim ..............................      138 bytes
indexerrors.nim .........................       95 bytes
chcks.nim ...............................       68 bytes
ansi_c.nim ..............................       65 bytes
iterators.nim ...........................       50 bytes
helloword.nim ...........................       37 bytes
atomics.nim .............................       35 bytes
memalloc.nim ............................        9 bytes
integerops.nim ..........................        2 bytes
other ...................................    33388 bytes
sections:
code ....................................    87640 bytes
data ....................................    87920 bytes
debug ...................................  1400641 bytes
```

Also works when linking with `.c`, `.cpp`, or using `.h` imports!

Make sure `objdump` utility from gcc is in your path.
