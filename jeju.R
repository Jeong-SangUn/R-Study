# 패키지 경로 확인
.libPaths()

# 자바 경로 설정
Sys.setenv(JAVA_HOME='C:\\Program Files\\Java\\jre1.8.0_221')

# 워킹디렉토리
setwd("C:\\R_work")

# 필요 패키지 설치 및 라이브러리
# install.packages(c('rJava','KoNLP'))
# install.packages(c('RColorBrewer','wordcloud'))

library(rJava)
library(KoNLP)
library(stringr)

# remove.packages('KoNLP')
# install.packages('KoNLP')

# 2.buildDictionary() 이용하여, 여행사의 패키지 여행지 
# 사전에 등록
dics <- c("sejong","woorimalsam")
buildDictionary(ext_dic=dics,
                replace_usr_dic=T)


#### 1. 분석할 데이터 벡터로 읽어오기
txt <- readLines("jeju.txt")
txt
#### 2. 명사 추출
?sapply
place <- sapply(txt,extractNoun,USE.NAMES = F)
head(place,50)

#### 3. 벡터화
cdata <- unlist(place)
head(cdata,50)

#### 4. 불용어 제거
place_re <- str_replace_all(cdata,"[A-z0-9]","")
place_re <- gsub("제주","",x = place_re)

## 불용어 목록
txt1 <- readLines("jejugsub.txt")
txt1

#### 4. 불용어 제거

?gsub
for (i in 1:length(txt1)) {
  place_re <- gsub(pattern = txt1[i],"",x = place_re)
}

## 문자길이 2개이상 단어 추출
?Filter
place_re <- Filter(function(x){
  nchar(x) >= 2
},place_re)
place_re

#### 5. 단어 빈도 확인 및 최종 단어 변수 작성
table(place_re)
wordcount <- table(place_re)

wordcount1 <- head(sort(wordcount,decreasing = T),40)
wordcount1

library(RColorBrewer)
library(wordcloud)

palette<-brewer.pal(9,"Set1")
wordcloud(names(wordcount1),freq=wordcount1,scale=c(5,0.5),
          rot.per=0.25,min.freq=1,
          random.order=F,random.color=T,colors=palette)
legend(0,1,"제주도 추천 여행 코스 분석",cex=0.7,
       text.col="red",box.col="red")


#### 사용자 정의 사전 추가
user_d <- data.frame(readLines("제주도여행지.txt", encoding = 'euc-kr'),"ncn",
                     stringsAsFactors = FALSE)

buildDictionary(ext_dic=dics,
                user_dic = user_d,
                replace_usr_dic=T)





# 빌드 딕셔너리의 내부 인수는 다음과 같이 사용
# buildDictionary(ext_dic=c('sejong','woorimalsam'),
# user_dic = user_d,
# replace_usr_dic=F)

?buildDictionary
dics <- c("sejong","woorimalsam")
# category <- c("jeju")
user_d <- data.frame(readLines("제주여행샘플.txt", encoding = 'euc-kr'),"ncn",
                     stringsAsFactors = FALSE)
user_d
str(user_d)
?readLines()
#install.packages("curl")
buildDictionary(ext_dic=dics,
                replace_usr_dic=F,)
buildDictionary(ext_dic=dics,
                user_dic = user_d,
                replace_usr_dic=F)

# SimplePos22("제가 천지연 폭포에 다녀왔어요")

.libPaths()

#### 분석할 데이터 벡터로 읽어오기
txt <- readLines("jeju.txt")
head(txt)
# pla <- sapply(txt,SimplePos22, USE.NAMES = F)
# pla
place <- sapply(txt,extractNoun,USE.NAMES = F)
place
cdata <- unlist(place)
head(cdata,40)

#### 불용어 제거
place_re <- str_replace_all(cdata,"[A-z]","")
# place_re
# place_re <- gsub(" ","",place_re)
txt1 <- readLines("jejugsub.txt")
txt1

#### 제거위한 반복문
?gsub
for (i in 1:length(txt1)) {
  place_re <- gsub(pattern = txt1[i],"",x = place_re)
}

## 문자길이 2개이상 단어 추출
?Filter
place_re <- Filter(function(x){
  nchar(x) >= 2
},place_re)
place_re

# write(unlist(place_re),"jeju_new.txt")

table(place_re)
wordcount <- table(place_re)

wordcount1 <- head(sort(wordcount,decreasing = T),30)
wordcount1

library(RColorBrewer)
library(wordcloud)

palette<-brewer.pal(9,"Set1")
wordcloud(names(wordcount1),freq=wordcount1,scale=c(3,0.5),rot.per=0.25,min.freq=1,
          random.order=F,random.color=T,colors=palette)
legend(0,1,"제주도 추천 여행 코스 분석",cex=0.7,
       text.col="red",box.col="red")
help(legend)

.libPaths()
