d1 <- upper.tri(as.matrix(distance))*as.matrix(distance)
d1[d1==0]<-NA
e1 <- as.data.frame(which(d1<dist_min, arr.ind = TRUE, useNames = FALSE))
e2 <- cbind(e1[,2],e1[,1])
g1 <- graph_from_data_frame(e1, directed = FALSE)
short_p <- shortest.paths(g1)


ai<-c()
aj<-c()
n <-c()
p <- c()


out <- matrix(NA, nrow = length(area_c), ncol = length(area_c))
for(i in as.numeric(row.names(short_p))){
  for(j in as.numeric(row.names(short_p))){
    
    nij <- short_p[as.character(i),as.character(j)]
    n<- c(n,nij)
    ai<-c(ai,area_c[i])
    aj<-c(aj,area_c[j])
    prob <-  (area_c[i] * area_c[j])/(1+nij)
    p <- c(p,prob)
    #out[i, j] <- prob
  }# final for j
} # final for i


cbind(ai,aj,n,p)
sum(p)/area_l^2
