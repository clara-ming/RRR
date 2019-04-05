#### .=========.####
#### | [[ Day 5 ]] ####
#### .=========.####

# 하나씩 실행시키세요.
install.packages("tidyverse")
install.packages("dplyr")
install.packages("reshape2")
install.packages("psych")

install.packages("intergraph")
install.packages("network")
install.packages("igraph")
install.packages("sna")

install.packages("ggplot2")
install.packages("ggnetwork")
install.packages("wordcloud")

library("tidyverse")
library("dplyr")
library("reshape2")
library("psych")

library("intergraph")
library("network")
library("igraph")
library("sna")

library("ggplot2")
library("ggnetwork")
library("wordcloud")

#### 1. 4주차 복습 ####
#### 2. 고급 텍스트 처리 ####
#### ____ ● 정규표현식 ####
# 실습 데이터 만들기
text1 = "1234 asdfASDF  ㄱㄴㄷㄹㅏㅑㅓㅕ가나다라   .!@#"
text2 = "<a> <ab> <abc> <abcd>"
text3 = c("aaa", "bbb", "ccc", "abc")

# 활용 함수
# ▶ gsub(): 패턴 치환
# ▶ grep(): 매칭되는 패턴을 포함하는 데이터 또는 그 위치를 출력
# ▶ grepl(): 패턴 매칭 결과를 논리값(TRUE/FALSE)으로 반환
# ▶ gregexpr(): 주어진 데이터에서 패턴이 매칭되는 결과를 리스트 형식으로 출력
# ▶ regmatches(): 패턴 매칭

# 숫자 치환
gsub(pattern = "[0-9]", replacement = "@", x = text1)


# 영문 치환
# __ 소문자 치환
gsub(pattern = "[a-z]", replacement = "@", x = text1)
# __ 대문자 치환
gsub(pattern = "[A-Z]", replacement = "@", x = text1)
# 한글 치환
# __ 자음 치환
gsub(pattern = "[ㄱ-ㅎ]", replacement = "@", x = text1)
# __ 모음 치환
gsub(pattern = "[ㅏ-ㅣ]", replacement = "@", x = text1)
# __ 완성형 치환
gsub(pattern = "[가-힣]", replacement = "@", x = text1)
# 띄어쓰기 치환
gsub(pattern = "[ - ]", replacement = "@", x = text1)
gsub(pattern = " ", replacement = "@", x = text1)
gsub(pattern = "  ", replacement = "@", x = text1)
gsub(pattern = "   ", replacement = "@", x = text1)
# 응용
# __ 숫자가 아닌 모든 문자 치환
gsub(pattern = "[^0-9]", replacement = "", x = text1)

# __ 영문자가 아닌 모든 문자 치환
gsub(pattern = "[^a-zA-Z]", replacement = "", x = text1)

# __ 한글이 아닌 모든 문자 치환
gsub(pattern = "[^ㄱ-ㅎㅏ-ㅣ가-힣]", replacement = "", x = text1)
gsub(pattern = "[^ㄱ-힣]", replacement = "@", x = text1)

# __ 숫자와 영문 대문자가 아닌 모든 문자 치환
gsub(pattern = "[^0-9A-Z]", replacement = "", x = text1)

# __ 숫자 2, 3만 치환
gsub(pattern = "[2-3]", replacement = "@", x = text1)
gsub(pattern = "[23]", replacement = "@", x = text1)
gsub(pattern = "2|3", replacement = "@", x = text1)

gsub(pattern = "[159]", replacement = "@", x = "1234567890")

# __ 숫자 2, 3, 4, 7, 8, 9 치환
gsub(pattern = "[2-47-9]", replacement = "@", x = "1234567890")
gsub(pattern = "2|3|4|7|8|9", replacement = "@", x = text1)
gsub(pattern = "[234789]", replacement = "@", x = text1)

# __ '.'의 치환
gsub(pattern = "[.]", replacement = "@", x = text1)
gsub(pattern = "\\.", replacement = "@", x = text1)

# __ 두 칸 띄어쓰기와 세 칸 띄어쓰기의 치환
gsub(pattern = "  |   ", replacement = "@", x = text1)
gsub(pattern = " {2}| {3}", replacement = "@", x = text1)
gsub(pattern = " {2,3}", replacement = "@", x = text1)
  #위의 세개의 코드는 완전 같은 코드.
gsub(pattern = " {2,3}", replacement = " ", x = text1)
gsub(pattern = " {2,}", replacement = " ", x = text1) 
  #두칸이상 띄어쓰기를 한 칸 띄어쓰기로 다 바꾸어준다.
gsub(pattern = "[0-9]{2}", replacement = "@", x = text1)
  # 두 자리수 이상(10-99)의 숫자를 @로 바꾸세요 !
gsub(pattern = "[0-9]{2}", replacement = "@", x = 1:120)

# __ "asdf"와 "가나다라" 치환
gsub(pattern = "asdf|가나다라", replacement = "@", x = text1)
gsub(pattern = "asdf|[가-라]", replacement = "@", x = text1)

# __ 1, 3 치환
gsub(pattern = "[1,3]", replacement = "@", x = text1)

# __ 1~3, 7~9 치환
gsub(pattern = "[1-3, 7-9]", replacement = "@", x = 1234567890)

# 특수문자내 문자 처리
# __ 모든 경우의 수 치환
gsub(pattern = "", replacement = "@", x = text2)
# __ 내부 문자 1개 치환
gsub(pattern = "<.>", replacement = "@", x = text2)
# __ 내부 문자 2~4개 치환
gsub(pattern = "<.{2,4}>", replacement = "@", x = text2)

gsub(pattern = "\\(.*?\\)", replacement = "", 
     x = c("hana(bank)", "woori(bank)"))
  #text의 ()부분을 빼버림 


# 텍스트 조건
# __ "a"를 포함하는 원소 추출
grep(pattern = "a", x = text3)
text3[c(1, 4)]
text3[grep(pattern = "a", x = text3)]

# __ "b"를 포함하는 원소 추출
grep(pattern = "b", x = text3, value = TRUE)

# __ "b"로 시작하는 원소 추출
grep(pattern = "^b", x = text3, value = TRUE)

# __ "a"로 끝나는 원소 추출
grep(pattern = "a$", x = text3, value = TRUE)

#8자리 숫자로 시작하고, ".csv로 끝나는 것
#(단, 숫자와 ".csv" 사이의 글자 개수는 관계 없음)
#"20190405_hana_report.csv"
#"20190405_hana_edu.csv"
grep(pattern = "^[0-9]{8}.*?\\.csv$", x = text3, value = TRUE)

grep(pattern = "^HANA_2019_[0-9]{2}_report\\.csv", x = text3, value = TRUE)
#"HANA_2019_01_report.csv"
#"HANA_2019_02_report.csv"
#"HANA_2019_11_report.csv"

list.files(pattern = "csv$")

list.files(pattern = "^bike")


# __ "a"또는 "b"를 포함하는 원소 추출
# grep(pattern = "a|b", x = text3, value = TRUE)


list.files(pattern = "csv$")

# grepl() 함수의 활용
grepl(pattern = "a|b", x = text3)
# ! 앞에 붙이면 반전의 결과가 나옴.
!grepl(pattern = "a|b", x = text3)

text3[grepl(pattern = "a|b", x = text3)]
text3[!grepl(pattern = "a|b", x = text3)]

# 참고 사이트
# https://regexr.com/

#### ____ ● 실전 예제 ####
# ▶ regexpr_example.txt
#### _____ L Q1 ####
# 파일을 읽어들여 이미지 파일 주소를 추출하고 데이터프레임으로 정제하시오.

