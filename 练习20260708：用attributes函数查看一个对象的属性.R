# 很多 R 对象都具有属性。
# 这些属性包含了关于这个对象的某些额外信息并且被赋予了属性名称，附加在该对象上。
# 属性不会影响对象的实际取值，但是作为该对象的某种类型的元数据，可以被 R 用于控制和管理这个对象。

# 练习20260708：用attributes函数查看一个对象的属性

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

attributes(deck)
