print("중간고사 준비")

#############3주차실습#############
getwd()
setwd("C:/Users/bestl/OneDrive/바탕 화면/24-1/데이터분석입문")
getwd()

#파일생성
write(file = "./testwrite.txt",cbind(x,y))

#help 기능 사용하기
?persp
x <- seq(-10, 10, length.out = 30)
y <- x
f <- function(x, y) { r <- sqrt(x^2+y^2); 10 * sin(r)/r }
z <- outer(x, y, f)
op <- par(bg = "white")
persp(x, y, z, theta = 30, phi = 30, expand = 0.5, col = "lightblue")
persp(x, y, z, theta = 30, phi = 30, expand = 0.5, col = "lightblue",
      ltheta = 120, shade = 0.75, ticktype = "detailed",
      xlab = "X", ylab = "Y", zlab = "Sinc( r )", cex.axis = 0.8
) -> res
round(res, 3)

#library다운받기
#library(MASS, lib,loc = )


########4주차###########


#변수명 지정하기
x <- 3       # OK
x <- x + 1   # OK
res <- x     # OK
res.2 <- x   # OK
res_2 <- x   # OK
res.a <- x   # OK
res_ab <- x  # OK
.res <- x    # OK (but 비추천)
#2.res <- x   # error...

#여러변수 이어주기
print(x); y<-4;print(y)

#기본 사칙연산
x<-11; y<- 3
print("나눗셈 x/y = ")
print(x/y)
print("제곱 x^y")
print(x^y)
print("정수나눗셈 x%/%y= ")
print( x%/%y)
print("나머지 x%%y = ")
print( x%%y)
print("곱셈 x*y")
print(x*y)

#지수 e활용하기
1.2e4 #1.2 * 10000 = 12000
100000000 #1e+08
1.2e-3 #0.0012

#수학함수
pi #파이
exp(1) #2.72

#지수함수그려보기
# n^y 그래프 그리기
n <- 2
curve(n^x, from = -5, to = 5, n = 1000,
      xlab = "y", ylab = paste(n, "^y"), main = paste("Graph of", n, "^y"))


#e^x 함수그려보기
curve(exp(x), from = -5, to = 5, n = 1000, 
      xlab = "x", ylab = "Y = e^x", main = "Graph of Y = e^x")

#log그리기
log(x,base = n)
log(x)
#로그의 밑과 값 정해주기
result <- log(10,base = 2)
print(result)

#삼각함수들
sin(x)
cos(x)
tan(x)
asin(x)
acos(x)
atan(x)


#절대값
abs(x)
#제곱근
sqrt(x)

#올림
y<-3.5
ceiling(y)
#내림
floor(y)
#반올림
round(pi, digits=2)
round(y)

#팩토리얼
factorial(x)

#조합
choose(5,3)



#벡터: 같은타입의 성분만 묶을 수 있다. 즉 boolean,int,str이런식으로 못묶음
x <- c(1, 2.5, 3.2)                                     # double
y <- c(1200000, 1000000, 900000)                        # integer
z <- c("인천", "대전", "광주", "대구", "울산", "부산")     # string
v <- c(TRUE, FALSE, FALSE, TRUE)                        # logical
#인덱싱 가능
x[1]
y[c(1,2)]


#팩터: 성분을 정해주는 벡터. 
blood.type <- factor(x = c("A", "A", "AB", "O", "O", "A"), 
                     levels = c("A", "B", "AB", "O"))
#table도수분포표 작성
table(blood.type)

#table로 처리하면 그냥 다들어오는 차이
table(c("A", "A", "AB", "O", "O", "A","외계인"))


#1차원벡터와 인덱싱
info <- data.frame(Height = c(165, 180), Weight = c(45, 80))
info[1,2];info[2,2]

#배열예시
z <- array(data = 1:20, dim = c(4, 5))     # 벡터 1:20를 4*5 배열로 재배치  
z

#3차원 배열
tri = array(1:24, dim = c(2,4,3))
tri

#matrix(행렬)얘시
z <- matrix(data = 1:20, nrow = 4, ncol = 5, byrow = FALSE)          
z

###############5주차##############################

#리스트실습
Hong <- list(kor.name = "홍길동",
             eng.name = "Gil-dong",
             age = 43, 
             married = TRUE, 
             no.child = 2, 
             child.age = c(13, 10))
#리스트값꺼내오기
Hong$age #권장
Hong["no.child"]
#인덱스 내의 값이 여러개인 경우
Hong$child.age[2]

#str사용
str(Hong)

#리스트 인덱싱:숫자
Hong[[3]]
#벡터로 리스트 인덱싱
Hong[c(2,5)]


#데이터프레임(dataframe, df)
x <- c(100, 75, 80)
y <- c("A302043", "A302044", "A302045")
#세사람의 정보가 담긴 x,y를 z에 데이터프레임으로 담기
z <- data.frame(score = x, ID = y)
z
#id가 먼저오게 이쁘게바꿔주기
z<- data.frame(id=y, score = x)
z

#아이리스불러오기
str(iris)
head(iris)

#stringasfoactors
dat.1 <- data.frame(x = 1:3, y = c('a', 'b', 'c'))
dat.1 <- data.frame(x = 1:3, y = c('a', 'b', 'c'))

dat.2 <- data.frame(x = 1:3, y = c('a', 'b', 'c'), stringsAsFactors = TRUE)
dat.2

#strasfacotr여부 비교
str(dat.1)
str(dat.2)

####다시 벡터 관련 문법
a <- c(1,2,3)
b <- c(5, 6) 
#기존의 벡터를 연결하여 새로운 벡터 x만들기
x <- c(a, 4, b)
print(x)

#append해보기
append(x,99,after = 3) #세번째 다음에 넣기
append(x,99,after = 0) #맨 처음에 넣기

#결측치 확인하기
x<-c(1,2,3,NA,5)
is.na(x)
#범위를 넘어선 값에 할당 시 그 사이의 값들을 NA 처리해버림
a <- c(1,2,3)
a[7] <- 10
a


#벡터에 이름붙여 사용이 가능하다
fruit<-c(5,3,2)
names(fruit)<-c("apple","orange","peach")
fruit

#벡터생성:수열(seq())
x<-seq(from = 0, to =1 , by = 0.1)
x #0.1씩 증가하는 수열
#10등분도 가능
y<-seq(from = 0 , to = 1, length =11) #10등분하려면 11번자르기(0부터 10까지 길이)
y

#아래와 같이 :로도 생성가능
z<-1:10
z
5:-5

#반복하여 생성하기 (rep())
rep(7,10)
#1~3 두번
rep(1:3,2)
#1~3까지 각각 두번
rep(1:3, each =2)

#벡터 사칙연산: 재활용(recycling)
x<-c(1,2,3)
z<-rep(2,5)
#123_12 + 22222임
x+z

#논리값 연산
x<-1:10
x
z<-x<5
z
sum(z)
mean(z)

#boolean asnumeric
as.numeric(z)

#인덱스 벡터 추출
x<- -10:10
x
x>0
#해당인덱스벡터 추출
x[x>0]

######기출유력후보###########
x<- -10:10
y <- x[x < 0]             # x에서 음수인 성분을 추출해 y에 할당
y
x[x < 0] <- -x[x < 0]     # 절대값 벡터 : -인 애들에 -를 붙여 x의 값을 정정해줌 
x
#결측이 있을 시 빼고 출력하라
x <- c(1, 2, 3, NA, 5)
x[!is.na(x)]
#결측채우기
x[is.na(x)]<-4
x


#통계함수:rnorm(랜덤)
set.seed(0) #난수 고정을 위한 set.seed
x<-round(rnorm(10),2) #가상데이터 생성. rnorm으로 정규분포에서 변수생성
x

##### 6주차 #######
set.seed(0) #난수 고정을 위한 set.seed
x<-round(rnorm(10),2) #가상데이터 생성. rnorm으로 정규분포에서 변수생성
x

#곱
prod(x)

#누적합
cumsum(x)
#요약통계
summary(x)


#자료의 범위 확인
range(x)
#quantile확인
quantile(x,probs = 0.5)
quantile(x,probs = c(0.25,0.5,0.75))
quartile(x)

#분산
var(x)
#표준편차
sd(x)

#pmax, pmin 찾기
y<-rep(5:4,5)
max(x,y) #그냥 큰 값
pmax(x,y)
pmin(x,y)

#sort:정렬
sort(x)
#rank: 순위매기기. 1이 적힌 위치가 가장 작은 수
rank(x)


##### cbind,rbind ####
x <- 1:4
y <- 5:3
#컬럼명에 잘 들어감
cbind(x,y)
#x,y가 행으로 들어가는 요상한 상황
rbind(x,y)

#matrix(재료,행개수,열개수)로 지정하여 확인 가능
B<-matrix(0,4,5)
cbind(B,1:4)

#matrix두개 붙여보기
A<-matrix(1:20,4,5)
B<-matrix(1:20,4,5)
C<-cbind(A,B)
C


######리스트다루기#########
x<-list(a=1:10,
        beta = exp(-3:3),
        logic = c(TRUE,FALSE,FALSE,TRUE))
#lapply적용하여 반복해보기
lapply(x,mean)
#사분위수 lapply
lapply(x,quantile, probs = (1:3)/4)


###### 데이터프레임 다루기 ####
#faithful
str(faithful)
plot(faithful)
head(faithful$waiting)

waiting = faithful$waiting
mean(waiting)

#결측처리: na.omit
x<-data.frame(a=1:5, b = c(1,2,NA,4,5))
cumsum(x)
print("####na.omit실행######")
cumsum(cumsum(na.omit(x)))

#cbind, rbind
a1<-data.frame(x = c(20,25,30),y = c('d','e','f'))
rbind(a,a1)


#with 배우기
###### Cars93등장#####
library(MASS)
str(Cars93)
#표준화 : 값을 0~1사이로 바꿔줌
z <- (Cars93$Price - mean(Cars93$Price)) / sd(Cars93$Price)
head(z)
#with로 간단해진 구성
z <- with(Cars93, (Price - mean(Price))/sd(Price))
tail(z)


###### 데이터변환 as#####
x<-1:3
y<-as.character(x)
print(x)
print(y)
as.numeric(y)

#조건문 if
x<-10
if(x<3) print("x<3") else print("x>=3")

#ifelse2
y<- -3:3
z<- ifelse(y<0, -1,1) #0보다 작으면 -1, else면 1
cbind(y,z)

#조건블록화
x<-4
if(x<3){
  print("x<3")
  z<-"M"
} else {
  print("x>3")
  z<-"F"
}

#for문
n<-10
x<-1:n
#cumsum을반복문으로 구현해보자
sum.so.far<-0
for(i in 1:n){
  sum.so.far<- sum.so.far + x[i]
  print(sum.so.far)
}

#while 용례
n<-0
sum.so.far<-0
while(sum.so.far <= 100){
  n<-n+1
  sum.so.far <- sum.so.far +n
}
print(c(n,sum.so.far))
sum(1:45)

#break용례
n<-0
sum.so.far<-0
while(i){
  if(sum.so.far > 1000) break
  n<-n+1
  sum.so.far<-sum.so.far+n
}
print(c(n, sum.so.far))

######## 7주차 #####

#Barchart(막대그래프)
beer <- c(3, 4, 1, 1, 3, 4, 3, 3, 1, 3, 2, 1, 2, 
          1, 2, 3, 2, 3, 1, 1, 1, 1, 4, 3, 1)
# (1) 국내산 캔맥주  (2) 국내산 병맥주 
# (3) 수제맥주       (4) 수입맥주
barplot(table(beer)) 
#조금의 치장을 더함
barplot(table(beer)/length(beer),      # 상대도수 
        col = c("lightblue", "mistyrose", "lightcyan", "cornsilk"),    # 막대 색깔 
        names.arg = c("Domestic\n can", "Domestic\n bottle", "Microbrew\n", "Import\n"),  # 막대 라벨 
        ylab = "Relative frequency", main = "Beer Preference")

#piechart(원형그래프)
beer.counts <- table(beer) 
names(beer.counts) <- c("Domestic\n can","Domestic\n bottle", "Microbrew","Import")
pie(beer.counts)


#양적자료
#줄기 잎그림 (stem-leaf)
scores <- c(2, 3, 16, 23, 14, 12, 4, 13, 2, 0, 0, 0, 6, 28, 31, 14, 4, 8, 2, 5)
stem(scores)

#히스토그램(histogram)
x<-rnorm(1000)
hist(x)
#꾸며주기
hist(x,xlab = "data", col = "navy", border = "white")

#probaility 켜주기
hist(x,probability = TRUE, col = "navy",border ="white", ylim = c(0,0.45),
     xlab = "Simulated Data", main = "Histogram(Relative Frequency",
     cex.axis = 0.7, cex.lab = 0.8, cex.main = 0.9)
z<- seq(from = -3, to =3 ,by =0.01) #밀도함수 grid지정
lines(z,dnorm(z),col = 2, lwd =3 )

#밀도함수 예시
lines(z,dnorm(z),lwd =3 , col = "pink")
hist(x,prob = TRUE)
lines(z,dnorm(z))

#상자그림(boxplot, 박스플롯)

growth <- c(75, 72, 73, 61, 67, 64, 62, 63) # the size of flies
sugar <- c("C", "C", "C", "F", "F", "F", "S", "S") # diet
fly <- data.frame(growth = growth, sugar = sugar)
boxplot(fly$growth)
#가로로그리기 가능
boxplot(fly$growth, horizontal = TRUE, xlab = "Growth")

#먹이별로 분류하여 그림그리기
boxplot(growth ~ sugar, col = "orange", data = fly)

##### 산점도 ####
summary(iris)
str(iris)
plot(iris$Sepal.Width, iris$Sepal.Length)

#예쁘게 채우기
plot(iris$Sepal.Width, iris$Sepal.Length, pch = 19, col = "gray", 
     xlab = "Width", ylab = "Length", main = "iris data: sepal shape")

# 더 이쁘게!
plot(iris$Sepal.Width, iris$Sepal.Length, 
     pch = 21, bg = iris$Species, col = "darkred", cex = 1.5,
     xlab = "Width", ylab = "Length", main = "iris data: sepal shape",
     cex.axis = 0.8, cex.lab = 0.8, cex.main = 2)

#html로 색괴랄하게 넣기
#중요한건 with 사용과 legend(범례)
colors <- c("#999999", "#E69F00", "#56B4E9") # html color code 
colors <- colors[as.numeric(iris$Species)]
with(iris, plot(Sepal.Width, Sepal.Length, col = colors, pch = 19))
#범례를 오른쪽위에 두가
legend("topright", legend = levels(iris$Species), 
       pch = c(19, 19, 19), col = c("#999999", "#E69F00", "#56B4E9"))


#3차원패키지 받아주기
#install.packages("scatterplot3d")
library("scatterplot3d")
s3d <- scatterplot3d(iris[,1:3], pch = 16, color = colors)
legend(s3d$xyz.convert(7.5, 3, 4.5), legend = levels(iris$Species),
      col =  c("#999999", "#E69F00", "#56B4E9"), pch = 16)

#범례 위치 바꿔주기 정도
s3d <- scatterplot3d(iris[,1:3], pch = 16, color = colors)
legend("right", legend = levels(iris$Species), inset = 0.1,
       col =  c("#999999", "#E69F00", "#56B4E9"), pch = 16)



##### scan 문법 ####
x<-scan()
x <- read.table(file = "./dat/iris.txt", header = TRUE)