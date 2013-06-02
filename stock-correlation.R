#!/usr/bin/env Rscript
# --no-restore --no-save -f $0

library(quantmod)
library(season)
library(PerformanceAnalytics)


# getSymbols("SPY", from="1900-01-01", src="yahoo")
# write.zoo(SPY, file="data/yahoo/SPY.csv", sep=",")
#   cd data ; ln -s yahoo/SPY.csv
# getSymbols("TLT", from="1900-01-01", src="yahoo")
# write.zoo(TLT, file="data/yahoo/TLT.csv", sep=",")
#   cd data ; ln -s yahoo/TLT.csv

# eur.usd <- get.hist.quote(instrument = "EUR/USD", provider = "oanda", start = "2004-01-01|_

setSymbolLookup(SPY=list(src="csv",format="%Y-%m-%d", dir="data"))
setSymbolLookup(TLT=list(src="csv",format="%Y-%m-%d", dir="data"))

s1 <- getSymbols("SPY", auto.assign=FALSE)
s1$s1.Close = s1$SPY.Close

s2 <- getSymbols("TLT", auto.assign=FALSE)
s2$s2.Close = s2$TLT.Close

#universe = merge(s1, s2, all=FALSE)
universe = merge(s1$s1.Close, s2$s2.Close, all=FALSE)

universe$s1.CloseL = log(universe$s1.Close)
universe$s2.CloseL = log(universe$s2.Close)

universe$s1.CloseM = monthlyReturn(universe$s1.Close)
universe$s2.CloseM = monthlyReturn(universe$s2.Close)

universe$s1.mlm = format(time(universe$s1.CloseM), "%m")
universe$s2.mlm = format(time(universe$s2.CloseM), "%m")

universe$s1.m = merge(universe$s1.CloseM, universe$sw.mlm)
universe$s2.m = merge(universe$s2.CloseM, universe$sw.mlm)

cor(universe)
symnum(cor(universe), show.max="-", symbols = c(" ", "3", "6", "9", "*", "-"))

