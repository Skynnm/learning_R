# 在R中使用一个或多个预先定义好的函数来折叠（collapse）数据

# 代码清单5-13：改进后的使用 aggragate()汇总数据的代码（折叠collapse数据）
# 上面的代码有两个问题。第一，Group.1 和 Group.2 是非常不明确的变量名；其次，在汇总后的数据框中包含了初始的Cy1和gear变量，而现在这两个列是多余的。

# 我们可以在列表中为各组声明自定义的名称，例如 by = list(Cylinders = cy1, Gears = gear) 可将 Group.1 和 Group.2替换为Cylinders 和 Gears。可以使用括号从输入数据框中删除多余的列（mtcars[-c(2, 10)]）
# 代码清单5-13显示了改进后的代码版本
aggdata <- aggregate(mtcars[-c(2, 10)],    # R的环境系统
                     by = list(Cylinders = mtcars$cyl, Gears = mtcars$gear),
                     FUN = mean, na.rm = TRUE)
aggdata
#  Cylinders Gears mpg disp  hp drat  wt qsec  vs   am carb
#1         4     3  22  120  97  3.7 2.5   20 1.0 0.00  1.0
#2         6     3  20  242 108  2.9 3.3   20 1.0 0.00  1.0
#3         8     3  15  358 194  3.1 4.1   17 0.0 0.00  3.1
#4         4     4  27  103  76  4.1 2.4   20 1.0 0.75  1.5
#5         6     4  20  164 116  3.9 3.1   18 0.5 0.50  4.0
#6         4     5  28  108 102  4.1 1.8   17 0.5 1.00  2.0
#7         6     5  20  145 175  3.6 2.8   16 0.0 1.00  6.0
#8         8     5  15  326 300  3.9 3.4   15 0.0 1.00  6.0
