# from R-finance message id 51C73567.3060600@linsomniac.com

require(quantmod)
require(fastcluster)
require(graphics)
symList <- c('MSN','GOOG','YHOO', 'BA', 'SI', 'BP', 'AMD','AMGN.MX')
getSymbols(symList)

# Matrix of daily returns. Or use weekly, monthly returns...
returns.mat <- NULL
for (sym in symList) returns.mat<- cbind(returns.mat,
                                         dailyReturn( Ad(get(sym)) ) )

colnames(returns.mat) <- symList
returns.mat
na.omit(returns.mat)

hc <- hclust(dist(t(na.omit(returns.mat))), "ave")
plot(hc)
plot(hc, hang = -1)
