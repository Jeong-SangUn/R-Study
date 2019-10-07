<h2>
    R 정리
</h2>



<h4>R의 자료구조</h4>

`vector` : 

- 1차원의 자료구조 (하나의 컬럼이라고 생각하면 됨)
- 데이터의 순서를 가진다
- 자료형이 같다

`matrix` :  2차원의 자료구조 

`array` : 잘 안 씀  

`list ` : python의 딕셔너리 구조와 유사 함, 비정형 데이터 처리에 좋음

`dataframe`



`factor` : 명목형

<h4>구조 확인 함수</h4>

`str()` : 데이터 구조를 보는 함수

`class()` : 자료형을 보는 함수



<h4>날짜 함수</h4>

Date 자료 사이에서 연산 가능 

`Sys.Date()` : 현재 날짜를 "2019-10-07" 형식으로 반환

`Sys.time()` : 현재 시간을 "2019-10-07 10:13:12 KST" 형식으로 반환

`date()` : 현재 시간을 "Mon Oct 07 10:13:17 2019" 형식으로 반환

`as.Date()` : 문자열을 Date  객체로 변환

```R
a = as.Date('2018/6/16')
a-1
[1] "2018-06-15"
```

```R
dt1 <- c('1/5/7','5/8/19')
as.Date(dt1,'%d/%m/%y')
[1] "2007-05-01" "2019-08-05"
```



<h4>집합 함수</h4>

`union(x,y)` : 합집합
`intersect(x,y)` : 교집합
`setdiff(x,y)` : 차집합



`rep(x,option=n)` : 일정한 데이터의 반복

- option
  - times : vector n번 반복
  - each : 각각 동일한 횟수로 n번 반복

```R
rep(5,3)
[1] 5 5 5
rep(c('a','b','c'),times=3)
[1] "a" "b" "c" "a" "b" "c" "a" "b" "c"
rep(c('a','b','c'),each=3)
[1] "a" "a" "a" "b" "b" "b" "c" "c" "c"
rep(c(1,2),c(3,5))
[1] 1 1 1 2 2 2 2 2
```

`sep(from,to,option)` : 일정한 구조/순차 데이터 생성

- option
  - length
  - length.out : 수열의 길이 설정 공차는 수열의 길이에 따라 자동 설정
  - by : 수열이 증가하는 범위를 지정

`seq_along() `: 입력받은 벡터의 길이만큼 seq를 수행

`seq_len()` : 입력받은 인자만큼의 seq를 수행

<h4>vector</h4>

`names(vector)` : 입력된 vector의 인덱스 이름 설정

`length(vector)` : vector 길이 반환 함수



<h4>matrix</h4>

`matrix(option)` : 2차원 행렬을 option의 방법으로 생성

- option
  - nrow : 행의 수 설정, 열의 수는 자료 수에 맞춰 자동 생성
  - ncol : 열의 수 설정, 행의 수는 자료 수에 맞춰 자동 생성
  - byrow :  자료 입력 우선 순위 설정, TRUE : 열 우선 입력 FALSE : 행 우선 입력(default)
  - dimnames : 



`dim(matrix)` : 입력된 matrix의 차원(행,열) 출력

`nrow(matrix)` : 입력된 matrix의 행(row) 수 출력

`ncol(matrix)` : 입력된 matrix의 열(column) 수 출력

`dimnames(matrix)` : 입력된 matrix의 행과 열 이름 설정

`colnames(matrix)` : 입력된 matrix의 열 이름 설정

`rownames(matrix) `: 입력된 matrix의 행 이름 설정

```R
colnames(m)<-c('a','b','c')
rownames(m)<-c('r1','r2','r3')
m
   a b c
r1 1 2 3
r2 4 5 6
r3 7 8 9
```

`apply(matrix,1,option)` : 입력된 matrix의 행의 option 값 출력(1:행, 2:열)

- option
  - max : 최대값 출력
  - mean : 평균값 출력
  - min : 최소값 출력



<h4>list</h4>

`unlist(list)` : list를 vector로 변환 컬럼명은 index로 변환



<h4>dataframe</h4>







