# 시험 전 다운받아야할 것들####
#Working directory 설정하기
library(tidyverse) #다운 _ ggplot 사용
install.packages("nycflights13")
library(nycflights13) #nycflights 패키지 다운
data(flights) #다운확인

#1번 :MASS 패키지 내장데이터 Car93 객관식 (옳지않는거 : 1번,4번) ####

#1) Cars93은 결측값이 없는 데이터셋이다
any(is.na(Cars93)) #True
#2) origin의 값이 USA인 관측치는 모두 48개다
summary(Cars93) #후 origin 찾아서 확인.US48, non-US:45개

#3) Horsepower, Weight 두 변수의 상관계수의 값을 소숫점 넷째자리까지 반올림한 값은 0.7388이다
correlation <- cor(Cars93$Horsepower, Cars93$Weight, use="complete.obs")
# 상관계수를 소수점 넷째자리까지 반올림
rounded_correlation <- round(correlation, 4)
print(rounded_correlation) #0.7388

#4) Width 변수의 중앙값은 69다
median_width <- median(Cars93$Width, na.rm= TRUE)
print(median_width) #69

#5) Cars93은 27개의 관측치, 93개의 변수로 구성되었다. 
nrow(Cars93) #93
ncol(Cars93) #27 -> 즉 93개의 관측치, 27개의 변수

#2번:다음에 제시된 특성에 대한 설명중 옳지 않은것: 1,3번  ####
#1) 분산이 클수록 분포의 중심인 평균이 반드시 커진다 -> 아님
#2) 정규분포의 왜도는 0이고 첨도는 3이다
#3) 첨도는 평균과 분산에 따라달라진다 -> 그럴수도있지만 무조건은 아님
#4) 왜도가 오른쪽으로 꼬이면 왜도는 양수다


#3번: 초코과자 한봉지가 평균이 170그램이고 표준편차가 5g이도록 관리함. 
#100봉지를 골라 평균이 179그램이하가 될 확률. (소수점 세자리)
choco = pnorm(179, mean = mean_value, sd = sd_value)
round(chodo,3) #0.0023

#4번: 내장데이터인 mtcars데이터 셋에서 am값이 0인 그룹과 1인 그룹에 대해 mpg의 평균값의 차이에 대한 90% 신뢰구간을 소수점두자리까지 반올림하여 구했더니[-10.58,b]였다.b는? #####
t_test_result <- t.test(group0, group1, conf.level = 0.90)
confidence_interval <- t_test_result$conf.int
rounded_confidence_interval <- round(confidence_interval, 2)
print(rounded_confidence_interval)

#5번코드
# 12월 데이터 필터링 및 도착 지연 합계 계산
december_delays <- flights %>%
  filter(month == 12) %>%
  group_by(dest) %>%
  summarise(total_arrival_delay = sum(arr_delay, na.rm = TRUE)) %>%
  arrange(desc(total_arrival_delay))
# 도착 지연이 가장 많이 발생한 공항 출력
most_delayed_airport <- december_delays %>% slice(1)
# 결과 출력
print(most_delayed_airport)


# 6번: 아이리스 상관계수에 대해 올바르지 않은걸 고르시오(2번)
# 해당 알고리즘 방식으로 species == "versicolor" / "setosa"/ "verginica" 바꿔서 확인
versicolor_data <- subset(iris, Species == "versicolor")
numeric_data <- versicolor_data[, 1:4]
cor_matrix <- cor(numeric_data)
cor_matrix

#7번: 다음코드에서는 파란색이 적용되지 않는다. 적용되도록바꾸세요 ####
#적용이 안되는 코드 (문제코드)
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = "blue"))
#정답코드
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")

#8번: t겁정값과 pvalue 보는법 (영상참고) ####

#9번: 선형회귀 설명에 대해 옳은 것####
# 10번 ####
merged_data <- merge(a, b, by = "Name")
weight_mean <- mean(merged_data$weight)
score_mean <- mean(merged_data$score)
total_mean_sum <- weight_mean + score_mean
total_mean_sum
