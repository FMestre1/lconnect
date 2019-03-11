#leave one patch out at a time to derive patch relevance to overall connectivity

patch.imp <- function(landscape, metric)
{
#object from upload.landscape
#metric - metric to use in the prioritization

#compute full landscpe metrics
full.CONN <- as.numeric(l.metrics(landscape=landscape, metric))

dCONN <- c()#results vector
npatch <- #deriving the number of patches

for (i in 1:npatch){

land1 <- landscape #landscape #This is just no to change landscape

land2 <- #removing patch i

partial.CONN <- as.numeric(l.metrics(landscape=land2, metric))

dCONN[i] <- 100*((full.CONN-partial.CONN)/full.CONN)#send the result to the vector

}
return(dCONN)#get result
}
