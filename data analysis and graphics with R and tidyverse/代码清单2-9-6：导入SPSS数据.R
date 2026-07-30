# API指定了软件组件间如何互相进行交互

# 代码清单2-9-6：导入SPSS数据
# IBM SPSS数据集可以通过haven包中的函数read.spss()导入到R中。首先，下载并安装此包：
install.packages("haven")

# 然后，使用以下代码导入数据
library(haven)
mydataframe <- read_spss("mydata.sav")

# 导入的数据集是一个tibble数据框，其中的变量包含了导入的SPSS值标签，这些变量被指定了被标记的类。
# 我们可以用以下代码将这些标记的变量转化为R因子
labelled_vars <- names(mydataframe)[sapply(mydataframe, is.labelled)]
for (vars in labelled_vars) {
  mydataframe[[vars]] = as_factor(mydataframe[[vars]])
}

# haven包还提供了其他函数，用来读取压缩格式（.zsav）或转化格式（.por）的SPSS文件