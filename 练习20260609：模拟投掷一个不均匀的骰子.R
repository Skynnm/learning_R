# 编程语言也是一门语言，有名词、动词，语法的目的是为了表意，但前提是有足够的词汇量

# 练习20260609：模拟投掷一个不均匀的骰子

roll4 <- function(){
  die <- 1:6
  dice <- sample(die, size = 2, replace = TRUE,
                 prob = c(1/8, 1/8, 1/8, 1/8, 1/8, 3/8))
  sum(dice)
}

roll4()
