# http://stackoverflow.com/questions/8970823/how-to-load-csv-data-file-into-r-for-use-with-quantmod

library(quantmod)

# create sample data
getSymbols("SPY", from="1900-01-01")

#save
#write.zoo(SPY, file="SPY.csv", sep=",")

# set symbol lookup
setSymbolLookup(SPY=list(src="csv",format="%Y-%m-%d"))
# call getSymbols(.csv) with auto.assign=FALSE
spy <- getSymbols("SPY", auto.assign=FALSE)

#setDefaults(chartSeries, theme="white")
barChart(spy, theme="white")