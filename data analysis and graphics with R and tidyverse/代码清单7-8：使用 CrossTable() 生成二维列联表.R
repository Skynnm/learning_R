# 注意：table() 函数默认忽略缺失值（NA）。要在频数统计中将NA视为一个有效的类别，请设定参数 useNA = "ifany"

# 创建二维列表的第1种方法 —— table()函数：table(A, B)
# 创建二维列表的第2种方法 —— xtabs()函数：xtabs(~ A + B, data = mydata)
# 创建二维列表的第3种方法 —— gmodels 包中的 CrossTable() 函数

# 代码清单7-8：使用 CrossTable() 生成二维列联表
# 创建二维列联表的第3种方法是使用 gmodels 包中的 CrossTable() 函数。
# CrossTable() 函数仿照 SAS 中 PROC FREQ 或 SPSS 中 CROSSTABS 的形式生成二维列联表
install.packages("gmodels")
library(gmodels)
CrossTable(Arthritis$Treatment, Arthritis$Improved)
#Cell Contents
#|-------------------------|
#  |                       N |
#  | Chi-square contribution |
#  |           N / Row Total |
#  |           N / Col Total |
#  |         N / Table Total |
#  |-------------------------|
#  
#  
#  Total Observations in Table:  84 
#
#
##| Arthritis$Improved 
#Arthritis$Treatment |      None |      Some |    Marked | Row Total | 
#  --------------------|-----------|-----------|-----------|-----------|
#  Placebo |        29 |         7 |         7 |        43 | 
#  |     2.616 |     0.004 |     3.752 |           | 
#  |     0.674 |     0.163 |     0.163 |     0.512 | 
#  |     0.690 |     0.500 |     0.250 |           | 
#  |     0.345 |     0.083 |     0.083 |           | 
#  --------------------|-----------|-----------|-----------|-----------|
#  Treated |        13 |         7 |        21 |        41 | 
#  |     2.744 |     0.004 |     3.935 |           | 
#  |     0.317 |     0.171 |     0.512 |     0.488 | 
#  |     0.310 |     0.500 |     0.750 |           | 
#  |     0.155 |     0.083 |     0.250 |           | 
#  --------------------|-----------|-----------|-----------|-----------|
#  Column Total |        42 |        14 |        28 |        84 | 
#  |     0.500 |     0.167 |     0.333 |           | 
#  --------------------|-----------|-----------|-----------|-----------|

# CrossTable() 函数有很多选项，可以做许多事情：计算（行、列、单元格）的百分比；指定小数位数；进行卡方、Fisher 和 McNemar 独立性检验；计算期望和（Pearson、标准化、调整的标准化）残差；将缺失值作为一种有效值；进行行和列标题的标注；生成 SAS 或 SPSS 风格的输出。更多详情，请参阅 help(CrossTable)。