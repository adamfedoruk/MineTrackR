library(googlesheets)
library(ggplot2)
library(reshape)
library(dplyr)


gs_ls()
GRLC<- gs_title("CoinStats")
coin<- gs_read(ss=GRLC)
coinDF<-as.data.frame(coin)
coinDF$Date<-as.Date.character(coinDF$Date, format = "%m/%d/%Y")
##### fix dates later
coinDF_2 <- transform(coinDF, Timestamp = colsplit(Timestamp, split = " ", names=c("Day", "Month","Year", "Time")))

coin_sum <- coinDF %>%
  group_by(Date) %>%
  summarise(TotalPayout = sum(Amount))
ggplot(coin_sum, aes(x=Date, y=TotalPayout)) +
  geom_bar(stat="identity")

