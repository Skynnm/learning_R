# 代码清单7-7-1：使用 dplyr 进行交互式汇总数据
# 到目前为止，我们所讨论的函数集中在为整个数据框计算综合的描述性统计量。
# 但是，在交互式、探索性数据分析中，我们的目前是回答具有针对性的问题。在这种情况下，我们希望获取特定观测值的特定的统计量

# 3.11节介绍的dplyr包为我们提供了快速并灵活地达成此目标的工具。
# 函数 summarize() 和 summarize_all() 可以用来计算任何指定的统计量，
# 函数 group_by() 可以用来指定要计算这些统计量的分组

# 在此举个示例，我们使用 carData 包中的Salaries数据框来询问并回答一系列问题。
# 这个数据集包含美国一所大学在2008年至2009年之间397名教授9个月的薪水（以美元为单位）数据
# 这些数据是一项正在进行的，旨在检测男性教师和女性教师的薪水差异项目的一部分。
# 在继续操作之前，请确保已安装 carData包 和 dplyr包（install.packages(c("carData", "dplyr"))），然后载入包
install.packages(c("carData", "dplyr"))
library(carData)
library(dplyr)
# 现在，我们准备对数据提出问题了。
# 397名教授的薪资中位数和薪水范围是多少。
Salaries %>%
  summarize(med = median(salary),
            min = min(salary),
            max = max(salary))
#     med   min    max
#1 107300 57800 231545
# 将 Salaries 数据集传递给函数 summarize()，此函数计算薪水的中位数、最小值即最大值，并返回一个单行 tibble 数据框
# 9个月薪水的中位数是107300美元，至少有一人的薪水大于230000美元





# 不同性别和级别的教授数量、薪水的中位数和薪水范围是多少？
Salaries %>% 
  group_by(rank, sex) %>%
  summarize(n = length(salary),
            med = median(salary),
            min = min(salary),
            max = max(salary))
#`summarise()` has regrouped the output.
#ℹ Summaries were computed grouped by rank and sex.
#ℹ Output is grouped by rank.
#ℹ Use `summarise(.groups = "drop_last")` to silence this message.
#ℹ Use `summarise(.by = c(rank, sex))` for per-operation grouping instead.
# A tibble: 6 × 6
# Groups:   rank [3]
#rank      sex        n     med   min    max
#<fct>     <fct>  <int>   <dbl> <int>  <int>
#  1 AsstProf  Female    11  77000  63100  97032
#2 AsstProf  Male      56  80182  63900  95079
#3 AssocProf Female    10  90556. 62884 109650
#4 AssocProf Male      54  95626. 70000 126431
#5 Prof      Female    18 120258. 90450 161101
#6 Prof      Male     248 123996  57800 231545

# 在 by_group() 语句中指定分类变量后，函数 summarise() 为分类变量的每个水平组合生成一行统计量。
# 在所有的教授级别中，女性薪水的中位数都低于男性。另外，这所大学有大量的男性正教授




# 不同性别和级别的教授的平均任职年限和获得博士学位后的平均任职年限是多少？
Salaries %>% 
  group_by(rank, sex) %>%
  select(yrs.service, yrs.since.phd) %>%
  summarise_all(mean)
# 函数 summarize_all() 为每个非分组变量（yrs.service 和 yrs.since.phd）的计算汇总统计量
# 如果我们希望为每个变量计算多个统计量，则可以提供一个清单。
# 例如，summarize_all(list(mean = mean, std = sd))将计算么个变量的均值和标准差。
# 在助理教授和副教授职位，男女教授的平均任职年限相近；但是，女性正教授的任职年限少于男性


# 使用 dplyr 包的一个优点是结果以 tibble(数据框) 的形式返回，便于我们进一步分析这些汇总结果、绘制图形、重新设置汇总结果的格式并打印出来。
# dplyr包还提供了汇总数据的简易机制。

# 一般来说，数据分析人员对于输出哪些描述性统计量以及如何设置它们的格式有着自己的偏好。
# 这可能就是有那么多统计函数的原因吧。选择一个最适合自己的统计函数，或者自己创造一个。
