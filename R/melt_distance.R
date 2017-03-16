#' Melt a square distance matrix into long format
#'
#' This will take a square distance matrix, and will transform in to long
#' format. It will remove upper triangle, and diagonal elements, so you
#' end with only (n)*(n-1)/2 rows, where n are the total number of rows in
#' the distance matrix.
#'
#' @param dist An object of class matrix, it must be square
#' @param order A character vector of size n with the order of the columns and rows (default: NULL)
#' @param dist_name A string to name the distance column in the output (default: dist)
#'
#' @return A data.frame with three columns: (1) iso1; (2) iso2; (3) dist. iso1 and
#' iso2 indicate the pair being compared, and dist indicates the distance between
#' that pair.
#'
#' @importFrom tidyr gather
#' @importFrom magrittr %>%
#' @importFrom lazyeval interp
#' @export
#' @examples
#' \dontrun{
#' data(woodmouse)
#' dist <- ape::dist(woodmouse, model = 'N', as.matrix = TRUE)
#' dist_df <- melt_dist(dist)
#' }

melt_dist <- function(dist, order = NULL, dist_name = 'dist') {
  if(!is.null(order)){
    dist <- dist[order, order]
  } else {
    order <- row.names(dist)
  }
  diag(dist) <- NA
  dist[upper.tri(dist)] <- NA
  dist_df <- as.data.frame(dist)
  dist_df$iso1 <- row.names(dist)
  dist_df <- dist_df %>%
    tidyr::gather_(key = "iso2", value = lazyeval::interp("dist_name", dist_name = as.name(dist_name)), order, na.rm = T)
  return(dist_df)
}

#' Return evolutionary distance in long format
#'
#' This will take an alignment, will calculate the evolutionary distance between
#' all pairs of sequence, and will transform the distance matrix to long
#' format. It will remove upper triangle, and diagonal elements, so you
#' end with only (n)*(n-1)/2 rows, where n are the total number of rows in
#' the distance matrix.
#'
#' If a tree is optionally given, a fourth column is returned with the cophenetic
#' distance across all elements of tree. It assumes the tree was generated from
#' the alignment.
#'
#' @param aln An object of class matrix, it must be square
#' @param order A character vector of size n with the order of the columns and rows (default: NULL)
#' @param dist A string naming the model to calculate distances (accepted values are those in ape::dist.dna)
#' @param tree An object of class phylo
#'
#' @return A data.frame with three or four columns: (1) iso1; (2) iso2: (3) dist. If a tree is given then a fourth column (evol_dist) containig the distances from the tree is also supplied.
#'
#' @export
#' @importFrom magrittr %>%
#' @importFrom ape dist.dna
#' @importFrom ape cophenetic.phylo
#' @importFrom dplyr inner_join
#' @examples
#' \dontrun{
#' data(woodmouse)
#' dist_df <- dist_long(woodmouse)
#' }

dist_long <- function(aln, order = NULL, dist = 'N', tree = NULL){
  dist <- ape::dist.dna(x = aln, model = dist, as.matrix = T)
  if(is.null(order) & !is.null(tree)) {
    order = tree$tip.labels
  }
  dist_df <- melt_dist(dist, order = order)
  if(!is.null(tree)) {
    evol_dist <- ape::cophenetic.phylo(tree)
    evol_dist_df <- melt_dist(evol_dist, order = order, dist_name = 'evol_dist')
    dist_df <- dist_df %>%
      dplyr::inner_join(evol_dist_df, c('iso1' = 'iso1', 'iso2' = 'iso2'))
  }
  return(dist_df)
}

