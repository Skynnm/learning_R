# 与人类语言一样，R语言也有这样的特性：
# 如果不掌握一定数量的 R 命令（即词汇量），就很难自如地用 R 语言与计算机交流。

# 代码清单6-5：简单的树形图
# 可以替换饼图的就是树形图（tree map），这种图形使用与变量水平成比例的矩形来显示分类变量的分布。
# 我们可以使用 treemapify 包创建树形图。
# 在使用前请先安装它（install.packages("treemapify")）
install.packages("treemapify")
# 我们先来创建一个展示 mpg 数据框中的汽车厂商分布情况的树形图
library(ggplot2)
library(dplyr)
library(treemapify)

plotdata <- mpg %>% count(manufacturer)      # ①对数据进行描述性统计

ggplot(plotdata,                             # ②创建树形图
       aes(fill = manufacturer,              # ②创建树形图
           area = n,                         # ②创建树形图
           label = manufacturer)) +          # ②创建树形图
  geom_treemap() +                           # ②创建树形图
  geom_treemap_text() +                      # ②创建树形图
  theme(legend.position = "none")            # ②创建树形图
# 上述代码生成了：显示 mpg 数据框中的汽车厂商分布的树形图。矩形大小与每个汽车厂商的汽车数量成比例。

# 首先，我们计算 manufacturer 变量的每个水平的频数①。
# 得到的数据传递到 ggplot2 以创建图形②。
# 在函数 aes() 中，fill 是分类变量，area 是每个水平的数量，label 是选项变量，用于添加单元的标签。
# 函数 geom_treemap() 创建了树形图，函数 geom_treemap_text() 向每个单元添加标签。
# 函数 theme() 用来删去图例，图例是多余的，因为每个单元格都有标签。
