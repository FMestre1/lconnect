#' l.metric
#' @title 
#' @description
#' Compute connectivity metrics
#' @title Landscape connectivity metrics
#' @description Calculates several landscape connectivity metrics
#' @param landscape Landscape object produced by upload.landscape
#' @param metric Landscape metrics to be computed
#' @usage l.metric (landscape, metric)
#' @return que valores a funcao retorna
#' @examples exemplos de aplicacao com dados fornecidos pelo package
#' @references artigos em que se baseia a funcao
#' @author Frederico Mestre
#' @export
l.metric <- function (landscape,dist_min, metric) {
  # landscape object produced by upload.landscape
  # metric - landscape metrics to be computed
  
  if (class(landscape)!="lconnect") 
  {
    stop(paste(landscape, " should be an object of class class 'lconnect'.", sep=""), call. = FALSE)
  }
  
  #distance <- as.dist(landscape$distance) # passou para a funcao upload
  
  #create result vector
  result <- c()
  
  if("NC" %in% metric)
  {
    grouping <- hclust(distance, "single")
    clusters <- cutree(grouping, h=dist_min)
    df0 <- data.frame(landscape$area_c, clusters)
    result <- c(result,NC = max(clusters))
  }
  
  if("LNK" %in% metric)
  {
    result <- c(result, LNK = sum(distance<500))
  }
  
  if("SLC" %in% metric)
  {
    grouping <- hclust(distance, "single")
    clusters <- cutree(grouping, h=dist_min)
    df0 <- data.frame(landscape$area_c, clusters)
    NC <- max(clusters)
    Ac <- as.numeric(sum(landscape$area_c))
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
    clusters <- cutree(grouping, h=dist_min)
    df0 <- data.frame(landscape$area_c, clusters)
    NC <- max(clusters)
    Ac <- as.numeric(sum(landscape$area_c))
    result <- c(result, MSC = Ac/NC)
  }
  
  #CCP
  if("CCP" %in% metric)
  {
    #number of components
    grouping <- hclust(distance, "single")
    clusters <- cutree(grouping, h=dist_min)
    df0 <- data.frame(landscape$area_c, clusters)
    NC <- max(clusters)
    Ac <- as.numeric(sum(landscape$area_c))
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
    clusters <- cutree(grouping, h=dist_min)
    df0 <- data.frame(landscape$area_c, clusters)
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
    clusters <- cutree(grouping, h=dist_min)
    df0 <- data.frame(landscape$area_c, clusters)
    NC <- max(clusters)
    Ac <- as.numeric(sum(landscape$area_c))
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
