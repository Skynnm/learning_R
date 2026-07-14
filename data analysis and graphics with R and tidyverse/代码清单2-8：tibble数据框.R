# tibble = 普通数据框 + 更友好的使用体验
# ①普通数据框会一次性打印所有内容，tibble数据框会智能预览，同时标注数据类型
# ②tibble永远不会自动转换数据类型
# ③tibble完全摒弃行名，并有更安全的提取子集检查

# 代码清单2-8：tibble数据框
# tibble数据框有一些特殊的操作方式，从而更有实用价值。
# 可以使用 tibble 包里的函数 tibble() 或 as_tibble() 来创建 tibble 数据框。
# 可以使用 install.packages("tibble") 来安装 tibble 包。

# 与标准数据框相比，tibble 数据框的打印格式更加紧凑。另外，变量标签描述了每一列的数据类型
library(tibble)
mtcars <- as_tibble(mtcars)
mtcars
# A tibble: 32 × 11
#mpg   cyl  disp    hp  drat    wt  qsec    vs    am  gear  carb
#<dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
#  1  21       6  160    110  3.9   2.62  16.5     0     1     4     4
#2  21       6  160    110  3.9   2.88  17.0     0     1     4     4
#3  22.8     4  108     93  3.85  2.32  18.6     1     1     4     1
#4  21.4     6  258    110  3.08  3.22  19.4     1     0     3     1
#5  18.7     8  360    175  3.15  3.44  17.0     0     0     3     2
#6  18.1     6  225    105  2.76  3.46  20.2     1     0     3     1
#7  14.3     8  360    245  3.21  3.57  15.8     0     0     3     4
#8  24.4     4  147.    62  3.69  3.19  20       1     0     4     2
#9  22.8     4  141.    95  3.92  3.15  22.9     1     0     4     2
#10  19.2     6  168.   123  3.92  3.44  18.3     1     0     4     4
# ℹ 22 more rows
# ℹ Use `print(n = ...)` to see more rows

# 【tibble数据框不会将字符串变量转换为因子】。在R的旧版本（R4.0.0版本以前）中，函数read、table()、data.frame() 和 as.data.frame()默认将字符型数据转换为因子。我们需要在这些函数中添加字符串 AsFactors = FALSE 来取消这个默认操作。
# 【tibble数据框不会改变变量的名称】。假设导入的数据集中有一个变量名称为 Last Address，由于 R 的变量名称不能使用空格，因此基本的R函数会将此名称改为 Last.Address。tibble数据框会保留此名称不变，并用反引号（例如'Last Address'）使变量名称在语法上是正确的。
# 【tibble数据框取子集总是返回一个tibble数据框】。例如，使用mtcars[,"mpg"]对数据框mtcars取子集，将返回一个向量，而不是单列的数据框。R会自动简化结果。如果要获取单列的数据框，则需要添加 drop = FALSE参数（mtcars[, "mpg", drop = FALSE]）。但是如果mtcars是一个tibble数据框，那面mtcarsp[, "mpg"]将返回一个单列的tibble数据框。因为这个结果未被简化，所以我们可以轻松地预测子集的操作结果。
# 【tibble数据框不支持行名】。在tibble数据框中可以使用函数 rownames_to_column() 将数据框中的行名转换为变量。

# tibble数据框的重要之处在于，现在许多流行的R包，比如readr、tidyr、dplyr 和 purr 都将数据框保存为 tibble 数据框。
# 虽然 tibble 数据框是“数据框的全新模式”，但是它可以和普通数据框相互替换使用。
# 任何需要普通数据框的功能都可以使用 tibble 数据框，反之亦然。