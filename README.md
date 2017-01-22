# visual_rpg_align
Align a class in Visual RPG

If you're using the Visual RPG by ASNA then this may be handy trying to format your text.

General conventions:
We indent with 2 spaces for every black we create. i.e.: 
BegClass
  xxx
  xxx
  BegSr
    if this
      xxx
    else
      xxx
    endif

We code DclDiskFile in blocks like this:
  Dcldiskfile name(pcm) +
    type(*input) +
    org(*indexed) +
    file("*libl/file") +
    db(reiconet) +
    chkfmtid(*no) +
    impopen(*yes)  

We expect an indentation for KList's and PList's
