# “代码是编程的诗歌”

# 代码清单4-0-6：标签
# 图形应该是易于解读的，而传达信息的标签在实现这一目标的过程中是一个关键元素。
# 函数 labs() 为坐标轴和图例提供了自定义标签。
# 此外，我们还可以添加自定义的标题、副标题 和 说明文字。在下面的代码中，我们对每一项进行了修改：
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
  theme_bw()
# 以上代码生成了   雇员工作年限和薪资的散点图，其包含8个职业中每个职业的图形（刻面），以及自定义的标题和标签
# 现在，看到此图的人无须猜测标签工作年限和薪资的意思，也无须猜测数据来源。
