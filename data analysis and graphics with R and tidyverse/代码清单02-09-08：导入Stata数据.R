# 程序员看代码的时间远多于写代码的时间

# 代码清单2-9-8：导入Stata数据
# 将Stata数据导入R中非常简单直接，我们还是使用haven包
install.packages("haven")
library("haven")
maydataframe <- read_dta("mydata.dta")

# 这里，mydata.dta是Stata数据集，mydataframe是返回的R数据框，被保存为tibble数据框
