library(quantmod)

setDefaults(getSymbols, auto.assign=FALSE, adjust=TRUE, src="yahoo")

stocks = getSymbols("^GSPC")
bonds  = getSymbols("^DJCBTI")  # also consider ^SPUSTTTR
gold   = getSymbols("IAU")
cds    = getSymbols("^STOXX50E")

# names(stocks)


#data = merge.zoo(stocks, bonds, gold, cds)
data = merge(stocks, bonds, gold, cds)

cor.test(data)
symnum(cor(data))




# good background reading: http://stackoverflow.com/questions/7089444/r-merge-two-irregular-time-series-solved
