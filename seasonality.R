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


chart.TimeSeries(spyml)



plotCircular(area1=spyml,labels=spymlm,dp=0)

spy$SPY.Month = format(time(spy$SPY.Close), "%m")

plotCircular(area1=spy$SPY.Close,labels=spy$SPY.Month,dp=0)

plot(ts(coredata(spyml)[,1], frequency=12))
plot(stl(ts(coredata(spyml)[,1], frequency=12), "periodic"))

y = coredata(spyml)[,1]
x = index(spyml)
plot(stl(ts(y, frequency=12), "periodic"), x)
plot(stl(zooreg(y, frequency=12), "periodic"), x)

n = 48
plot(stl(ts(tail(y, n=n), frequency=12), "periodic"), tail(x, n=n))


#http://www.math.mcmaster.ca/peter/s3n03/s3n03_0203/classnotes/tsandlaginr.html
lag.plot(y)


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



# other ideas
#from http://www.designandanalytics.com/recession-beard-time-series-in-R-part-2

library(XML)         # read.zoo
library(xts)         # our favorite time series
library(tis)         # recession shading.
library(ggplot2)     # artsy plotting
library(gridExtra)   # for adding a caption
library(timeDate)    # for our prediction at the end

# Get the data from the web as a zoo time series
URL <- 'http://robjhyndman.com/tsdldata/roberts/beards.dat'
beard <- read.zoo(URL,
    header=FALSE,
    index.column=0,
    skip=4,
    FUN=function(x) as.Date(as.yearmon(x) + 1865))
# Last line is tricky, check here:
#http://stackoverflow.com/questions/10730685/possible-to-use-read-zoo-to-read-an-unindexed-time-series-from-html-in-r/10730827#10730827

# Put it into xts, which is a more handsome time series format.
beardxts <- as.xts(beard)
names(beardxts) <- "Full Beard"

# Make into a data frame, for ggplotting
beard.df <- data.frame(
    date=as.Date(index(beardxts),format="%Y"),
    beard=as.numeric(beardxts$'Full Beard'))

# Make the plot object
bplot <- ggplot(beard.df, aes(x=date, y=beard)) +
    theme_bw() +
    geom_point(aes(y = beard), colour="red", size=2) +
    ylim(c(0,100)) +
    geom_line(aes(y=beard), size=0.5, linetype=2) +
    xlab("Year") +
    ylab("Beardfulness (%)") +
    opts(title="Percentage of American Men Fully Bearded")
print(bplot)

# Add recession shading
bplot2 <- nberShade(bplot,
    fill = "#C1C1FF",
    xrange = c("1866-01-01", "1911-01-01"),
    openShade = TRUE) # looks weird when FALSE

#Plot it
print(bplot2)
