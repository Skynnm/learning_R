# SQL：structure query language
# 人类非常善于从视觉呈现中洞察关系

# 代码清单4-0-1：函数ggplot()
# ggplot2包通过一系列函数在图层中创建图形。
# 我们将从一个简单图形开始，通过每次往里添加一个元素来逐步创建一个复杂的图形。
# 默认情况下，ggplot2图形显示在带白色参考线的灰色背景下。

# 我们要学习的第一个函数是ggplot2()，我们需要设置以下参数：
# （1）一个数据框：其中包含要绘制的数据；
# （2）一组映射，是数据框中的变量到图形的可视属性的映射。
#                映射放置在函数 aes() (该函数代表“美化”或“你能看见的东西”)中。

install.packages(c("mosaicData", "ggplot2"))
library(ggplot2)
library(mosaicData)
ggplot(data = CPS85, mapping = aes(x = exper, y = wage)) # 如何放置 数据 / 观测值

# 为什么这个图是空白的？这是因为我们已经指定了变量 exper (工作年限)映射到x轴，变量 wage（薪资）映射到y轴，但是我们还没指定在图形上要放置什么。
# 在本例中，我们希望用点来代表每个参与者。
