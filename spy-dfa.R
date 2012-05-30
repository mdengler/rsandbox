#!/usr/bin/env R
# --no-restore --no-save -f $0

library(quantmod)
library(fractal)

getSymbols("SPY",src="google")
getSymbols("^VIX",src="yahoo")

SPY_CLOSE = Cl(SPY)
fractalBlock = DFA(coredata(SPY_CLOSE))

#str(fractalBlock)
#summary(fractalBlock)
DFA.walk <- fractalBlock
print(DFA.walk)

log_returns_SPY_CLOSE = diff(log(SPY_CLOSE))
fractalBlock = DFA(coredata(log_returns_SPY_CLOSE), detrend="poly2")
DFA.walk <- fractalBlock
print(DFA.walk)

fractalBlock = DFA(coredata(log_returns_SPY_CLOSE), detrend="poly1")
DFA.walk <- fractalBlock
print(DFA.walk)

fractalBlock = DFA(log_returns_SPY_CLOSE, detrend="poly2")
DFA.walk <- fractalBlock
print(DFA.walk)

fractalBlock = DFA(log_returns_SPY_CLOSE, detrend="poly1")
DFA.walk <- fractalBlock
print(DFA.walk)

# png(filename="DFA_%03d_med.png", width=480, height=480)
eda.plot(DFA.walk)
# dev.off()
