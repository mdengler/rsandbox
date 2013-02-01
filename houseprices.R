require("googleVis")
housing_pricesDF <- read.csv("housing_pricesDF.csv", header=TRUE)
housing_prices <- gvisLineChart (housing_pricesDF, options=list (title = "OECD Housing Prices 1975-2012", 
		#gvis.editor = "OECD Housing Prices 1975-2012", 
		height = 1000,
		width = 1000,
		legend = "right",
		backgroundColor = "white",
		vAxis="{title:'House Prices', gridlines:{color:'grey', count:5}}",
		hAxis="{title:'Year', titleTextStyle:{color:'black'}}",
		#curveType = "function",
		titleTextStyle = "{color:'black',
				     fontName:'Cambria',
				     fontSize:20}"
))
plot(housing_prices)
