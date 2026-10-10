# 无视中断

# 代码清单10-0-3：用pwr包做功效分析-t检验
library(pwr)
# 对于t检验，pwr.t.test() 函数提供了许多有用的功效分析选项，格式为：
pwr.t.test(n =, d =, sig.level =, alternative = )
# 其中各选项的含义如下：
# 【】n为样本量
# 【】d为效应值，即标准化的均值之差
d = (μ1 - μ2) / σ # 其中，μ1 = 组1均差，μ2 = 组2均差，σ = 公共误差的方差
# 【】sig.level 表示显著性水平（默认为0.05）
# 【】power为功效水平
# 【】type指检验类型：双样本t检验（"two.sample"）、单样本t检验（“one.sample”）或用相依样本t检验（”paired“）。默认为双样本t检验。
# 【】alternative 指统计检验是双侧检验（”two.sided“）还是单侧检验（”one.sided“）。默认为双侧检验。

# 让我们举例说明函数的用法。我们仍继续10.1节中使用手机与驾驶反应时间的实验、假定将使用双尾独立样本t检验来比较两种情况下驾驶员的反应时间均值

# 如果我们根据过去的经验知道反应时间有1.25s的标准差，并认定反应时间1s的差值是巨大的差异，那么在这个研究中，可设定要检测的效应值为d = 1/1.25 = 0.8或者更大。
# 另外，如果差异存在，我们希望有90%的把握检测到它，由于随机变异性的存在，我们也希望有95%的把握不会误报差异显著。
# 这时，该研究需要多少受试者呢？
library(pwr)
pwr.t.test(d = .8, sig.level = .05, power = .9, type = "two.sample",
           alternative = "two.sided")
#Two-sample t test power calculation 
#
#n = 33.82555
#d = 0.8
#sig.level = 0.05
#power = 0.9
#alternative = two.sided
#
#NOTE: n is number in *each* group

# 结果表明，每组中我们需要34个受试者（总共68人），这样才能保证有90%的把握检测到0.8的效应值，并且最多5%的可能性会误报差异存在

# 现在变化一下这个问题。假定在比较这两种情况时，我们想检测到总体均值0.5个标准差的差异，并且将误报差异的概率限制在1%内。
# 此外，我们能获得的受试者只有40人。
# 那么在该研究中，我们能检测到这么大总体均值差异的概率是多少呢？
# 假定每种情况下受试者数目相同，可以进行如下操作：
pwr.t.test(n = 20, d = .5, sig.level = .01, type = "two.sample",
           alternative = "two.sided")
#Two-sample t test power calculation 
#
#n = 20
#d = 0.5
#sig.level = 0.01
#power = 0.1439551
#alternative = two.sided
#
#NOTE: n is number in *each* group

# 结果表明，在0.01的先验显著性水平下，每组20个受试者，因变量的标准差为1.25s，有低于14%的可能性断言差值为0.625s或者不显著（d = 0.5 = 0.625/1.25）
# 换句话说，我们将有86%的可能性错过要寻找的效应值。
# 因此，我们可能需要慎重考虑要投入到该研究中的时间和精力。

# 上面的例子都是假定两组中样本量相等，如果两组中样本量不同，可用函数：
pwr.t2n.test(n1 = , n2 = , d = , sig.level = , power =, alternative = )
# 此处，n1 和 n2是两组的样本量，其他参数含义与 pwt.t.test() 的相同。
# 我们可以尝试改变 pwr.t2n.test() 函数中的参数值，看看输出的效应值如何变化