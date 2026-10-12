# 功效分析通常是一个需要多次尝试的迭代式过程

# 代码清单10-0-5：用pwr包做功效分析-相关性
# pwr.r.test()函数可以对相关系数检验进行功效分析。格式为：
pwr.r.test(n =, r =, sig.level =, power =, alternative =)
# 其中，n是观测值数目，r是效应值（通过线性相关系数衡量），sig.level是显著性水平，power是功效水平，alternative指定显著性检验是双侧检验（“two.sided”）还是单侧检验（“less”或“greater”）
# 假定正在研究抑郁与孤独的关系。我们的零假设和研究假设为：
# H0: ρ ≤ 0.25 和 H1: ρ ＞ 0.25
# 其中，ρ是两个心理变量的总体相关性大小。我们设定显著性水平为0.05，而且如果H0是错误的，我们想有90%的信心拒绝H0，那么研究需要多少观测值呢？下面的代码给出了答案：
pwr.r.test(r = .25, sig.level = .05, power = .90, alternative = "greater")
#approximate correlation power calculation (arctangh transformation) 
#
#n = 133.2803
#r = 0.25
#sig.level = 0.05
#power = 0.9
#alternative = greater

# 因此，要满足以上要求，我们需要134个受试者来评价抑郁与孤独的关系，以便在零假设为假的情况下有90%的信心拒绝它