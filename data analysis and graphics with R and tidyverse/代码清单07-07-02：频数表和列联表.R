# 代码清单7-7-2：频数表和列联表
# 在本节中，我们将着眼于分类变量的频数表和列联表，以及相应的独立性检验、相关性的度量、图形化展示结果的方法。
# 我们除了使用基础安装中的函数，还将连带使用 vcd 包 和 gmodels 包中的函数。在下面的示例中，假设A、B 和 C代表分类变量。

# 本节中的数据来自 vcd包中的 Arthritis 数据集。这份数据来自一项风湿性关节炎新疗法的双盲临床实验的结果，前几个观测值是这样的：
install.packages("vcd")
library(vcd)
head(Arthritis)
#  ID Treatment  Sex Age Improved
#1 57   Treated Male  27     Some
#2 46   Treated Male  29     None
#3 77   Treated Male  30     None
#4 17   Treated Male  32   Marked
#5 36   Treated Male  46   Marked
#6 23   Treated Male  58   Marked

# 治疗方式（安慰剂治疗、用药治疗）、性别（男性、女性） 和 改善情况（无改善、一定程度的改善、显著改善）均为分类因子
# 我们将使用此数据集创建频数表和列联表（交叉的分类）



#### 生成频数表 ####
# R中提供了用于创建频数表和列联表的若干方法，其中最重要的函数已列于表7-1中
#         函数                                        描述
# tbale(var1, var2, ... varN)      使用N个分类变量（因子）创建一个N维列联表
# xtabs(formula, data)             根据一个公式和一个矩阵或数据框创建一个N维列联表
# prop.table(table, margins)       依 margins 定义的边际列表将表中条目表示为分数形式
# margin.table(table, margins)     依 margins 定义的边际列表计算表中条目的和
# addmarings(table, margins)       将描述边 margins (默认是求和结果) 放入表中
# ftable(table)                    创建一个紧凑的“平铺”式列联表

# 接下来，我们将逐个使用以上函数来探索分类变量。
# 我们首先考察简单的频数表，接下来是二维列联表，最后是多维列联表。
# 第一步是使用函数 table() 或 xtable() 创建一张表，然后使用其他函数处理它。

## 一维列联表 ##
# 我们可以使用 table() 函数生成简单的频数统计表。示例如下：
mytable <- with(Arthritis, table(Improved))
mytable
#Improved
#None   Some Marked 
#42     14     28 

# 可以用 prop.table() 将这些频数转化为比例值：
prop.table(mytable)
#Improved
#None      Some    Marked 
#0.5000000 0.1666667 0.3333333 

# 或使用 prop.table() * 100 转化为百分比
prop.table(mytable)*100
#Improved
#None     Some   Marked 
#50.00000 16.66667 33.33333

# 这里可以看到，有 50% 的研究参与者获得了一定程度或者显著的改善（16.7+33.3）



## 二维列联表 ##
# 对于二维列联表，table() 函数的使用格式为：
mytable <- table(A, B)
# 其中，A是行变量，B是列变量。除此之外，xtabs() 函数还可使用公式风格的输入创建列联表，格式为：
mytable <- xtabs(~ A + B, data = mydata)
# 其中，mydata 是一个矩阵或数据框。总的来说，要进行交叉分类的变量应出现在公式的右侧（即~符号的右方），以+作为分隔符
# 若某个变量写在公式的左侧，则其作为一个频数向量（在数据已经被表格化时很有用）
# 对于Arthritis数据集，我们有：
mytable <- xtabs(~ Treatment + Improved, data = Arthritis)
mytable
#          Improved
#Treatment None Some Marked
#Placebo   29    7      7
#Treated   13    7     21

# 我们可以使用函数 margin.table() 和 prop.table() 分别生成边际频数和比例。行和与行的比例可以这样计算：
margin.table(mytable, 1)
#Treatment
#Placebo Treated 
#43      41

prop.table(mytable, 1)
#               Improved
#Treatment      None      Some    Marked
#Placebo 0.6744186 0.1627907 0.1627907
#Treated 0.3170732 0.1707317 0.5121951

# 下标1指代 table() 语句中的第1个变量——行变量。每一行的比例之和为1。
# 观察表格可以发现，与接受安慰剂治疗的个体中有显著改善的16%相比，接受用药治疗的个体中的51%的个体病情有了显著的改善。

# 列和与列的比例可以这样计算：
margin.table(mytable, 2)
#   Improved
#None   Some Marked 
#42     14     28 

prop.table(mytable, 2)
#                      Improved
#Treatment      None      Some    Marked
#Placebo 0.6904762 0.5000000 0.2500000
#Treated 0.3095238 0.5000000 0.7500000

# 这里的下标2指代table()语句中的第2个变量——列变量。每一列的比例加起来为1.

# 各单元格所占的比例可用如下语句获取：
prop.table(mytable)
#                        Improved
#Treatment       None       Some     Marked
#Placebo 0.34523810 0.08333333 0.08333333
#Treated 0.15476190 0.08333333 0.25000000

# 所有单元格的比例加起来为1

# 我们可以使用 addmarings() 函数为这些表格添加边际和。例如，以下代码添加了各行的和与各列的和：
addmargins(mytable)
#                 Improved
#Treatment None Some Marked Sum
#Placebo   29    7      7  43
#Treated   13    7     21  41
#Sum       42   14     28  84

addmargins(prop.table(mytable))
#                           Improved
#Treatment       None       Some     Marked        Sum
#Placebo 0.34523810 0.08333333 0.08333333 0.51190476
#Treated 0.15476190 0.08333333 0.25000000 0.48809524
#Sum     0.50000000 0.16666667 0.33333333 1.00000000

# 在使用 addmargins() 时，默认行为是为表中所有的变量创建边际和。作为对照：
addmargins(prop.table(mytable, 1), 2)
#                        Improved
#Treatment      None      Some    Marked       Sum
#Placebo 0.6744186 0.1627907 0.1627907 1.0000000
#Treated 0.3170732 0.1707317 0.5121951 1.0000000
# 仅添加了各行的和。类似地：
addmargins(prop.table(mytable, 2), 1)
#                   Improved
#Treatment      None      Some    Marked
#Placebo 0.6904762 0.5000000 0.2500000
#Treated 0.3095238 0.5000000 0.7500000
#Sum     1.0000000 1.0000000 1.0000000
# 添加了各列的和。在表中可以看到，有显著改善患者中的25%是接受安慰剂治疗的
