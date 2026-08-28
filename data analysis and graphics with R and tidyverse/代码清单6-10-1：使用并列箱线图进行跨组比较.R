# 函数 aes() 用于将变量映射到图形的视觉特征

# 代码清单6-10-1：使用并列箱线图进行跨组比较
# 箱线图是比较根据分类变量各水平分组的定量变量分布的有效方法。
# 让我们再次比较四缸、六缸 和 八缸汽车每加仑汽油行驶英里数，但是这次我们将使用 1999 年和 2008 年的数据。

# 因为五缸车很少，所以删除五缸车的数据。我们还要将 year 和 cyl 从连续型数值变量转化为分类（分组）因子：
library(ggplot2)
cars <- mpg[mpg$cyl != 5,]
cars$Cylinders <- factor(cars$cyl)
cars$Year <- factor(cars$year)

# 代码：
ggplot(cars, aes(x = Cylinders, y = cty)) +
  geom_boxplot() +
  labs(x = "Number of Cylinders",
       y = "Miles Per Gallon",
       title = "Car Miles Data")
# 生成：不同气缸数量车型每加仑汽油行驶英里数的箱线图
# 我们可以看到不同组间每加仑汽油行驶英里数的区别非常明显。
# 同时，我们也发现，随着气缸数量的增加啊，然后效率在降低。在四缸车车组中还有 4 个离群值点（英里数异常高的汽车）


# 箱线图非常灵活，通过添加 notch = TRUE，可以得到含凹槽的箱线图。
# 【若两个箱的凹槽互不重叠，则表明它们的中位数有显著差异】
# 以下代码将为不同气缸数量车型每加仑汽油行驶英里数的示例创建一幅含凹槽的箱线图：
ggplot(cars, aes(x = Cylinders, y = cty)) +
  geom_boxplot(notch = TRUE,
               fill = "steelblue",
               varwidth = TRUE) +
  labs(x = "Number of Cylinders",
       y = "Miles Per Gallon",
       title = "Car Mileage Data")
# 选项fill以刚蓝色填充了箱线图。在标准箱线图中，箱子宽度没有任何意义。
# 添加 varwidth = TRUE后，绘制的箱线图的宽度与每个组的观测值数量的平方根成比例。
# 从图中可以看出，四缸、六缸、八缸车型的油耗中位数是不同的。随着气缸数量的增加，每加仑汽油行驶英里数明显降低。
# 此外，八缸车型的样本量比四缸或着六缸车型少（虽然差异并不明显）


# 最后，我们可以为多个分组因子绘制箱线图。以下代码提供了不同年份不同气缸数量车型每加仑汽油行驶英里数的箱线图。
# 代码中添加了函数 scale_fill_manual() 用于自定义填充颜色：
ggplot(cars, aes(x = Cylinders, y = cty, fill = Year)) +
  geom_boxplot() +
  labs(x = "Number of Cylinders",
       y = "Miles Per Gallon",
       title = "City Mileage by # Cylinders and Year") +
  scale_fill_manual(values = c("gold", "green"))
# 如图所示，我们可以再次清楚地看到每加仑汽油行驶英里数的中位数随着气缸数量增加而减少。
# 另外，对于每个组，2008年 较 1999年的每加仑汽油行驶英里数有所增加。
