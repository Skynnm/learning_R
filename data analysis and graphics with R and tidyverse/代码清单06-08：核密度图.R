# 看代码、理解代码的时间，远多于写代码的时间

# 代码清单6-8：核密度图
# 在6.4节中，我们看到了直方图上叠加的核密度图。
# 用术语来说，核密度估计是用于估计随机变量概率密度函数的一种非参数方法。
# 从本质上来说，我们试图画一个平滑的直方图，直方图曲线下面的面积为1.
# 虽然其数学细节已经超出了本书的范畴，单核密度图不失为一种用来观察连续型变量分布的有效方法。
# 核密度图的格式如下：
ggplot(data, aes(x = contvar)) + geom_density()
# 其中 data 是一个数据框，contvar 是一个连续型变量。
# 让我们再次绘制 2008年汽车的每加仑汽油行驶英里数分布图。下面的代码给出了3个核密度示例
library(ggplot2)
data(mpg)
cars2008 <- mpg[mpg$year == 2008, ]

ggplot(cars2008,aes(x = cty)) +                           # ①缺省的核密度图
  geom_density() +                                        # ①缺省的核密度图
  labs(title = "Default kernel density plot")             # ①缺省的核密度图

ggplot(cars2008,aes(x = cty)) +                           # ②填充核密度图
  geom_density(fill = "red") +                            # ②填充核密度图
  labs(title = "Filled kernel density plot",              # ②填充核密度图
       x = "City Miles Per Gallon")                       # ②填充核密度图

bw.nrd0(cars2008$cty)                                     # ③打印默认带宽
# [1] 1.4                                                 # ③打印默认带宽

ggplot(cars2008,aes(x = cty)) +                           # ④小带宽核密度图
  geom_density(fill = "red", bw = .5) +                   # ④小带宽核密度图
  labs(title = "Kernel density plot with bw=0.5",         # ④小带宽核密度图
       x = "City Miles Per Gallon")                       # ④小带宽核密度图

# 首先，绘制默认的核密度图①。在第2个例子中，曲线下面的区域被填充为红色。
# 曲线的平滑度由带宽参数控制，该参数的值使用要绘制的数据进行计算②。
# 代码 bw.nrd0(cars2008$cty) 显示这个值为1.408 ③
# 当带宽参数较大时，曲线会更平滑，且展示的细节更少。当带宽参数较小时，曲线会更粗糙。
# 第3个例子使用的是较小的带宽（bw = .5），这样我们可以观察到更多细节 ④
# 同调整直方图的 bins 参数一样，我们可以尝试不同的带宽值来观察哪个值可以最有效地可视化数据
