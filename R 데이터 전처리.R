getwd()

dataset <- read.csv("./data/dataset.csv", stringsAsFactors = T)

head(dataset)

table(is.na(dataset$resident))

summary(dataset)

View(dataset)

names(dataset)
attributes(dataset)
str(dataset)

x <- dataset$gender
y <- dataset$price

plot(x,y)

plot(dataset$price)

summary(dataset$price)

sum(dataset$price)

sum(dataset$price, na.rm=T)
mean(dataset$price, na.rm=T)

price2 <- na.omit(dataset$price)
plot(dataset$price)
sum(price2)
length(dataset$price)
length(price2)

x <- dataset$price
x[1:30]
dataset$price2 <- ifelse(!is.na(x),x,0)
dataset$price2[1:30]

x <- dataset$price
x[1:30]
dataset$price3 = ifelse(!is.na(x),x,round(mean(x,na.rm = TRUE),2))
dataset$price3[1:30]
a <- dataset[c('price','price2','price3')]
a

table(dataset$gender)
pie(table(dataset$gender))


dataset <- subset(dataset, gender==1 | gender==2)
length(dataset$gender)
pie(table(dataset$gender))
pie(table(dataset$gender), col = c('red','blue'))
attributes(dataset)
View(dataset)

dataset$price
length(dataset$price)
plot(dataset$price)
summary(dataset$price)

dataset2 <- subset(dataset,price >=2 & price <=8)
length(dataset2$price)
dataset2$price
stem(dataset2$price)

dataset2$resident2[dataset2$resident == 1] <-'1.서울특별시'
dataset2$resident2[dataset2$resident == 2] <-'2.인천광역시'
dataset2$resident2[dataset2$resident == 3] <-'3.대전광역시'
dataset2$resident2[dataset2$resident == 4] <-'4.대구광역시'
dataset2$resident2[dataset2$resident == 5] <-'5.시구군'
dataset2[c('resident','resident2')]

dataset2$age2[dataset2$age <= 30] <- "청년층"
dataset2$age2[dataset2$age >30 & dataset2$age<=55] <- "중년층"
dataset2$age2[dataset2$age > 55] <- "장년층"
head(dataset2)

install.packages('dplyr')
library(dplyr)

exam <- read.csv('./data/csv_exam.csv')
head(exam)
head(exam, 10)

tail(exam)
tail(exam)

View(exam)
dim(exam)
str(exam)
summary(exam)

mpg <- ggplot2::mpg
View(mpg)

df_raw <- data.frame(var1 = c(1,2,1),
                     var2 = c(2,3,2))
df_raw

df_new <- df_raw
df_new

df_new <- rename(df_new, v2 = var2)
df_new

mpg <- rename(mpg, company = manufacturer)

mpg$total <- (mpg$cty + mpg$hwy)/2
head(mpg)
mean(mpg$total)

mpg$grade <- ifelse(mpg$total >=30, 'A',
                    ifelse(mpg$total >=20, 'B', 'C'))
head(mpg$grade, 20)
table(mpg$grade)

ggplot2::qplot(mpg$grade)


subset(exam, class == 1)

exam %>% filter(class==1)
filter(exam, class == 1)

exam %>% filter(class==2)

exam %>% filter(class==3)

exam %>% filter(class==1|class==3|class==5)

exam %>% filter(class %in% c(1,3,5))

exam %>% select(math)
exam %>% select(english)
exam %>% select(class, math, english)
exam %>% select(-math)
exam %>% select(-math,-english)

exam %>% filter(class==1) %>% select(english)
exam %>% filter(class==1) %>% select(id, math) %>% head
exam %>% filter(class==1) %>% select(id, math) %>% head(10)

exam %>% arrange(math)
exam %>% arrange(desc(math))
exam %>% arrange(class,math)

names(exam)

exam %>% mutate(total=math+english+science)
exam %>% mutate(total=math+english+science,
                mean=(math+english+science)/3)

exam %>%summarise(mean_math = mean(math))

exam %>% group_by(class) %>% summarise(mean_math = mean(math))

exam %>% group_by(class) %>%
  summarise(mean_math = mean(math),
            sum_math = sum(math),
            median_math=median(math),
            n = n())

mpg %>% 
  group_by(company, drv) %>%     # 회사별, 구동방식별 분리
  summarise(mean_cty = mean(cty)) %>%
  arrange(desc(mean_cty)) %>% 
  head(15)

mpg %>% 
  group_by(company) %>% 
  filter(class == 'suv') %>% 
  mutate(total = (cty+hwy)/2) %>% 
  summarise(mean_total = mean(total)) %>% 
  arrange(desc(mean_total)) %>% 
  head(5)

test1 <- data.frame(id = c(1,2,3,4,5),
                    midterm = c(60,80,70,90,85))
test2 <- data.frame(id = c(1,2,3,4,5,6),
                    final = c(70,83,65,95,80,90))
test1
test2

total <-left_join(test1,test2,by='id')
total

total1 <- full_join(test1,test2,by='id')
total1

