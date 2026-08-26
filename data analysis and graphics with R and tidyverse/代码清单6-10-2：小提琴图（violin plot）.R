# 有序步骤（sequential step）、分类情况（parallel case）

# 代码清单6-10-2：小提琴图（violin plot）
# 在结束箱线图的讨论之前，有必要研究一种称为小提琴图（violin plot）的箱线图变种。
# 小提琴图是箱线图与核密度图的结合。我们可以使用函数geom_violin()绘制它
library(ggplot2)
cars <- mpg[mpg$cyl != 5,]
cars$Cylinders <- factor(cars$cyl)

ggplot(cars, aes(x = Cylinders, y = cty)) +
  geom_boxplot(width = 0.2,
               fill = "green") +
  geom_violin(fill = "gold",
              alpha = 0.3) +
  labs(x = "Number of Cylinders",
       y = "City Miles Per Gallon",
       title = "Violin Plots of Miles Per Gallon")
# 箱线图的宽度设为0.2，以便它们能放在小提琴图的里面。小提琴图的透明度设为0.3，这样我们仍可以看见箱线图。

# 小提琴图基本上是核密度图以镜像方式在箱线图上的叠加。
# 在图中，中间线是中位数，黑色盒子的范围是下四分位点到上四分位点，细黑线表示须。点表示离群值。
# 外部形状即为核密度图。从图上可知八缸车的分布可能是双峰型的，这是单独使用箱线图时看不出来的。
# 小提琴图还没有真正地流行起来。同样，这可能也是普遍缺乏方便好用的软件导致的。时间会证明一切。