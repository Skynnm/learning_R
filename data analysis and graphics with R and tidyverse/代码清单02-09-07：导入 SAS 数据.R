# 蛇形命名法：snake_case

# 代码清单2-9-7：导入 SAS 数据
# 我们可以使用haven包中的函数 read_sas() 导入SAS数据集。在安装haven包后，我们用library(haven)语句导入数据
install.packages("haven")
library("haven")

# 用户还可以使用以下代码导入变量格式目录，并应用到数据：
mydataframe <- read_sas("mydata.sas7bdat",
                        catalog_file = "mydata.sas7bdat")

# 无论使用哪种方法，其结果都是保存为tibble数据框
# 还可以使用一款名为 Stat/Transfer的商业软件。该软件可以很好地将SAS数据集（包括任何已知的变量格式）保存为R数据框。
