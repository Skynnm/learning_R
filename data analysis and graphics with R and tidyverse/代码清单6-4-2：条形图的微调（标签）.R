# 看代码、理解代码、思考代码的时间  多于  直接写代码的时间

# 代码清单6-4-2：条形图的微调（标签）
# 当数据条形图很多或者标签较长时，条形图的标签可能会重叠而影响阅读。请看下面的例子。
# ggplot2包里的数据集 mpg 描述了 1999 和 2008 年 38 种流行车型的燃油经济性数据。每种车型都有一些配置（变速器类型、气缸数量等）
# 比如，我们想要知道数据集种每种车型的数量，那么代码：
ggplot(mpg, aes(x = model)) +
  geom_bar() +
  labs(title = "Car models in the mpg dataset",
       y = "Frequency")
# 上述代码生成了：标签重叠的条形图

# 即使戴上眼镜（或者来一杯葡萄酒），我也读不了这些标签。两种简单的微调方法可以改善标签的可读性。
# 首先，我们可以将数据绘制成水平条形图：
ggplot(mpg, aes(x = model)) +
  geom_bar() +
  labs(title = "Car models in the mpg dataset",
       y = "Frequency", x = "") +
  coord_flip()    # 上述代码生成了：避免了标签重叠的水平条形图

# 其次，我们可以使标签文本倾斜并使用较小的字体：
ggplot(mpg, aes(x = model)) +
  geom_bar() +
  labs(title = "Model names in the mpg dataset",
       y = "Frequency", x = "") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 8))
# 上述代码生成了：标签倾斜、字体更小的条形图


# 第19章将详细讨论函数theme()，除了条形图，饼图也是一种用于展示分类变量分布的流行工具。