# 无视中断（断头今日意如何，创业艰难百战多）

# 代码清单9-9：检验多元正太性
# 单因素多元方差分析有两个前提假设，一个是多元正态性，一个是方差-协方差矩阵同质性。
# 第一个假设即指因变量组合成的向量服从一个多元正太分布。
# 可以用Q-Q图来检验该假设条件（参见“理论补充”对其工作原理的统计解释）

#### 理论补充 ####
# 若有一个 p X 1的多元正太随机向量 x，均值为 μ，协方差矩阵为Σ，那么 x 与 μ的马氏距离的平方服从自由度为 p 的卡方分布。
# Q-Q图展示卡方分布的分位数，横纵坐标分别是样本量与马氏距离平方值。
# 如果点全部落在斜率为1、截距项为0的直线上，则表明数据服从多元正太分布。
data(UScereal, package = "MASS")
shelf <- factor(UScereal$shelf)
shelf <- factor(shelf)
y <- cbind(UScereal$calories, UScereal$fat, UScereal$sugars)
colnames(y) <- c("calories", "fat", "sugars")

center <- colMeans(y)
n <- nrow(y)
p <- ncol(y)
cov <- cov(y)
d <- mahalanobis(y, center, cov)
coord <- qqplot(qchisq(ppoints(n), df = p),
                d, main = "Q-Q Plot Assessing Multivariate Normality",
                ylab = "Mahalanobis D2")
abline(a = 1, b = 1)
identify(coord$x, coord$y, labels = row.names(UScereal))           # 交互性地对图中的点进行标注

# 上述代码生成了：检验多元正态性的Q-Q图
# 若数据服从多元正太分布，那么点将落在直线上。
# 我们可以通过 identify() 函数交互性地对图中的点进行标注。
# 单击每个感兴趣的点，然后按“Esc”键或者 Finish 按钮。
# 从图形上看，观测点“Wheaties Honey Gold” 和 “Wheaties” 异常，数据集似乎违反了多元正态性。
# 我们可以删除这两个点再重新分析。

# 方差-协方差矩阵同质性指各组的协方差矩阵相同，我们通常可以用 Box's M检验来评估该假设。
# 由于R中没有 Box's M 函数，我们可以通过网络收缩到合适的代码。
# 不过，该检验对正态性假设很敏感，会导致在大部分案例中直接拒绝同质性假设。
# 也就是说，对于这个重要假设的检验，我们目前还没有一个好方法。

# 最后，我们还可以使用 mvoutlier 包中的 aq.plot() 函数来检验多元离群点。
library(mvoutlier)
outliers <- aq.plot(y)
outliers