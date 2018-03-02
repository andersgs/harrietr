#' Add metadata to long distance matrix
#'
#' @description This functions takes the output from \code{dist_long}, plus a
#' data.frame with metadata, and attaches it to the data.frame output from
#' \code{dist_long}. It uses a column in the metadata data.frame as a key to
#' join the two data.frames. So, it requires a column of data in the metadata
#' data.frame to have same ID labels as those in the pairwise comparison table.
#'
#' @param dist A data.frame produced by dist_long function
#' @param meta A data.frame with one column of IDs that match the IDs in \code{dist_long}
#' @param isolate A character string with the name of the column in the meta data.frame with the ID data
#' @param group A character string with the name of column containing the grouping variable
#' @param remove_ind A boolean whether to remove all non-essential columns
#' @param measure_col_contains A character string with a pattern that matches up with the measurement columns you wish to retain in the final output (default: 'dist')
#'
#' @details The output from \code{dist_long} with an additional column containing
#' a factor, with levels composed of joining the categories in the \code{group}
#' colum of the metadata data.frame for each pairwise comparison. For example,
#' if one row has distance between samples id1 and id2, and in the grouping column
#' of the metadata id1 is identified as part of group 'A', and id2 is identified
#' as part of group 'B', then the output from that row will 'AB'. If they were
#' from the same group, say 'A', the output would be just 'A'. In this way
#' it is easy to identify pairs of isolates that are from the same group, and
#' pairs of isolates that are from different groups.
#'
#' @examples
#' \dontrun{
#' data(woodmouse)
#' data(woodmouse_meta)
#' dist_df <- dist_long(woodmouse)
#' join_metadata(dist_df, woodmouse_meta, isolate = 'SAMPLE_ID', group = 'CLUSTER', remove_ind = TRUE)
#' }
#' @export


join_metadata <- function(dist, meta, isolate = 'ISOLATES',
                          group = 'CLUSTER', remove_ind = TRUE,
                          measure_col_contains = 'dist') {
  gr1 <- paste(group, '1', sep = '_')
  sgr1 <- rlang::sym(gr1)
  gr2 <- paste(group, '2', sep = '_')
  sgr2 <- rlang::sym(gr2)
  sgr <- rlang::sym(group)
  iso1 <- "iso1"
  iso2 <- "iso2"
  dist <- dist %>%
    dplyr::left_join(meta, c('iso1' = isolate)) %>%
    dplyr::rename_at(dplyr::vars(!!group), dplyr::funs(paste(., "_1", sep=''))) %>%
    dplyr::left_join(meta, c('iso2' = isolate)) %>%
    dplyr::rename_at(dplyr::vars(!!group), dplyr::funs(paste(., "_2", sep=''))) %>%
    dplyr::rowwise() %>%
    dplyr::mutate(!!group := dplyr::if_else((!!sgr1) == (!!sgr2),
                                     !!sgr1,
                                     paste(sort(c(!!sgr1, !!sgr2)),
                                           collapse=''))) %>%
    dplyr::ungroup() %>%
    dplyr::mutate(!!group := factor(!!sgr,
                                    levels = unique(!!sgr)[order(nchar(unique(!!sgr)))]))
  if(remove_ind) {
    dist <- dist %>%
      dplyr::select(!!iso1, !!iso2, dplyr::contains(measure_col_contains), !!group)
  }
  return(dist)
}
