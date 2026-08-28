# 代码清单7-4：【未维护】通过pastecs包中的 stat.desc() 函数计算描述性统计量
# pastecs包中右一个名为 stat.desc() 的函数，它可以计算种类繁多的描述性统计量。使用格式为
stat.desc(x, basic = TRUE, desc = TRUE, norm = FALSE, p = 0.95)
# 其中的 x 是一个数据框或时间序列。
# 若 basic = TRUE（默认值），则计算其中所有值、空值、缺失值的数量，以及最小值、最大值、值域，还有总和。
# 若 desc = TRUE（同样也是默认值），则计算中位数、均值、均值的标准误、平均数置信度为95%的置信区间、方差、标准差以及变异系数。
# 最后，若 norm = TRUE（不是默认的），则返回正太分布统计量，包括偏度和峰度（以及它们的统计显著程度）和Shapiro-Wilk正太检验结果。这里使用p值来计算平均数的置信区间（默认置信度为0.95）
install.packages("pastesc")
library(pastesc)
myvars <- c("mpg", "hp", "wt")
stat.desc(mtcars[myvars])


version
