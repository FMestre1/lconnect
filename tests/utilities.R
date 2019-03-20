#http://pierreroudier.github.io/teaching/20170626-Pedometrics/20170626-soil-data.html
#https://ryanpeek.github.io/2017-11-05-mapping-with-sf-Part-2/
land_path <- "~/Projectos/lconnect/inst/extdata/vec_projected.shp"

landscape <- upload_land(land_path, habitat = 1, min_dist =500)

plot(landscape$landscape)

aux <- component_calc(land$landscape, 500)

#This R code selects a systematic sample of size n from a  
# population of size N. 
# The values of N and n must be provided 
sys.sample = function(N,n){
  k = ceiling(N/n)
  #ceiling(x) rounds to the nearest integer that’s larger than x. 
  #This means ceiling (2.1) = 3 
  r = sample(1:k, 1)
  sys.samp = seq(r, r + k*(n-1), k)
  cat("The selected systematic sample is: \"", sys.samp, "\"\n")
  # Note: the last command "\"\n" prints the result in a new line
}
# To select a systematic sample, type the following command
# providing the values of N and n
# sys.sample(50, 5)