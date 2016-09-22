setwd("/Users/jeremyalbright/Dropbox/MCAA/Webinars/Regression/Data")
setwd("C:/Users/Jeremy/Dropbox/MCAA/Webinars/Regression/Data")


dat<-read.csv("mtmv_data_10_12.csv")

# Create Imaginary Shape Variable
tempDV<-ifelse(is.na(dat$vote_share)==0,dat$vote_share,50.5)
tempIV<-rnorm(nrow(dat),scale(tempDV),1)
dat$shape <- rank(tempIV,ties.method="random")%/%(ceiling(length(tempIV)/3)+1)
dat$shape <- factor(dat$shape, levels=c(0:2),labels=c("Square","Circle","Triangle"))

attach(dat)

hist(vote_share,xlab="Republican Vote Share in District",col="indianred1",breaks=10,main="")
hist(mshare,xlab="Republican Tweet Share in District",col="dodgerblue",breaks=10,main="")

min(vote_share,na.rm=TRUE)
max(vote_share,na.rm=TRUE)
mean(vote_share,na.rm=TRUE)
median(vote_share,na.rm=TRUE)
sd(vote_share,na.rm=TRUE)

min(mshare,na.rm=TRUE)
max(mshare,na.rm=TRUE)
mean(mshare,na.rm=TRUE)
sd(mshare,na.rm=TRUE)

plot(vote_share~mshare,xlab="Proportion Tweets for Republican",ylab="Republican Vote Share",col="red",pch=20)
abline(lm(vote_share~mshare),lwd=1.5,lty=2,col="navy")
summary(lm(vote_share~mshare))
text(80,10,expression(paste(hat(Y) == 37.04 + .27,"b")),col="navy")
lines(c(50,50),c(0,50.54),lty=2,col="navy",lwd=2)
lines(c(-10,50),c(50.54,50.54),lty=2,col="navy",lwd=2)
points(50,50.54,pch=20,col="black",cex=2,lwd=2)

boxplot(vote_share~rep_inc,xaxt="n",ylab="Republican Vote Share",col=c("dodgerblue","indianred1"))
axis(1,c(1,2),c("Non-Republican Incumbent","Republican Incumbent"))
t.test(vote_share~rep_inc)
lm(vote_share~rep_inc)

boxplot(vote_share~shape,xaxt="n",ylab="Republican Vote Share",col=c("dodgerblue","indianred1","seagreen3"),xlab="Shape of District")
axis(1,c(1,2,3),c("Square","Circle","Triangle"))
summary(aov(vote_share~shape))
summary(lm(vote_share~shape))

