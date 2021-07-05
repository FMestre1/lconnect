#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
NumericMatrix IICRcpp(NumericVector x,NumericVector area_c, NumericVector names,NumericMatrix short_p) {
  const int nr = x.length();
  const int nv = names.length();
  NumericMatrix y(nr, nr);
  for (int i=0; i < nv;i++) {
    for (int j=0; j < nv; j++) {
      y(names(i),names(j)) =(area_c(names(i)) * area_c(names(j)))/(1 + short_p(i, j));
    }
  }
  return y;
}