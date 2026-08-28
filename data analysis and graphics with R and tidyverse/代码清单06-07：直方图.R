# 获取单个变量的分布信息；揭示两个变量间的基本关系

# 代码清单6-7：直方图
# 直方图通过在 x 轴上将值域分割为一定数量的数据桶，在 y 轴上显示了响应值的频数，展示了连续型变量的分布。
# 可以使用如下函数创建直方图：
ggplot(data, aes(x = countvar)) + geom_histogram()
# 其中 data 是一个数据框，countvar是一个连续型变量
# 使用ggplot包中的mpg数据框，我们可以分析2008年117个汽车配置的每加仑汽油行驶英里数的分布情况
# 代码清单6-7使用了4种方法绘制直方图：
library(ggplot2)
library(scales)

data(mpg)
cars2008 <- mpg[mpg$year == 2008, ]

ggplot(cars2008, aes(x = cty)) +                                          # ①简单的直方图
  geom_histogram() +                                                      # ①简单的直方图
  labs(title = "Default histogram")                                       # ①简单的直方图

ggplot(cars2008, aes(x = hwy)) +                                          # ②带有20个数据桶的彩色直方图
  geom_histogram(bins = 20, color = "white", fill = "steelblue") +        # ②带有20个数据桶的彩色直方图
  labs(title = "Colored histogram with 20 bins",                          # ②带有20个数据桶的彩色直方图
       x = "City Miles Per Gallon",                                       # ②带有20个数据桶的彩色直方图
       y = "Frequency")                                                   # ②带有20个数据桶的彩色直方图

ggplot(cars2008, aes(x = hwy, y = ..density..)) +                         # ③带有百分比的直方图
  geom_histogram(bins = 20, color = "white", fill = "steelblue") +        # ③带有百分比的直方图
  scale_y_continuous(labels = scales::percent) +                          # ③带有百分比的直方图
  labs(title = "Histogram with percentages",                              # ③带有百分比的直方图
       y = "Percent",                                                     # ③带有百分比的直方图
       x = "City Miles Per Gallon")                                       # ③带有百分比的直方图

ggplot(cars2008, aes(x = cty, y = ..density..)) +                         # ④带有核密度曲线的直方图
  geom_histogram(bins = 20, color = "white", fill = "steelblue") +        # ④带有核密度曲线的直方图
  scale_y_continuous(labels = scales::percent) +                          # ④带有核密度曲线的直方图
  geom_density(color = "red", size = 1) +                                 # ④带有核密度曲线的直方图
  labs(title = "Histogram with density curve",                            # ④带有核密度曲线的直方图
       y = "Percent",                                                     # ④带有核密度曲线的直方图
       x = "Highway Miles Per Gallon")                                    # ④带有核密度曲线的直方图

# 第1幅直方图①展示了未指定任何选项时的默认图形。在这幅图中共创建了30个数据桶。

# 在第2幅直方图中②，我们创建了20个数据桶，指定填充色未钢蓝色，边框为白色。
# 此外，添加了信息量更为丰富的标签。数据桶的数量会在很大程度上影响直方图的外观。
# 尝试调整 bins 选项的值直到找到一个可以较好地反映分布情况的值，这是一个不错的做法。
# 这 20个数据桶的分布似乎有两个峰值——一个在13mpg左右，另一个在20.5mpg左右。

# 第3幅直方图③将数据绘制为百分比而不是频数。这可以通过将内置变量 ..density.. 指定给y轴来实现。
# 使用 scales 包将y轴格式设为百分比。在运行此部分代码前请确保安装scales包（install.packages("scales")）

# 第4幅直方图④与前1幅图类似，只是添加了一条核密度曲线。核密度曲线时核密度估计值。
# 我们将在6.5节中对其进行详解。这个曲线更平滑地描述了得分的分布。
# 使用函数 geom_density() 将核密度曲线绘制成红色，曲线的宽度略大于默认的线条宽度。
# 此核密度曲线也显示的是双峰分布（两个峰值）
