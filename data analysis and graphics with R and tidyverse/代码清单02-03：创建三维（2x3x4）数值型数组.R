# 数组（array）与矩阵类似，但是维度可以大于2，数组可通过函数array创建,形式如下：
# myarray <- array(vector, dimensions, dimnames)
# 其中vector包含了数组中的数据，dimensions是一个数值型向量，给出了各个维度下标的最大值，而dimnames是可选的、各维度名称标签的列表

# 代码清单2-3：创建三维（2x3x4）数值型数组
dim1 <- c("A1", "A2")
dim2 <- c("B1", "B2", "B3")
dim3 <- c("C1", "C2", "C3", "C4")
z <- array(1:24, c(2, 3, 4), dimnames = list(dim1, dim2, dim3))
z

# 数组是矩阵的一个自然推广。数组在创建用于进行统计计算的函数时可能很有用
# 像矩阵一样，数组中的数据也只能拥有一种模式
# 从数组中选取元素的方式与矩阵相同。
z[1, 2, 3]
# [1] 15
