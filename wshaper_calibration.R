trafficdata <- read.csv("/home/martin/tmp/wshaper-calibrate_output_second.txt", header=TRUE)

# correlation of two series
cor.test(trafficdata$uplink, trafficdata$mdev) # 0.803 - correlated
cor.test(trafficdata$ecn, trafficdata$mdev) # -0.0188 - not correlated

# correlation matrix for all series
cor(trafficdata)
##             packetloss        mdev     downlink       uplink          ecn
## packetloss  1.00000000  0.47121419 -0.046186536  0.628801470 -0.027456832
## mdev        0.47121419  1.00000000 -0.032457781  0.802990878 -0.018808923
## downlink   -0.04618654 -0.03245778  1.000000000 -0.001089056  0.001292956
## uplink      0.62880147  0.80299088 -0.001089056  1.000000000  0.003139004
## ecn        -0.02745683 -0.01880892  0.001292956  0.003139004  1.000000000

# easier way to see that
symnum(cor(trafficdata), show.max="-")

symnum(cor(trafficdata), show.max="-", symbols = c(" ", "3", "6", "9", "", "-"))
##            p m d u e
## packetloss -
## mdev       3 -
## downlink       -
## uplink     6 9   -
## ecn                -
## attr(,"legend")
## [1] 0 ‘ ’ 0.3 ‘3’ 0.6 ‘6’ 0.8 ‘9’ 0.9 ‘’ 0.95 ‘-’ 1


# I like this idea, but the symbols are not the same width :(
symnum(cor(trafficdata), show.max="-", symbols = c(" ", "", "", "", "", "-"))

plot(trafficdata$uplink, trafficdata$mdev)
plot(trafficdata)


# consider ggplot2 for ranges:
# http://r.789695.n4.nabble.com/adding-the-mean-and-standard-deviation-to-boxplots-td861308.html
## library(ggplot2)
## r <- ggplot(ToothGrowth, aes(y=len, x=factor(dose)))
## r$background.fill = "cornsilk"
## r + geom_boxplot(aes(colour=supp)) + stat_summary(aes(group=supp),fun="mean_cl_normal",colour="red",geom="smooth",linetype=3,size=1) + stat_summary(aes(group=supp),fun="mean_cl_normal",colour="blue",geom="point",size=4)
## grid.gedit("label", gp=gpar(fontsize=10, col="red")) # color the axis labels

# another ggplot2 example:
# http://stackoverflow.com/questions/4733182/how-to-highlight-time-ranges-on-a-plot
## p <- ggplot(data=diamonds, aes(x=price, y=carat)) + geom_line(aes(color=color))
## rect <- data.frame (
##     xmin=5000, xmax=10000, ymin=-Inf, ymax=Inf)
## p + geom_rect(data=rect, aes(xmin=xmin, xmax=xmax, ymin=ymin, ymax=ymax), color="grey20", alpha=0.5, inherit.aes = FALSE)
## Also note that ymin and ymax could be set to -Inf and Inf with ease.

# might want to use par("usr") to get ylim of main plot for overlay plots:
# http://stackoverflow.com/questions/8415220/how-to-get-the-range-ylim-of-a-plot
## my_plot <- boxplot(a ~ b, outline=F)
## But the parameters inside my_plot only concern statistical information but not plotting.
## UPDATE: Nick's @nick-sabbe suggestion (par("yaxp")[1:2]) partially works. It returns properly the value of each of the labels in each extreme on the Y-axis. The correct way is to use par('usr')
