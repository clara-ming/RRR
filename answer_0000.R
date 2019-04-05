#### 1. "elec_load.csv" 파일을 data.table 패키지의 fread() 함수로 읽어와서 df 객체에 저장하시오.
#(단, data.table 인자의 값을 FALSE로 한다.)
library("data.table")
df = fread("elec_load.csv", data.table = FALSE)

#### 2. df 객체의 최초 6개 row를 출력하여 확인하시오.
df[1:6, ]
head(df)

#### 3. df 객체에 존재하는 결측치 개수는 총 몇개인가?
sum(is.na(df))

#### 4. df 객체의 YEAR 변수를 참고하여 각 연도별 기록된 데이터 개수를 확인하시오.
table(df$YEAR)

#### 5. 4번의 결과를 보고 데이터의 기록이 가장 적은 연도와 많은 연도를 차례대로 기술하시오.
tb = as.data.frame(table(df$YEAR))
head(tb)
tb[tb$Freq == max(tb$Freq), "Var1"]
tb[tb$Freq == min(tb$Freq), "Var1"]
head(tb)

#### 6. df 객체의 YEAR, MONTH, DAY 변수를 하이픈(-)으로 연결하여 df 객체에 DATE라는 새로운 변수를 생성하시오.
# paste()

df[, "DATE"] = paste(df$YEAR,df$MONTH,df$DAY, sep = '-')
head(df)

#### 7. df 객체의 DATE 변수의 속성을 확인하시오.\
class(df$DATE)

#### 8. df 객체의 DATE 변수의 속성을 날짜(date 또는 POSIX) 속성으로 변경하시오.
df[, "DATE"] = as.Date(df$DATE)
class(df$DATE)

#### 9. df 객체의 YEAR, MONTH, DAY 변수를 제거하고, DATE 변수의 위치를 첫 번째로 옮기시오.
#단순 벡터 연산
df = df[, c(28, 4:(ncol(df) - 1))]
head(df, 2)
colnames(df)

#### 10. reshape2 패키지를 불러오시오.
library("reshape2")

#### 11. melt() 함수를 사용하여 df객체의 DATE 변수를 기준으로 df객체의 구조를 변형하고 
#### 그 결과를 df_melt 객체에 저장하시오.
#(df_melt의 row, column 개수는 85104, 3 이다)
df$DATE
str(df$DATE)
df_melt = melt(data = df, id.vars = "DATE")
dim(df)

#### 12. df_melt 객체의 두 번째 변수를 "hour", 세 번째 변수를 "load"로 변경하시오.
colnames(df_melt)[c(2, 3)] = c("hour", "load")

#### 13. hour 변수의 영문자를 모두 제거하시오.
df_melt[, "hour"] = gsub(pattern = "[A-Z]", replacement = "", df_melt$hour)
head(df_melt)
unique(df_melt$hour)
#### 14. hour 변수의 속성을 확인하시오.
class(df_melt$hour)

#### 15. hour 변수의 속성을 숫자로 변경하시오.
df_melt[, "hour"] = as.numeric(df_melt$hour)

#### 16. df_melt 객체의 "DATE" 변수를 기준으로 "wday" 라는 이름의 요일 변수를 생성하시오.
df_melt[, "wday"] = lubridate::wday(df_melt$DATE, week_start = 1)
head(df_melt)

#### 17. df_melt 객체의 "wday" 변수를 활용하여 주말 데이터만 추출하고 그 결과를 df_melt_wend 객체에 저장하시오.
df_melt_wend = df_melt[df_melt$wday >= 6, ]
head(df_melt_wend)

#### 18. df_melt_wend 객체를 "elec_load_wend.csv"로 저장하시오.
#(단, 함수는 fwrite()를 사용할 것)
fwrite(df_melt_wend, "elec_load_wend.csv")