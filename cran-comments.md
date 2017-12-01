## Test environments
* local OS X install, R 3.4.2
* ubuntu 12.04 (on travis-ci), R 3.4.2
* win-builder (release)
* win-builder (develop)

## R CMD check results
There were no ERRORs or WARNINGs.

win-builder issued 1 NOTE: It said 'Phylogenetic' and 'phylogenetic' might
be mispelled in the DESCRIPTION file.

previous version had the following issues in the package check results page:

1. NOTE under various fedora and solaris: about having ggplot2 in Imports section
      --- I have moved it to Suggests as it will be used in the future.
2. ERROR under r-release-osx-x86_64: ggtree dependency not available --- I am 
    unsure what I can do about it.
3. ERROR under r-oldrel-osx-x86_64: wrong version of ggtree available ---
    as in error 2, I am unsure what I can do about it.

## Downstream dependencies
There are no downstream dependencies.
