#### R Code for Mathematical Statistic ####
###            May 8, 2017              ###
##   ID: 14b1seas0946 Name: Chinzorigt   ##
###### Uushignii bagtaamj bolon tamhi tatdag humuusiin tuuver######
# Ogogdliig tsugluulah
LungCapData <-read.table(file="C:/Users/chinzo/Desktop/MATH/LungCapData.txt" , header=TRUE, sep="\t")
  # Багануудыг tab-аар тусгаарласан, толгой (хүснэгтийн баганын гарчиг) бүхий текст файлаас өгөгдөл импортлон авч LungCapData нэр бүхий датафрейм төрлийн объектод оноож байна
  # Бодит өгөгдөл нь өөрөөр хэлбэл дээрх файл нь шейрлэгдээгүй байсан тул бүх тайлбарыг зөвхөн R хэлний мэдлэгтээ тулгаарлаж өгөх болж байна.
LungCapData <-read.table(file.choose(),header=T, sep="\t")
  # Файл сонгох цонх нээгдэнэ. T бол TRUE тогтмолын товчлол юм.
attach(LungCapData)
  # LungCapData датафрейм дахь хувьсагдыг шууд дуудах боломж бүрдүүлж байна. Тодруулбал LungCapData$var.name гэхийн оронд шууд var.name гэж хандаж болно гэсэн үг.
# Ajillah orchin zaaj ogoh
projectHW <- "C:/Users/chinzo/Desktop/MATH"
  # Хавтасны нэр агуулсан тэмдэгт мөр төрлийн скаляр хувьсагч үүсгэж байна
setwd(projectHW)
  # Ажлын хавтас зааж өгч байна. R програмаас файл бичих болон уншихаар хандах хавтсыг зааж байна гэж ойлгож болно.
getwd()
  # Ажлын хавтасны хаягийг хэвлэнэ. Дээрх тушаалаа шалгаж баталгаажуулж байгаа ажээ.
# Husnegten medeellee harah
View(LungCapData)
  # Датафреймын агуулгыг харуулах
# Hemjeesiig n harah
dim(LungCapData)
  # Мөрийн тоо болон баганын тоог агуулсан вектор хэлбэртэй утга хэвлэнэ.
# Ogogdol tuuverlej harah
head(LungCapData)
  # Датафреймын эхний хэдэн мөрийг хэвлэнэ.
tail(LungCapData)
  # Датафреймын сүүлийн хэдэн мөрийг хэвлэнэ.
LungCapData[c(5,10,7,2,9),]
  # Датафреймын 5, 10, 7, 2, 9 дүгээр мөрүүдийг (бүх багана) хэвлэнэ.
# Zoriltot ded olonloguudiin ner harah
names(LungCapData)
  # Датафрейм дахь хувьсагч буюу баганын нэр хэвлэнэ.
# Uushignii bagtaamjiin tarhalt
LungCap
  # Датафреймыг хэвлэнэ
# Huvisagchiin torol harah
class(Age) ; class(LungCap); class(Height); class(Smoke); class(Gender)
  # Age, LungCap, Height, Smoke, Gender хувьсагчдын утгын төрөл буюу классыг хэвлэнэ.
  # Энэ тохиолдолд numeric болон factor классууд л байх боломжтой. Учир нь read.table() функцийн импортлох багана буюу хувьсагчийн классыг зааж удирдах аргументын утгыг дээр өөрчилж заагаагүй байсан.
  # Иймд уг функц тэмдэгт мөрүүдийг чанарын хувьсагч буюу фактор болгож хувиргах болно.
# Chanariin ogogdliin avah utguudiig harah
levels(Smoke); levels(Gender)
  # Эндээс үзвэл Smoke, Gender хувьсагчид фактор классынх ажээ.
  # Тус хувьсагчдын бүх утга буюу ангиийг хэвлэнэ.
# Tovch medeelel
summary(LungCapData)
summary(LungCap)
summary(Smoke)
  # Дээр тухайн судлаачийн бичсэнчлэн товч мэдээлэл хэвлэгдэнэ.
  # Нэмж хэлэхэд summary() нь ерөнхий (generic) функц бөгөөд тухайлбал Smoke хувьсагчийн хувьд угтаа factor класст тодорхойлсон summary.factor() функц ажиллана.
# Torol solih
x <- c(0,1,1,1,0,0,0,0,0,0)
x <- as.factor(x)
  # Чанарын хувьсагч шинээр (хэрэв LungCapData датафрейм дотор x гэсэн нэртэй багана байхгүй тохиолдолд) үүсгэж байна. Энэ хувьсагчийг ямар зорилгоор үүсгэсэн нь яваандаа тодорхой болох биз ээ.
# Tuuver 
FemData <- LungCapData[Gender=="female",]
MaleData <- LungCapData[Gender=="male",]
  # Өгөгдлөө эрэгтэй, эмэгтэйгээр нь ялгаж авч байна.
  # Эндээс харвал анх импортолсон өгөгдлийн файлд хүйсийг female, male гэж тект хэлбэрээр өгсөн байжээ.
  # Цаашилбал read.table() функцийн ажиллах зарчим буюу аргументын анхны (default) утгыг анхаарвал уг функц Gender хувьсагчийг нэрлэсэн төрлийн хэмжээстэй гэж авсан ажээ.
  # Тодруулбал ordered = FALSE (is.ordered(x) функцээс FALSE утга буцна) байдлаар ажилласан гэсэн үг юм.
# 15aas deesh nasnii eregteichuudiin tuuver
MaleOver15 <- LungCapData[Gender=="male" & Age>15,]
  # R хэлэнд логик векторыг элементийн индекс байдлаар ашиглаж болдог бөгөөд энэ тохиолдолд
  # LungCapData датафреймын Gender хувьсагчийн утга male байхын зэрэгцээ (логикийн AND үйлдэл) Age хувьсагчийн утга 15-аас эрс их байх мөрүүдийг (бүх багана) сонгоод MaleOver15 датафрейм болгон авч байна.
#Logic Statements
FemSmoke <- Gender=="female" & Smoke=="yes"
  # Түүврийн элемент нэг бүрчлэн дээрх нөхцлийг хангасан эсэхийг заасан логик утга бүхий вектор үүснэ.
MoreData <- cbind(LungCapData, FemSmoke)
  # Дээрх логик векторыг анхны датафреймтэй нийлүүлж өөр нэг шинэ датафрейм үүсгэж байна.
head(MoreData)
  # Дээр тайлбарласан функц
#### Ogogdliig tailbarlah n ####
  # Одоо шинжилгээний хэсэгтээ орж буй бололтой.
# Tegsh ontsogt diagramm
count <- table(Gender)
  # Gender хувьсагчийн female, male утгуудын давтамжийг олж байна.
percent <- table(Gender)/length(Gender)
  # Харьцангуй давтамж олж байна.
barplot(percent, main="Eregtei emegtein ezleh huvi", xlab="Gender", ylab="%", las=1,
        names.arg=c("Male", "Female"))
  # тэгш өнцөгт диаграм байгуулж байна.
barplot(percent, main="Eregtei emegtein ezleh huvi", xlab="Gender", ylab="%", las=1,
        names.arg=c("Male", "Female"), horiz=TRUE)
  # тэгш өнцөгт диаграмыг хэвтээ босоо янз бүрээр л байгуулаад байна.
# Dugui diagramm 
pie(count, main="Eregtei emegtein ezleh huvi")
  # За дугуй диаграм аа..
  # Хүйсийн тархалтыг харуулъя гэвэл анхнаасаа л дугуй диаграмаа л байгуулахад болох байсан юм.
# Hairtsgan diagramm
boxplot(LungCap)
  # Хайрцган диаграм байгуулаад л орхиж байна.
  # Орхиж байна гэдгийн учир нь уг функц зүгээр л диаграм байгуулахаас гадна тус диаграмд холбогдох статистик үзүүлэлтүүдийг (онцгой утга, квартилууд гэх мэт) буцаадаг юм. 
quantile(LungCap, probs=c(0, 0.25, 0.5, 0.75, 1))
  # Хамгийн их болон бага утгууд бас квартилууд олж байна.
boxplot(LungCap, main="Boxplot", ylab="Lung Capacity", ylim=c(0,16), las=1)
  # Бас л хайрцган диаграм..
boxplot(LungCap ~ Gender, main="Boxplot by Gender")
  # formula бичээд тамхидалтын хэмжээг хүйсээр салгаж харьцуулсан хайрцган диаграм байгуулж байна.
boxplot(LungCap[Gender=="female"], LungCap[Gender=="male"])
  # Өмнө formula бичсэнтэй ялгаагүй үр дүн гарна.
# Nasaar n bulegleh
AgeGroups <- cut(Age, breaks=c(0, 13, 15, 17, 25),labels=c("<13","14/15",
                                                           "16/17","18+"))
  # breaks аргументаар өгсөн утгуудаар насны бүлгүүд үүсгэж байна.
AgeGroups
  # Үүсгэсэн бүлгүүдээ хэвлэж үзэж байна.
Age[1:5]
  # Age хувьсагчийн эхний таван утга хэвлэнэ.
AgeGroups[1:5]
  # Үүсгэсэн бүлгүүдээ хэвлэж үзэж байна.
levels(AgeGroups)
  # Үүсгэсэн бүлгүүдийнээ анги зэргийг хэвлэж үзэж байна.
# Hairtsgan diagramm
boxplot(LungCap~Smoke, ylab="Uushignii bagtaamj", main="Tamhi tatdag bolon tatdaggui humuusiin haritsaa", las=1)
boxplot(LungCap[Age>=18]~Smoke[Age>=18], ylab="Uushignii bagtaamj", main="18-s deesh nasnii humuus", las=1)
boxplot(LungCap~Smoke*AgeGroups, ylab="Uushignii bagtaamj", main="Nas nasnii tamhi tatdag humuus"
        , las=2, col=c(4,2))
  # Тайлбараа бөөндчихье.
  # formula ашиглаж LungCap хувьсагчийг Smoke чанарын хувьсагчийн ангиудаар улмаар
  # насанд хүрэгчдийг ялгаж эцэст нь насны бүлгүүдээр нэмж ялган харьцуулж харуулж байа.
legend(x=5.5 , y=4.5, legend=c("Tatdag", "Tatdaggui"), col=c(4,2), pch=15, cex=0.8)
  # Байгуулсан диаграмдаа тайлбар нэмж өгч байна.
# Histograms
hist(LungCap)
  # Гистгорам байгуулах
hist(LungCap, freq=FALSE)
  # Гистгорам байгуулах, харьцангуй давтамжаар
hist(LungCap, prob=T)
  # Гистгорам байгуулах, харьцангуй давтамжаар
hist(LungCap, prob=T, ylim=c(0,0.2))
  # Давтамжид харгалзах тэнхлэгийн эхлэл, төгсгөлийн утгыг зааж байна.
hist(LungCap, prob=T, ylim=c(0,0.2), breaks=7)
  # Тэгш өнцөгтүүдийн тоог 7 гэж зааж байна.
  # Гэвч функцийн алгоритмаас хамаарч яг 7 тэгш өнцөгт гарахгүй байж болно.
hist(LungCap, prob=T, ylim=c(0,0.2), breaks=c(0,2,4,6,8,10,12,14,16))
  # Тэгш өнцөгтийн тоо болон хуваалт болж өгөөгүй бололтой. Одоо хуваалтаа гараар зааж өгч байна.
hist(LungCap, prob=T, ylim=c(0,0.2), breaks=seq(from=0, to=16, by=1.5),main=
       "Uushignii bagtaamjiin Histogram", xlab="Lung Capacity", las =1)
  # Алхмаа 1.5 болгож багасгасан л байна. Олон бутархай тоо бичихийг хялбарчилж seq() функц ашиглажээ.
# Polygon
lines(density(LungCap), col=2, lwd=3)
  # Полигон нэмж зурж байна.
# Tegsh ontsogt diagramm
Table1 <- table(Smoke, Gender)
  # Smoke болон Gender хувьсагчдын хамтын давтамжийн хүснэгт байгуулж байна.
barplot(Table1)
barplot(Table1, beside=T, legend.text=c("Non-Smoke", "Smoke"), main
        = "Gender and Smoking", xlab="Gender", las=1, col=c(2,4))
mosaicplot(Table1)
  # Дээрх хамтын давтамжийг диаграммуудаар харуулж байна.
# Tsegen diagramm
class(Age); class(Height)
  # Age болон Height хувьсагчдын төрөл буюу классыг харуулна. Энэ бараг л numeric байх болов уу.
summary(Height)
summary(Age)
  # Дээрх хувьсагчдын тайлбарлах статистикууд гарна.
cor(Age, Height) # corriliance
  # Корреляцын матриц гарна.
plot(Age, Height)
plot(Age, Height, main="Scatterplot", xlab="AGE", ylab="HEIGHT", las=1, 
     xlim=c(0,25), cex=0.5)
plot(Age, Height, main="Scatterplot", xlab="AGE", ylab="HEIGHT", las=1, 
     xlim=c(0,25), pch=8, col=2)
  # Хоёр хувьсагчийн холбоо хамаарлыг харуулсан цэгэн диаграм байгуулж байна.
# Shugaman hamaaral
abline(lm(Height~Age),col=4)
  # Өмнөх цэгэн диаграм дээрээ регрессийн шулуун нэмж өгч байна.
# Kvadrat hamaaral
lines(smooth.spline(Age, Height))
lines(smooth.spline(Age, Height), lty=2, lwd=5)
  # За хамаарал нь шулуун байгаагүй юм байлгүй дээ.
# Disperse, Math dundaj, standaart hazailt, median oloh
table(Smoke)/length(Smoke)
table(Smoke, Gender)
  # Давтамж олох
mean(LungCap, trim=0.10)
  # Түүврийн дундаж
median(LungCap)
  # Түүврийн медиан
var(LungCap) #Disperse 
  # Түүврийн дундаж квадрат хазайлт
sd(LungCap)^2 # Dispersiig standart hazailtaar n oloh
  # Түүврийн дундаж квадрат хазайлт
sd(LungCap) # Standart hazailt
  # Түүврийн стандарт хазайлт
sqrt(var(LungCap)) # Standart hazailtiig disperseer oloh
  # Түүврийн стандарт хазайлт
min(LungCap)
  # Түүврийн хамгийн бага утга
max(LungCap)
  # Түүврийн хамгийн их утга
range(LungCap)
  # Түүврийн хамгийн бага болон их утгуудаас тогтох вектор гарна.
quantile(LungCap, probs=0.90) #quantile
  # Түүврийн 90 хувийн квантил
quantile(LungCap, probs=c(0.20,0.5,0.9,1)) #quantile
  # Түүврийн янз бүрийн хувийн квантилуудыг нэг дор олж үр дүнг нь нэгтгэж буцаана
sum(LungCap)/length(LungCap) #dundaj
  # Түүврийн дунджийг нийлбэрийг хуваах нь түүврийн хэмжээ гэж олжээ.
mean(LungCap) #dundaj
  # Түүврийн дундаж
cor(LungCap, Age) #Corrilyatsi
  # Корреляцын матриц
cor(LungCap, Age, method="spearman") #Spearmanii arga ashiglasan corrilliance
  # Спримэний рангийн корреляцаас тогтох корреляцын матриц гарна.
cov(LungCap, Age) # covariance
  # Ковариацын матриц гарна.
# # # # Binomial Distribution  # # # #
help(dbinom)
  # Бином тархалтын нягтад холбогдох функцийн баримтжуулалтыг үзэх гэж байна.
#P(X=3)
dbinom(x=3, size=20, prob=1/6)
#P(X=0) & P(X=1) & ... & P(X=3)
dbinom(x=0:3, size=20, prob=1/6)
#P(X <= 3)
sum(dbinom(x=0:3, size=20, prob=1/6))
pbinom(q=3, size=20, prob=1/6, lower.tail=T)
  # Баахан магадлал боджээ.
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
  # Бас л баахан магадлал боджээ.
# find Q1
qnorm(p=0.25, mean=75, sd=5, lower.tail=T)
  # Хэвийн тархалтын 1 дүгээр квартил олж байна.
x <- seq(from=55, to=95, by=0.25)
  # seq() бол тоон дараалал үүсгэдэг функц юм.
dens <- dnorm(x, mean=75, sd=5)
  # Хэвийн тархалтын нягтын функцийн утгууд гарна.
plot(x,dens)
plot(x, dens, type="l")
plot(x, dens, type="l", main="X~Normal: Mean=75, SD=5", xlab="x", ylab="Probability Density", las=1)
  # Хэвийн тархалтын нягтын муруй зурж байна.
abline(v=75)
  # Хэвийн тархалтынхаа дунджийг нь тодотгож өгч буй бололтой.
rand <- rnorm(n=40, mean=75, sd=5)
  # Хэвийн тархалттай санамсаргүй тоонууд
hist(rand)
  # Дээрх санамсаргүй тоонуудаараа гистограм байгуулж байна.
# # # # The Student t distribution # # # #
help(pt)
  # Стьюдентийн тархалтын функцийн баримтжуулалт үзэх
# t- stat=2.3, df=25
# one-sided pvalue
# P(t > 2.3)
pt(q=2.3, df=25, lower.tail=F)
  # 25 чөлөөний зэрэгтэй Стьюдентийн тархалттай санамсаргүй хувьсагчийн 2.3-аас их байх магадлал гэсэн үг.
# two-sided pvalue
pt(q=2.3, df=25, lower.tail=F) + pt(q=-2.3, df=25, lower.tail=T)
pt(q=2.3, df=25, lower.tail=F)*2
  # Стьюдентийн тархалтын тэгш хэмтэй болохыг л шалгаад байгаа бололтой.
# find t for 95% confidence
# value of t with 2.5% in each tail
qt(p=0.025, df=25, lower.tail=T)
  # 25 чөлөөний зэрэгтэй Стьюдентийн тархалтын 2.5 хувийн квантилын утга олж байна.
# # # # One Sample Test # # # #
boxplot(LungCap)
  # Хайрцган диаграм байгуулах
# Ho: mu <8
# one sided 95% confidence interval for mu
t.test(LungCap, mu=8, alternative="less", conf.level=0.95)
t.test(LungCap, mu=8, alt="less", conf=0.95)
  # дунджийн тухай таамаглал шалгаж байна. Мөн онолын дунджийн 95 хувийн итгэх завсар гарна.
# Two-sided 
t.test(LungCap, mu=8, alt="two.sided", conf=0.95)
t.test(LungCap, mu=8, alt="two.sided", conf=0.99)
TEST <-t.test(LungCap, mu=8, alt="two.sided", conf=0.99)
  # Функцийн буцаах утгыг агуулсан TEST объект үүсгэж байна.
TEST
  # Функцийн үр дүнг хэвлэж үзэж байна.
attributes(TEST)
  # t.test() функцийн буцаасан утгуудын нэрсийг харуулна.
  # Ерөнхийдөө ийм функцүүд олон утгуудыг нэг дор буцаахдаа тэдгээр утгуудыг нэгтгэн лист болгодог.
  # Лист дэх тухайн утга уруу хандахдаа доор бичсэн шиг $value.name байдлаар хандаж болдог. Бас индексээр нь ч хандаж болно.
TEST$conf.int
  # Дунджийн итгэх завсар
TEST$p.value
  # Таамаглалын магадлалын утга
