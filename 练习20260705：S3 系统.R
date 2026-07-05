# S3指的是 R 自带的类系统，这个系统掌管着 R 如何处理具有不同类的对象
# 一些函数会首先查询对象的 S3 类，再根据其类属性作出相应的响应
# R 的 S3 系统具有三个组成部分：属性（attribute）(尤其是class属性)、泛型函数（generic function）和方法（method）

# 练习20260705：S3 系统

num1 <- 1000000000
num2 <- 1000000000

print(num1)
print(num2)

class(num2) <- c("POSIXct", "PSIXt")
print(num1)
print(num2)
