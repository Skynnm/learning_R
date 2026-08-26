# 核密度图用于比较组间差异

# 代码清单6-9：核密度图的比较
# 【核密度可用于比较组间差异】
# 在本例中我们将比较 2008年四缸车、六缸车 和 八缸车的每加仑汽油行驶英里数估计值。五缸车很少，所以我们在分析中删除了五缸车的数据。
data(mpg, package = "ggplot2")                                              # ①准备数据
cars2008 <- mpg[mpg$year == 2008 & mpg$cyl != 5, ]                          # ①准备数据
cars2008$Cylinders <- factor(cars2008$cyl)                                  # ①准备数据

ggplot(cars2008, aes(x = cty, color = Cylinders, linetype = Cylinders)) +   # ②绘制核密度曲线
  geom_density(size = 1) +                                                  # ②绘制核密度曲线
  labs(title = "Fuel Efficiecy by Number of Cylinders",                     # ②绘制核密度曲线
       x = "City Miles per Gallon")                                         # ②绘制核密度曲线

ggplot(cars2008, aes(x = cty, fill = Cylinders)) +                          # ③绘制填充核密度曲线
  geom_density(alpha = .4) +                                                # ③绘制填充核密度曲线
  labs(title = "Fuel Efficiecy by Number of Cylinders",                     # ③绘制填充核密度曲线
       x = "City Miles per Gallon")                                         # ③绘制填充核密度曲线

# 首先，载入数据的新剧本，保留 2008年四缸、六缸 和 八缸 的汽车数据①。
# 气缸数（cyl）保存为类别型因子（Cylinders）
# ggplot2希望分组变量是类别型的（cyl存储为连续型变量），因此，进行相应的转换是有必要的

# 我们对变量 Cylinders 的每个水平绘制核密度曲线②。颜色（红、绿、蓝）和线条类型（实线、点线、虚线）都映射到气缸数。
# 最后，生成和前一幅相同的图形，它的曲线为填充曲线③
# 因为填充曲线是重叠的，所以添加了透明度（alpha = 0.4），这样我们才能看见每条曲线。

# 重叠核密度图不失为一种在某个结果变量上跨组比较观测值的强大方法。
# 从上面的图中我们可以看到不同组的分布情况，以及不同组之间的重叠程度。（这个例子的寓意是我下一辆车将是四缸的或电动的）

#### 在灰阶模式下输出图形 ####
# ggplot2 包默认的图形配色在灰阶模式下可能很难区分。把上图打印到纸质书上的时候就会遇到这个问题。
# 需要输出灰阶图时，我们可以在代码中使用函数 scale_fill_grey() 以及函数 scale_color_grey()，这种配色方案能很好地适配黑白打印的情况；
# 我们还可以使用sp包里的函数byp.colors()来设置绘图颜色，这个函数所使用的蓝粉黄配色方案在彩色打印机和黑色打印机上都有很好的输出效果。当然了，首先我们得喜欢这种配色。
