# 无视debuff（重视可以改进的反馈，但不要影响你的心气和决心）

# 代码清单8-8-3：异常观测值——强影响点
# 强影响点，即对模型参数估计值的影响有些比例失衡的点。
# 例如，若移除模型的一个观测点时模型会发生巨大的改变，那么我们就需要检测一下数据中是否存在强影响点了

# 有两种方法可以检测强影响点：
# ① Cook距离，或称D统计量
# ② 变量添加图（added variable plot）

# 一般来说，Cook's D 值大于4/(n-k-1)，则表明它是强影响点，其中n为样本量，k是自变量数目。
# 可通过如下代码绘制 Cook‘D 图
states <- as.data.frame(state.x77[,c("Murder", "Population", 
                                     "Illiteracy", "Income","Frost")])
fit <- lm(Murder ~ Population + Illiteracy + Income + Frost, data = states)


cutoff <- 4/(nrow(states) - length(fit$coefficients) - 2)

plot(fit, which = 4, cook.levels = cutoff)
abline(h = cutoff, lty = 2, col = "red")
# 代码生成了：识别强影响点的 Cook'D 图

# 通过图形可以判断 Alaska、Hawaii 和 Nevada 是强影响点。
# 若删除这些点，将会导致回归模型截距项和斜率发生显著变换。
# 注意，虽然该图对搜寻强影响点很有用，但我逐渐发现以1为分割点比4/(n-k-1)更具一般性。
# 若设定 D = 1为判别标准，则数据集中没有任何点看起来像是强影响点

# Cook'D 图有助于识别强影响点，但是并不提供关于这些点如何影响模型的信息。
# 变量添加图弥补了这个缺陷。对于一个因变量和k个自变量，我们可以如下图创建k个变量添加图

# 所谓变量添加图，即对于每个自变量Xk，绘制Xk在其他k-1个自变量上回归的残差值相对于因变量在其他k-1个自变量上回归的残差值的关系图。
# car包中的avPlots()函数可提供变量添加图：
library(car)
avPlots(fit, ask = FALSE, id = list(method = "identify"))
# 代码生成了：评估强影响点影响效果的变量添加图
# 图形一次生成一个，用户可以通过单击点来判断强影响点。
# 按下“Esc”键，或单击图形右上角的 Finish 按钮，便可移动到下一个图形


# 图形中的直线表示相应自变量的实际回归系数
# 我们可以想象删除某些强影响点后致谢的改变，以此来估计它的影响效果。
# 例如，来看左下角的图（“Murder|others” vs. "Income|others"），若删除点Alaska，直线将往负向移动。
# 事实上，删除Alaska，Income的回归系数将会从0.00006变为-0.00085

# 当然，利用car包中的influencePlot()函数，我们还可以将离群点、杠杆值 和 强影响点的信息整合到一副图形中
library(car)
influencePlot(fit, id = "noteworthy→TRUE", main = "Influence Plot",
              sub = "Circle size is proportional to Cook's distance")
# 代码生成了影响图。纵坐标超过+2或小于-2的州可被认为是离群点，水平轴超过0.2或0.3的州有高杠杆值（自变量值的异常组合）
# 圆圈大小与影响成比例，圆圈很大的点可能是对模型参数的估计造成的不成比例影响的强影响点

# 图反映出需要特别注意的几个观测点。Nevada 和 Rhole Island是离群点，Calironia 和 Hawaii有高杠杆值，Nevada和 Alaska为强影响点

# 入宫将 id = TRUE 替换为 id = list(method = "identity")，则我们通过单击鼠标来交互式识别观测点（按“Esc"键或者单击 Finish 按钮退出）
