#!/usr/bin/env R
# --no-restore --no-save -f $0

library(quantmod)
library(fractal)

getSymbols("SPY",src="google")
getSymbols("^VIX",src="yahoo")

SPY_CLOSE = Cl(SPY)
fractalBlock = DFA(coredata(SPY_CLOSE))

str(fractalBlock)
summary(fractalBlock)
DFA.walk <- fractalBlock
print DFA.walk

