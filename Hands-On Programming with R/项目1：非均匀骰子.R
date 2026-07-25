# 项目1：非均匀骰子
# 边做边学恰恰是学习R的最佳途径
# R是交互式的，最好的方法就是自己尝试


# 一、将掷骰子的模拟构建为一个函数
roll <- function() {
  die <- 1:6
  dice <- sample(die, size = 2, replace = TRUE)
  sum(dice)
}


# 二、调用函数模拟掷不同类型骰子
roll2 <- function(bones) {
  dice <- sample(bones, size = 2, replace = TRUE)
  sum(dice)
}


# 三、给函数参数设定默认初始值
roll3 <- function(bones = 1:6) {
  dice <- sample(bones, size = 2, replace = TRUE)
  sum(dice)
}
# 1.函数名、2.函数主体、3.参数、4.参数的默认值、5.最后一行代码


# 四、模拟10000次投掷之后两个骰子点数和的直方图
library("ggplot2")
rolls <- replicate(10000, roll())
qplot(rolls, binwidth = 1)


# 五、模拟投掷一个不均匀的骰子
roll4 <- function() {
  die <- 1:6
  dice <- sample(die, size = 2, replace = TRUE,
                 prob = c(1/8, 1/8, 1/8, 1/8, 1/8, 3/8))
  sum(dice)
}


# 对象【元素方式执行】
# 函数
# 参数
# 脚本
# install.package
# library