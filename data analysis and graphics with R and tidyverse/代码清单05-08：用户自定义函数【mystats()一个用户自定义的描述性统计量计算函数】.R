# 放轻松，有时候太勤奋也是一种错
# 在正常情况下，R中的语句是从上至下顺序执行的。但是，有时我们可能希望重复重复执行某些语句，仅在满足特定条件下执行另外的语句。

# 代码清单5-8：用户自定义函数【mystats():一个用户自定义的描述性统计量计算函数】
# R的优点之一就是用户可以自行添加函数。事实上，R中的许多函数都是由已有的函数构成的。
# 一个函数的结构看起来大致如此：
myfunction <- function(arg1, arg2, ...) {
  statements
  return(object)
}
# 函数中的对象只在函数内部使用。
# 返回对象的数据类型是任意的，从标量到列表皆可。让我们来看一个示例：

# 假设我们想自定义一个函数，用来计算数据对象的集中趋势和散布情况。
# 此函数应当可以选择性地给出参数统计量（均值和标准差）和非参数统计量（中位数和绝对中位差）
# 【结果应当以一个含名称列表的形式给出】
# 另外，用户应当可以选择是否自动输出结果。除非另外指定，否则此函数的默认行为应当是计算参数统计量并且不输出结果。下面的代码给出了一种解答：
mystats <- function(x, parametric = TRUE, print = FALSE) {
  if (parametric) {
    center <- mean(x); spread <- sd(x)
  } else {
    center <- median(x); spread <- mad(x)
  }
  if (print & parametric) {
    cat("Mean=", centr, "\n", "SD=", spread, "\n")
  } else if (print & !parametric){
    cat("Median=", center, "\n", "MAD=", spread, "\n")
  }
  result <- list(center = center, spread = spread)
  return(result)
}
# 要查看此函数的实际用法，首先需要生成一些数据（服从正太分布的，大小为500的随机样本）：
set.seed(1234)
x <- rnorm(500)
# 再执行语句：
y <- mystats(x)
# 之后，y$center将包含均值（0.00184），y$spread将包含标准差（1.03），并且没有输出结果。
y$center
# [1] 0.0018
y$spread
# [1] 1
# 如果执行语句：
y <- mystats(x, parametric = FALSE, print = TRUE)
# y$center将包含中位数（-0.0207），y$spread将包含绝对中位差（1.001）。另外，还会输出以下结果：
#Median= -0.021 
#MAD= 1

# 下面我们看一个使用了switch结构的用户自定义函数，此函数可以让用户选择输出当天日期的格式。
# 再函数声明中为参数指定的值将作为其默认值。再函数mydate()中，如果未指定type，则long将为默认的日期格式：
mydate <- function(type="long"){
  switch(type,
         long = format(Sys.time(), "%A %B %d %Y"),
         short = format(Sys.time(), "%m-%d-%y"),
         cat(type, "is not a recognized type\n"))
}
# 实际使用中的函数如下：
mydate("long")
# [1] "星期五 八月 21 2026"
mydate("short")
# [1] "08-21-26"
mydate()
# [1] "星期五 八月 21 2026"
mydate("medium")
# medium is not a recognized type

# 请注意，函数 cat() 仅会再输入的日期格式类型不匹配"long"或"short"时执行，
# 使用一个表达式来捕获用户的错误输入的参数值通常来说是一个好主意。

# 有若干函数可以用来为函数添加错误捕获和纠正功能。
# 我们可以使用函数 warning() 来生成一条错误提示信息；
# 用message()来生成一条诊断信息；
# 或用stop()停止当前表达式的执行并提示错误。20.6 节将更加详细地讨论错误捕获和调试。

# 在创建好自己的函数以后，我们可能希望在每个会话中都能直接使用它们。附录B描述了如何定制R环境，以使R启动时自动加载自定义函数。我们将在后续章节中看到更多的用户自定义函数示例。

# 我们可以使用本节中提供的基本技术完成很多工作。第20章更加详细地讲解了控制流和其他编程主题。第22章涵盖了如何创建包。如果你想探索自定义函数的微妙之处，或自定义可以分发给他人使用的专业级代码，我推荐阅读这两章。
