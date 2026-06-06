# 脚本就是一个用来保存代码的纯文本文件

# 练习20260607：给函数参数设定默认初始值
roll3 <- function(bones = 1:6) {
  dice <- sample(bones, size = 2, replace = TRUE)
  sum(dice)
}

roll3()
roll3()
