# 缺失值被认为是不可比较的
# R并不把无限（±Inf）或者不可能出现的值（Null/NaN）标记成缺失值
# R只能使用相应的函数识别和处理缺失值
# Null：不存在的值（R会自动跳过空值Null，而不影响计算）
# 缺失值：NA：Not Available 存在但未知的数


# 代码清单3-3：is.na() 函数
# 在R中，缺失值以符号NA（Not Available，不可用）表示。
# R中字符型和数值型数据使用的缺失值符号是相同的。

#【函数 is.na() 允许我们检测缺失值是否存在】
Y <- c(1, 2, 3, NA)
is.na(Y)
# [1] FALSE FALSE FALSE  TRUE

# 请注意 is.na() 函数是如何作用于一个对象上的。它将返回一个相同大小的对象，如果某个元素是缺失值，相应的位置将被写为TRUE，不是缺失值的位置则为FALSE
leadership <- data.frame(
  manager = c(1, 2, 3, 4, 5),
  data    = c("10/24/08", "10/28/08", "10/1/08", "10/12/08", "5/1/09"),
  country = c("US", "US", "UK", "UK", "UK"),
  gender  = c("M", "F", "F", "M", "F"),
  age     = c(32, 45, 25, 39, 99),
  q1      = c(5, 3, 3, 3, 2),
  q2      = c(4, 5, 5, 3, 2),
  q3      = c(5, 2, 5, 4, 1),
  q4      = c(5, 5, 5, NA, 2),
  q5      = c(5, 5, 2, NA, 1)
)
is.na(leadership[,6:10])
#      q1    q2    q3    q4    q5
#[1,] FALSE FALSE FALSE FALSE FALSE
#[2,] FALSE FALSE FALSE FALSE FALSE
#[3,] FALSE FALSE FALSE FALSE FALSE
#[4,] FALSE FALSE FALSE  TRUE  TRUE
#[5,] FALSE FALSE FALSE FALSE FALSE


# 当我们在处理缺失值的时候，我们要一直记得两件重要的事情：
# 【第一】缺失值被认为是不可比较的，即便是与缺失值自身的比较。这意味着无法使用比较运算符来检测缺失值是否存在。例如，逻辑测试 myvar == NA 的结果永远不会为 TRUE。作为替代，我们只能使用处理缺失值的函数（比如is.na）来识别出R数据对象中的缺失值
# 【第二】R并不把无限（±Inf）或者不可能出现的值（Null/NaN）标记成缺失值。正无穷和负无穷分别用Inf和-Inf所标记。因此5/0返回Inf。不可能的值（比如sin(Inf)）用NaN符号来标记（not a number，不是一个数）。若要识别这些数值，我们需要用到is.infinite()或is.nan()
