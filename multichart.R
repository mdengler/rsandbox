library(quantmod)
symbols = list("AAPL", "SPY", "000001.SS")

hash <- function( keys ) {
    result <- new.env( hash = TRUE, parent = emptyenv(), size = length( keys ) )
    for( key in keys ) {
        result[[ key ]] <- NA
    }
    return( result )
}

bars = hash(symbols)

for (symbol in symbols) {
    bars[[symbol]] = getSymbols(symbol, from="1900-01-01", auto.assign=FALSE, adjust=TRUE)
}
