set.seed(0)
x<-round(rnorm(10),2)
print(x)
sum(x)
#곱
prod(x)
#누적합
cumsum(x)
#누적곱, 누적최대-최소 등 있다
#요약통계
summary(x)
#자료값의 범위
range(x)
#quantile
quantile(x, probs = c(0.25,0.5,0.75))
#분산
var(x)
#표준편차
sd(x)

#pmin,pmax
print(y<-5:4)
max(x,y)
min(x,y)
pmax(x,y)
pmin(x,y)

#정렬
sort(x, decreasing = False)
rank(x)

#rbind,cbind
x<-1:4
y<-5:3
cbind(x,y)
rbind(x,y)

#matrix(재료,행개수,열개수)
B<- matrix(0,4,5)
cbind(B,1:4)

A<-matrix(1:20,4,5)
B<-matrix(1:20,4,5)
C<-cbind(A,B)
C


x<-list(a= 1:10,
        beta = exp(-3:3),
        logic = c(TRUE, FALSE, FALSE, TRUE))
print(x)

lapply(x,mean)
lapply(x,quantile,probs=(1:3)/4)

#데이터프레임다루기
str(faithful)
plot(faithful)
head(faithful[[1]])
head(faithful$waiting)


#결측생략
x <- data.frame(a = 1:5, b = c(1,2,NA,4,5))
x
cumsum(x)
cumsum(na.omit(x))


a <-data.frame(x = c(5,10,15), y = c("a","b","c"))
b <- data.frame(z = c(10,20,30))
cbind(a,b)

a1<-data.frame(x = c(20,25,30),y = c('d','e','f'))
rbind(a,a1)

library(MASS)
z <- (Cars93$Price - mean(Cars93$Price))/sd(Cars93$Price)
head(z)#cars함수 활용

#간단해진 Cars93$Price
z<-with(Cars93,(Price - mean(Price)/sd(Price)))
head(z)

#head,tail
library(MASS)
head(Cars93)
tail(Cars93)
str(Cars93)

#데이터 타입 변환
x<-1:3
x
y <- as.character(x)
y
as.numeric(y)

#조건문 if-else
x<-10
if(x<3)print("x<3")else print("x>=3")

#예제2
y<- -3:3
z<-ifelse(y<0,-1,1)
cbind(y,z)

#조건만들시 블록화
x<-4
if(x<3){
  print("x<3")
  z<-"M"
} else{
  print("x>3")
  z<-"F"
}

#반복문 for
n<-10
x<-1:n
#cumsum대신 루프로 구현
sum.so.far<-0
for( i in 1:n){
  sum.so.far<-sum.so.far + x[i]
  print(sum.so.far)
}

#while사용하기
n<-0
sum.so.far<-0
while(sum.so.far <= 100){
  n<-n+1
  sum.so.far <- sum.so.far +n
}
print(c(n, sum.so.far))

sum(1:45)


#break 공부
n<-0
sum.so.far<-0
while(i){
  if(sum.so.far > 1000)break
  n<-n+1
  sum.so.far<-sum.so.far + n
}
print(c(n, sum.so.far))
