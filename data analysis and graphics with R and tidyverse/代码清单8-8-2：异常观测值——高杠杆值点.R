# 无视中断

# 代码清单8-8-2：异常观测值——高杠杆值点
# 高杠杆值观测点，即与其他自变量有关的离群点。换句话说，它们是由许多异常的自变量值组合起来的，与因变量值没有关系

# 高杠杆值的观测点可通过帽子统计量（hat statistic）判断。
# 对于一个给定的数据集，帽子均值为 p/n，其中p是模型估计的参数数目（包含截距项），n是样本量
# 一般来说，若观测点的帽子值大于帽子均值的2倍或3倍，就可以判定为高杠杆值点。
# 下面的代码绘制出了帽子值的分布：

hat.plot <- function(fit) {
  p <- length(coefficients(fit))
  n <- length(fitted(fit))
  plot(hatvalues(fit), main = "Index Plot of Hat Values")
  abline(h = c(2, 3)*p/n, col = "red", lty = 2)
  identify(1:n, hatvalues(fit), names(hatvalues(fit)))
}

states <- as.data.frame(state.x77[,c("Murder", "Population", 
                                     "Illiteracy", "Income","Frost")])
fit <- lm(Murder ~ Population + Illiteracy + Income + Frost, data = states)

hat.plot(fit)
# 代码生成了：用帽子值来判定高杠杆值点

# 水平线标注的即帽子均值2倍和3倍的位置。
# 定位函数（locator function）能以交互模式绘图：单击感兴趣的点，然后进行标注，停止交互时，用户可按“Esc”键退出，或单击图形右上角的Finish按钮

# 此图中，可以看到 Alaska 和 California 非常异常，查看它们的自变量值，并与其他 48 个州进行比较发现：Alaska 的收入比其他州高得多，但其人口少、温度低；California 的人口比其他州多得多，但其收入和温度也很高

# 高杠杆值点可能是强影响点，也可能不是，这要看它们是否是离群点