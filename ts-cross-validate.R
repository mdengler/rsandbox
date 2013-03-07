#Setup
rm(list = ls(all = TRUE))
 
#Function to cross-validate a time series.
cv.ts <- function(x, FUN, tsControl, ...) {
	
	#Load required packages
	stopifnot(is.ts(x))
	stopifnot(require(forecast))
	stopifnot(require(foreach))
	stopifnot(require(plyr))
 
	#Load parameters from the tsControl list
	stepSize <- tsControl$stepSize
	maxHorizon <- tsControl$maxHorizon
	minObs <- tsControl$minObs
	fixedWindow <- tsControl$fixedWindow
	summaryFunc <- tsControl$summaryFunc
	
	#Define additional parameters
	freq <- frequency(x)
	n <- length(x)
	st <- tsp(x)[1]+(minObs-2)/freq
 
	#Create a matrix of actual values, that we will later compare to forecasts.
	#X is the point in time, Y is the forecast horizon
	formatActuals <- function(x,maxHorizon) {
		actuals <- outer(seq_along(x), seq_len(maxHorizon), FUN="+")
		actuals <- apply(actuals,2,function(a) x[a])
		actuals
	}
	actuals <- formatActuals(x,maxHorizon)
	actuals <- actuals[minObs:(length(x)-1),]
 
	#At each point in time, calculate 'maxHorizon' forecasts ahead
	#This is the 'Main Function'
	forcasts <- foreach(i=1:(n-minObs), .combine=rbind, .multicombine=FALSE) %dopar% {
		
		if (fixedWindow) {
			xshort <- window(x, start=st+(i-minObs+1)/freq, end=st+i/freq)
		} else { 
			xshort <- window(x, end=st + i/freq)
		}
 
		return(FUN(xshort, h=maxHorizon, ...))
	}
	
	#Asess Accuracy at each horizon
	out <- data.frame(
					ldply(1:maxHorizon, 
						function(horizon) {
							P <- forcasts[,horizon]
							A <- na.omit(actuals[,horizon])
							P <- P[1:length(A)]
							summaryFunc(P,A)
						}
					)
				)
	
	#Calculate mean accuracy across all horizons
	overall <- colMeans(out)
	out <- rbind(out,overall)
	
	#Add a column for which horizon and output
	return(data.frame(horizon=c(1:maxHorizon,'All'),out))
}
