#' descricao da funcao que aparece no in icio do documento de apoio da funcao
#' @title
#' @description
#' @param landscape Landscape object produced by upload.landscape
#' @param metric Landscape metrics to be computed
#' @usage l.metric (landscape, metric)
#' @return que valores a funcao retorna
#' @examples exemplos de aplicacao com dados fornecidos pelo package
#' @references artigos em que se baseia a funcao
#' @author Frederico Mestre
#' @export
l.metric <- function (landscape, metric) {
# landscape object produced by upload.landscape
# metric - landscape metrics to be computed

#faltam as fórmulas e algum código antes das métricas

#create result vector
result <- c()

#CCP
    if("CCP" %in% metric)
{
}
result <- c(result, CCP = sum (r0))#has to be corrected

#LCP
    if("LCP" %in% metric)
{
}
result <- c(result, LCP = sum(r0_vec))#has to be corrected

#CPL
    if("CPL" %in% metric)
{
}
result <- c(result, CPL = mean(m0,na.rm=TRUE))

#ECS
    if("ECS" %in% metric)
{
}
result <- c(result, ECS = a_num/a)

#AWF
    if("AWF" %in% metric)
{
}
result <- c(result, AWF = (sum(paths[, 3]*paths[, 4]*paths[, 5])))

#IIC
    if("IIC" %in% metric)
{
}
result <- c(result, IIC = sum(paths[, 6])/Al2)

#PC
    if("PC" %in% metric)
{
}
result <- c(result, PC = (PCnum/Al2^2))

#ECA
    if("ECA" %in% metric)
{
}
result <- c(result, ECA = EC)

#provide results
	return(round(result,5))
}
