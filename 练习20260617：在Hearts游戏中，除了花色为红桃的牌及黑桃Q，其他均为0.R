# 面向目的编程，你的最终目的是解决问题，而不是研究“茴”字有多少种写法
# R 会分别执行布尔运算符两侧的逻辑测试，然后将两个逻辑测试的结果整合成一个单独的逻辑值 TRUE 或者 FALSEE

# 练习20260617：在Hearts游戏中，除了花色为红桃的牌及黑桃Q，其他均为0
# ①所有红桃牌点数为1
# ②黑桃Q：13

deck <- data.frame(
  face = c("king", "queen", "jack", "ten", "nine", "eight", "seven", "six",
           "five", "four", "three", "two", "ace", "king", "queen", "jack", 
           "ten", "nine", "eight", "seven", "six", "five", "four", "three", 
           "two", "ace", "king", "queen", "jack", "ten", "nine", "eight",
           "seven", "six", "five", "four", "three", "two", "ace", "king",
           "queen", "jack", "ten", "nine", "eight", "seven", "six", "five",
           "four", "three", "two", "ace"),
  suit = c("spades", "spades", "spades", "spades", "spades", "spades","spades",
           "spades", "spades", "spades", "spades", "spades", "spades", "clubs", 
           "clubs", "clubs", "clubs", "clubs", "clubs", "clubs", "clubs", "clubs",
           "clubs", "clubs", "clubs", "clubs", "diamonds", "diamonds", "diamonds",
           "diamonds", "diamonds", "diamonds", "diamonds", "diamonds", "diamonds",
           "diamonds", "diamonds", "diamonds", "diamonds", "hearts", "hearts", 
           "hearts", "hearts", "hearts", "hearts", "hearts", "hearts", "hearts",
           "hearts", "hearts", "hearts", "hearts"),
  value = c(13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 13, 12, 11, 10, 9, 8, 7, 6,
            5, 4, 3, 2, 1, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 13, 12, 11,
            10, 9, 8, 7, 6, 5, 4, 3, 2, 1)
)

deck4 <- deck4
deck4$value <- 0
deck4$value[deck4$suit == "hearts"] <- 1
queen_of_spades <- deck4$face == "queen" & deck4$suit == "spades"
deck4$value[queen_of_spades] <- 13