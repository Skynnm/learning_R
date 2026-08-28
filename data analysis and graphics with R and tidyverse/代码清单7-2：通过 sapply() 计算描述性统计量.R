# apply() 函数用于矩阵/数组，而lapply()应用于列表（含数据框）输出list， sapply() 是 lapply() 的简化版本

# 代码清单7-2：通过 sapply() 计算描述性统计量
?sapply  
# 与apply()函数不同，sapply()函数默认按列遍历（遍历每一列），它没有直接的MARGIN（行/列参数），不能直接横向按行跑

# 我们可以使用第 5 章中的 apply() 函数或 sapply() 函数计算所选择的任意描述性统计量
# apply() 函数用于矩阵，而 sapply() 函数用于数据框
# 对于 sapply() 函数，其使用格式为：
sapply(x, FUN, options)
# 其中，x是数据框，FUN为一个任意的函数。如果指定了 options，这些选项的值将被传递给FUN
# 在这里插入的典型函数有：mean()、sd()、var()、min()、max()、median()、length()、range() 和 quantile()
# 函数 fivenum() 可返回【图基五数总括（Tukey's five-number summary, 即最小值、下四分位数、中位数、上四分位数、最大值）
# 不过，基础安装的居然没有提供偏度和峰度的计算函数，不过我们可以自行添加：
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

myvars <- c("mpg", "hp", "wt")
sapply(mtcars[myvars], mystats) # 【依次将函数应用于数据框的每一列】，所以也一列一列输出
#           mpg     hp     wt
#n        32.00  32.00 32.000
#mean     20.09 146.69  3.217
#stdev     6.03  68.56  0.978
#skew      0.61   0.73  0.423
#kurtosis -0.37  -0.14 -0.023

# 如上所示，【即返回一列列的单列数据框】


# 对于样本中的车型，每加仑汽油行驶英里数的平均值为20.1，标准差为6.0。
# 分布呈现右偏（偏度+0.61），并且较正太分布稍平（峰度-0.37）
# 如果你针对数据绘制图形，这些特征会显而易见。
# 请注意，如果我们希望忽略缺失值，那么应当使用 sapply(mtcars[myvars], mystats, na.omit = TRUE)
