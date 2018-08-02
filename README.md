This repo demos a problem I'm having with saved projects and call graph node
names.  The labels on nodes appear to be wrong some of the time when loading
a project.  I'm using BAP 1.4.0 (the latest version in opam).

To observe this, I've created a simple plugin called "shownames".  To
install it, just run `make`.  It's invoked with both a binary and a saved
project from some other binary, as in:

    $ bap --pass=shownames --shownames-prog1=foo0.bpj foo1

This dumps the symbol tables from foo1 and foo0, and it dumps the names of
every node in the call graph of both programs.  Although the symbol tables
both look correct, the names for the nodes in the call graph of the loaded
project are wrong. I've included the output for the above example at the
bottom of this file.  Note the strange names under the "Saved project node
labels" heading.

The `examples` subdirectory includes a small C program compile with GCC at
three different optimization levels for experimentation.  It also includes
saved BAP project files for each binary (which I created with a different
plugin).

The problem occurs whenever `shownames` is run with a saved project file and
a different binary.  The weird names are always given for the project loaded
from the project file, never the binary.  If you use the project file and
the binary it was loaded from, the problem goes away.  That is, this
invocation prints correct names:

    $ bap --pass=shownames --shownames-prog1=foo1.bpj foo1


# Weird output

    Saved project symbols:
        __libc_csu_fini  [0x4006F0]
        __libc_csu_init  [0x400680]
        __libc_start_main  [0x400480]
        _init  [0x400438]
        _start  [0x4004C0]
        atoi  [0x400490]
        exit  [0x4004A0]
        fact  [0x4005B6]
        main  [0x4005FB]
        mymin  [0x4005DF]
        printf  [0x400470]
        sub_4004b0  [0x4004B0]
        sub_4005aa  [0x4005AA]
    
    New project symbols:
        __libc_csu_fini  [0x4006E0]
        __libc_csu_init  [0x400670]
        __libc_start_main  [0x400490]
        __printf_chk  [0x4004B0]
        _init  [0x400460]
        _start  [0x4004E0]
        exit  [0x4004C0]
        fact  [0x4005D6]
        main  [0x4005F6]
        mymin  [0x4005EE]
        strtol  [0x4004A0]
        sub_4004d0  [0x4004D0]
        sub_4005ca  [0x4005CA]
        sub_4005dd  [0x4005DD]
    
    
    Saved project node labels:
      @__libc_csu_init
      @__libc_start_main
      %000000ac
      %000000fa
      @_start
      @exit
      %0000013c
      %00000192
      %000001b0
      %000001b3
      %000001b6
    
    New project node labels:
      @__libc_csu_init
      @__libc_start_main
      @__printf_chk
      @_init
      @_start
      @exit
      @fact
      @main
      @strtol
      @sub_4004d0
      @sub_4005dd
