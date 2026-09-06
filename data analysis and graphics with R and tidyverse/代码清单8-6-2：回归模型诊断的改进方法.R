# 计算机模型的七层架构

# 代码清单8-6-2：回归模型诊断的改进方法
# car包提供了大量函数，大大增强了拟合和评估回归模型的能力

#                （car包中的）回归诊断实用函数
#  函数                         用途
#  qqplot()                     分位数比较图
#  durbinWatsonTest()           对误差自相关性做Durbin-Watson检验
#  crPlots()                    成分与残差图
#  ncvTest()                    对非恒定的误差方差做得分检验
#  spreadLevelPlot()            分散水平图
#  outlierTest()                Bonferroni离群点点检验
#  avPlots()                    添加的变量图形
#  influencePlot()              回归影响图
#  vif()                        方差膨胀因子

# 我们把这些函数应用到之前的多元回归例子中，并逐个探讨

#### 正态性 ####
# 与基础包中的 plot() 函数相比，qqplot() 提供了更为精确的正太假设检验方法，它绘制出了在 n-p-1 个自由度的t分布下的学生化残差（studentized residual，也称学生化删除残差 或 折叠化残差）图形，其中 n 是样本量，p是回归参数的数目（包括截距项）。代码如下：
library(car)
states <- as.data.frame(state.x77[, c("Murder", "Population",
                                      "Illiteracy", "Income", "Frost")])
fit <- lm(Murder ~ Population + Illiteracy + Income + Frost, data = states)
qqPlot(fit, labels = row.names(states), id = list(method = "identify"),
       simulate = TRUE, main = "Q-Q Plot")

# qqPlot() 函数生成的概率图见：学生化残差的Q-Q图
# id = list(method = "identify")选项能够交互式绘图——待图形绘制后，用鼠标单击图形内的点，将会标注函数中 labels 选项的设定值。
# 按 “Esc” 键，或者单击图形右上角的 Finish 按钮，都将关闭这种交互模式。
# 此处，我已经识别出了 Nevada 异常点。
# 当 simulate = TRUE 时，95% 的置信区间将会用参数自助法（自助法参加第12章）生成。

# 除了 Nevada，所有的点都离直线很近，并都落在置信区间内，这表明正态性假设符合得很好。
# 但是，我们也必须关注 Nevada，它有一个很大的正残差值（真实值-预测值），表明模型低估了该州的谋杀率。代码具体如下：
states["Nevada",]
#       Murder Population Illiteracy Income Frost
#Nevada   11.5        590        0.5   5149   188

fitted(fit)["Nevada"]
#Nevada 
#3.878958 

residuals(fit)["Nevada"]
#Nevada 
#7.621042 

rstudent(fit)["Nevada"]
#Nevada 
#3.542929

# 可用看到，Nevada 的谋杀率是11.5%，而模型预测的谋杀率约为3.9%。
# 你应该会提出这样的问题：“为什么 Nevada 的谋杀率会比根据人口、收入、文盲率 和 结霜天数预测所得的谋杀率高呢？”



#### 误差的独立性 ####
# 之前的章节提过，判断因变量值（或残差）是否相互独立，最好的方法就是依据收集数据方式的【先验知识】。
# 例如，【时间序列数据通常呈现自相关性】——相隔时间越近的观测值相关性大于相隔远的观测值。
# car包提供了一个可做 Durbin-Watson 检验的函数，能够检测误差的序列相关性。
# 在多元回归中，使用下面的代码可以做 Durbin-Watson 检验：
durbinWatsonTest(fit)
#lag Autocorrelation D-W Statistic p-value
#1      -0.2006929      2.317691   0.234
#Alternative hypothesis: rho != 0

# p值不显著（p = 0.282）说明没有自相关性，误差项 之间独立。
# 滞后项（lag = 1）表明数据集中每个数据都是与其后一个数据进行比较的。
# 该检验适用于时间独立的数据，对于非聚集型的数据并不适用。
# 注意，durbinWatsonTest() 函数使用自助法（参见第12章）来导出p值
# 如果添加了选项 simulate = TRUE，则每次运行测试时获得的结果都将略有不同。



#### 线性 ####
# 通过成分残差图（component plus residual plot）也称偏残差图（partial residual plot），我们可以看看因变量与自变量之间是否呈非线性关系，也可以看看是否有不同于已设定线性模型的系统偏差，图形可用car包中的crPlots()函数绘制
# 创建变量k的成分残差图，需要绘制点：
εi + β(hat)i x Xik vs. Xik
# 其中残差项εi是基于完全模型的（包含所有自变量），i=1...n。
# 每幅图都会绘出由εi + β(hat)i x Xik vs. Xik得出的直线。
# 每幅图都有平滑拟合非参数曲线（loess）（第11章将介绍此曲线）
# 生成这些图形的代码如下：
library(car)
crPlots(fit)
# 结果生成了：谋杀率对州各因素回归的成分残差图
# 若图形存在非线性，则说明我们可能对自变量的函数形式建模不够充分，那么就需要添加一些曲线成分，比多项式项，或对一个或多个变量进行变换（如用 log(x) 代替 x），或用其他回归变体形式而不是线性回归。本章稍后会介绍变量变换。
# 从图中可以看出，成分残差图证实了我们的线性假设，线性模型形式对该数据集看似是合适的。



#### 同方差性 ####
# car包还提供了两个有用的函数，可以判断误差方差是否恒定不变。
# ncvTest() 函数生成一个计分检验，零假设为误差方差不变，备择假设为误差方差随着拟合值水平的变化而变化
# 若检验显著，则说明存在异方差性（误差方差不恒定）

# spreadLevelPlot() 函数创建一个添加了最佳拟合曲线的散点图，展示标准化残差绝对值与拟合值的关系
library(car)
ncvTest(fit)
#Non-constant Variance Score Test 
#Variance formula: ~ fitted.values 
#Chisquare = 1.746514, Df = 1, p = 0.18632

spreadLevelPlot(fit)
# Suggested power transformation:  1.209626 

# 可以看到，计分检验不显著（p = 0.19），说明满足同方差性假设。
# 我们还可以通过分布水平图看到这一点，其中的点在水平的最佳拟合曲线周围呈水平随机分布。
# 若违反了该假设，我们将会看到一个非水平的曲线。
# 代码清单8-6建议幂次变化（suggested power transformation）的含义是，经过p次幂（Y^p）变换，非恒定的误差方差将会平稳。
# 例如，若图形显示出了非水平趋势，建议幂次转换为0.5，在回归方程中用Y^1/2代替Y，可能会使模型满足同方差性
# 若建议幂次为0，则使用对数变换。
# 对于当前例子，异方差性很不明显，因此建议幂次接近1（ 不需要进行变换）