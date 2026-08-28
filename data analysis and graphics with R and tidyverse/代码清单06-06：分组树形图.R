# R 语言有两个最重要的组成部分：一个是对象，用来存储数据；另一个是函数，用来操作数据

# 代码清单6-6：分组树形图
# 正如我们看到的，树形图可以用来可视化具有许多水平的分类变量（这和饼图不一样）
# 在下面的示例中，我们添加了第2个变量——drivetrain，绘制了各汽车厂商生成的前轮驱动、后轮驱动 和 四轮驱动汽车的数量情况。
library(ggplot2)
library(dplyr)
library(treemapify)
plotdata <- mpg %>%                                                   # ①计算单元格计数
  count(manufacturer, drv)                                            # ①计算单元格计数
plotdata$drv <- factor(plotdata$drv,                                  # ②调整 drivetrain 的标签
                       levels = c("4", "f", "r"),                     # ②调整 drivetrain 的标签
                       labels = c("4-wheel", "front-wheel", "rear"))  # ②调整 drivetrain 的标签
ggplot(plotdata,                                                      # ③创建树形图
       aes(fill = manufacturer,                                       # ③创建树形图
           area = n,                                                  # ③创建树形图
           label = manufacturer,                                      # ③创建树形图
           subgroup = drv)) +                                         # ③创建树形图
  geom_treemap() +                                                    # ③创建树形图
  geom_treemap_subgroup_border() +                                    # ③创建树形图
  geom_treemap_subgroup_text(                                         # ③创建树形图
    place = "middle",                                                 # ③创建树形图
    colour = "black",                                                 # ③创建树形图
    alpha = 0.5,                                                      # ③创建树形图
    grow = FALSE) +                                                   # ③创建树形图
  geom_treemap_text(colour = "white",                                 # ③创建树形图
                    place = "centre",                                 # ③创建树形图
                    grow = FALSE) +                                   # ③创建树形图
  theme(legend.position = "none")                                     # ③创建树形图

# 首先，计算每个 manufacturer-drivetrain 组合的频数①。
# 接下来，调整变量 drivetrain 的标签②
# 新的数据框传递给 ggplot2 生成树形图③
# 函数 aes() 中的 subgroup 选项用于创建每个 drivetrain 的各自的分组图。
# geom_treemap_border() 和 geom_treemap_subgroup_text() 分别为分组图添加边框和标签。每个函数中的选项控制各个分组图的外观。
# 分组文本被居中放置，被指定透明度（alpha = 0.5）。文本字体大小保持不变，而不是增大并填充区域（grow = FALSE）。
# 这张树形图的单元格文本的颜色为白色字体，位于每个单元格中心，不会增大并填充区域。

# 上述代码生成了：按驱动类型划分的厂商分布树形图

# 从图中可以清楚地看到，Hyundai（现代）汽车有前驱车，但是没有后驱车和四驱车。
# 后驱车的厂商主要是Ford（福特）和Chevrolet（雪佛兰）。
# 许多四驱车是Dodge（道奇）制造的

# 至此，我们已经讨论了饼图和树形图，接下来我们看看直方图。与条形图、饼图 和 树形图 不同，直方图描述连续型变量的分布
