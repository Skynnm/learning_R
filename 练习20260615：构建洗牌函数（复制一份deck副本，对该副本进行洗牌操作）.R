# 逻辑值取子集（logical subsetting）提供了一种精确提取和替换 R 对象中值的方法，
# 有点类似于再你的数据集中进行一番地毯式搜索

# 练习20260615：构建洗牌函数（复制一份deck副本，对该副本进行洗牌操作）
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

cards <- deck

deal <- function(cards){
  cards[1, ]
}

shuffle <- function(cards){
  random <- sample(1:52, size = 52)
  cards[random, ]
}

shuffle(cards)
deal(cards)
