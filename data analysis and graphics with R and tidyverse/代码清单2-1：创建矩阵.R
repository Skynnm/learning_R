# 矩阵（matrix）是一个二维数组，只是每个元素都拥有相同的模式
# 可通过函数matrix()创建矩阵，一般使用格式如下：
# mymatrix <- matrix(vector, nrow = number_of_rows, ncol = number_of_colnums,
#                    byrow = logical_value, dimnames = list(
#                    char_vector_rownames, char_vector_colnames))

# 代码清单2-1：创建矩阵
y <- matrix(1:20, nrow = 5, ncol = 4) # 创建一个5x4的矩阵
y
cells <- c(1, 26, 24, 68)
rnames <- c("R1", "R2")
cnames <- c("C1", "C2")
mymatrix <- matrix(cells, nrow = 2, ncol = 2, byrow = TRUE,
                   dimnames = list(rnames, cnames))  # 创建一个2x2的含列名标签的矩阵，并按行进行填充
mymatrix

mymatrix <- matrix(cells, nrow = 2, ncol = 2, byrow = FALSE,
                   dimnames = list(rnames, cnames))  # 创建一个2x2的矩阵并按列进行了填充
mymatrix
