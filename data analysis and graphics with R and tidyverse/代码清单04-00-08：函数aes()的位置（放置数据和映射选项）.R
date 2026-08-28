# ggplot包的详细信息中，有3个重要问题需要考虑：函数aes()的位置、将ggplot2图形用作R对象，以及各种保存图形的方法，以便在报告和网页中使用图形

# 代码清单4-0-8：函数aes()的位置（放置数据和映射选项）
# 使用ggplot2创建图形总是从函数ggplot开始。
# 在前面的例子中，这个函数中放置了data和mapping选项。
# 在本例中，这两个选项将应用到后面的每一个geom函数

# 我们也可以将这两个选项直接放进几何对象。如果这样做，它们仅可以应用到指定的几何对象。以下面的图形代码为例：
ggplot(CPS85_new, aes(x = exper, y = wage, color = sex)) +
  geom_point(alpha = .7, size = 1.5) +
  geom_smooth(method = "lm", se = FALSE, size = 1) + 
  scale_color_manual(values = c("lightblue", "midnightblue")) +
  theme_bw()
# 图形生成了按性别分组的雇员工作年限和薪资的散点图，其中函数 ggplot() 放置了 aes(color=sex)，映射应用到geom_point()和geom_smooth()，生成了男性和女性各自的点颜色和最佳拟合


# 由于性别到颜色的映射出现在函数ggplot()中，因此这个映射也会应用到geom_point和geom_smooth
# 点的颜色表示性别，生成了男性和女性各自带颜色的趋势线。我们将上面的代码与下面的代码进行比较：
ggplot(CPS85_new, aes(x = exper, y = wage)) +
  geom_point(aes(color = sex), alpha = .7, size = 1.5) +
  geom_smooth(method = "lm", se = FALSE, size = 1) + 
  scale_color_manual(values = c("lightblue", "midnightblue")) +
  theme_bw()
# 图形生成了按性别分组的雇员工作年限和薪资的散点图，其中函数 geom_point() 放置了 aes(color=sex) ，映射应用到点的颜色，生成了男性和女性各自的点颜色，以及所有雇员的一条最佳拟合线。
# 由于性别到颜色的映射只出现在函数 geom_point() 中，所以它仅在此处使用，且我们仅创建了一条针对所有观测值的趋势线

# 本书中绝大多数的示例是在 ggplot 函数中放置数据和映射选项的。
# 另外，因为第1个选项总是引用数据，第2个选项总是引用映射，所以我们将省略短语 data =和 mapping =
