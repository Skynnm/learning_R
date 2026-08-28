# regular expression 正则表达式
# Quotes  转义字符

# 代码清单5-4-1：其他实用函数（转义字符）
# 下表中的函数对于数据管理和处理同样非常实用，只是它们无法清晰地划入某一分类中

#  函数                       描述
#  length(x)                  对象 x 的长度
                              x <- c(2, 5, 6, 9) 
                              length(x) # 的返回值为4
#
#  seq(from, to, by)          生成一个序列
                              indices <- seq(1, 10, 2)
#                             indices的值为c(1, 3, 5, 7, 9)
#
#  rep(x, n)                  将 x 重复 n 次
                              y <- rep(1:3, 2)
#                             y 的值为c(1, 2, 3, 1, 2, 3)
#
#  cut(x, n)                  将连续型变量 x 分割为有着 n 个水平的因子
#                             使用选项ordered_result = TRUE 以创建一个有序型因子
#
#  cat(..., file = "myfile",  连接...中的对象，并将其输出到屏幕上或文件中
#      append = FALSE)        （如果声明了一个的话）
                              name <- c("Jane")
                              cat("Hello", name, "\n")

                              
                              
#  表中的最后一个示例演示了在输出时转义字符的使用方法。
#  \n表示新行，\t表示制表符，\'为单引号，\b为退格，等等。（输入?Quotes以了解更多。）
#  例如，代码：
name <- "Bob"
cat("Hello", name, "\b.\n", "Isn't R", "\t", "GREAT?\n")
#  可生成
#  Hello Bob.
#   Isn't R 	 GREAT?

name <- "Bob"
cat("Hello", name, ".\n", "Isn't R", "\t", "GREAT?\n")

#  请注意第 2 行缩进了一个空格。当 cat 输出要连接的对象时，它会将每一个对象都用空格分开。
#  这就是在句点之前使用退格转义符（\b）的原因。不然，生成的结果将是“Hello Bob .”

#  在数值、字符串和向量上使用我们最近学习的函数是直观而明确的，但是如何将它们应用到矩阵和数据框上呢？这就是下一节的主题——将函数应用于矩阵或数据框
