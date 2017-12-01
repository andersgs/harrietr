#' \code{harrietr} package
#'
#' harrietr: Wrangle Phylogenetic Distance Matrices and Other Utilities
#'
#' See the README on
#' \href{https://cran.r-project.org/package=harrietr/README.html}{CRAN}
#' or \href{https://github.com/andersgs/harrietr#readme}{GitHub}
#'
#' @docType package
#' @name harrietr
#' @importFrom dplyr %>%
#' @importFrom rlang ":="
NULL

## quiets concerns of R CMD check re: the .'s that appear in pipelines
## Thank you to Jenny Bryant for this little bit of code.
if(getRversion() >= "2.15.1")  utils::globalVariables(c("."))
