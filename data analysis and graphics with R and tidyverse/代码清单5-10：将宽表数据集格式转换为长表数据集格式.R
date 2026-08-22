# regular expression 正则表达式为文本模式的匹配提供了一套清晰且简练的语法
# Quotes 转义字符

# 代码清单5-10：将宽表数据集格式转换为长表数据集格式
# 矩形数据集通常为宽表或长表格式。【在宽表格式中，每一行代表唯一的观测值】
# 下标展示了一个示例，此表包含了3个国家在1990年、2000年 和 2010年 的人均预期寿命估计值。
# 请注意表中的每一行代表的是一个国家中采集的数据：

# 不同年份和国家的人均预期寿命——宽表格式【在宽表格式中，每一行代表唯一的观测值】
# ID    Country    LExp1990    LExp2000    LExp2010
# FR    France     77.0        79.2        81.8
# BE    Belgium    76.1        77.8        80.3
# GER   Germany    75.3        78.2        80.5

# 不同年份和国家的人均预期寿命——长表格式【在长表格式中，每一行代表唯一的测量值】
# ID    Country    Variable    Life_Exp
# FR    France     LExp1990    77.0
# BE    Belgium    LExp1990    76.1
# GER   Germany    LExp1990    75.3
# FR    France     LExp2000    79.2
# BE    Belgium    LExp2000    77.8
# GER   Germany    LExp2000    78.2
# FR    France     LExp2010    81.8
# BE    Belgium    LExp2010    80.3
# GER   Germany    LExp2010    80.5

# 【不同的数据分析类型要求的数据格式不一样】
# 例如，如果想要识别哪些国家随着时间的推移具有相似的人均预期寿命趋势，我们可以采用聚类分析（第16章），而聚类分析要求数据为宽表格式。
# 另一方面，我们可能想要使用多次回归（第8章）来预测不同国家和年份的人均预期寿命，在这种情况下，数据则要求是长表格式的。

# 然而，大多数R函数使用宽表格式的数据框，只有一些函数要求数据为长表格式。
# 不过幸运的是，tidyr包提供了可以将数据框从一种格式轻松转化为另一种格式的函数。在继续操作前，请使用install.packages("tidyr")安装此包

# tidyr包中的函数gather()将宽表格式数据框转化为长表格式数据框，语法如下：
longdata <- gather(widedata, key, value, variable list)
# 其中
# 【】widedata是要转化的数据框
# 【】key指定变量列的名称（本例中为Variable）
# 【】value指定值列的名称（本例中为Life_Exp）
# 【】variable list指定要堆叠的变量（本例中为LExp1990、LExp2000、LExp2010）
library(tidyr)
data_wide <- data.frame(ID = c("FR", "BE", "GER"),
                        Country = c("France", "Belgium", "Germany"),
                        LExp1990 = c(77.0, 76.1, 75.3),
                        LExp2000 = c(79.2, 77.8, 78.2),
                        LExp2010 = c(81.8, 80.3, 80.5))
data_wide
#   ID Country LExp1990 LExp2000 LExp2010
#1  FR  France       77       79       82
#2  BE Belgium       76       78       80
#3 GER Germany       75       78       80
data_long <- gather(data_wide, key = "Variable", value = "Life_Exp",
                    c(LExp1990, LExp2000, LExp2010))
data_long
#   ID Country Variable Life_Exp
#1  FR  France LExp1990       77
#2  BE Belgium LExp1990       76
#3 GER Germany LExp1990       75
#4  FR  France LExp2000       79
#5  BE Belgium LExp2000       78
#6 GER Germany LExp2000       78
#7  FR  France LExp2010       82
#8  BE Belgium LExp2010       80
#9 GER Germany LExp2010       80
