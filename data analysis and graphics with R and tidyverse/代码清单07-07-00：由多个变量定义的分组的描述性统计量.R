# DIKW

# 代码清单7-7-0：由多个变量定义的分组的描述性统计量
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

dstats <- function(x) sapply(x, mystats, na.omit = TRUE)
myvars <- c("mpg", "hp", "wt")
by(mtcars[myvars],
   list(Transmiss = mtcars$am,
        English = mtcars$vs),
   FUN = dstats)
#Transmiss: 0
#English: 0
#mpg          hp         wt
#n        12.0000000  12.0000000 12.0000000
#mean     15.0500000 194.1666667  4.1040833
#stdev     2.7743959  33.3598379  0.7683069
#skew     -0.2843325   0.2785849  0.8542070
#kurtosis -0.9635443  -1.4385375 -1.1433587
#----------------------------------------------------------------------- 
#  Transmiss: 1
#English: 0
#mpg          hp          wt
#n         6.0000000   6.0000000  6.00000000
#mean     19.7500000 180.8333333  2.85750000
#stdev     4.0088652  98.8158219  0.48672117
#skew      0.2050011   0.4842372  0.01270294
#kurtosis -1.5266040  -1.7270981 -1.40961807
#----------------------------------------------------------------------- 
#  Transmiss: 0
#English: 1
#mpg          hp         wt
#n         7.0000000   7.0000000  7.0000000
#mean     20.7428571 102.1428571  3.1942857
#stdev     2.4710707  20.9318622  0.3477598
#skew      0.1014749  -0.7248459 -1.1532766
#kurtosis -1.7480372  -0.7805708 -0.1170979
#----------------------------------------------------------------------- 
#  Transmiss: 1
#English: 1
#mpg         hp         wt
#n         7.0000000  7.0000000  7.0000000
#mean     28.3714286 80.5714286  2.0282857
#stdev     4.7577005 24.1444068  0.4400840
#skew     -0.3474537  0.2609545  0.4009511
#kurtosis -1.7290639 -1.9077611 -1.3677833



# 虽然前面的示例使用的是 mystats() 函数，但我们也可以使用 Hmisc 和 psych 包中的 describe() 函数或者 pastecs 包中的 stat.desc() 函数。
# 事实上，by() 函数提供了通用的处理机制，可以针对分组逐一进行任意的分析操作。
