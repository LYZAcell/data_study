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

# 11주차: GGplot ####
# 시험시작 전 ggplot가져오기
# library(tidyverse)

# 다이아몬드 cut에 따라 시각화
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut))

# ..prop..으로 상대도수 만들기
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, y = ..prop.., group = 1))


# 그래프에 색입히기 _ fill = 기준 설정해줄 시 가능
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = cut))

# clarity
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity)) # good!
  #geom_bar(mapping = aes(x = cut, color = clarity)) # Not good

# 투명도 사용해서 그래프그리기
d <- ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity))
d + geom_bar(alpha = 1/5, position = "identity")

# 같은길이로 늘려주는 position = "fill")
d + geom_bar(position = "fill")

# 옆으로 펼쳐주는 position = "dodge"
d + geom_bar(position = "dodge")

# 산점도 jitter 로 그려주기 (position = "jitter")
ggplot(data = mpg) +
  geom_point(
    mapping = aes(x = displ, y = hwy),
    position = "jitter"
  )


# 중위수 데이터 그리기
ggplot(data = diamonds) + 
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.min = min,
    fun.max = max,
    fun = median
  )

# 좌표축 다루기 - CoordFlip
# boxplot 그려주기
m <- ggplot(data = mpg, mapping = aes(x = class, y = hwy)) 
m + geom_boxplot()


# 박스플롯 가로로 눕히기 (flip)
m + 
  geom_boxplot() +
  coord_flip()

# 극좌표 :coord_polar
dbar <- ggplot(data = diamonds) + 
  geom_bar(
    mapping = aes(x = cut, fill = cut),
    show.legend = FALSE,
    width = 1
  ) +
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL)
dbar 

# 옆으로 돌리기
dbar + coord_flip()
  

# 나이팅게일 장미같이 그리기
dbar + coord_polar() # Coxcomb chart

# mpg에 대해 도시/고속도로 연비 선으로 그리기
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_point() +
  geom_abline()

#### ggplot 끝 ####

### 11주차 :dplyr ####

# nycflights13: 뉴욕 비행기들 확인
install.packages("nycflights13")
library(nycflights13)
# 다운 확인
data(flights)

# filter () 사용
# 1월1일의 비행기들
filter(flights, month == 11 | month == 12)

# 11월이거나 12월 비행인 경우
filter(flights, month == 11 | month == 12)

# 파이프 연산자 (%in% 문법)
filter(flights, month %in% c(11, 12))

# arrange 사용
arrange(flights, year, month, day)
# 연착률이 큰 순 나열 (arr_delay)
arrange(flights, desc(arr_delay)) # 내림차순 정렬

# select사용
select(flights, year, month, day)
# 인덱싱으로 같은 표현하기
select(flights, year:day)  
# - 연산자로 빼고 연산하기
select(flights, -(year:day))

# helper 함수
# 아래의 두 함수는 같다
select(flights, time_hour, air_time, everything())
select(flights, time_hour, starts_with("air"))

# rename: 변수명 바꿔주기
rename(flights, tail_num = tailnum)

# mutate 함수 : 변형시켜 저장하기
flights_sml <- select(flights, 
                      year:day, 
                      ends_with("delay"), 
                      distance, 
                      air_time)

mutate(flights_sml,
       gain = arr_delay - dep_delay,
       hours = air_time/60,
       gain_per_hour = gain/hours)

# transmute: 새로남은 변수만 남기고 남은 변수 지우고싶다면
transmute(flights_sml,
          gain = arr_delay - dep_delay,
          hours = air_time/60,
          gain_per_hour = gain/hours)

# summarise: 여러 통계를 한번에 계산하는 함수
summarise(flights, delay = mean(dep_delay, na.rm = TRUE))

# groupby
by_month <- group_by(flights, year, month)
summarise(by_month, delay = mean(dep_delay, na.rm = TRUE))

# groupby 안쓰고 파이프연산자로 만들기
result <- flights %>%
  group_by(year, month) %>%
  summarise(delay = mean(dep_delay, na.rm = TRUE))
# print result

# 파이프 연산자로 가독성 올리기
# 12월 데이터 필터링을 해보자
delays <- flights %>%
  group_by(dest) %>%
  filter(month == 12) %>%
  summarise(count = n(), #n = 건수를 카운팅해주는 변수
            dist = mean(distance, na.rm = TRUE),
            delay = mean(arr_delay, na.rm = TRUE)) %>% #파이프를 통해 arrange로 보냄
  arrange(desc(delay)) %>% #그 결과를 filter로 보냄
  filter(count > 20, dest != "HNL") # count가 20초과, 도착지가 호놀룰루가 아닌 곳

delays

# flights 데이터 프레임에서 11월과 12월 데이터를 필터링하고, 도착 지연 시간 기준으로 정렬하고, 일부 열만 선택
flights %>%
  filter(month %in% c(11, 12)) %>%
  arrange(desc(arr_delay)) %>%
  select(year, month, day, dep_delay, arr_delay)


# 그래프를 그리고 이를 파이프연산자로 바꿔보자
ggplot(data = delays, mapping = aes(x = dist, y = delay)) +
  geom_point(aes(size = count), alpha = 1/3) +
  geom_smooth(se = FALSE)

# 파이프연산자로 바꾸기
flights %>%
  group_by(dest) %>%
  filter(month == 12) %>%
  summarise(count = n(),
            dist = mean(distance, na.rm = TRUE),
            delay = mean(arr_delay, na.rm = TRUE)) %>%
  arrange(desc(delay)) %>%
  filter(count > 20, dest != "HNL")

# mpg 박스플롯 파이프연산자
mpg %>% 
  ggplot(mapping = aes(x = class, y = hwy)) +
  geom_boxplot() +
  coord_flip()

# mpg 파이프 연산자
mpg1 <- mpg %>%
  group_by(class) %>%
  summarise(Median = median(hwy)) %>%
  arrange(Median)
mpg %>%
  mutate(class = factor(class, levels = mpg1$class)) %>%
  ggplot(mapping = aes(x = class, y = hwy)) +
  geom_boxplot() +
  coord_flip()

### 11주차: 데이터사이언스 #####
pop <- data.frame(x = 1:6, prob = rep(1/6, 6))

# type = "h"라 눈물점찍힘. 빈 점 찍히게도 가능
plot(prob ~ x, dat = pop, type = "h", lty = 2,
     xlim = c(0, 7), ylim = c(0, 0.2), 
     xlab = "", ylab = "Probability", 
     main = "Population distribution",
     cex.lab = 0.8, cex.axis = 0.8, cex.main = 0.9)
# abline = 0 : 가로축에 선을 긋는데 h=0으로 쭉그어줘
abline(h = 0)
points(pop$x, pop$prob, pch = 19, cex = 1.5)


# 데이터 생성하기
set.seed(123)
n <- 30
dat <- sample(pop$x, size = n, prob = pop$prob, replace = TRUE)
dat
mean(dat)
sd(dat) #표준편차
var(dat) #분산


# 12주차 ####


# 주사위를 던져 데이터 만들기
set.seed(12357)
dat <- sample(pop$x, size = n, prob = pop$prob, replace = TRUE)
dat


# 만번 던지기
# 행2개, 열이 하나. 그래프 두개를 출력할 때 세로로 그릴 수 있게해준다
# 가로로 나열을 원할 시 c(1,2)해주면 된다
par(mfrow = c(2, 1))

# pop의 prob이 y축, x는 공백. Y의 범위는 0.2까지, y에는 가능성으로 이름붙이기
plot(prob ~ x, dat = pop, ylim = c(0, 0.2), pch = 19, 
     xlab = "", ylab = "Probability", 
     main = "Population distribution",
     # 글자 및 점크기 조정. 라벨은 원 크기에서 80%수준으로 만들어줘 (min은 90정도로 줄여줘)
     # 교수님 스타일. 취향껏 고
     cex.lab = 0.8, cex.axis = 0.8, cex.main = 0.9)
# 회색선 그리기
abline(v = pop$x, lty = 2, col = "gray")		
# 2번은 빨간색. 중간의 빨간선을 그어주는 함수
abline(v = 3.5, col = 2)

# 그리스 문자 mu. 3.5 옆  라틴어 문자임
text(3.5, 0, expression(mu == 3.5))

# 만번 반복해서 샘플을 30개씩 뽑을 것 (monte carlo)
M <- 10000
# xbar에 저장한 값을 저장해주도록 한다. Rep은 반복. 결측인 상태에서 M(만개) 실행하라
x.bar <- rep(NA, M)
for (r in 1:10000) {
  dat <- sample(pop$x, size = n, prob = pop$prob, replace = TRUE)
  # xbar의 r번째에 데이터를 채움 -> 반복하고 나면 xbar가 만개가 채워진다. 
  x.bar[r] <- mean(dat)
}
# xbar라는 만개의 mean을 구한거에 대한 histplot을 그릴 것
hist(x.bar, probability = TRUE, xlim = c(1, 6), 
     xlab = "Sample means", main = "Simulated sampling distribution", 
     cex.lab = 0.8, cex.axis = 0.8, cex.main = 0.9)
abline(v = 3.5, col = 2)

# 중심극한 정리 히스토그램 비교
z <- seq(from = 1, to = 6, by = 0.0025)
plot(z, dnorm(z, mean = 3.5, sd = 1.7078/sqrt(30)),
     type = "l", col = "gray", lwd = 2,
     xlab = "Sample Means", ylab = "Density",
     ylim = c(0, 2.5),
     main = "Theoretical sampling distributions by CLT",
     cex.axis = 0.8, cex.lab = 0.8, cex.main = 0.8)
lines(z, dnorm(z, mean = 3.5, sd = 1.7078/sqrt(100)),
      col = "darkred", lwd = 2)
text(4.25, 1.75, expression(N(3.5, 1.71^2/100)), col = "darkred", cex = 0.8)
text(4.5, 0.5, expression(N(3.5, 1.71^2/30)), cex = 0.8)


#설명 안함. 그냥 확인하라 한 코드
M <- 10000; n <- 30
par(mfcol = c(2, 2))

pop <- data.frame(x = 1:6, prob = (6:1)/sum(1:6))
mu <- sum(pop$x*pop$prob)
plot(prob ~ x, dat = pop, ylim = c(0, 0.3), pch = 19, 
     xlab = "", ylab = "Probability", 
     main = "Population distribution", 
     cex.lab = 0.8, cex.axis = 0.8, cex.main = 0.9)
abline(v = pop$x, lty = 2, col = "gray")

x.bar <- rep(NA, M)
for (r in 1:M) {
  dat <- sample(pop$x, size = n, prob = pop$prob, replace = TRUE)
  x.bar[r] <- mean(dat)
}
hist(x.bar, probability = TRUE, xlim = c(1, 6), 
     xlab = "Sample means", main = "Simulated sampling distribution", 
     cex.lab = 0.8, cex.axis = 0.8, cex.main = 0.9)
abline(v = mu, col = 2)

##
p <- c(6, 4, 2, 2, 4, 8)
pop <- data.frame(x = 1:6, prob = p/sum(p))
mu <- sum(pop$x*pop$prob)
plot(prob ~ x, dat = pop, ylim = c(0, 0.32), pch = 19, 
     xlab = "", ylab = "Probability", 
     main = "Population distribution",
     cex.lab = 0.8, cex.axis = 0.8, cex.main = 0.9)
abline(v = pop$x, lty = 2, col = "gray")

x.bar <- rep(NA, M)
for (r in 1:M) {
  dat <- sample(pop$x, size = n, prob = pop$prob, replace = TRUE)
  x.bar[r] <- mean(dat)
}
hist(x.bar, probability = TRUE, xlim = c(1, 6), 
     xlab = "Sample means", main = "Simulated sampling distribution", 
     cex.lab = 0.8, cex.axis = 0.8, cex.main = 0.9)
abline(v = mu, col = 2)


# 표준화 한 값 표준분포 활용하기
#평균값이 62.5(점)이 될 확률 / 현재 평균이 60에 편차가 10 -> 표준화
round(1 - pnorm(62.5, mean = 60, sd = 1), 4)

# 통계적 추론
mpg #활용. miles per gallon

# 산점도 그려보기 -> 이건 너무 크다고 안그려줌 ㅎㅎ
pairs(mtcars, cex.axis = 0.7, cex.lab = 0.8, cex = 0.8)


### 추정과 검정 ####

#1번: 미국 자동차의 평균 연비는?
m <- mean(mtcars$mpg)
s <- sd(mtcars$mpg)
print(c(m , s)) 

# 표준오차 연산 함수
n <- nrow(mtcars)
se <- s/sqrt(n)
print(se)

# 신뢰수준 95%에서의 오차한계 검산
print(q <- qnorm(0.025, lower.tail = FALSE))
# 위의 결과를 바탕으로 한 신뢰구간
err.bound <- q*se
print(err.bound)


# t분포 자유도
print(q <- qt(0.025, df = n - 1, lower.tail = FALSE))


#12주차의 모든 요약 t.test
t.test(mtcars$mpg, conf.level = 0.95)



# 13주차 ####

#pvalue : 유의수준 알파 설정하기
pt(1.9623, df = 31, lower.tail = FALSE)  # p-value

# 대립가설이 greater
t.test(mtcars$mpg, mu = 18, alternative = "greater")

# 대립가설이 less하다 => 귀무가설이 맞다
t.test(mtcars$mpg, mu = 18, alternative = "less")

#양쪽 검정
t.test(mtcars$mpg, mu = 18)

# 혹은 한쪽검정에 바꿔줌에 있어서 아래의 식을 지켜보는 방법도있음
t.test(mtcars$mpg, mu = 100)

# 변속기 종류와 연비사이의 관계
t.test(mpg ~ am, data = mtcars)

# 14주차 ####
# 선형인지 확인하기 위해 산점도 그리기
pairs(iris[,1:4], main = "Anderson's Iris Data -- 3 species", 
      pch = 21, bg = c("red", "green3", "blue")[unclass(iris$Species)])

library(dplyr)
# setosa에 대해 상관계수 구해보기
Setosa <- iris %>% filter(Species == "setosa") %>% select(-Species)
pairs(Setosa)

# cor을 활용해 상관계수 연산
with(Setosa, cor(Sepal.Width, Sepal.Length))

# sepal 너비와 petal 너비는 sepal의 너비와 길이 관계보다 약하다
with(Setosa, cor(Sepal.Width, Petal.Width))

# 아이리스의 전반상관행렬보기
cor(Setosa)

# 귀무가설: 상관계수가 0이다 vs 대립가설: 상관계수가 존재한다
with(Setosa, cor.test(Sepal.Width, Sepal.Length))

# sepal의 너비, petal의 너비도 검증하기
with(Setosa, cor.test(Sepal.Width, Petal.Width))

# 한쪽검정. 대립가설이 더 크다
with(Setosa, cor.test(Sepal.Width, Petal.Width, alternative = "greater"))

### 회귀분석 ####

R <- cor(mtcars[,1:7])
round(R, 2)

# 회귀분석이 유효한지 확인
pairs(mtcars[,1:7], pch = 20)


###### 단순선형회귀 ####

# target = mpg, features = weigt + e
with(mtcars, 
     plot(mpg ~ wt, pch = 20, xlim = c(0, 6), ylim = c(0, 40), 
          xlab = "Weight", ylab = "MPG")
)

# 단순선형회귀에 fit 시키기
fit <- lm(mpg ~ wt, data = mtcars)
summary(fit)

# 분석 결과 바탕 산점도그리기
# 산점도 그리기
with(mtcars, 
     plot(mpg ~ wt, pch = 20, xlim = c(0, 6), ylim = c(0, 40),
          xlab = "Weight", ylab = "MPG")
)
# ax+b 그리는 함수. Coef를 통해 아래와 같은 함수를 그릴 수 있다. 
abline(coef(fit), col = 2, lwd = 3)

# 나온 식 바탕으로 wt=2.4 , 3.2인 경우 연비 예측하기
# predict사용
# predict로 넣어주려면 newx를 데이터 프레임으로 만들어 넣어줘야한다. 
newx <- data.frame(wt = c(2.4, 3.2))
# predict (fit을 이용해서, newdata = 2.4(나3,2등넣기)
predict(fit, newdata = newx)


#예측오차 측정
# 데이터 없이 predict를 넣으면 모든값이 들어간다
pred <- predict(fit)
# 예측오차 제곱한거에 대해 평균냄
print(MSE <- mean((mtcars$mpg - pred)^2))
print(RMSE <- sqrt(MSE))

#위의 내용 바탕으로 산점도 그리기
par(mfrow = c(1, 2))
with(mtcars, 
     plot(mpg ~ wt, pch = 20, xlim = c(0, 6), ylim = c(0, 40),
          xlab = "Weight", ylab = "MPG")
)
abline(coef(fit), col = 2, lwd = 3)

lbub <- range(c(pred, mtcars$mpg))
plot(mtcars$mpg, pred, pch = 19, xlim = lbub, ylim = lbub,
     ylab = "Predicted", xlab = "Actual",
     cex.axis = 0.8, cex.lab = 0.8)
abline(0, 1, col = 2, lty = 2)


#### 다항회귀 #####
fit2 <- lm(mpg ~ wt + I(wt^2), data = mtcars) # I(): As-is 함수
summary(fit2)

# 단항회귀와 비교하는 시각화
with(mtcars, 
     plot(mpg ~ wt, xlim = c(1, 6), ylim = c(0, 40),
          xlab = "Weight", ylab = "MPG")
)
w <- seq(from = 1, to = 6, by = 0.001)
abline(coef(fit), col = 2, lwd = 3)
coef2 <- coef(fit2)
lines(w, coef2[1] + coef2[2]*w + coef2[3]*w^2, col = 4, lwd = 3)
legend("topright", legend = c("Linear", "Quadratic"), lty = c(1, 1), lwd = c(3, 3), col = c(2, 4))

#예측회귀모형 : 시각화
par(mfrow = c(1, 2))
plot(mtcars$mpg, predict(fit), xlim = c(0, 40), ylim = c(0, 40), pch = 19,
     xlab = "Actual MPG", ylab = "Predicted MPG", main = "Linear fit")
abline(0, 1, col = 2, lty = 2)
plot(mtcars$mpg, predict(fit2), xlim = c(0, 40), ylim = c(0, 40), pch = 19,
     xlab = "Actual MPG", ylab = "Predicted MPG", main = "Quadratic fit")
abline(0, 1, col = 2, lty = 2)

#제곱수
sqrt(mean((predict(fit) - mtcars$mpg)^2))
# 2.9
sqrt(mean((predict(fit2) - mtcars$mpg)^2))
# 2.5 -> 수로 0.4차이지만 꽤 큰차이다

# 3차식의 경우 2.52가 나온다 -> 과적합 (큰 향상이 없다)

# 과적합관련코드
# poly로 12차식
fit12 <- lm(mpg ~ poly(wt, 12), data = mtcars)
sqrt(mean((predict(fit12) - mtcars$mpg)^2))


#### 다중회귀 #####
fitM <- lm(mpg ~ hp + wt, data = mtcars)
summary(fitM)


#stepwise 알고리즘만들기
fitM <- lm(mpg ~ factor(am) + factor(cyl) + factor(vs) + factor(gear) + factor(carb) 
           + disp + hp + drat + wt + qsec, data = mtcars)
summary(fitM)  # embarrasing. pvalue, rsqure이 넘크다


# stepwise 절차만들기
# 넣었다 빼는과정 다 출력은 1, 결과만 보려면 0
step(fitM, trace = 0) # Stepwise 

# 결과 바탕 다시 summary
fitM <- lm(mpg ~ factor(am) + factor(cyl) + hp + wt, data = mtcars)
summary(fitM)

# 다중회귀의 성능이 가장 좋다
plot(mtcars$mpg, predict(fitM), 
     pch = 20, col = "navy",
     xlim = c(0, 40), ylim = c(0, 40),
     ylab = "Predicted MPG", xlab = "Actual MPG", 
     main = "Multiple regression fit",
     cex.axis = 0.7, cex.lab = 0.8, cex.main = 0.8)
abline(0, 1, col = 2, lty = 2)

# fitM으로 넣되 변수를 제대로 넣기
newx <- data.frame(am = 0, cyl = 4, hp = 200, wt = 3)
predict(fitM, newdata = newx)

# 자동차 3대에 대한 정보 넣고 예측
newx <- data.frame(am = c(0, 0, 0),
                   cyl = c(4, 4, 6), 
                   hp = c(180, 200, 250), 
                   wt = c(3, 3, 3.5))
predict(fitM, newdata = newx)
