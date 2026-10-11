# 无视debuff

# 代码清单10-0-4：用pwr包做功效分析-方差分析
# pwr.anova.test() 函数可以对平衡单因素方差分析进行功效分析。格式如下：
pwr.anova.test(k =, n =, f =, sig.level = , power = )
# 其中，k是组的个数，n是组中的样本量
# 对于单因素方差分析，效应值可通过f来衡量：
# f=\textit{\sqrt{\textit{\frac{\textit{\sum\limits^k_{t−1}{pix(μ1−μ)^2}}}{σ^2}}}}
# 其中，pi  = ni/N
#       ni  = 组i的观测值数目
#       N   = 总观测值数目
#       μi  = 组i的均值
#       μ   = 总体均值
#       σ^2 = 组内方差误差

# 让我们举例说明函数用法。
# 我们现对5个组做单因素方差分析，要达到0.8的功效，效应值为0.25，并选择0.05的显著性水平，计算各组需要的样本量。代码如下：
pwr.anova.test(k = 5, f = .25, sig.level = .05, power = .8)
#Balanced one-way analysis of variance power calculation 
#
#k = 5
#n = 39.1534
#f = 0.25
#sig.level = 0.05
#power = 0.8
#
#NOTE: n is number in each group

# 结果表明，总样本量为 5 x 39，即195.
# 注意，本例中需要估计在同方差时5个组的均值。
# 如果我们对上述情况一无所知，10.2.7节提供的方法可能会有所帮助
