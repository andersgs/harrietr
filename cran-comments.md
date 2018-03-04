## Test environments
* local OS X install, R 3.4.3
* ubuntu 12.04 (on travis-ci), R 3.4.2
* win-builder (release), R 3.4.3
* win-builder (develop)

## R CMD check results

local OX X install: There were no ERRORs or WARNINGs

Ubunty 12.04: There were no ERRORs or WARNINGs

win-builder (release): There were no ERRORs or WARNINGs

win-builder (develop) issued 1 ERROR: 

  `Error : object 'read.fasta' is not exported by 'namespace:treeio'`
  
  Investigation of the error shows that the current version 1.2.1 of treeio
  indeed does not export `read.fasta`. I have filled an issue with the 
  developer to make a new release. The version on GitHub already fixes this
  problem (https://github.com/GuangchuangYu/treeio/issues/6). This does 
  not impact on the user's ability to use this package.
  
The previous version had the following issues in the package check results page:

1. ERROR under r-devel-windows-ix86+x86_64: same as above.

2. ERROR under r-release-osx-x86_64: ggtree dependency not available --- I am 
    unsure what I can do about it.
    
3. ERROR under  r-oldrel-windows-ix86+x86 and r-oldrel-osx-x86_64: 
    wrong version of ggtree available --- as in error 2, I am unsure what I can do about it.

## Downstream dependencies
There are no downstream dependencies.
