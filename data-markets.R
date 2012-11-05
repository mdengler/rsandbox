#!/usr/bin/env R
# --no-restore --no-save -f $0

library(quantmod)

# From http://r.789695.n4.nabble.com/quantmod-and-stock-splits-td3806006.html :
# Google does not adjust for dividends.  If you want to make the
# Google data match the Yahoo data, you need to adjust it for
# dividends (but not splits, because Google does that for you).
#
# To do that, try adjustOHLC(SPY,adjust='dividend') and getSplits(SPY)
# in a useful way...exercise for me, later :/

#x <- getSymbols( "^GSPC", src="yahoo", from="1900-01-01", auto.assign=FALSE) ; write.zoo(x, file="data/yahoo/^GSPC.csv", sep=",")
#x <- getSymbols( "SPY", src="yahoo", from="1900-01-01", auto.assign=FALSE) ; write.zoo(x, file="data/yahoo/SPY.csv", sep=",")
#x <- getSymbols("^TNX", src="yahoo", from="1900-01-01", auto.assign=FALSE) ; write.zoo(x, file="data/yahoo/^TNX.csv", sep=",")
#x <- getSymbols("^FVX", src="yahoo", from="1900-01-01", auto.assign=FALSE) ; write.zoo(x, file="data/yahoo/^FVX.csv", sep=",")
#x <- getSymbols("^TYX", src="yahoo", from="1900-01-01", auto.assign=FALSE) ; write.zoo(x, file="data/yahoo/^TYX.csv", sep=",")
#x <- getSymbols("000001.SS", src="yahoo", from="1900-01-01", auto.assign=FALSE) ; write.zoo(x, file="data/yahoo/000001.SS.csv", sep=",")


#x <- getSymbols("SPY", src="google", from="1900-01-01", auto.assign=FALSE); write.zoo(SPY, file="data/google/SPY.csv", sep=",")



# not sure whence to get these
#x <- getSymbols("XAUUSD=X", src="google", from="1900-01-01", auto.assign=FALSE) ; write.zoo(x, file="data/google/XAUUSD=X.csv", sep=",")
#x <- getSymbols("XAGUSD=X", src="google", from="1900-01-01", auto.assign=FALSE) ; write.zoo(x, file="data/google/XAGUSD=X.csv", sep=",")


#####################
# TODO
# http://www.liaad.up.pt/~ltorgo/DataMiningWithR/code3.html

###################################
# Usage examples

# setSymbolLookup(SPY=list(src="csv",format="%Y-%m-%d",dir="data"))
# SPY <- getSymbols("SPY", auto.assign=FALSE, adjust=TRUE)
# SPY_CLOSE = Cl(SPY)
#
# log_returns_SPY_CLOSE = diff(log(SPY_CLOSE))
# another way:
# n <- length(SPY_CLOSE); log_returns_SPY_CLOSE <- log(SPY_CLOSE[-n]/SPY_CLOSE[-1])
#
# fractalBlock = DFA(log_returns_SPY_CLOSE, detrend="poly1") ; DFA.walk <- fractalBlock ; print(DFA.walk)
# png(filename="DFA_%03d_med.png", width=480, height=480) ; eda.plot(DFA.walk) ; dev.off()
#
