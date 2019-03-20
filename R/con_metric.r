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
  aux <- component_calc(landscape$landscape, landscape$distance, landscape$min_dist)
  clusters <- aux$clusters
  area_c <- as.numeric(aux$area_c)
  area_l <- as.numeric(landscape$area_l)
  min_dist <- landscape$min_dist
  distance <- landscape$distance
  NC <- max(clusters)
  
  
  #create result vector
  result <- c()
  
  if("NC" %in% metric)
  {
    result <- c(result, NC = NC)
  }
  
  if("LNK" %in% metric)
  {
    result <- c(result, LNK = sum(distance < min_dist))
  }

    if("SLC" %in% metric)
  {
    df0 <- data.frame(area_c, clusters)
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

    Ac <- sum(area_c)
    result <- c(result, MSC = Ac/NC)
  }
  
  #CCP
  if("CCP" %in% metric)
  {

    df0 <- data.frame(area_c, clusters)
    Ac <- sum(area_c)
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
    df0 <- data.frame(area_c, clusters)
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
    d1 <- upper.tri(as.matrix(distance))*as.matrix(distance)
    d1[d1==0]<-NA
    e1 <- as.data.frame(which(d1<dist_min, arr.ind = TRUE, useNames = FALSE))
    g1 <- graph_from_data_frame(e1, directed = FALSE)
    short_p <- shortest.paths(g1)
    n_links <- (sum(!is.infinite(short_p))-nrow(short_p))/2
    filt<-which(!is.infinite(short_p))
    sum_links <- sum(short_p[filt])/2
    result <- c(result, CPL = sum_links/n_links)
    }
  
  #ECS
  if("ECS" %in% metric)
  {
    df0 <- data.frame(area_c, clusters)
    Ac <- sum(area_c)
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
    k <- -(log(0.5)/(dist_min/2))
    out <- matrix(NA, nrow = length(area_c), ncol = length(area_c))
    for(i in 1:length(area_c)){
      for(j in 1:length(area_c)){
        prob <- exp(-k*(as.matrix(distance)[i, j])) * area_c[i] * area_c[j]
        out[i, j] <- prob
    }# final for j
  } # final for i
    diag(out)<-0
    result <- c(result, AWF = sum(out))
   }

  #IIC
  if("IIC" %in% metric)
  {
    
    d1 <- upper.tri(as.matrix(distance))*as.matrix(distance)
    d1[d1==0]<-NA
    e1 <- as.data.frame(which(d1<dist_min, arr.ind = TRUE, useNames = FALSE))
    e2 <- cbind(e1[,2],e1[,1])
    g1 <- graph_from_data_frame(e1, directed = FALSE)
    short_p <- shortest.paths(g1)
    
    out <- matrix(NA, nrow = length(area_c), ncol = length(area_c))
    for(i in as.numeric(row.names(short_p))){
      for(j in as.numeric(row.names(short_p))){
        nij <- short_p[as.character(i),as.character(j)]
        prob <-  (area_c[i] * area_c[j])/(1+nij)
        out[i, j] <- prob
      }# final for j
    } # final for i   
    out[is.na(out)]<-0
    result <- c(result, IIC = (sum(out)/(area_l^2)))
  }


  #provide results
  return(round(result,5))
}
