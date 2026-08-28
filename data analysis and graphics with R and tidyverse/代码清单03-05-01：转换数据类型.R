# 程序员看代码的时间多于写代码的时间

# 代码清单3-5-1：转换数据类型
# R中提供了一系列用来判断某个对象的数据类型和将其转换为另一种数据类型的函数

# R与其他统计编程语言有着类似的数据类型转换方式。
# 举例来说，向一个数值型向量中添加一个字符串会将此向量中的所有元素转换为字符型

#          判断                        转换
#     is.numeric()                 as.numeric()
#     is.charactier()              as.character()
#     is.vector()                  as.vector()
#     is.matrix()                  as.matrix()
#     is.data.frame()              as.data.frame()
#     is.factor()                  as.factor()
#     is.logical()                 as.logical()

# 名为 is.datatyped() 这样的函数返回 TRUE 或 FALSE，而 as.datatyped() 这样的函数则将其参数转换为对应的类型

a <- c(1, 2, 3)
a
# [1] 1 2 3
is.numeric(a)
# [1] TRUE
is.vector(a)
# [1] TRUE
a <- as.character(a)
a
# [1] "1" "2" "3"
is.numeric(a)
# [1] FALSE
is.vector(a)
# [1] TRUE
is.character(a)
# [1] TRUE

# 当和第5章讨论的控制流（如 if-then）结合使用时，is.datatype()这样的函数将成为一类强大的工具，即允许根据数据的具体类型以不同的方式处理数据。
# 另外，某些 R 函数需要接受某个特定类型（字符型或数值型，矩阵或数据框）的数据，as.datatype()这类函数可以让我们在分析之前先将数据转换为要求的格式。
