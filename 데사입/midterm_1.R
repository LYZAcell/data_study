print("중간고사 준비")

#3주차실습
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
