# R 的环境树系统

# 代码清单7-6：使用by()分组计算描述性统计量
# 在比较多组个体或观测值时，关注的焦点经常是各组的描述性统计量，而不是样本整体的描述性统计量。
# 我们可以使用基础 R 函数 by() 计算分组统计量，格式如下：
by(data, INDICES, FUN)
# 其中的data是一个数据框或矩阵，INDICES是一个因子或因子组成的列表，定义了分组，FUN可以是任意一个函数，用来操作数据框中的所有列。


dstats <- function(x) sapply(x, mystats)
myvars <- c("mpg", "hp", "wt")

mystats <- function(x, na.omit = FALSE) {
  if(na.omit)
    x <- x[!is.na(x)]
  m <- mean(x)
  n <- length(x)
  s <- sd(x)
  skew <- sum((x-m)^3/s^3)/n
  kurt <- sum((x-m)^4/s^4)/n - 3
  return(c(n = n, mean = m, stdev = s,
           skew = skew, kurtosis = kurt))
}

by(mtcars[myvars], mtcars$am, mystats)
by(mtcars[myvars], mtcars$am, dstats)
#mtcars$am: 0
#mpg           hp         wt
#n        19.00000000  19.00000000 19.0000000
#mean     17.14736842 160.26315789  3.7688947
#stdev     3.83396639  53.90819573  0.7774001
#skew      0.01395038  -0.01422519  0.9759294
#kurtosis -0.80317826  -1.20969733  0.1415676
#----------------------------------------------------------------------- 
#  mtcars$am: 1
#mpg          hp         wt
#n        13.00000000  13.0000000 13.0000000
#mean     24.39230769 126.8461538  2.4110000
#stdev     6.16650381  84.0623243  0.6169816
#skew      0.05256118   1.3598859  0.2103128
#kurtosis -1.45535200   0.5634635 -1.1737358

# 这里，dstats()调用了代码清单7-2中的 mystats() 函数，将其应用于数据框的每一列中。
# 将它传递给 by() 函数就可以得到 am 中每一水平的汇总统计量
