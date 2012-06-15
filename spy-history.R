#!/usr/bin/env R
# --no-restore --no-save -f $0

# http://www.quantmod.com/examples/charting/

library(quantmod)
library(fractal)

spy = getSymbols("SPY",src="google")

chartSeries(spy, theme="white", TA="addVo();addBBands();addCCI()")
addOpCl <- newTA(OpCl,col='green',type='h')
addOpCl()


shanghai = getSymbols("000001.SS", auto.assign=FALSE)
chartSeries(shanghai, theme="white", TA="addVo();addBBands();addCCI()")
