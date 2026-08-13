# 先设置映射，再放置几何图形

# 代码清单4-0-2：geom_函数
# geom_函数是在图像上放置的几何对象（点、线、条 和 阴影区域）。
# 我们使用名称以 geom_开头的函数来添加它们。当前可用的geom_函数有37个，且数量还在增长。
# 表4-1中列出了常用的geom_函数，以及每个geom_函数常用的选项。


#  函数              添加的图形            选项     
#  geom_bar()        条形图                color, fill, alpha
#  geom_boxplot()    箱线图                color, fill, alpha, notch, width
#  geom_density()    核密度图              color, fill, alpha, linetype
#  geom_histogram()  直方图                color, fill, alpha, linetype, bindwidth
#  geom_hline()      水平线条              color, alpha, linetype, size
#  geom_jitter()     抖动点                color, size, alpha, shape
#  geom_line()       线图                  colorvalpha, linetype, size
#  geom_point()      散点图                color, alpha, shape, size
#  geom_rug()        地毯图                color, side
#  geom_smooth()     拟合曲线              method, formula, color, fill, linetype, size
#  geom_text()       文本注解              选项很多，详见该函数的帮助信息
#  geom_violin()     小提琴图              color, fill, alpha, linetype
#  geom_vline()      垂线                  color, alpha, linetype, size


# 我们使用函数 geom_point() 来添加点，创建一个散点图。在 ggplot2 图形中，我们使用 + 号将函数串联在一起，创建一个最终的图形：
library(ggplot2)
library(mosaicData)
ggplot(data = CPS85, mapping = aes(x = exper, y = wage)) +
  geom_point()
# 想象：将数据框中的点/变量，以各种形式和规则绘制到图点【映射】


# 从图（雇员工作年限和薪资的散点图）中可以看出随着工作年限的增长，薪资也在增加，但是这个关系并不明显。
# 这个图还显示了一个异常值。有一个雇员的薪资远远高于其他人。我们删除这个异常值，重新绘制图形。
CPS85_new <- CPS85[CPS85$wage < 40, ]
ggplot(data = CPS85_new, mapping = aes(x = exper, y = wage)) +
  geom_point()
# 展示了新的图形，删除异常值后的雇员工作年限和薪资的散点图


# geom_函数中可以指定很多选项。geom_point() 的选项包括color、size、shape 和 alpha。这些选项分别控制点的颜色、大小、形状 和 透明度。
# 颜色可以通过名称或十六进制代码来指定。
# 形状和线条类型可分别由表示图案或符号的名称或数字指定。
# 点大小由从0开始的正实数指定。大的数字生成较大的点。
# 透明度的范围从0（完全透明）到1（完全不透明）。添加透明度有助于可视化重叠的点。
# 第19章将对每个选项进行更详细的描述。


# 我们将图中的点变大一些，透明度调成半透明，颜色改成蓝色。我们还使用函数theme将灰色背景变成白色。
ggplot(data = CPS85_new, mapping = aes(x = exper, y = wage)) +
  geom_point(color = "cornflowerblue", alpha = .7, size = 1.5) +
  theme_bw()
# 上图绘制了雇员工作年限和薪资的散点图，其删除了异常值、修改了点的颜色、透明度 和 大小，并应用了 bw 主题（亮底暗字）
# 我认为这张图更有吸引力（至少你有了一张带颜色的输出图），但是它并没有增进我们对图形的理解。
# 如果图中有一条线用于总结工作年限和薪资之间的关系，那么会更有利于我们理解图形。
# 我们可以使用函数 geom_smooth() 来添加这条线。此函数的选项可以控制线条的类型（线性、二次、非参数）、粗细、颜色，以及是否存在置性区间。第11章将对每一项进行探讨，在这里我们使用一个线性回归（method = lm）线条（lm代表线性模型）：
ggplot(data = CPS85_new, mapping = aes(x = exper, y = wage)) +
  geom_point(color = "cornflowerblue", alpha = .7, size = 1.5) +
  geom_smooth(method = "lm") +
  theme_bw()
# 结果生成了带最佳拟合拟合线的的雇员工作年限和薪资的散点图。
# 从这个图中可以看出，平均来说，薪资的增长与工作年限的增长中呈现中等的相关性。
# 本章仅使用了两个geom_函数。在后续章节中，我们将使用其他 geom_函数创建多种图形类型，包括条形图、直方图、箱线图、核密度图等图形。
