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
#' @param remove_ind A boolean whether to remove intermediary columns
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
#' add_metadata(dist_df, woodmouse_meta, isolate = 'SAMPLE_ID', group = 'CLUSTER', remove_ind = TRUE)
#' }
#' @export
#' @importFrom stats setNames


add_metadata <- function(dist, meta, isolate = 'ISOLATES', group = 'CLUSTER', remove_ind = TRUE) {
  gr1 <- paste(group, '1', sep = '_')
  gr2 <- paste(group, '2', sep = '_')
  dist <- dist %>%
    dplyr::left_join(meta, c('iso1' = isolate)) %>%
    dplyr::rename_(.dots = setNames(group, gr1)) %>%
    dplyr::left_join(meta, c('iso2' = isolate)) %>%
    dplyr::rename_(.dots = setNames(group, gr2)) %>%
    dplyr::rowwise() %>%
    dplyr::mutate_(.dots = setNames(lazyeval::interp("ifelse(gr1 == gr2, gr1, paste(sort(c(gr1, gr2)), collapse = delim))", .values = list(gr1 = as.name(gr1), gr2 = as.name(gr2), delim = '')), group)) %>%
    dplyr::ungroup() %>%
    dplyr::mutate_(.dots = setNames(lazyeval::interp("factor(gr, levels = unique(gr)[order(nchar(unique(gr)))])", gr = as.name(group)), group))
  if(remove_ind) {
    dist <- dist %>%
      dplyr::select_(lazyeval::interp(quote(-x1), quote(-x2), x1 = as.name(gr1)), lazyeval::interp(quote(-x2), x2 =as.name(gr2)))
  }
  return(dist)
}
