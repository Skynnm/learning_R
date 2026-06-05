# 边做边学恰恰是学习R的最佳途径，R是交互式的，最好的方法就是自己尝试

# 练习20260605：将掷骰子的模拟构建成为一个函数

roll <- function() {
  die <- 1:6
  dice <- sample(die, size = 2, replace = TRUE)
  sum(dice)
}

roll()
roll()
roll()
