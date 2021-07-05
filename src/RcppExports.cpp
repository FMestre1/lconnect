// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <Rcpp.h>

using namespace Rcpp;

// IICRcpp
NumericMatrix IICRcpp(NumericVector x, NumericVector area_c, NumericVector names, NumericMatrix short_p);
RcppExport SEXP _lconnect_IICRcpp(SEXP xSEXP, SEXP area_cSEXP, SEXP namesSEXP, SEXP short_pSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< NumericVector >::type x(xSEXP);
    Rcpp::traits::input_parameter< NumericVector >::type area_c(area_cSEXP);
    Rcpp::traits::input_parameter< NumericVector >::type names(namesSEXP);
    Rcpp::traits::input_parameter< NumericMatrix >::type short_p(short_pSEXP);
    rcpp_result_gen = Rcpp::wrap(IICRcpp(x, area_c, names, short_p));
    return rcpp_result_gen;
END_RCPP
}

static const R_CallMethodDef CallEntries[] = {
    {"_lconnect_IICRcpp", (DL_FUNC) &_lconnect_IICRcpp, 4},
    {NULL, NULL, 0}
};

RcppExport void R_init_lconnect(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
