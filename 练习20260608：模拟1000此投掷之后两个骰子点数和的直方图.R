# R 语言有两个最重要的组成部分：一个是对象，用来存储数据；另一个是函数，用来操作数据

# 练习20260608：模拟1000此投掷之后两个骰子点数和的直方图

roll <- function(){
  die <- 1:6
  dice <- sample(die, size = 2, replace = TRUE)
  sum(dice)
}

??qplot
install.packages("ggplot2")
library("ggplot2")

rolls <- replicate(10000, roll())
qplot(rolls, biwidth = 1)
