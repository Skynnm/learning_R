# 公共索引——共有变量

# 代码清单3-8：使用SQL语句操作数据框
# 到目前为止，我们一直在使用 R 语句和函数操作数据。
# 但是许多数据分析人员在接触 R 之前就已经精通了结构化查询语言（SQL），要丢弃那么多积累下来的知识实为一件憾事。
# 因此在我们结束本章之前简述一下sqldf包。（如果你对SQL不熟，请尽管跳过本节）

# 在下载并安装好 sqldf 包以后（install.packages("sqldf")），我们可以使用sqldf()函数在数据框上使用SQL中的 SELECT 语句。
install.packages("sqldf")                                                              # ①
library(sqldf)                                                                         # ①
newdf <- sqldf("select * from mtcars where carb = 1 order by mpg", row.names = TRUE)   # ①
newdf                                                                                  # ①
#                mpg cyl  disp  hp drat    wt  qsec vs am gear carb
#Valiant        18.1   6 225.0 105 2.76 3.460 20.22  1  0    3    1
#Hornet 4 Drive 21.4   6 258.0 110 3.08 3.215 19.44  1  0    3    1
#Toyota Corona  21.5   4 120.1  97 3.70 2.465 20.01  1  0    3    1
#Datsun 710     22.8   4 108.0  93 3.85 2.320 18.61  1  1    4    1
#Fiat X1-9      27.3   4  79.0  66 4.08 1.935 18.90  1  1    4    1
#Fiat 128       32.4   4  78.7  66 4.08 2.200 19.47  1  1    4    1
#Toyota Corolla 33.9   4  71.1  65 4.22 1.835 19.90  1  1    4    1
sqldf("select avg(mpg) as avg_mpg, avg(disp) as avg_disp, gear                         # ②
      from mtcars where cy1 in (4, 6) group by gear")                                  # ②

# ①从数据框 mtcars 中选取所有的变量（列），但只保留化油器（carb）数量为 1 的车型（行），按照mpg的值对车型进行升序排列，并将结果保存为数据框newdf。参数row.names =  RUE 将数据框中的行名直接迁移到新数据框中。
# ②输出四缸和六缸（cy1）车型每一 gear 水平的 mpg 和 disp 的平均值

# 经验丰富的SQL用户会发现，sqldf包是R中一个实用的数据管理辅助工具。更多详情，请参阅 GitHub 上的项目主页。
