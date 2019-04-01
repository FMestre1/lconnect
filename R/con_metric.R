#' @title Landscape connectivity metrics
#' @description Compute several landscape connectivity metrics.
#' @param landscape Object of class 'lconnect' created by \code{\link{upload_land}}.
#' @param metric Character vector of landscape metrics to be computed. Can be one or more of
#' the metrics currently available: "NC", "LNK", "SLC", "MSC", "CCP", "LCP",
#' "CPL", "ECS", "AWF" and "IIC".  
#' @usage con_metric(landscape, metric)
#' @return Numeric vector with the landscape connectivity metrics selected.
#' @examples vec_path <- system.file("extdata/vec_projected.shp", package = "lconnect")
#' landscape <- upload_land(vec_path, bound_path = NULL,
#' habitat = 1, max_dist = 500)
#' metrics <- con_metric(landscape, metric = c("NC", "LCP"))
#' @details The landscape connectivity metrics currently available are: 
#' \itemize{
#'   \item NC – Number of components (groups of interconnected patches) in the 
#'   landscape (Urban and Keitt, 2001). Patches in the same component are 
#'   considered to be accessible, while patches in different components are not.
#'   Highly connected landscapes have less components. Threshold dependent,
#'   i.e., maximum distance for two patches to be considered connected, which 
#'   can be interpreted as the maximum dispersal distance for a certain species.
#'   \item LNK – Number of links connecting the patches. The landscape is 
#'   interpreted as binary, which means that the habitat patches are either
#'   connected or not (Pascual-Hortal and Saura, 2006). Higher LNK implies 
#'   higher connectivity. Threshold dependent, i.e., maximum distance for
#'    two patches to be considered connected, which can be interpreted as 
#'    the maximum dispersal distance for a certain species.
#'   \item SLC – Area of the largest group of interconnected patches 
#'   (Pascual-Hortal and Saura, 2006). Threshold dependent, i.e., maximum 
#'   distance for two patches to be considered connected, which can be 
#'   interpreted as the maximum dispersal distance for a certain species.
#'   \item MSC – Mean area of interconnected patches 
#'   (Pascual-Hortal and Saura, 2006). Threshold dependent, i.e., maximum 
#'   distance for two patches to be considered connected, which can be 
#'   interpreted as the maximum dispersal distance for a certain species. 
#'   \item CCP – Class coincidence probability. It is defined as the probability 
#'   that two randomly chosen points within the habitat belong to the same 
#'   component (or cluster). Ranges between 0 and 1 (Pascual-Hortal and 
#'   Saura, 2006). Higher CCP implies higher connectivity. Threshold dependent, 
#'   i.e., maximum distance for two patches to be considered connected, which 
#'   can be interpreted as the maximum dispersal distance for a certain species. 
#'   \item LCP – Landscape coincidence probability. It is defined as the 
#'   probability that two randomly chosen points in the landscape (whether in 
#'   an habitat patch or not) belong to the same habitat component (or cluster).
#'    Ranges between 0 and 1 (Pascual-Hortal and Saura, 2006). Threshold 
#'    dependent, i.e., maximum distance for two patches to be considered 
#'    connected, which can be interpreted as the maximum dispersal distance for a certain species.
#'   \item CPL – Characteristic path length. Mean of all the shortest paths 
#'   between the habitat patches (Minor and Urban, 2008). The shorter the CPL 
#'   value the more connected the patches are. Threshold dependent, i.e., 
#'   maximum distance for two patches to be considered connected, which can be 
#'   interpreted as the maximum dispersal distance for a certain species. 
#'   \item ECS – Expected component (or cluster) size. Mean cluster size of the 
#'   clusters weighted by area. (O’Brien et al., 2006 and Fall et al, 2007).
#'    This represents the size of the component in which a randomly located 
#'    point in an habitat patch would reside. Although it is informative 
#'    regarding the area of the component, it does not provide any ecologically 
#'    meaningful information regarding the total area of habitat. As an example: 
#'    ECS increases with less isolated small components or patches, although the 
#'    total habitat decreases (Laita et al. 2011). Threshold dependent, i.e., 
#'    maximum distance for two patches to be considered connected, which 
#'    can be interpreted as the maximum dispersal distance for a certain species.
#'   \item AWF – Area-weighted Flux. Evaluates the flow, weighted by area, 
#'   between all pairs of patches (Bunn et al. 2000 and Urban and Keitt 2001). 
#'   The probability of dispersal between two patches, was computed using 
#'   pij=exp(-k * dij), where k is a constant making pij (the dispersal 
#'   probability between patches) 50% at half the dispersal distance 
#'   defined by the user. Although k, as was implemented, is dependent on 
#'   the dispersal distance, AWF is a probabilistic index and not 
#'   directly dependent on the threshold. 
#'   \item IIC – Integral index of connectivity. Index developed specifically 
#'   for landscapes by Pascual-Hortal and Saura (2006). It is based on habitat 
#'   availability and on a binary connection model (as opposed to a 
#'   probabilistic). It ranges from 0 to 1 (higher values indicating more 
#'   connectivity). Threshold dependent, i.e., maximum distance for two patches 
#'   to be considered connected, which can be interpreted as the maximum 
#'   dispersal distance for a certain species.
#'   }
#' @references Bunn, A. G., Urban, D. L., and Keitt, T. H. (2000). Landscape connectivity: a conservation application of graph theory. Journal of Environmental Management, 59(4): 265-278.
#' @references Fall, A., Fortin, M. J., Manseau, M., and O' Brien, D. (2007). Spatial graphs: principles and applications for habitat connectivity. Ecosystems, 10(3): 448-461.
#' @references Laita, A., Kotiaho, J.S., Monkkonen, M. (2011). Graph-theoretic connectivity measures: what do they tell us about connectivity? Landscape Ecology, 26: 951-967.
#' @references Minor, E. S., and Urban, D. L. (2008). A Graph-Theory Framework for Evaluating Landscape Connectivity and Conservation Planning. Conservation Biology, 22(2): 297-307.
#' @references O'Brien, D., Manseau, M., Fall, A., and Fortin, M. J. (2006). Testing the importance of spatial configuration of winter habitat for woodland caribou: an application of graph theory. Biological Conservation, 130(1): 70-83.
#' @references Pascual-Hortal, L., and Saura, S. (2006). Comparison and development of new graph-based landscape connectivity indices: towards the priorization of habitat patches and corridors for conservation. Landscape Ecology, 21(7): 959-967. 
#' @references Urban, D., and Keitt, T. (2001). Landscape connectivity: a graph-theoretic perspective. Ecology, 82(5): 1205-1218.
#' @author Frederico Mestre
#' @author Bruno Silva
#' @export
con_metric <- function(landscape, metric) {
  if (class(landscape) != "lconnect") {
    stop("Argument landscape must be an object of class 'lconnect'",
         call. = FALSE)
  }
  if (!all(metric %in% c("NC", "LNK", "SLC", "MSC", "CCP", "LCP", "CPL",
                       "ECS", "AWF", "IIC"))){
    stop("Argument metric must be one or more of: 'NC', 'LNK', 'SLC', 'MSC', 'CCP',
'LCP', 'CPL', 'ECS', 'AWF' or 'IIC'", call. = FALSE)
  }
  aux <- component_calc(landscape$landscape, landscape$distance,
                        landscape$max_dist)
  clusters <- aux$clusters
  area_c <- as.numeric(aux$area_c)
  area_l <- as.numeric(landscape$area_l)
  max_dist <- landscape$max_dist
  distance <- landscape$distance
  NC <- max(clusters)
  result <- c()
  if ("NC" %in% metric) {
    result <- c(result, NC = NC)
  }
  if ("LNK" %in% metric) {
    result <- c(result, LNK = sum(distance < max_dist))
  }
  if ("SLC" %in% metric) {
    df0 <- data.frame(area_c, clusters)
    Ac <- sum(area_c)
    r0 <- rep(NA, NC)
    for (i in 1:NC) {
      df1 <- df0[df0$clusters == i, ]
      ci <- sum(df1[, 1])
      r0[i] <- ci
    }
    result <- c(result, SLC = max(r0))
  }
  if ("MSC" %in% metric) {
    Ac <- sum(area_c)
    result <- c(result, MSC = Ac / NC)
  }
  if ("CCP" %in% metric) {
    df0 <- data.frame(area_c, clusters)
    Ac <- sum(area_c)
    r0 <- rep(NA, NC)
    for (i in 1:NC) {
      df1 <- df0[df0$clusters == i, ]
      ci <- sum(df1[, 1])
      r0[i] <- (ci / Ac) ^ 2
    }
    result <- c(result, CCP = sum (r0))
  }
  if ("LCP" %in% metric) {
    df0 <- data.frame(area_c, clusters)
    r0 <- rep(NA, NC)
    for (i in 1:NC) {
      df1 <- df0[df0$clusters == i, ]
      ci <- sum(df1[, 1])
      r0[i] <- (ci / landscape$area_l) ^ 2
    }
    result <- c(result, LCP = sum (r0))
  }
  if ("CPL" %in% metric) {
    d1 <- upper.tri(as.matrix(distance)) * as.matrix(distance)
    d1[d1 == 0] <- NA
    e1 <- as.data.frame(which(d1 < max_dist, arr.ind = TRUE, useNames = FALSE))
    g1 <- igraph::graph_from_data_frame(e1, directed = FALSE)
    short_p <- igraph::shortest.paths(g1)
    n_links <- (sum(!is.infinite(short_p)) - nrow(short_p)) / 2
    filt <- which(!is.infinite(short_p))
    sum_links <- sum(short_p[filt]) / 2
    result <- c(result, CPL = sum_links / n_links)
  }
  if ("ECS" %in% metric) {
    df0 <- data.frame(area_c, clusters)
    Ac <- sum(area_c)
    r0 <- rep(NA, NC)
    for (i in 1:NC) {
      df1 <- df0[df0$clusters == i, ]
      ci <- sum(df1[, 1])
      r0[i] <- ci ^ 2
    }
    result <- c(result, ECS = sum(r0) / Ac)
  }
  if ("AWF" %in% metric) {
    k <- -log(0.5) / (max_dist / 2)
    out <- matrix(NA, nrow = length(area_c), ncol = length(area_c))
    for (i in seq_len(area_c)) {
      for (j in seq_len(area_c)) {
        prob <- exp(-k * (as.matrix(distance)[i, j])) * area_c[i] * area_c[j]
        out[i, j] <- prob
      }
    }
    diag(out) <- 0
    result <- c(result, AWF = sum(out))
  }
  if ("IIC" %in% metric) {
    d1 <- upper.tri(as.matrix(distance)) * as.matrix(distance)
    d1[d1 == 0] <- NA
    e1 <- as.data.frame(which(d1 < max_dist, arr.ind = TRUE, useNames = FALSE))
    g1 <- igraph::graph_from_data_frame(e1, directed = FALSE)
    short_p <- igraph::shortest.paths(g1)
    out <- matrix(NA, nrow = length(area_c), ncol = length(area_c))
    for (i in as.numeric(row.names(short_p))) {
      for (j in as.numeric(row.names(short_p))) {
        nij <- short_p[as.character(i), as.character(j)]
        prob <- (area_c[i] * area_c[j]) / (1 + nij)
        out[i, j] <- prob
      }
    }
    out[is.na(out)] <- 0
    result <- c(result, IIC = sum(out) / (area_l ^ 2))
  }
  return(round(result, 5))
}
