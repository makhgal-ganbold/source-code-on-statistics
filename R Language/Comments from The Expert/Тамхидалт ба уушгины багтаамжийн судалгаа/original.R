#### R Code for Mathematical Statistic ####
###            May 8, 2017              ###
##   ID: 14b1seas0946 Name: Chinzorigt   ##
###### Uushignii bagtaamj bolon tamhi tatdag humuusiin tuuver######
# Ogogdliig tsugluulah
LungCapData <-read.table(file="C:/Users/chinzo/Desktop/MATH/LungCapData.txt" , header=TRUE, sep="\t")
LungCapData <-read.table(file.choose(),header=T, sep="\t")
attach(LungCapData)
# Ajillah orchin zaaj ogoh
projectHW <- "C:/Users/chinzo/Desktop/MATH"
setwd(projectHW)
getwd()
# Husnegten medeellee harah
View(LungCapData)
# Hemjeesiig n harah
dim(LungCapData)
# Ogogdol tuuverlej harah
head(LungCapData)
tail(LungCapData)
LungCapData[c(5,10,7,2,9),]
# Zoriltot ded olonloguudiin ner harah
names(LungCapData)
# Uushignii bagtaamjiin tarhalt
LungCap
# Huvisagchiin torol harah
class(Age) ; class(LungCap); class(Height); class(Smoke); class(Gender)
# Chanariin ogogdliin avah utguudiig harah
levels(Smoke); levels(Gender)
# Tovch medeelel
summary(LungCapData)
summary(LungCap)
summary(Smoke)
# Torol solih
x <- c(0,1,1,1,0,0,0,0,0,0)
x <- as.factor(x)
# Tuuver 
FemData <- LungCapData[Gender=="female",]
MaleData <- LungCapData[Gender=="male",]
# 15aas deesh nasnii eregteichuudiin tuuver
MaleOver15 <- LungCapData[Gender=="male" & Age>15,]
#Logic Statements
FemSmoke <- Gender=="female" & Smoke=="yes"
MoreData <- cbind(LungCapData, FemSmoke)
head(MoreData)
#### Ogogdliig tailbarlah n ####
# Tegsh ontsogt diagramm
count <- table(Gender)
percent <- table(Gender)/length(Gender)
barplot(percent, main="Eregtei emegtein ezleh huvi", xlab="Gender", ylab="%", las=1,
        names.arg=c("Male", "Female"))
barplot(percent, main="Eregtei emegtein ezleh huvi", xlab="Gender", ylab="%", las=1,
        names.arg=c("Male", "Female"), horiz=TRUE)
# Dugui diagramm 
pie(count, main="Eregtei emegtein ezleh huvi")
# Hairtsgan diagramm
boxplot(LungCap)
quantile(LungCap, probs=c(0, 0.25, 0.5, 0.75, 1))
boxplot(LungCap, main="Boxplot", ylab="Lung Capacity", ylim=c(0,16), las=1)
boxplot(LungCap ~ Gender, main="Boxplot by Gender")
boxplot(LungCap[Gender=="female"], LungCap[Gender=="male"])
# Nasaar n bulegleh
AgeGroups <- cut(Age, breaks=c(0, 13, 15, 17, 25),labels=c("<13","14/15",
                                                           "16/17","18+"))
AgeGroups
Age[1:5]
AgeGroups[1:5]
levels(AgeGroups)
# Hairtsgan diagramm
boxplot(LungCap~Smoke, ylab="Uushignii bagtaamj", main="Tamhi tatdag bolon tatdaggui humuusiin haritsaa", las=1)
boxplot(LungCap[Age>=18]~Smoke[Age>=18], ylab="Uushignii bagtaamj", main="18-s deesh nasnii humuus", las=1)
boxplot(LungCap~Smoke*AgeGroups, ylab="Uushignii bagtaamj", main="Nas nasnii tamhi tatdag humuus"
        , las=2, col=c(4,2))
legend(x=5.5 , y=4.5, legend=c("Tatdag", "Tatdaggui"), col=c(4,2), pch=15, cex=0.8)
# Histograms
hist(LungCap)
hist(LungCap, freq=FALSE)
hist(LungCap, prob=T)
hist(LungCap, prob=T, ylim=c(0,0.2))
hist(LungCap, prob=T, ylim=c(0,0.2), breaks=7)
hist(LungCap, prob=T, ylim=c(0,0.2), breaks=c(0,2,4,6,8,10,12,14,16))
hist(LungCap, prob=T, ylim=c(0,0.2), breaks=seq(from=0, to=16, by=1.5),main=
       "Uushignii bagtaamjiin Histogram", xlab="Lung Capacity", las =1)
# Polygon
lines(density(LungCap), col=2, lwd=3)
# Tegsh ontsogt diagramm
Table1 <- table(Smoke, Gender)
barplot(Table1)
barplot(Table1, beside=T, legend.text=c("Non-Smoke", "Smoke"), main
        = "Gender and Smoking", xlab="Gender", las=1, col=c(2,4))
mosaicplot(Table1)
# Tsegen diagramm
class(Age); class(Height)
summary(Height)
summary(Age)
cor(Age, Height) # corriliance
plot(Age, Height)
plot(Age, Height, main="Scatterplot", xlab="AGE", ylab="HEIGHT", las=1, 
     xlim=c(0,25), cex=0.5)
plot(Age, Height, main="Scatterplot", xlab="AGE", ylab="HEIGHT", las=1, 
     xlim=c(0,25), pch=8, col=2)
# Shugaman hamaaral
abline(lm(Height~Age),col=4)
# Kvadrat hamaaral
lines(smooth.spline(Age, Height))
lines(smooth.spline(Age, Height), lty=2, lwd=5)
# Disperse, Math dundaj, standaart hazailt, median oloh
table(Smoke)/length(Smoke)
table(Smoke, Gender)
mean(LungCap, trim=0.10)
median(LungCap)
var(LungCap) #Disperse 
sd(LungCap)^2 # Dispersiig standart hazailtaar n oloh
sd(LungCap) # Standart hazailt
sqrt(var(LungCap)) # Standart hazailtiig disperseer oloh
min(LungCap)
max(LungCap)
range(LungCap)
quantile(LungCap, probs=0.90) #quantile
quantile(LungCap, probs=c(0.20,0.5,0.9,1)) #quantile
sum(LungCap)/length(LungCap) #dundaj
mean(LungCap) #dundaj
cor(LungCap, Age) #Corrilyatsi
cor(LungCap, Age, method="spearman") #Spearmanii arga ashiglasan corrilliance
cov(LungCap, Age) # covariance
# # # # Binomial Distribution  # # # #
help(dbinom)
#P(X=3)
dbinom(x=3, size=20, prob=1/6)
#P(X=0) & P(X=1) & ... & P(X=3)
dbinom(x=0:3, size=20, prob=1/6)
#P(X <= 3)
sum(dbinom(x=0:3, size=20, prob=1/6))
pbinom(q=3, size=20, prob=1/6, lower.tail=T)
# # # # Poisson Distribution # # # #
#P(X=4)
dpois(x=4, lambda=7)
#P(X=0) & P(X=1) & ... & P(X=4)
dpois(x=0:4, lambda=7)
#P(X <= 3)
sum(dpois(x=0:4, lambda=7))
ppois(q=4, lambda=7, lower.tail=T)
#P(X >= 12)
ppois(q=12, lambda=7, lower.tail=F)
# # # # The Normal Distribution # # # #
# P(X <= 70)
pnorm(q=70, mean=75, sd=5, lower.tail=T )
pnorm(q=70, mean=75, sd=5)
# P(X >= 85)
pnorm(q=85, mean=75, sd=5, lower.tail=F)
# P(Z >= 1)
pnorm(q=1, mean=0, sd=1, lower.tail=F)
# find Q1
qnorm(p=0.25, mean=75, sd=5, lower.tail=T)
x <- seq(from=55, to=95, by=0.25)
dens <- dnorm(x, mean=75, sd=5)
plot(x,dens)
plot(x, dens, type="l")
plot(x, dens, type="l", main="X~Normal: Mean=75, SD=5", xlab="x", ylab="Probability Density", las=1)
abline(v=75)
rand <- rnorm(n=40, mean=75, sd=5)
hist(rand)
# # # # The Student t distribution # # # #
help(pt)
# t- stat=2.3, df=25
# one-sided pvalue
# P(t > 2.3)
pt(q=2.3, df=25, lower.tail=F)
# two-sided pvalue
pt(q=2.3, df=25, lower.tail=F) + pt(q=-2.3, df=25, lower.tail=T)
pt(q=2.3, df=25, lower.tail=F)*2
# find t for 95% confidence
# value of t with 2.5% in each tail
qt(p=0.025, df=25, lower.tail=T)
# # # # One Sample Test # # # #
boxplot(LungCap)
# Ho: mu <8
# one sided 95% confidence interval for mu
t.test(LungCap, mu=8, alternative="less", conf.level=0.95)
t.test(LungCap, mu=8, alt="less", conf=0.95)
# Two-sided 
t.test(LungCap, mu=8, alt="two.sided", conf=0.95)
t.test(LungCap, mu=8, alt="two.sided", conf=0.99)
TEST <-t.test(LungCap, mu=8, alt="two.sided", conf=0.99)
TEST
attributes(TEST)
TEST$conf.int
TEST$p.value


