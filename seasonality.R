#!/usr/bin/env R
# --no-restore --no-save -f $0

# http://stackoverflow.com/questions/8970823/how-to-load-csv-data-file-into-r-for-use-with-quantmod

library(quantmod)
library(season)
library(PerformanceAnalytics)

# getSymbols("SPY", from="1900-01-01")
# write.zoo(SPY, file="SPY.csv", sep=",")

# set symbol lookup
setSymbolLookup(SPY=list(src="csv",format="%Y-%m-%d", dir="data"))
# call getSymbols(.csv) with auto.assign=FALSE
spy <- getSymbols("SPY", auto.assign=FALSE)

#spy$SPY.CloseMonthly = diff(log(spy$SPY.Close), lag=30)
spym  = monthlyReturn(spy$SPY.Close)

spy$SPY.CloseL = log(spy$SPY.Close)
spyml = monthlyReturn(spy$SPY.CloseL)
spymlm = format(time(spyml), "%m")
spym = merge(spyml, spymlm)


# other ways of generating returns
## ?Return.calculate
## ?ROC
## ?allReturns

aggregate(spyml, list(spymlm), mean)

## > colnames(spym)
## [1] "monthly.returns" "spymlm"

## > aggregate(spyml, list(spymlm), mean)

## 01  0.0011599204
## 02 -0.0009147371
## 03  0.0022493656
## 04  0.0044247731
## 05  0.0015866736
## 06 -0.0013248545
## 07  0.0007318037
## 08 -0.0006720283
## 09 -0.0014816244
## 10  0.0032614190
## 11  0.0031847884
## 12  0.0019140271

## > summary(aggregate(spyml, list(spymlm), mean))
##      Index   aggregate(spyml, list(spymlm), mean)
##  01     :1   Min.   :-0.0014816
##  02     :1   1st Qu.:-0.0007327
##  03     :1   Median : 0.0013733
##  04     :1   Mean   : 0.0011766
##  05     :1   3rd Qu.: 0.0024832
##  06     :1   Max.   : 0.0044248


y = coredata(spyml)[,1]
x = index(spyml)

plot(stl(ts(y, frequency=12), "periodic"), x)

stlspy = stl(zooreg(y, frequency=12), "periodic")
plot(stlspy, x)


n = 48
plot(stl(ts(tail(y, n=n), frequency=12), "periodic"), tail(x, n=n))

