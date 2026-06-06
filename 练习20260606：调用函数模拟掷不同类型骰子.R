# 逻辑测试、取子集、元素方式执行
# 向量化编程、作用域、S3方法

# 练习20260606：调用函数模拟掷不同类型骰子

roll2 <- function(bones) {
  dice <- sample(bones, size = 2, replace = TRUE)
  sum(dice)
}

roll2(2)
roll2(1:12)
