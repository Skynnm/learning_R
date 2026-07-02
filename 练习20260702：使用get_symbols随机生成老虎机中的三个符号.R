# 使用 if 和 else语句告诉R在什么时候做什么事

# 练习20260702：使用get_symbols随机生成老虎机中的三个符号

get_symbols <- function(){
  wheel <- c("DD", "7", "BBB", "BB", "B", "C", "0")
  sample(wheel, size = 3, replace = TRUE,
         prob = c(0.03, 0.03, 0.06, 0.1, 0.25, 0.01, 0.52))
}

get_symbols()

# > get_symbols()
# [1] "0"   "0"   "BBB"