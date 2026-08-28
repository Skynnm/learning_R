# 在图层中逐渐添加元素以创建图形，先放映射，再放几何对象

# 代码清单4-0-5：刻面
# 下一个问题是：对于每个职业来说，工作年限、薪资 和 性别 之间的关系是否相同。我们将针对每个职业重新绘制图形，以探讨这个问题。

# 相对于挤在一张图中重叠展示，如果使用并排的几张图来分别展示每个组的数据，那么变量之间的关系就会清晰得多。
# 【刻面为给定的某个变量（或变量组合）的每一个水平分别绘制一张图】
# 我们可以使用函数 facet_wrap() 和 facet_grid() 来创建可免图。
# 下表给出了相关的语法，其中 var、rowvar 和 colvar 是因子

# 语法                        结果
# facet_wrap(~var, ncol = n)  将每个var水平排列成n列的独立图【一维平铺，自动换行，因为总量一定，行设置了，列也就设置了】
# facet_wrap(~var, nrow = n)  将每个var水平排列成n行的独立图【一维平铺，自动换行】     
# facet_grid(rowvar~colvar)   rowvar 和 colvar组合的独立图，其中rowvar表示行，colvar表示列
# facet_grid(rowvar~,)        每个rowvar水平的独立图，配置成一个单列【只分行，不分列（纵向堆叠多个图）】
# facet_grid(,~colvar)        每个colvar水平的独立图，配置成一个单行【只分列，不分行（横向并排多个图）】

# 在本例中，刻面图由变量 sector 的8个水平来定义。
# 因为每个刻面都比独占一个绘图面板的图形小，所以我们将忽略 geom_point() 中的size=3和gwom_smooth()中的size=1.5。
# 这么做，与前面的图形相比，点和线条的大小都会变小、变细，会使每个刻面看起来更加好看。
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
  theme_bw()
# 上面的代码生成了 雇员工作年限和薪资的散点图（带有自定义的x轴和y轴与自定义的的性别的颜色映射）为8个职业中的每个职业提供了图形（刻面）

# 从图中我们可以看出男性和女性之间的差异与他们所处的职业相关。
# 例如，男性经理的工作年限与薪资之间具有很强的正相关关系，但是对于女性经理来说没有。
# 某种程度上，销售行业中的男性和女性也是这样。
# 另一方面，不论是男性服务人员还是女性服务人员，他们的工作年限和薪资之间看上去没有什么关系。
# 同时，不论是哪个职业，男性的薪资都略高于女性。
# 女性文员的薪资也会增长，但是男性文员的薪资可能减少（此处所显示的这种趋势并不明显）
# 现在，我们对工作年限和薪资之间的关系有了更加深入的认识。
