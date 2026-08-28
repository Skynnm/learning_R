# 函数 aes() 将变量映射到图形的视觉特征
# 我们的目标是在准确传递信息的前提下创建尽可能简洁的图形

# 代码清单4-0-4：标尺
# 正如我们所看到的，函数 aes() 将变量映射到图形的视觉特征。
# 标尺用于指定每个映射是如何进行的。
# 举例来说，ggplot2会自动创建带刻度、刻度标签  和  轴标签的图形坐标轴。它们往往看起来不错。
# 但是有时候我们需要在更大程度上控制它们的外观。
# 代表组的颜色是自动选择的，但是根据自己的品味或出版物的要求，我们可能需要选择不同的颜色。


# 标尺函数（以scale_开始）允许我们修改默认的标尺设置。下标列出了一些常用的标尺函数：
#   函数                        描述
#   scale_x_continuous()        缩放定量变量的x轴和y轴，选项包括用于指定刻度标记的 breaks，用于指定刻度标记标签的 labels，以及用于控制显示的值范围的 limits
#   scale_y_continuous()        缩放定量变量的x轴和y轴，选项包括用于指定刻度标记的 breaks，用于指定刻度标记标签的 labels，以及用于控制显示的值范围的 limits
#   scale_x_discrete()          与上述表示连续变量的坐标轴相同
#   scale_y_discrete()          与上述表示连续变量的坐标轴相同
#   scale_color_manual()        指定代表分类层级的颜色。values选项指定颜色


# 在下一个图中，我们将更改x轴和y轴的标尺以及代表男性和女性的颜色。
# 代表工作年限的x轴范围从0到60，每个格子为10；
# 代表薪资的y轴的范围从0到30，每个格子为5。
# 女性编码为非红色，男性编码为非蓝色。
# 以下代码生成了：雇员工作年限和薪资的散点图，其带有自定义的x轴和y轴与自定义的性别的颜色图
ggplot(data = CPS85_new,
       mapping = aes(x = exper, y = wage, 
                     color = sex, shape = sex, linetype = sex)) +
  geom_point(alpha = .7, size = 3) +
  geom_smooth(method = "lm", se = FALSE, size = 1.5) +
  scale_x_continuous(breaks = seq(0, 60, 10)) +
  scale_y_continuous(breaks = seq(0, 30, 5)) +
  scale_color_manual(values = c("indianred", "cornflowerblue")) +
  theme_bw()
# 刻度标记由一个向量值定义。这里，函数 seq() 提供了一种便捷方式。
# 例如，seq(0, 60, 10) 可生成一个数值向量，它从 0 到 60，按 10 递增
# 在上面代码生成的图中，x轴和y轴上的数字更易懂了，颜色也更加更好看了。
# 但是，我们还有注意薪资的单位是美元。我们可以使用 scales 包更改 y 轴上的标签以表示美元。这个包提供美元、欧元、百分比等标签格式。
# 我们先安装 scales 包（install.packages("scales")），然后运行下面的代码
install.packages("scales")
library("scales")
library("ggplot2")
ggplot(data = CPS85_new,
       mapping = aes(x = exper, y = wage, 
                     color = sex, shape = sex, linetype = sex)) +
  geom_point(alpha = .7, size = 3) +
  geom_smooth(method = "lm", se = FALSE, size = 1.5) +
  scale_x_continuous(breaks = seq(0, 60, 10)) +
  scale_y_continuous(breaks = seq(0, 30, 5),
                     label = scales::dollar) +
  scale_color_manual(values = c("indianred", "cornflowerblue")) +
  theme_bw()
# 图片显示了雇员工作年限和薪资的散点图，其带有自定义的 x 轴和 y 轴与自定义性别的颜色映射，且薪资的单位为美元。


# 我们完成了关键的一步。下一个问题是，对于每个职业来说，工作年限、薪资和性别之间的关系是否相同。我们将针对每个职业重新绘制图形，来探讨这个问题。
