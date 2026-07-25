# 项目1：非均匀骰子
# 边做边学恰恰是学习R的最佳途径
# R是交互式的，最好的方法就是自己尝试
# 详略得当，获取自己需要的信息即可

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
install.packages("ggplot2")
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



# （1）绘制散点图（scatter plot）
x <- c(-1, -0.8, -0.6, -0.4, -0.2, 0, 0.2, 0.4, 0.6, 0.8, 1)
y <- x ^ 3 
qplot(x, y)   # 元素方式执行


# （2）绘制直方图（hitogram）[只要仅给qplot一个向量]
x2 <- c(1, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 4)
qplot(x2, binwidth = 1)


# 对象【元素方式执行】
# 函数
# 参数
# 脚本
# install.package
# library