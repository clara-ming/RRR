#### 3. 텍스트 분석 ####
#### __ [01] 워드 클라우드 ####
library("wordcloud")
words = readRDS("wordcloud.rds")
head(words)
words = sort(rowSums(words), decreasing = TRUE)
df = data.frame(word = names(words),
                freq = words)
head(df, 10)

set.seed(1234)
wordcloud(words = df$word, freq = df$freq, min.freq = 2,
          max.words = 200, colors = brewer.pal(8, "Dark2"))

#### __ [02] 문서 분류 ####

# ▶ news_ecommerce_lda_k10.csv

#### _____ L Q1 ####
# Q1. 첫 번째 부터 열 번째 column의 기술통계량을 확인하시오.

#### _____ L Q2 ####
# Q2. year, month, press column
# Q2-1. (year) 자료는 몇 년도 부터 몇 년도 까지 기록되어있는가?

# Q2-2. (month) 자료는 몇 월 부터 몇 월 까지 기록되어있는가?

# Q2-3. (press) 몇 종류의 언론사명이 자료에 존재하는가?

#### _____ L Q3 ####
# Q3. 자료의 분할
# Q3-1. df객체의 첫 번째 부터 열 번째 column을 뽑아 df_topic 이라는 새로운 객체에 할당하시오.

# Q3-2. df객체의 열한번째 부터 마지막 column까지,
# 2015년 10월 부터 2016년 3월까지 추출하여 
#       df_sub 이라는 새로운 객체에 할당하시오.


#### _____ L Q4 ####
# Q4. 고급 필터링
# Q4-1. df_topic의 첫 번째 부터 열 번째 column까지 row별로 가장 높은 값을 추출하여
#       df_topic 객체에 "topic_no"라는 새로운 column을 만들어 붙이시오. 
#       ※ which() 함수 활용

# Q4-2. df_topic객체에서 topic_no가 3인 row를 추출하여 df_topic_3이라는 새로운 객체에 할당하시오.



#### 4. Social Network Analysis ####
#### __ [01] 개요 ####
#### ____ ● 목적 ####
#### ____ ● Social Metrics ####
# http://www.socialmetrics.co.kr/

#### __ [02] 실전 예제 ####
#### ____ ● 교우관계 네트워크 분석 ####
library("dplyr")
library("igraph")

df = read.csv("network_friends.csv", stringsAsFactors = FALSE)
df = df[df$relationship != 0, ]
df[, "relationship_2"] = 1
head(df)

# 색상 설정
color_df = data.frame(major = unique(df$major),
                      color = c("#225378", "#1695A3", "#ACF0F2", "#F3FFE2", "#EB7F00"),
                      stringsAsFactors = FALSE)
df = left_join(df, color_df, by = c("major" = "major"))
head(df)

df_graph_sub = df
graph = graph.data.frame(df_graph_sub[, c("from", "to" , "relationship_2")],
                         directed = TRUE)
V(graph)$label.color = "#000000"
V(graph)$color = df_graph_sub$color
V(graph)$size = sqrt(igraph::degree(graph)) * 2 + 2

par(mar = c(0, 0, 0, 0))
plot(graph, 
     vertex.label.dist = 1.5, 
     vertex.label.cex = 0.7,
     edge.arrow.size = 0.5,
     vertex.shape = ifelse(df_graph_sub$sex == 2, "square", "circle"))


df_degree = data.frame(names = names(igraph::degree(graph)),
                       degree = igraph::degree(graph),
                       stringsAsFactors = FALSE)
df_degree = df_degree[order(-df_degree$degree), ]
row.names(df_degree) = NULL
head(df_degree)

#### 15학번 이하 ####
df_graph_sub = df[df$num %in% 12:15, ]
graph = graph.data.frame(df_graph_sub[, c("from", "to" , "relationship_2")],
                         directed = TRUE)
V(graph)$label.color = "#000000"
V(graph)$color = df_graph_sub$color
V(graph)$size = sqrt(igraph::degree(graph)) * 3 + 2
# E(graph)$label = aggregate(formula = relationship ~ from, 
#                            data = df_graph_sub,
#                            FUN = "sum")[, 2]

par(mar = c(0, 0, 0, 0))
plot(graph, 
     vertex.label.dist = 1.5, 
     vertex.label.cex = 0.7,
     edge.arrow.size = 0.5,
     vertex.shape = ifelse(df_graph_sub$sex == 2, "square", "circle"))


df_degree = data.frame(names = names(igraph::degree(graph)),
                       degree = igraph::degree(graph),
                       stringsAsFactors = FALSE)
df_degree = df_degree[order(-df_degree$degree), ]
row.names(df_degree) = NULL
head(df_degree)



#### __ [03] 기초 예제 ####
#### ____ ● 기본 네트워크 ####
#### ______ 1) 패키지 준비 ####
library("igraph")

#### ______ 2) 무향 네트워크 생성 ####
# 방법 1

# 방법 2

#### ______ 3) 유향 네트워크 생성 ####
# 방법 1

# 방법 2


#### ____ ●  임의의 네트워크 생성 ####
#### ______ 1) 패키지 준비 ####
library("ggnetwork")
library("network")
library("sna")

#### ______ 2) 데이터 준비 ####
n_size = 8

# 방법 1
set.seed(1)
mat_net = rgraph(n_size, tprob = 0.2)

# 방법 2
set.seed(1)
df = data.frame(from  = sample(1:15, size = 88, replace = TRUE),
                to    = sample(1:15, size = 88, replace = TRUE),
                value = 1)

#### ______ 3) 네트워크 생성 ####
n = network(mat_net, directed = FALSE)

# network 패키지의 함수!!
# set.vertex.attribute()

#### ______ 4) 네트워크 속성 확인 ####
# 네트워크 크기

# 네트워크 attribute 확인

# 네트워크의 특정 attribute에 할당된 값 추출

# 특정 node에 연결된 node 정보를 추출하시오.



#### ______ 5) 네트워크 그리기 ####
gg_net = ggnetwork(n)
ggplot(data = gg_net,
       aes(x = x, 
           y = y, 
           xend = xend, 
           yend = yend)) +
  geom_edges(aes(linetype = type), size = 1) +
  theme_blank()

#### ____ ● 다양한 네트워크 ####
#### ______ 1) 비어있는 그래프 ####
ng = make_empty_graph(40)
plot(ng)

#### ______ 2) 완전 연결 그래프 ####
ng = make_full_graph(40)
plot(ng)

#### ______ 3) 트리 그래프 ####
ng = make_tree(40)
plot(ng)

#### ______ 4) 고리 그래프 ####
ng = make_ring(40)
plot(ng)

#### ______ 5) Erdos-Renyi 그래프 ####
ng = sample_gnm(n = 100, m = 50)
plot(ng)

#### 5. 크롤링 맛보기 ####
#### __ [01] 개요 ####
#### ____ ● 크롤링(Crawling)? ####
#### ____ ● 크롤러(Crawler)의 활용 ####
# DDoS 오인
# robots.txt
# https://www.naver.com/robots.txt
# https://www.daum.net/robots.txt
# https://www.google.com/robots.txt
# https://www.clien.net/robots.txt

#### ____ ● 각종 도구 ####
#### ____ ● 필요 기술 ####
# 웹페이지 구조
# HTML
# 자료구조
# 통신
# HTML / CSS / JavaScript
#### __ [02] URL ####
#### ____ ● URL 이해하기 ####

#### __ [03] 실시간 검색어 크롤링 ####
paste0()
#text = readLines("https://www.naver.com", encoding = "UTF-8")
head(text, 20)
text[22]
#grep()
#gsub()
text2 = grep(pattern = "ah_k", x = text, value = TRUE)
text3 = gsub(pattern = "<.*?>", replacement = "", x = text2)
head(text3)
text3[1:20]

gsub("<.*?>", "", grep(pattern = "ah_k", readLines("https://www.naver.com"), x = text, value = TRUE))

#### ____ ● 실시간 검색어 크롤링 ####
text4 = readLines("https://www.daum.net", encoding = "UTF-8")

text5 = gsub("<.*?>", "", grep(pattern = "link_issue", readLines("https://www.daum.net"), x = text4, value = TRUE))
text5[1:20]
text5[5:length(text5)][1:20][(1:10)*2]
text5[4+((1:10)*2)]

#### ____ ● 네이버 실시간 검색어 ####

#### ____ ● Zum ####
text8 = readLines("http://zum.com/", encoding = "UTF-8")
text9 = gsub("<.*?>", "", grep(pattern = "keyword d_keyword", readLines("http://zum.com/"), x = text8, value = TRUE))
head(text9)
text9

#### ____ ● Daum ####

#### __ [04] SNS 크롤링 ####
#### ____ ● SNS 크롤링 목적 ####
#### ____ ● 주의 사항 ####