
weather <- read.csv('./data/weather.csv', stringsAsFactors = F)
summary(weather)

weather <- na.omit(weather)

dim(weather)
str(weather)
head(weather)

weather_df <- weather[,c(-1,-6,-8,-14)]
str(weather_df)

weather_df$RainTomorrow[weather_df$RainTomorrow =='Yes'] <- 1
weather_df$RainTomorrow[weather_df$RainTomorrow =='No'] <- 0
weather_df$RainTomorrow <- as.numeric(weather_df$RainTomorrow)
head(weather_df)

idx <- sample(1:nrow(weather_df), nrow(weather_df)*0.7)
train <- weather_df[idx,]
test <- weather_df[-idx,]
nrow(train);nrow(test)

?glm
weather_model <- glm(RainTomorrow ~ ., data = train, family = 'binomial')
weather_model



# 일반 모델 
##############################################################################
?predict
pred <- predict(weather_model, newdata=test, type='response')
pred

length(pred)
plot(pred)
summary(pred)
str(pred)

result_pred <- ifelse(pred>=0.5,1,0)
result_pred
table(result_pred)

table(result_pred, test$RainTomorrow)


step <- step(object = weather_model, trace = F , direction = 'backward')
step
summary(step)
# step 함수로 유의미한 feature만 모은 모델 
##############################################################################
?predict
pred <- predict(step, newdata=test, type='response')
pred

length(pred)
plot(pred)
summary(pred)
str(pred)

result_pred_step <- ifelse(pred>=0.5,1,0)
result_pred_step
table(result_pred_step)

table(result_pred_step, test$RainTomorrow)
table(result_pred, test$RainTomorrow)

##############################################################################

names(iris)
str(iris)
iris_df <- iris[c('Sepal.Length',"Species")]
table(iris_df[2])

iris_df1 <- iris_df %>% filter(Species=='setosa'|Species=='versicolor')

iris_df1$Species <- as.character(iris_df1$Species)
iris_df1$Species[iris_df1$Species == 'setosa'] <- 0
iris_df1$Species[iris_df1$Species == 'versicolor'] <- 1

iris_df1$Species <- as.numeric(iris_df1$Species)

?dplyr::sample
?base::sample

# install.packages('caret')
# library(caret)
# idx <- createDataPartition(iris$Species, p=0.7, list=F) 
# caret::createDataPartition() 품종별로 같은 비율로 나눠서 들고옴
# 예: train : setosa: 35 versicolor: 35   = 70
#     test : setosa: 15 versicolor: 15    = 30
# base::sample()은 품종별로 어떤 비율로 나눠서 들고올지 모름 내가 정한 7:3만 지킴
# 예: train : setosa: 30 versicolor: 40   = 70
#     test : setosa: 5 versicolor: 25     = 30
#이 정도의 극단적인 경우는 거의 없겠지만 그렇다는거
idx <- sample(1:nrow(iris_df1), nrow(iris_df1)*0.7)
train <- iris_df1[idx,]
test <- iris_df1[-idx,]
nrow(train);nrow(test)
table(train$Species)

iris_model <- glm(Species ~ Sepal.Length, data = train, family = 'binomial')
iris_model

pred <- predict(iris_model, newdata=test, type='response')
pred

result_pred <- ifelse(pred>=0.5,1,0)
result_pred
table(result_pred)

table(result_pred, test$Species)




install.packages('rpart')
install.packages('rpart.plot')
install.packages('e1071')
require(rpart)
require(rpart.plot)
library(e1071)
library(caret)

head(iris,51)

data(iris)

idx <- createDataPartition(iris$Species, p=0.7, list=F)
train <- iris[idx,]
test <- iris[-idx,]

length(train$Species); length(test$Species)

table(train$Species)

m.rpart <- rpart(Species ~ ., data = train)
m.rpart
summary(m.rpart)

plot(m.rpart, margin = .2, compress = T)
text(m.rpart, cex=1.0)

m.rpart.pr <- predict(m.rpart, newdata = test, type = 'class')
m.rpart.pr
summary(m.rpart.pr)

table(m.rpart.pr, test$Species)
confusionMatrix(m.rpart.pr, test$Species)



install.packages('party')
require(party)

m.ctree <- ctree(Species ~ ., data = train)
m.ctree

plot(m.ctree)

m.ctree.pr <- predict(m.ctree, newdata = test)
summary(m.ctree.pr)

table(m.ctree.pr, test$Species)
confusionMatrix(m.ctree.pr, test$Species)


install.packages('tree')
require(tree)

m.tree <- tree(Species ~ ., data = train)
m.tree

plot(m.tree)
text(m.tree)

m.tree.pr <- predict(m.tree, newdata = test ,type= 'class')
summary(m.tree.pr)
table(m.tree.pr)
table(test$Species)

table(m.tree.pr, test$Species)
confusionMatrix(m.tree.pr, test$Species)


install.packages('randomForest')
library(randomForest)

rf <- randomForest(Species~.,data=iris)
rf

# 연산이 많기 때문에 
rf2 <- randomForest(iris[,1:4],iris[,5])
rf2

# importance 변수의 중요도를 나타내줌
# mtry: 변수의 개수를 몇개로 해줄것인가 floor():소수점 내림(4.12=>4)
rf3 <- randomForest(iris[,1:4],iris[,5], importance = T,
                    mtry=floor(sqrt(4)))
importance(rf3)

varImpPlot(rf3, main='varImpPlot of iris')

#library(e1071) #gridsearch를 위한 라이브러리
install.packages('kernlab')
library(kernlab)
library(caret)

set.seed(127);idx <- createDataPartition(iris$Species, p=0.7, list=F)
set.seed(127);idx1 <- createDataPartition(iris$Species, p=0.7, list=F)

idx == idx1

head(iris)
iris_train <- iris[idx,]
iris_test <- iris[-idx,]
nrow(iris_test)
nrow(iris_train)
?tune.svm
tune_svm <- tune.svm(Species~., data = iris_train,
                     gamma = 2^(-4:4), cost=2^(-4:4))
tune_svm$best.parameters

svm.result <- ksvm(Species~., iris_train, kernel='rbfdot',
                     kpar = list(sigma=0.625), C=4, prob.model=TRUE)

svm.result
svm.pred <- predict(svm.result, iris_test, type='response')
svm.pred
table(svm.pred, iris_test$Species)
confusionMatrix(svm.pred, iris_test$Species)

#로지스틱 랜덤포레스트 SVM

credit_data <- read.csv('./data/credit_rating.csv')

# head(credit_data)
# names(credit_data)
# ncol(credit_data)

credit_data$credit.rating <- as.factor(credit_data$credit.rating)
# rf_model <- randomForest(credit.rating ~ .,data=credit_data, importance = T,
#                          mtry=floor(sqrt(ncol(credit_data))))
# 
# importance(rf_model)
# varImpPlot(rf_model, main='varImpPlot of credit')

set.seed(1); idx <- createDataPartition(credit_data$credit.rating, p=0.7, list=F)

credit_main <- credit_data[c('account.balance',
                             'credit.rating')]
# 'account.balance' ,
# 'credit.duration.months',
# 'savings',
# 'previous.credit.payment.status',
# 'credit.purpose',
# 'marital.status',
# 'installment.rate ' 
credit_train <- credit_main[idx,]
credit_test <- credit_main[-idx,]

tune_svm <- tune.svm(credit.rating~., data = credit_train,
                     gamma = 2^(-4:4), cost=2^(-4:4))
tune_svm$best.parameters

svm.result <- ksvm(credit.rating~., credit_train, kernel='rbfdot',
                   kpar = list(sigma=0.0625), C=0.0625, prob.model=TRUE)

# svm.result
svm.pred <- predict(svm.result, credit_test, type='response')

table(svm.pred, credit_test$credit.rating)
confusionMatrix(svm.pred, credit_test$credit.rating)
#'credit.amount', 'age','account.balance', 'credit.duration.months'
#위의 변수 4개로 Accuracy : 0.7467  Kappa : 0.3426 
#'credit.amount', 'age','account.balance', 'credit.duration.months','previous.credit.payment.status'
#위의 변수 5개로 Accuracy : 0.75   Kappa : 0.3622  

#모든 변수로 Accuracy : 0.7533   Kappa : 0.3599   
names(credit_data)

#로지스틱
############################################################################################


credit <- read.csv('./data/credit_rating.csv')

str(credit)
# credit$credit.rating <- as.factor(credit$credit.rating)
set.seed(100);idx <- createDataPartition(credit$credit.rating, p=0.7, list=F)
credit_train1 <- credit[idx,]
credit_test1 <- credit[-idx,]
nrow(credit_train1);nrow(credit_test1)

?glm
creditr_model <- glm(credit.rating ~ ., data = credit_train1, family = 'binomial')
creditr_model

# 로지스틱 step에서의 유효성 높은 것들
# 'account.balance' ,
# 'credit.duration.months ',
# 'savings',
# 'previous.credit.payment.status',
# 'credit.purpose',
# 'marital.status',
# 'installment.rate ' 

# 일반 모델 
##############################################################################
?predict
pred <- predict(creditr_model, newdata=credit_test1, type='response')
pred

# length(pred)
# plot(pred)
# summary(pred)
# str(pred)

result_pred <- ifelse(pred>=0.5,1,0)
result_pred
table(result_pred)
names(result_pred)
names(credit_test1$credit.rating)
str(result_pred)
str(credit_test1$credit.rating)
result_pred <- as.factor(result_pred)
credit_test1$credit.rating <- as.factor(credit_test1$credit.rating)

table(result_pred, credit_test1$credit.rating)
confusionMatrix(result_pred, credit_test1$credit.rating)

# 로지스틱 모든 변수를 통한 일반 예측 Accuracy : 0.7533  Kappa : 0.3223

?step
step <- step(object = creditr_model, trace = F , direction = 'backward')
step
summary(step)
# 밑에는 step 함수로 유의미한 feature만 모은 모델 
##############################################################################
?predict
pred <- predict(step, newdata=credit_test1, type='response')
pred

# length(pred)
# plot(pred)
# summary(pred)
# str(pred)

result_pred_step <- ifelse(pred>=0.5,1,0)
result_pred_step
table(result_pred_step)
result_pred_step <- as.factor(result_pred_step)
credit_test1$credit.rating <- as.factor(credit_test1$credit.rating)

table(result_pred_step, credit_test1$credit.rating)
confusionMatrix(result_pred_step, credit_test1$credit.rating)
