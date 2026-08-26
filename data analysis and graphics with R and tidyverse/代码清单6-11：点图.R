# 条形图（其次是饼图和树形图）可以用来深入了解一个分类变量的分布
# 堆积条形图、分组条形图 和 填充条形图有助于我们理解不同分类输出的组间差异
# 直方图、箱线图、小提琴图和点图 可以帮助我们可视化连续型变量的分布
# 重叠核密度图和并列箱线图可以邦族我们可视化连续型变量的组间差异

# 代码清单6-11：点图
# 与之前看到的图形不同，点图绘制变量中的所有值

# 点图提供了一种在简单水平刻度上绘制大量标签值的方法。我们可以使用函数 dotchart() 创建点图，格式为：
ggplot(data, aes(x = contvar, y = catvar)) + geom_point()
# 其中，data是一个数据框，contvar是一个连续型变量，catvar是一个分类变量。

# 以下示例用的是mpg数据集中 2008年各车型的每加仑汽油高速公路行驶英里数。每加仑汽油高速公路行驶英里数取每种车型的平均值。
library(ggplot2)
library(dplyr)
plotdata <- mpg %>%
  filter(year == "2008") %>%
  group_by(model) %>%
  summarize(meanHwy = mean(hwy))

plotdata
#  A tibble: 38 × 2
#model              meanHwy
#<chr>                <dbl>
#  1 4runner 4wd           18.5
#2 a4                    29.3
#3 a4 quattro            26.2
#4 a6 quattro            24  
#5 altima                29  
#6 c1500 suburban 2wd    18  
#7 camry                 30  
#8 camry solara          29.7
#9 caravan 2wd           22.2
#10 civic                 33.8
# ℹ 28 more rows
# ℹ Use `print(n = ...)` to see more rows


ggplot(plotdata, aes(x = meanHwy, y = model)) +
  geom_point() +
  labs(x = "Miles Per Gallon",
       y = "",
       title = "Gas Mileage for Car Models")
# 上述代码生成了：每种车型的每加仑汽油行驶英里数的点图
# 在这个图上我们可以看到同一水平轴上每种车型的每加仑汽油行驶英里数。

# 在对点图进行排序后，点图变得非常有用，以下代码按每加仑汽油行驶英里数从低到高对车型进行排序：
ggplot(plotdata, aes(x = meanHwy, y = reorder(model, meanHwy))) +
  geom_point() +
  labs(x = "Miles Per Gallon",
       y = "",
       title = "Gas Mileage for Car Models")
# 绘图生成了：每种车型的每加仑汽油行驶英里数的排序点图。
# 如果要按降序进行绘制，就使用reorder(model, -meanHwy)

# 我们可以从本例的点图中获得有意义的信息，因为每个点都有标签，每个点的值都有其内在含义，并且这些点的排列方式有利于对比分析。
# 但是随着数据点的增多，点图的实用性会随之下降。