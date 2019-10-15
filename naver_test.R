local_restaurant_save <- function(local_restaurant){
  clientID <- 'm2bcMgVywKyVnsYcXEA4'
  clientPW <- 'fskq3bcZ9u'
  
  urlStr <- "https://openapi.naver.com/v1/search/local.xml?"
  
  searchQuery <-paste("query=",local_restaurant, sep="")
  searchStr <- iconv(searchQuery, to="UTF-8")
  searchStr <- URLencode(searchStr)
  otherStr <- "&display=10&start=1&sort=random"
  reqURL <- paste(urlStr,searchStr,otherStr, sep="")
  
  library(httr)
  
  apiResult <- httr::GET(reqURL,
                         add_headers("X-Naver-Client-Id" = clientID,
                                     "X-Naver-Client-Secret" = clientPW))
  local_food_split <- strsplit(local_restaurant," ")
  local_food_split <- unlist(local_food_split)
  
  sink('local_sub.txt',append = TRUE)
  for(i in 1:length(local_food_split)){
    cat(local_food_split[i],'\n',sep="")
  }
  for(i in 1:(nchar(local_food_split[1])-1)){
    cat(substr(local_food_split[1],i,i+1),'\n',sep="")
  }
  sink()
  
  library(XML)
  myUrl <- apiResult
  doc <- xmlParse(myUrl)
  root <- xmlRoot(doc)
  local_data <- xpathSApply(root,"//title",xmlValue)
  local_data <- local_data[-1]
  
  for (i in 1:length(local_food_split)) {
    local_data <- gsub(pattern = local_food_split[i],"",x = local_data)
  }
  
  library(stringr)
  local_data <- str_replace_all(local_data,'<b>'," ")
  local_data <- str_replace_all(local_data,'</b>',"")
  
  for (i in 1:length(local_data)) {
    if(!is.na(str_locate(local_data[i]," ")[1])){
      if(str_locate(local_data[i]," ")[1] == 1){  #처음 문자 띄어쓰기 일 때 해당 띄어쓰기 삭제
        local_data[i] <- str_replace(local_data[i],"[\\s]{1}","")
      }
    }
  }
  local_data <- str_replace_all(local_data,'[\\s]{1}[가-힣]{1,}',"")
  local_data <- str_replace_all(local_data,'[\\s]{1,}',"")
  local_data
  setwd('C:/R_work')
  sink('local_restaurant.txt')
  for(i in 1:length(local_data)){
    cat(local_data[i],'\n',sep="")
  }
  sink()
}

##############################################################################################################

blog_content <- function(local_restaurant){

  clientID <- 'm2bcMgVywKyVnsYcXEA4'
  clientPW <- 'fskq3bcZ9u'
  
  urlStr <- "https://openapi.naver.com/v1/search/blog.xml?"
  
  searchQuery <- paste("query=",local_restaurant, sep="")
  
  searchStr <- iconv(searchQuery, to="UTF-8")
  searchStr <- URLencode(searchStr)
  
  otherStr <- "&display=100&start=1&sort=sim"
  reqURL <- paste(urlStr,searchStr,otherStr, sep="")
  
  library(httr)
  
  apiResult <- httr::GET(reqURL,
                         add_headers("X-Naver-Client-Id" = clientID,
                                     "X-Naver-Client-Secret" = clientPW))

  
  # xml 추출 방식이 아닌 정규식을 이용한 데이터 추출
  # #raw data -> char 변경
  # blogData <- rawToChar(apiResult$content)
  # blogData
  # 
  # #encoding 변경
  # Encoding(blogData) <- "UTF-8"
  # 
  # blogData <-gsub("[^가-힣]"," ",blogData)
  # blogData <-gsub(" +"," ",blogData)
  # blogData
  
  library(XML)
  myUrl <- apiResult
  doc <- xmlParse(myUrl)
  root <- xmlRoot(doc)
  root
  blogData_title <- xpathSApply(root,"//title",xmlValue)
  blogData_description <- xpathSApply(root,"//description",xmlValue)
  blogData_title <- str_replace_all(blogData_title,'<b>',"")
  blogData_title <- str_replace_all(blogData_title,'</b>',"")
  blogData_description <- str_replace_all(blogData_description,'<b>',"")
  blogData_description <- str_replace_all(blogData_description,'</b>',"")
  blogData_title <- blogData_title[-1]
  blogData_description <- blogData_description[-1]
  setwd('C:/R_work')
  sink('local_blog.txt')
  for(i in 1:length(blogData_title)){
    cat(blogData_title[i],blogData_description[i],'\n',sep="")
  }
  sink()
}

##############################################################################################################

output_wordcloud <- function(){
  
  Sys.setenv(JAVA_HOME='C:\\Program Files\\Java\\jre1.8.0_221')
  
  library(rJava)
  library(KoNLP)
  library(stringr)
  
  dics <- c("sejong","woorimalsam")
  
  user_d <- data.frame(readLines("local_restaurant.txt", encoding = 'euc-kr'),"ncn",
                       stringsAsFactors = FALSE)
  
  buildDictionary(ext_dic=dics,
                  user_dic = user_d,
                  replace_usr_dic=T)
  
  txt <- readLines("local_blog.txt")
  
  place <- sapply(txt,extractNoun,USE.NAMES = F)
  cdata <- unlist(place)
  
  place_re <- str_replace_all(cdata,"[A-z]","")
  place_re <- str_replace_all(place_re,"[#]{1}[가-힣]{1,}","")
  place_re <- str_replace_all(place_re,"[&;]","")
  place_re <- str_replace_all(place_re,"[ㅋ]{1,}","")
  place_re <- str_replace_all(place_re,"[ㅎ]{1,}","")
  place_re <- str_replace_all(place_re,"[0-9]{2,}","")
  place_re <- str_replace_all(place_re,"[가-힣]{2}[동]{1}","")
  place_re <- gsub(" ","",place_re)
  
  txt1 <- readLines("local_sub.txt")
  
  for (i in 1:length(txt1)) {
    place_re <- gsub(pattern = txt1[i],"",x = place_re)
  }
  
  place_re <- Filter(function(x){
    nchar(x) >= 2
  },place_re)
  
  table(place_re)
  wordcount <- table(place_re)
  wordcount1
  wordcount1 <- head(sort(wordcount,decreasing = T),30)
  
  library(RColorBrewer)
  library(wordcloud)
  
  palette<-brewer.pal(9,"Set1")
  wordcloud(names(wordcount1),freq=wordcount1,scale=c(3,1),rot.per=0.25,min.freq=0.5,
            random.order=F,random.color=T,colors=palette)
  legend(0,1,"맛집 분석",cex=0.7, text.col="red",box.col="red")
}

##############################################################################################################

input_local_restaurant <- '대명동 냉면'
local_restaurant_save(input_local_restaurant)
blog_content(input_local_restaurant)
output_wordcloud()
