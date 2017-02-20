#' Woodmouse dataset
#'
#' @source "ape" package \link[ape]{woodmouse}
#'
"woodmouse"

#' Woodmouse IQTREE newick tree
#'
#' Generated a multiFASTA, and used IQTREE to generate a tree with the following
#' command:
#'
#'  \code{iqtree -s woodmouse.fasta -m TEST -nt 4 -bb 1000 -alrt 1000}
#'
#' The tree was loaded into `R` using `ape::read.tree`, and saved to a dataset.
#'
#' @source "ape" package \link[ape]{woodmouse}
#'
"woodmouse_iqtree"

#' Woodmouse metadata
#'
#' A dummy metadata table generated to demonstrate the use of \code{add_metadata}.
#'
"woodmouse_meta"
