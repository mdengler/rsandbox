# from http://stackoverflow.com/questions/2082553/using-ggplot2-and-rpanel-together
library(rpanel)
library(ggplot2)

poisson.draw = function(panel) {
  with(panel, {
     x = seq(0,n, by = 1)
     y = dpois(x, lambda)
     d = data.frame(cbind(x,y))
     p1 = ggplot(d, aes(x,y)) + geom_point()
     print(p1)
  })
  panel
}
panel <- rp.control("Poisson distribution", n = 30, lambda = 3, 
  ylim = 0.5)
rp.slider(panel, lambda, 1, 30, poisson.draw)



n = 10
lambda = 5

x = seq(0,n, by = 1)
y = dpois(x, lambda)
d = data.frame(cbind(x,y))
p1 = ggplot(d, aes(x,y)) + geom_point()

