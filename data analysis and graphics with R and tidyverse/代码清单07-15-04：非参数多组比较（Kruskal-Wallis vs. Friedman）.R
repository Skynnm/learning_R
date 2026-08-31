# 当t检验的假设合理时，参数检验的功效更强（更容易发现存在的差异）
# 而非参数检验在假设非常不合理时（如对于等级有序数据）更适用

# 代码清单7-15-4：非参数多组比较（Kruskal-Wallis vs. Friedman）
# 在要比较的组数多于两个时，必须转而寻求其他方法。可以看看7.3节中的state.x77数据集，它包含了美国各州的人口、收入、文盲率、预期寿命、谋杀率和高中毕业率数据。
# 如果我们想比较美国4个地区（东北部、南部、中北部 和 西部）的文盲率，应该怎么做呢？
# 这称为单向设计（one-way design），我们可以适用参数或非参数的方法来解决这个问题。

# 如果无法满足 ANOVA 设计的假设，那么可以适用非参数方法来评估组间的差异
# 【如果各组独立，则 Kruskal-Wallis 检验将是一种实用的方法】
# 【如果各组不独立（如重复测量设计或随机区组设计），那么 Friedman检验会更合适】

# Kruskal-Wallis检验的调用格式为：
kruskal.test(y ~ A, data)
#  其中的y是一个数值型结果变量，A是一个拥有两个或更多水平的分组变量（grouping variable）。若有两个水平，则它与 Mann-Whiteny U检验等价

# Friedman检验的格式为：
friedman.test(y ~ A | B, data)
# 其中的y是数值型结果变量，A是一个分组变量，而B是一个用以认定匹配观测值的区组变量（blocking variable）。在以上两例中，data皆为可选参数，它指定了包含这些变量的矩阵或数据框。


# 让我们利用 Kruskall-Wallis 检验回答文盲率的问题。首先，我们必须将地区的名称添加到数据集中。这些信息包含在随R基础安装分发的 state.region 数据集中
states <- data.frame(state.region, state.x77)
# 现在就可以开始检验了
kruskal.test(Illiteracy ~ state.region, data = states)
#                  Kruskal-Wallis rank sum test
#
#data:  Illiteracy by state.region
#Kruskal-Wallis chi-squared = 22.672, df = 3, p-value = 4.726e-05

# 显著性检验的结果意味着美国4个地区的文盲率各不相同（p < 0.001）
# 虽然我们可以拒绝不存在差异的原假设，但这个检验并没有告诉我们哪些地区与其他地区相比有显著不同。
# 要回答这个问题，我们可以使用 Wilconxon 检验每次比较两组数据。

# 一种更为优雅的方法是在控制犯第一类错误的概率（发现一个事实上并不存在的差异的概率）的前提下，执行可以同步进行的多组比较，这样可以直接完成所有组之间的成对比较
# 我写的函数 wmc() 可以实现这一目的，它每次用 Wilcoxon 检验比较两组数据，并通过p.adj()函数调整概率值

source("http://mp.ituring.com.cn/files/RiA3/rfiles/wmc.R")                   # ①获取函数
states <- data.frame(state.region, state.x77)
wmc(Illiteracy ~ state.region, data = states, method = "holm")               
#Descriptive Statistics                                                      # ②基本统计量
#
#West North Central Northeast    South
#n      13.00000      12.00000   9.00000 16.00000
#median  0.60000       0.70000   1.10000  1.75000
#mad     0.14826       0.14826   0.29652  0.59304
#
#Multiple Comparisons (Wilcoxon Rank Sum Tests)                              # ③成组比较
#Probability Adjustment = holm
#
#Group.1       Group.2    W            p    
#1          West North Central 88.0 8.665618e-01    
#2          West     Northeast 46.5 8.665618e-01    
#3          West         South 39.0 1.788186e-02   *
#4 North Central     Northeast 20.5 5.359707e-02   .
#5 North Central         South  2.0 8.051509e-05 ***
#6     Northeast         South 18.0 1.187644e-02   *
#  ---
#  Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1


# source() 函数下载并执行了定义wmc()函数的R脚本①
# 函数的形式是wmc(y ~ A, data, method)，其中y是数值输出变量，A是分组变量，data是包含这些变量的数据框，method指定限制I类误差的方法。
# 上述代码使用的是基于Holm(1979)提出的调整方法，它可以很大程度地控制总体I类误差率（在一组成对比较重犯一次或多次I类错误的概率）
# 参阅help(p.adjust)以查看其他可供选择的方法。

# wmc()函数首先给出了样本量、样本中位数、每组的绝对中位差②。
# 其中，西部地区（west）的文盲率较低，南部地区（South）文盲率最高。
# 然后，函数生成了6组统计比较（西部与中北部、西部与东北部、西部与南部、中北部与东北部、中北部与南部、东北部与南部）③
# 可以从双侧p值看到，南部与其他3个区域有明显差别，但当显著性水平p<0.05时，其他3个区域间并没有统计显著的差别。
