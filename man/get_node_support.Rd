% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tree_support.R
\name{get_node_support}
\alias{get_node_support}
\title{Get node support from a tree produced with IQTREE}
\usage{
get_node_support(tree)
}
\arguments{
\item{tree}{An object of type phylo generated using IQTREE}
}
\value{
A data.frame with internal node information, plus two columns:
(1) SH-aLRT; and (2) uBS
}
\description{
In IQTREE it is possible to obtain node support values by SH aproximate
likelihood ratio tests (SH-aLRT), and ultrafast bootstraps (uBS). Often,
we do both, which IQTREE encodes as two numbers separated by a '/' as the
internal node label. This function will return a data.frame with the
number of the internal nodes, and the support values for each.
}
\examples{
\dontrun{
data(woodmouse_iqtree)
get_node_support(woodmouse_iqtree)
}
}
