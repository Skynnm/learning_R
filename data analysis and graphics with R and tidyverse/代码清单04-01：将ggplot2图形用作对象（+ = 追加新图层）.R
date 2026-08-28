# 绘图的目标是在准确传递信息的前提下创建尽可能简洁的图形

# 代码清单4-1：将ggplot2图形用作对象（+ = 追加新图层）
# ggplot图形可以被保存为被命名的R对象（列表型数据）。
# 经过进一步操作，它被打印出来或者保存到磁盘中。我们来看看代码清单4-1中的代码。
data(CPS85, package = "mosaicData")                        # ①准备数据
CPS85_new2 <- CPS85[CPS85$wage < 40, ]                     # ①准备数据

myplot <- ggplot(data = CPS85,                             # ②创建一张散点图，并保存为myplot
                 aes(x = exper, y = wage)) +               # ②创建一张散点图，并保存为myplot
  geom_point()                                             # ②创建一张散点图，并保存为myplot

myplot                                                     # ③显示myplot

myplot2 <- myplot + geom_point(size = 3, color = "blue")   # ④修改数据点的大小，使其变大一些，同时设置数据点为蓝色，将其保存为myplot2，并显示该图形
myplot2                                                    # ④修改数据点的大小，使其变大一些，同时设置数据点为蓝色，将其保存为myplot2，并显示该图形

myplot + geom_smooth(method = "lm") +                      # ⑤显示myplot并配以最佳拟合线及标题
  labs(title = "Midly interesting graph")                  # ⑤显示myplot并配以最佳拟合线及标题

# 首先，导入数据并删除异常值。然后，创建一个简单的工作年限和薪资的散点图并将其保存为myplot。接下来，打印这张图。然后修改这张图的点大小和颜色，并将其保存为myplot2，并打印出来。最后，在原图中增加最佳拟合线和标题，并打印出来。请注意，最后一步的所有修改均未保存。
# 将图形用作对象的功能可以让我们继续操作并修改这些图形。可以起到实时保存的作用（还能预防鼠标手）
# 正如我们所看到的，用编程的方法保存图形十分方便。
