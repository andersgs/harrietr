% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/melt_distance.R
\name{dist_long}
\alias{dist_long}
\title{Return evolutionary distance in long format}
\usage{
dist_long(aln, order = NULL, dist = "N", tree = NULL)
}
\arguments{
\item{aln}{An object of class matrix, it must be square}

\item{order}{A character vector of size n with the order of the columns and rows (default: NULL)}

\item{dist}{A string naming the model to calculate distances (accepted values are those in ape::dist.dna)}

\item{tree}{An object of class phylo}
}
\value{
A data.frame with three or four columns: (1) iso1; (2) iso2: (3) dist. If a tree is given then a fourth column (evol_dist) containig the distances from the tree is also supplied.
}
\description{
This will take an alignment, will calculate the evolutionary distance between
all pairs of sequence, and will transform the distance matrix to long
format. It will remove upper triangle, and diagonal elements, so you
end with only (n)*(n-1)/2 rows, where n are the total number of rows in
the distance matrix.
}
\details{
If a tree is optionally given, a fourth column is returned with the cophenetic
distance across all elements of tree. It assumes the tree was generated from
the alignment.
}
\examples{
\dontrun{
data(woodmouse)
dist_df <- dist_long(woodmouse)
}
}
