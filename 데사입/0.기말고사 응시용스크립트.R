### 9주차 :파일 입출력 ####

# 데이터 입출력_scan치면 자료입력 받기 가능
x<-scan()

# 상대경로로 데이터 scan해오기
y<- matrix(scan("./data/data_x.txt"),ncol = 3, byrow = TRUE)

# read.table
x<-read.table(file = "./data/iris.txt", header = TRUE)
head(x,n=3)

# export 하기: write를 사용하면됨
x<-1:3
x<-seq(from =0, to=1, by = 0.1)
write(x, file = "./data/data+x.txt")

# write.table해보기
y<-matrix(1:20, 4,5)
write.table(y, file = "./data/data_y.txt", row.names = FALSE)

# iris 불러오기 가능
data("iris")
str(iris)
write.csv(iris, file = "./dat/iris.csv", row.names = FALSE)
write.table(iris, file = "./dat/iris.csv", row.names = FALSE, sep = ",")

# write.csv
write.csv(iris, file = "./dat/iris_false.csv", row.names = FALSE)
# false가 없으면 인덱스가 생긴다
write.csv(iris, file = "./dat/iris_true.csv")
# sep
write.table(iris,file = "./dat/iris_sep.csv", row.names = FALSE, sep = ",")

#읽어오기
iris.data<-read.csv(file = "./dat/iris.csv")
iris.data


#### 데이터 가공하기 ####


###### subset #######
# Cars93을 살펴보자
library(MASS)
summary(Cars93)

# origin 여부에 따라 split
tmp <- split(Cars93$MPG.city, Cars93$Origin)
str(tmp)

# subset: 시내주행연비 32이상인 수 뽑기
subset(Cars93, subset = (MPG.city > 32))
# 교수님이 돌려보라한 것
subset(Cars93, select = Model , subset = (MPG.city > 32))

# eustockMarkets가 있다
str(EuStockMarkets)
cor(EuStockMarkets)
# 프랑스와 스위스가 싫다면
cor(subset(EuStockMarkets, select = -c(SMI, CAC)))

# 오존농도를 보여주는 airquality
head(subset(airquality, select = Ozone:Wind), n = 10)
# 온도 제외 출력
subset(airquality, Day == 1, select = -Temp)

# 인덱싱해주기
head(subset(airquality, select = Ozone: Wind), n = 10)

###### Merge ######
a <- data.frame(Name = c("Mary", "Jane", "Alice", "Bianca"),
                score = c(90, 95, 100, 100))
b <- data.frame(Name = c("Jane", "Alice", "Ana"), 
                weight = c(70, 55, 60))
merge(a,b,by = "Name")

# merge결과확인 :all = True로 잡아 결측치 확인
merge(a,b,by = "Name", all = TRUE)

###### Apply ######

a<- matrix (1:20, 4,5)
a
apply(a, MARGIN = 1, FUN = mean)  # to every row (행)
apply(a,2,mean) #모든 컬럼에 적용

# lapply
Hong <- list (first.name = "Samuel",
              age = 44,
              gender = "M",
              n.child = 2,
              child.gender = c("M","F"))
lapply(Hong, length) #returns list

# Sapply : 벡터 반환
sapply(Hong, length)

# tapply: 특정 변수에 그룹별로 함수적용
with(iris, tapply(Sepal.Width, Species, mean))

# By로 그룹화해보기
by(iris, iris$Species, summary)

##### 확통(이항분포) 함수써보기 #####

#이항분포 : dbinom(확률변수,시행횟수, prob)
# 주사위면 dbinom (같은수가 나올 횟수 , 던질 횟수, 주사위확률)
dbinom(3, 5, 1/6)

# 누적분포 pbinom
pbinom(2,8,0.5) # = dbinom(0,8,0.5) + dbinom(1,8,0.5) + dbinom(2,8,0.5)

# 분위수 계산 qbinom
quantile <- qbinom(0.95, size = 10, prob = 0.5)
print(quantile)

# 랜덤분포 rbinom : rbinom(생성할 난수 개수, 시행횟수, 성공확률)
rbinom(5,size = 10, prob = 0.5)

# 포아송 함수
dpois(3, 0.2)

# 누적 포아송 : ppois
ppois(3,0.2) # = dpois(0,0.2) + .. dpois(3,0.2)

# 분위 포아송 : qpois (분위수, 평균 발생률)
qpois(0.75,3)

# 랜덤 포아송
rpois(10,3)

# 예제: 오타 두개 이상
1-ppois(1,0.5)

# 정규분포 dnorm(확률변수, 평균, 표준편차 = 1 -> 표준정규분포)
dnorm(2,3,1)

# 정규분포 : 초코과자 예제
pnorm(197, 200, 1.5)
# -2로 표준화 하기
Z<- (197 - 200) / 1.5
pnorm(Z)


##### TidyVerse #####
library(tidyverse)

# ggplot2 써보기
mpg
# data = 지정, 도형(geom은 point로)
#mapping = aes(예쁘게) x = 배연량, y는 고속도로 
ggplot(data = mpg) + 
  geom_point(mapping = aes ( x = displ, y = hwy))

# aes : 점 색 바꾸기
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")

# aes 안에 점색 지정해주는 경우
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class))

# alpha로 투명도 넣어주기
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, alpha = class))

# 모양으로 구분해주기
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, shape = class))

# 실린더 개수로 표현
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, size = cyl), alpha = 1/5)


# facet_wrap
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~ class, nrow = 2)

# 실린더개수 그리드 위에 facet_wrap 그리기
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ cyl)

# 추세 곡선 그리기
ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy))

# 추세곡선 + 점
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() +
  geom_smooth()

# 추세곡선 + 색점
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = class)) +  #색을 class 기준으로 잡음
  geom_smooth()

# filter 걸어 그리기
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = class)) + 
  geom_smooth(
    data = filter(mpg, class == "subcompact"),
    se = FALSE)








