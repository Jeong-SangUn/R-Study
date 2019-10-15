getwd()
setwd(getwd())

rm(list=ls())

# 방법1
vec <- c(1,2,3,4,5)
vec
vec[1]
vec[c(1,5)]

# 방법2
vec1 <-1:5
vec1

# 방법3
vec2<-seq(1,5,1)
vec2 +1
vec2

?seq
help(seq)

vec3<-'홍홍'

vec4<-c(1,'홍홍')
vec4

str(vec4[2])

Sys.Date()
Sys.time()
date()

a = as.Date('2018/6/16')
b = a-1
as.Date('17/02/28','%y/%m/%d')
dt <-'2018-03-01'
class(a)
str(a)

dt1 <- c('1/5/7','5/8/19')
as.Date(dt1,'%d/%m/%y')

x<-c(1,3,5,7)
y<-c(3,5,6)
union(x,y)
intersect(x,y)
setdiff(x,y)
setdiff(y,x)


num<- 1:100
num
num[1:10]
length(num)
num[11:(length(num)/2)]

length(num[-c(91:100)])

1 %in% c(1,3,5)
6 %in% c(1,3,5)

# 범주형(factior)

party <- factor(c("진보","보수","중도",'진보','보수'),c('진보','보수','중도'))
party
str(party)

party1 <-as.character(party)
str(party1)

iris_data <- iris
summary(iris_data)
str(iris_data$Species)
iris_data$Species <- as.character(iris_data$Species)
summary(iris_data)
str(iris_data$Species)

mat <- matrix(1:9,ncol = 3)
mat
?matrix
mat1 <- matrix(1:9,ncol = 3, byrow = TRUE)
mat1

mat2 <- matrix(1:9, nrow = 3, dimnames = list(c('a1','a2','a3'),c('b1','b2','b3')))
mat2

mat3 <- matrix(rep(c('a','b','c'),each=3),ncol=3)
mat3
mat4 <- matrix(rep(c('a','b','c'),times=3),ncol=3)
mat4
rep(c('a','b','c'),times=3)
dim(mat4)
nrow(mat4)
ncol(mat4)

rep(5,3)
rep(c('a','b','c'),times=3)
rep(c('a','b','c'),each=3)

mat5 <- matrix(1:6,ncol=2)
dim(mat5)
nrow(mat5)
ncol(mat5)

dim(mat5) <- c(2,3)
mat5
dim(mat5)

m <- matrix(1:9, ncol=3,byrow=TRUE)
m
apply(m,1,max)
apply(m,2,mean)
apply(m,2,min)

m1<-m
colnames(m1)<-c('a','b','c')
rownames(m1)<-c('r1','r2','r3')
m1

# 리스트 
# 키-밸류 구조

a<-list(name=c('GilDong','a','b'), age=30, job='SaleManager')
a
b<-list(1:3,'a',c(TRUE,FALSE,TRUE),c(2.3,5.9))
b
str(b)

c<-unlist(a)
c
str(c)
class(c)
c['name2']

dd <- c(1,2,3)
names(dd) <- c('a','b','c')
dd
str(dd)
class(dd)
dd.names <- c('a1','b1','c1')

rep(c(1,2),c(3,5))

seq(from=1, to=10)
seq_len(10)
seq( from = 1, to = 10, by=2 )
seq(1,20,by=3)
seq( 1, 10, length = 5 )
seq(1,by = 2, length = 10)

mat <- matrix(1:16, nrow=4, dimnames = list(c('r1','r2','r3','r4'),
                                            c('c1','c2','c3','c4')))
mat
mat[2,2]
mat['r2','c2']

mat[,-1]
mat[-1,]

list(name = c('GilDong','SeDol','GilDong'),
           age = c(30,35),
           job = c('SalesManager','GoPro'))
li['age']
li[['age']]
li$age
li[[2]]
li$age[1:2]
str(li[[2]][2])

df <-data.frame(name = c('GilDong','SeDol','GilDong'),
                age = c(30,35,30),
                job = c('SalesManager','GoPro','GoPro'))

df[1,]
df$name
df[,"name"]
df[,1]
str(df[1])
class(df[1])
new_mem <- data.frame(name= c('a','b'), age=c(12,1), job=c('b','c'))
df <- rbind(df, new_mem)
df
new_col <-data.frame( nationality=
                        c(0,9,8,7,6,5,4,3,2,1))
df <- cbind(df,new_col)
df$city <- c(1,2,3,4,5,6,7,8,9,0)
df$new <- c('a','b','c','d','e','f','g','h','a','b')
df
str(df$new)
str(df[,6])
?getwd()
setwd(getwd()+'/data')
student <- read.table(file='./data/student.txt', sep="")
student

student1 <- read.table(file= file.choose(),header=FALSE)
student1

student3 <- read.table(file='./data/student3.txt',
                       sep="",
                       header=T,
                       na.strings = "-",
                       stringsAsFactors = FALSE)
student3
str(student3)

student4 <- read.table(file='./data/student4.txt',
                       sep=",",
                       header = T,
                       na.strings = c("-","+","$"))
student4

getwd()
setwd('C:/R_work/data')
# install.packages('xlsx')
library('xlsx')

installed.packages()

studentexcel <- read.xlsx(file='studentexcel.xlsx',
                          sheetIndex=1,encoding = "UTF-8")
studentexcel



install.packages('stringr')
library('stringr')

# 
?str_extract
str_extract('홍길동35이순신45유관순25','[0-9]{2}')
unlist(str_extract_all('홍길동35이순신45유관순25','[0-9]{2}'))

string <-'hongkilldong105lee1002you25강감찬2005'
str_extract_all(string,'[a-z]{3}')
str_extract_all(string,'[a-z]{3,}')
str_extract_all(string,'[a-z]{3,5}')

string1 <-'YEShongkilldong105lee1002you25강감찬2005'
str_extract_all(string1,'[A-z]{3,}')

unlist(str_extract_all(string1,'[가-힣]{3}'))

?read.csv
GDP_ranking <-read.csv(file='http://databank.worldbank.org/data/download/GDP_PPP.csv',
                       skip=5 )
GDP_ranking <- GDP_ranking[c(1,2,4,5)]
str(GDP_ranking)
names(GDP_ranking) <- c('Country','Ranking','Economy','Dollar')
GDP_ranking <- GDP_ranking[1:193,]
str(GDP_ranking)
GDP_ranking$dollar <- as.character(GDP_ranking$dollar)
GDP_ranking$dollar <- str_remove_all(GDP_ranking$dollar,',')
GDP_ranking$dollar <- as.numeric(GDP_ranking$dollar)
str(GDP_ranking)

GDP_TOP20 <- GDP_ranking[1:20,]
GDP<-GDP_TOP20[,c(1,4)]
GDP$Country <- as.character(GDP$Country)
GDP$Dollar
temp<- matrix(GDP$Dollar/1000, nrow=1 )
colnames(temp) <- GDP$Country
temp
?barplot
barplot(GDP$Dollar/1000,
        xlab='Nations',
        ylab ='unit($Billion)',
        main='2018년 국가별 GDP 순위(상위20개국)',
        col=rainbow(20),
        names.arg=GDP$Country	)
abline(h=c(5000,10000), col=c('darkgray','lightblue'),lty=c(3,4))



library('ggplot2')
GDP_TOP20
Nations <- reorder(GDP_TOP20$Country,-GDP_TOP20$Dollar)
Nations

ggplot(GDP_TOP20,aes(x=Nations,y=Dollar/1000,fill=Nations))+
  geom_bar(stat='identity')+
  theme(axis.text.x = element_text(angle=90),
        plot.title=element_text(color='blue', size=12, face='bold.italic',
                                hjust=0.5))+
  labs(title = '2018년 국가별 GDP 순위', x= 'NATIONS', y= 'GDP($Billons)')

