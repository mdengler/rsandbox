#!/usr/bin/env R
# --no-restore --no-save -f $0

# http://www.quantmod.com/examples/charting/

library(quantmod)
library(fractal)

getSymbols("SPY",src="google")

chartSeries(SPY, theme="white", TA="addVo();addBBands();addCCI()")
addOpCl <- newTA(OpCl,col='green',type='h')
addOpCl()