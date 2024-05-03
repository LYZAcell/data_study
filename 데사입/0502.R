########### import & export ###############

x <- read.table(file = "./dat/iris.txt", header = TRUE)
head(x, n = 3)

x<-1:3
print(x)

#write로 export. data_x로 지정
x<- seq(from =0, to = 1 , by = 0.1)
write (x, file = "./data/data_x.txt")

#writetable사용해보기
y<-matrix(1:20, 4,5)
print(y)

write.table(y, file = "./data/data_y.txt", row.names = FALSE)

#iris 호출해서 csv저장하기
data(iris)
str(iris)
write.csv(iris, file = "./dat/iris.csv", row.names = FALSE)
#false가 없다면 어떻게되는지 : index가 생긴다
#write.csv(iris, file = "./dat/iris.csv")
#row_names = False 를 조절해보기. False가 있으면 앞에 rowname이 붙지만 False없애면 없어진다.
#write.table(iris, file = "./dat/iris.csv", row.names = FALSE, sep = ",")

iris.data<-read.csv(file = "./dat/iris.csv")

####### split 실습시작(가공) ############
library(MASS)    # for the dataset Cars93
summary(Cars93)

#origin에 따라 split 해보기
tmp <- split(Cars93$MPG.city, Cars93$Origin)   # grouping by 'Origin'
str(tmp)      # List of 2


#일부분 subset 하기 _ 유용

#시내 주행연비가 32이상인 수만 뽑기
subset(Cars93, subset = (MPG.city > 32))


#다른 데이터 소개: str(EuStockMarkets)
# 유럽 주식시장(주가지수) 모아둔 것
# 닥스는 독일, SMI 는 스위스, CAC는 프랑스, FTSE는 영국
str(EuStockMarkets)

#스위스, 프랑스는 관심이 없다면
cor(subset(EuStockMarkets, select = -c(SMI, CAC)))  # SMI and CAC excluded


#오존농도 보여주는 airquality 
head(subset(airquality, select = Ozone:Wind), n = 10)
head(subset(airquality, Temp>80, select = c(Ozone:Temp), n = 10))
subset(airquality , Day == 1 , select = -Temp)
#select에 :을 넣어주면 ~부터 ~까지
head(subset(airquality, select = Ozone:Wind), n = 10)

# merge
a <- data.frame(Name = c("Mary", "Jane", "Alice", "Bianca"),
                score = c(90, 95, 100, 100))
b <- data.frame(Name = c("Jane", "Alice", "Ana"), 
                weight = c(70, 55, 60))
merge(a, b, by = "Name")
#결측처리
merge(a, b, by = "Name", all = TRUE)


#apply: 함수 반복적용
a <- matrix(1:20, 4, 5)
a
apply(a, MARGIN = 1, FUN = mean)  # to every row
apply(a, 2, mean)                 # to every column

#lapply
Hong <- list(first.name = "Samuel", 
             age = 44, 
             gender = "M", 
             n.child = 2, 
             child.gender = c("M", "F"))
lapply(Hong, length)   # returns a list
sapply(Hong, length)   # returns a vector

#tapply
#종별로 잎넓이의 평균을 계산하라
with(iris, tapply(Sepal.Width, Species, mean)) 

#by데이터: 그룹별 함수적용,
#아이리스의 species별로 summary를 하라고 하고 싶다면
by(iris, iris$Species, summary)
