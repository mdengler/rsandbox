#!/usr/bin/env R
# --no-restore --no-save -f $0

library(quantmod)
getSymbols("SPY",src="google")
getSymbols("^VIX",src="yahoo")

mm <- specifyModel(Next(OpCl(SPY)) ~ OpCl(SPY) + Cl(VIX))


library(fpp)
fc = forecast(Cl(SPY))
summary(fc)
plot(fc)
