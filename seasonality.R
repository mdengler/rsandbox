#!/usr/bin/env R
# --no-restore --no-save -f $0

# http://stackoverflow.com/questions/8970823/how-to-load-csv-data-file-into-r-for-use-with-quantmod

library(quantmod)
library(season)

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

aggregate(spyml, list(spymlm), mean)


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


plotCircular(area1=spyml,labels=spymlm,dp=0)

spy$SPY.Month = format(time(spy$SPY.Close), "%m")

plotCircular(area1=spy$SPY.Close,labels=spy$SPY.Month,dp=0)

plot(stl(spy$SPY.CloseMonthly, s.window=30))

#setDefaults(chartSeries, theme="white")
barChart(spy, theme="white")




# another approach:

spyc <- ts(spy$SPY.Close, f=4)
fit <- ts(rowSums(tsSmooth(StructTS(spyc))[,-2]))
tsp(fit) <- tsp(spyc)
plot(spyc)
plot(spy$SPY.Close)
lines(fit,col=2)

#The idea is to use a basic structural model for the time series,
#which handles the missing value fine using a Kalman filter. Then a
#Kalman smooth is used to estimate each point in the time series,
#including any omitted.
#
#I had to convert your zoo object to a ts object with frequency 4 in
#order to use StructTS. You may want to change the fitted values back
#to zoo again.



# primitive plotCircular example
#daysoftheweek<-c('Monday','Tuesday','Wednesday','Thursday','Friday', 'Saturday','Sunday')
#weekfreq<-table(round(runif(100,min=1,max=7)))
#plotCircular(area1=weekfreq,labels=daysoftheweek,dp=0)
