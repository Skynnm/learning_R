# R语句由函数和赋值构成
# ggplot设置映射，其中aes()将变量值映射到图形特征（分组）
# geom_函数放置几何对象
# 标尺函数（以scale_开始）修改默认的标尺设置
# facet_wrap()、facet_grid()函数创建刻面图，为给定的变量（组合）的每一水平分别绘制一张图
# labs() 标签函数为坐标轴和图例提供了自定义标签，以及 添加自定义标题、副标题 和 说明文字
# 主题函数（以theme_开头）微调图形外观，控制背景、颜色、字体、网格线、图例位置等与数据无关的图形特征

# 代码清单4-0-7：主题
# 可以使用主题来微调图形的外观。
# 【主题函数（以theme_开头）控制背景、颜色、字体、网格线、图例位置，以及其他与数据无关的图形特征】
# 让我们使用一个更加简洁的主题。之前的图使用的主题会生成白色背景和浅灰色的参考线。
# 让我们试试不同的主题——比如一个更加简约的主题。
library("scales")
library("ggplot2")
ggplot(data = CPS85_new,
       mapping = aes(x = exper, y = wage, 
                     color = sex, shape = sex, linetype = sex)) +
  geom_point(alpha = .7) +
  geom_smooth(method = "lm", se = FALSE) +
  scale_x_continuous(breaks = seq(0, 60, 10)) +
  scale_y_continuous(breaks = seq(0, 30, 5),
                     label = scales::dollar) +
  scale_color_manual(values = c("indianred", "cornflowerblue")) +
  facet_wrap(~sector) +
  labs(title = "Relationship between wages and experience",
       subtitle = "Current Population Survey",
       x = "Years of Experience",
       y = "Hourly Wage",
       color = "Gender", shape = "Gender", linetype = "Gender") +
  theme_minimal()
# 上面的代码生成了雇员工作年限和薪资的散点图，其包含8个职业中每个职业的图形（刻面），自定义的标题和标签，以及更简约的主题

# 这是我们的最终图形，可供出版。当然，这些结果都是试验性的，它们基于有限的样本量，并未经过统计检验来评估这些差异是否是由于随机误差造成的。
# 第8章将讲解如何对此类型数据进行适当的检验，第19章将更加地讲解主题。
