# 离散程度 可衡量 均值/中位数 的可靠程度

# 代码清单6-4-1：条形图的微调（颜色）
# 有若干种方式可以微调条形图的外观。最常用的是自定义条形的颜色和标签。我们将逐个探讨每种方式

#### 条形图的颜色 ####
# 可以自定义条形区域和边框的颜色。在函数 geom_bar() 中，选项 fill = "color“ 指定了区域的颜色，而 color = "color"指定了边框的颜色

## 【fill 和 color的用法对比】 ##
# 通常情况下，ggplot2使用fill指定具有区域的几何对象（比如条形、扇形区、方格区）的颜色，使用color指定没有区域的几何对象（比如线、点 和 边框）的颜色。

# 例如代码
data(Arthritis, package = "vcd")
ggplot(Arthritis, aes(x = Improved)) +
  geom_bar(fill = "gold", color = "black") +
  labs(title = "Treatment Outcomes")
# 代码生成了：自定义填充颜色和边框颜色的条形图


# 在前面的示例中，代码指定的是单一的颜色。颜色也可以映射到分类变量的层级。例如，以下代码：
ggplot(Arthritis, aes(x = Treatment, fill = Improved)) +
  geom_bar(posiiton = "stack", color = "black") +
  scale_fill_manual(values = c("red", "grey", "gold")) +
  labs(title = "Stacked Bar chart",
       x = "Treatment",
       y = "Frequency")
# 代码生成了：映射到治疗效果的自定义区域颜色的堆积条形图

# 本例中，条形区域颜色映射到变量 Improved 的层级。
# 函数 scale_fill_manual() 指定治疗效果 None 为红色，Some 为灰色，Marked 为金色