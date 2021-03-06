% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{woodmouse_iqtree}
\alias{woodmouse_iqtree}
\title{Woodmouse IQTREE newick tree}
\format{An object of class \code{phylo} of length 5.}
\source{
"ape" package \link[ape]{woodmouse}
}
\usage{
woodmouse_iqtree
}
\description{
Generated a multiFASTA, and used IQTREE to generate a tree with the following
command:
}
\details{
\code{iqtree -s woodmouse.fasta -m TEST -nt 4 -bb 1000 -alrt 1000}

The tree was loaded into `R` using `ape::read.tree`, and saved to a dataset.
}
\keyword{datasets}
