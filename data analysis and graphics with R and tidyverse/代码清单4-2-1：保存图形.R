# ggplot()对象存储所有图层、坐标轴、主题，是绘图脚本，不是图片。

# 代码清单4-2-1：保存图形
# 我们可以通过 RStudio GUI 或者代码来保存由 ggplot2 创建的图形。
# 如果使用 RStudio 上的菜单保存图形，请转至 Plots（图形）选项卡并选择Expot（导出）

# 我们可以使用函数 ggsave() 保存图形，它可以指定要保存的图形，以及要保存的图形的大小、格式 和 保存路径。我们以下面的代码为例：
ggsave(file = "mygrahp.png", plot = myplot, width = 5, height = 4)
# 执行上面的代码后，可在当前工作路径下将myplot保存为名为mygraph.png的PNG格式的图片，其尺寸为5英寸 x 4英寸。
# 我们可以通过更改文件扩展名将图形保存为不同的格式。下表列出了最常见的格式：
#       扩展名             格式
#       pdf                便携式文档格式
#       jpeg               JPE
#       tiff               带标记的图片文件格式
#       png                便携式网络图片
#       svg                可伸缩式向量图
#       wmf                Windows元文件

# pdf、svg 和 wmf 格式为向量格式——这些格式的文件在调整大小时不会出现图片模糊或者有锯齿的情况。
# 其他格式为位图格式，调整文件大小时图片会出现锯齿。当把小图片变大时要特别注意。
# 用于网页的图片最常用的格式是png格式。
# jpeg 和 tiff 格式通常用于存储照片。

# 对于在 Microsoft Word 或 PowerPoint 文档中显示的图片，我们通常推荐使用 wmf 格式。
# MS Office不支持 pdf 或 svg格式，wmf格式的图片可以很好地调整大小。但是wmf文件会丢失已经指定的透明度设置。

# 如果我们忽略plot=选项，最近创建的图形会被保存。以下代码将图形的pdf文档格式保存到了磁盘：
ggplot(data = mtcars, aes(x = mpg)) + geom_histogram()
ggsave(file = "mygraph.pdf")

# 更多详情，请参阅 help(ggsave)
