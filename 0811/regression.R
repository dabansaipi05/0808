rm(list=ls(all=TRUE))
library(XML)
library(bitops)
library(RCurl)
library(NLP)
library(httr)
library(ggplot2)

ggplot(data=mdf, aes(x=date, y=Price, group=FX, colour=FX)) +
  geom_line() +
  geom_point( size=1, shape=1, fill="white" ) +
  scale_x_discrete(at, mdf$date[at]) +
  xlab("Date")

# regression y = b1 x1 + b2 x2 + b3 x3
train = 1:100
predict = 101:153
oneV = rep(1, length(train))
X = as.matrix( cbind(oneV, price[train,2:4]) )
Y = as.matrix( price[train, 5] )
Beta = solve(t(X) %*% X) %*% t(X) %*% Y
oneV = rep(1, length(predict))
Xpred = as.matrix( cbind(oneV, price[predict, 2:4]) )
plot(predict, Xpred%*%Beta)
lines(predict, price[predict,5])
