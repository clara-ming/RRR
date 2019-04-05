#[ctrl] + [shift] + [F10]
#hotel_booking_train_1m.csv

time = Sys.time()
df = read.csv("hotel_booking_train_1m.csv", stringsAsFactors = FALSE)
Sys.time() - time

libraty("data.table")
time = Sys.time()
df = fread("hotel_booking_train_1m.csv", data.table = FALSE)
Sys.time() - time

head(df)
colnames(df)

#### 1. 결측값 처리
#1-1) orig_destination_distance 변수의 결측값을 제외한 평균 값을 구하시오.

#1-2) orig_destination_distance 변수의 결측값을 Q1-1에서 구한 값으로 대치하여라.

#### 2. 날짜 계산
#2-1) 검색일(date_time)에서 체크인 일자(srch_ci) 까지의 차이를 계산하고 "date_diff" 라는 새로운 변수에 그 값을 대입하시오.
#(단, 대입하는 값의 형식은 numeric으로 한정한다.)

#2-2) 각 검색데이터에서(row) 숙박 일수를 계산하고 "nights" 라는 새로운 변수에 그 값을 대입하시오.
#(srch_ci, srch_co 변수 활용, 4박 5일의 경우 4로 계산)

#2-3) "date_diff" 변수를 활용하여 검색일 부터 최초 숙박일 까지 남은 개월 수를 계산하고 "month_left" 라는 변수에 그 값을 대입하시오.
#(단, 소수점 아래 숫자는 버린다, 30일 단위로 나눔.)

#### 3. 호텔이 위치한 국가별 평균 숙박일수를 계산하고 가장 숙박일수가 긴 3개 국가의 번호를 가장 숙박일수가 긴 순서대로 기술하시오.

#### 4. 상관분석
#4-1) orig_destination_distance와 date_diff 변수간 상관계수를 소수 넷 째 자리에서 반올림하여 셋 째 자리까지 표기하시오.
#※ 결측치 제외 후 계산하시오. 

#4-2) orig_destination_distance와 date_diff 변수간 상관계수 검정을 실시하고 p-value를 소수 넷 째 자리에서 반올림하여 셋 째 자리까지 표기하고 귀무가설의 기각 여부를 YES또는 NO로 기술하시오.
#※ 결측치 제외 후 계산하시오. 
