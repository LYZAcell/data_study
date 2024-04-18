beer <- c(3, 4, 1, 1, 3, 4, 3, 3, 1, 3, 2, 1, 2, 
          1, 2, 3, 2, 3, 1, 1, 1, 1, 4, 3, 1)
# (1) 국내산 캔맥주  (2) 국내산 병맥주 
# (3) 수제맥주       (4) 수입맥주
barplot(table(beer)) 


barplot(table(beer)/length(beer),      # 상대도수 
        col = c("lightblue", "mistyrose", "lightcyan", "cornsilk"),    # 막대 색깔 
        names.arg = c("Domestic\n can", "Domestic\n bottle", "Microbrew\n", "Import\n"),  # 막대 라벨 
        ylab = "Relative frequency", main = "Beer Preference")



#파이차트
beer.counts <- table(beer) 
names(beer.counts) <- c("Domestic\n can","Domestic\n bottle", "Microbrew","Import")
pie(beer.counts)

beer.counts
beer.counts<-table(beer)


#양적자료

#줄기잎그림
scores <- c(2, 3, 16, 23, 14, 12, 4, 13, 2, 0, 0, 0, 6, 28, 31, 14, 4, 8, 2, 5)
stem(scores)

#히스토그램
x <- rnorm(1000)  # N(0, 1)에서 1,000개의 난수 생성 
hist(x)
#꾸며주기
hist(x, xlab = "data", col = "navy", border = "white") # 히스토그램 


hist(x, probability = TRUE, col = "navy", border = "white", ylim = c(0, 0.45),
     xlab = "Simulated Data", main = "Histogram (Relative frequency)", 
     cex.axis = 0.7, cex.lab = 0.8, cex.main = 0.9)  # 상대도수 히스토그램 
z <- seq(from = -3, to = 3, by = 0.01)  # N(0,1)의 밀도함수 값을 계산할 grid 지정 
lines(z, dnorm(z), col = 2, lwd = 3)    # 빨간색 실선으로 N(0,1)의 밀도함수 곡선 덧그리기 

#약어로 쓰기 -> 습관은 TRUE다 쓰는 버릇으로 들일 것
barplot(x)
hist(x, prob = TRUE)
lines(z,dnorm(z))
lines(z,dnorm(z), lwd =3 )
lines(z,dnorm(z), lwd =3,col = "pink" )


#boxplot :상자그림
growth <- c(75, 72, 73, 61, 67, 64, 62, 63) # the size of flies
sugar <- c("C", "C", "C", "F", "F", "F", "S", "S") # diet
fly <- data.frame(growth = growth, sugar = sugar)
boxplot(fly$growth)

#가로로 그리기 가능
boxplot(fly$growth, horizontal = TRUE, xlab = "Growth")

#먹이별 boxplot
boxplot(growth ~ sugar, col = "orange", data = fly)


############# 2교시 산점도~~ #################
summary(iris)
#산점도 그림그리기
plot(iris$Sepal.Width, iris$Sepal.Length)

#좀 더 예쁘게 그리고 싶다!

plot(iris$Sepal.Width, iris$Sepal.Length, 
     pch = 21, bg = iris$Species, col = "darkred", cex = 1.5,
     xlab = "Width", ylab = "Length", main = "iris data: sepal shape",
     cex.axis = 0.8, cex.lab = 0.8, cex.main = 2)



#html로 컬러코드 괴랄하게 넣기
colors <- c("#999999", "#E69F00", "#56B4E9") # html color code 
colors <- colors[as.numeric(iris$Species)]
with(iris, plot(Sepal.Width, Sepal.Length, col = colors, pch = 19))
legend("topright", legend = levels(iris$Species), 
       pch = c(19, 19, 19), col = c("#999999", "#E69F00", "#56B4E9"))


#3차원 산점도
library("scatterplot3d")
s3d <- scatterplot3d(iris[,1:3], pch = 16, color = colors)
legend(s3d$xyz.convert(7.5, 3, 4.5), legend = levels(iris$Species),
       col =  c("#999999", "#E69F00", "#56B4E9"), pch = 16)


#데이터 import
x<-scan()

x <- scan("C:/Users/bestl/OneDrive/바탕 화면/24-1/데이터분석입문/lee.txt")
x <- scan("C:/Users/bestl/OneDrive/바탕 화면/24-1/데이터분석입문/lee.txt")
x
#[1]   1   2   3   4   5   6   7   8   9  10  11  32  63  20  21 349

#session에서 set directory해서 폴더 바꿔주기
y <- matrix(scan("./lee.txt"), ncol = 4, byrow = TRUE)
