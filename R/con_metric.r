#' con_metric
#' @title 
#' @description
#' Compute connectivity metrics
#' @title Landscape connectivity metrics
#' @description Calculates several landscape connectivity metrics
#' @param landscape Landscape object produced by upload.landscape
#' @param metric Landscape metrics to be computed
#' @usage con_metric (landscape, metric)
#' @return que valores a funcao retorna
#' @examples exemplos de aplicacao com dados fornecidos pelo package
#' @references artigos em que se baseia a funcao
#' @author Frederico Mestre
#' @export
con_metric <- function (landscape, metric) {
  if (class(landscape)!="lconnect") 
  {
    stop("landscape must be an object of class class 'lconnect'.",
    call. = FALSE)
  }
  aux <- component_calc(landscape$landscape)
  clusters <- aux$clusters
  area_c <- as.numeric(aux$area_c)
  area_l <- as.numeric(landscape$area_l)
  min_dist <- landscape$min_dist
  
  #create result vector
  result <- c()
  
  if("NC" %in% metric)
  {
    result <- c(result, NC = max(clusters))
  }
  
  if("LNK" %in% metric)
  {
    result <- c(result, LNK = sum(distance < 500))
  }

    if("SLC" %in% metric)
  {
    df0 <- data.frame(area_c, clusters)
    NC <- max(clusters)
    Ac <- sum(area_c)
    r0 <- rep(NA, NC)
    for(i in 1:NC)
    {
      df1 <- df0[df0$clusters==i, ]
      ci <- sum(df1[,1])
      r0[i] <- ci
    }
    result <- c(result, SLC = max(r0))
  }
  
  if("MSC" %in% metric)
  {
    grouping <- hclust(distance, "single")
    clusters <- cutree(grouping, h=landscape$min_dist)
    df0 <- data.frame(area_c, clusters)
    NC <- max(clusters)
    Ac <- as.numeric(sum(area_c))
    result <- c(result, MSC = Ac/NC)
  }
  
  #CCP
  if("CCP" %in% metric)
  {
    #number of components
    grouping <- hclust(distance, "single")
    clusters <- cutree(grouping, h=landscape$min_dist)
    df0 <- data.frame(area_c, clusters)
    NC <- max(clusters)
    Ac <- as.numeric(sum(area_c))
    r0 <- rep(NA, NC)
    for(i in 1:NC)
    {
      df1 <- df0[df0$clusters==i, ]
      ci <- sum(df1[,1])
      r0[i] <- (ci/Ac)^2
    }
    result <- c(result, CCP = sum (r0))
  }

  #LCP
  if("LCP" %in% metric)
  {
    grouping <- hclust(distance, "single")
    clusters <- cutree(grouping, h=landscape$min_dist)
    df0 <- data.frame(area_c, clusters)
    NC <- max(clusters)
    r0 <- rep(NA, NC)
    for(i in 1:NC)
    {
      df1 <- df0[df0$clusters==i, ]
      ci <- sum(df1[,1])
      r0[i] <- (ci/landscape$area_l)^2
    }
    result <- c(result, LCP = sum (r0))
  }

  #CPL
  if("CPL" %in% metric)
  {

  }
  
  #ECS
  if("ECS" %in% metric)
  {
    grouping <- hclust(distance, "single")
    clusters <- cutree(grouping, h=landscape$min_dist)
    df0 <- data.frame(area_c, clusters)
    NC <- max(clusters)
    Ac <- as.numeric(sum(area_c))
    r0 <- rep(NA, NC)
    for(i in 1:NC)
    {
      df1 <- df0[df0$clusters==i, ]
      ci <- sum(df1[,1])
      r0[i] <- ci^2
    }
    result <- c(result, ECS = sum(r0)/Ac)
    
  }
  
  #AWF
  if("AWF" %in% metric)
  {
  }

  #IIC
  if("IIC" %in% metric)
  {
  }

  #PC
  if("PC" %in% metric)
  {
  }

  #ECA
  if("ECA" %in% metric)
  {
  }

  #provide results
  return(round(result,5))
}
