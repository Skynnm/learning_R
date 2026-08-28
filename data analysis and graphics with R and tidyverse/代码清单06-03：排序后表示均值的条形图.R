# 条形图通过垂直的或水平的条形展示了分类变量的分布（频数）
# 看代码、理解代码的时间，远远多于直接写代码的时间

# 代码清单6-3：排序后表示均值的条形图
# 条形图并不一定要基于计数数据或频数数据。
# 我们可以通过使用合适的统计量汇总数据并将结果传递给ggplot2，来创建表示均值、中位数、百分比、标准差等的条形图。
# 在下面的图形中，我们将绘制1970年美国各地区的平均文盲率。R自带的数据集stats.x77具有各个州的文盲率，数据集state.region具有每个州所属的地区名。
states <- data.frame(state.region, state.x77)
library(dplyr)
plotdata <- states %>%                             # ①生成各地区的均值
  group_by(state.region) %>%                       # ①生成各地区的均值
  summarise(mean = mean(Illiteracy))               # ①生成各地区的均值
plotdata
#  A tibble: 4 × 2
#state.region   mean
#<fct>         <dbl>
#  1 Northeast      1   
#2 South          1.74
#3 North Central  0.7 
#4 West           1.02

ggplot(plotdata, aess(x = reorder(state.region, mean), y = mean)) +  # ②使用排序条形图表示均值
  geom_bar(stat = "identity") +                                     # ②使用排序条形图表示均值
  labs(x = "Region",                                                # ②使用排序条形图表示均值
       y = "",                                                      # ②使用排序条形图表示均值
       title = "Mean Illiteracy Rate")                              # ②使用排序条形图表示均值

# 代码清单6-3首先计算了每个地区的平均文盲率①。
# 然后，按升序排序均值，其绘制为条形图②
# 通常，函数 geom_bar() 计算并绘制单元格计算，但是添加 stat = "identity"选项可强制此函数绘制所提供的数（本例中为均值）。
# 使用函数reorder()对条形图按平均文盲率进行升序排列。

# 代码生成了：美国各地区平均文盲率排序条形图。

?reorder
state.region
state.x77
length(state.region)
nrow(state.x77)

plotdata

test <- reorder(plotdata$state.region, plotdata$mean)
test

#[1] Northeast     South         North Central West         
#attr(,"scores")
#Northeast         South North Central          West 
#1.0           1.7           0.7           1.0 
#Levels: North Central Northeast West South

# reorder()不会改动 tibble 行的顺序，只修改因子对象内部的水平顺序。
# 原 tibble plotdata的行还是原来 1‑4 行，没有重排。
