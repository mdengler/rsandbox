# from http://moderntoolmaking.blogspot.co.uk/2011/09/recession-forecasting-iii-better-naive.html
#Load current known recessions
library(xts)
ModRec <- read.csv("data/FRED/recession-data-modified.csv")
ModRec$DATE <- as.Date(ModRec$DATE)
ModRec <- xts(ModRec[,-1],order.by=ModRec[,1])

#Load actual recessions
library(quantmod)
setSymbolLookup(USREC=list(src="csv",format="%Y-%m-%d",dir="data/FRED"))
getSymbols('USREC',src='FRED')
#write.zoo(USREC, file="data/FRED/USREC.csv", sep=",")

#Check that actual recession values from the 2 datasets match
Check <- as.data.frame(cbind(ModRec,USREC))
all.equal(Check[,'VALUE'],Check[,'USREC'])

#Compare naive forecast to actuals
library(caret)
ModRec <- ModRec["1997-07-01::",] #Start from same period as Hussman's model
naiveforecast <- Lag(ModRec[,'MODIFIED.VALUE'],1)
actual <- ModRec[,'VALUE']
compare <- na.omit(merge(naiveforecast,actual))
confusionMatrix(compare[,1],compare[,2],positive = '1')
