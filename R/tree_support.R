#' Get node support from a tree produced with IQTREE
#'
#' In IQTREE it is possible to obtain node support values by SH aproximate
#' likelihood ratio tests (SH-aLRT), and ultrafast bootstraps (uBS). Often,
#' we do both, which IQTREE encodes as two numbers separated by a '/' as the
#' internal node label. This function will return a data.frame with the
#' number of the internal nodes, and the support values for each.
#'
#' @param tree An object of type phylo generated using IQTREE
#'
#' @return A data.frame with internal node information, plus two columns:
#' (1) SH-aLRT; and (2) uBS
#'
#' @importFrom ggtree ggtree
#' @importFrom magrittr %>%
#'
#' @export
#' @examples
#' \dontrun{
#' data(woodmouse_iqtree)
#' get_node_support(woodmouse_iqtree)
#' }

get_node_support <- function(tree) {
  p1 <- ggtree(tree)
  dat <- p1$data %>%
    dplyr::filter_(lazyeval::interp("!isTip", isTip = as.name("isTip"))) %>%
    dplyr::mutate_(label = lazyeval::interp(quote(ifelse(label == '', NA, label)), label = as.name('label'))) %>%
    tidyr::separate_(lazyeval::interp("label", label = as.name("label")), into = c("SH-aLRT", "uBS"), sep = '/', convert = T)
  return(dat)
}
