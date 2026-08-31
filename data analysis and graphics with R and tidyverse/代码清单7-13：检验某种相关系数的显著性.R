# 独立性检验 + 相关性度量
# 相关系数   + 显著性检验

# 代码清单7-13：检验某种相关系数的显著性
# 在计算好相关系数以后，如何对它们进行统计显著性检验呢？常用的原假设为变量间不相关（总体的相关系数为0）
# 我们可以使用 cor.test() 函数对单个的 Pearson、Spearman 和 Kendall 相关系数 以及二分变量之间的四分相关系数进行检验。
# 简化后的使用格式为：
cor.test(x, y, alternative =, method =)
# 其中，x 和 y为要检验相关性的变量，alternative 则用来指定进行双侧检验或单侧检验（取值为“two.side”、“less”或“greater”）
# 而method用以指定要计算的相关类型（“pearson”、“kendall”或“spearman”）
# 当研究的假设为总体的相关系数小于0时，请使用 alternative = "less"
# 在研究的假设为总体的相关系数大于0时，应使用 alternative = "greater"
# 在默认情况下，假设为 alternative = "two.side"（总体的相关系数不等于0）
cor.test(states[, 3], states[, 5])
#          Pearson's product-moment correlation
#
#data:  states[, 3] and states[, 5]
#t = 6.8479, df = 48, p-value = 1.258e-08
#alternative hypothesis: true correlation is not equal to 0
#95 percent confidence interval:
# 0.5279280 0.8207295
#sample estimates:
#      cor 
#0.7029752 

# 这段代码检验了预期寿命和谋杀率的 Pearson 相关系数为0的原假设。
# 假设总体的相关度为0，则预计在一千万次中只会有少于一次的机会见到0.703这样大的样本相关度（即p = 1.258e-08）
# 因为这种情况几乎不可能发生，所以我们可以拒绝原假设，从而支持了要研究的猜想，即预期寿命和谋杀率之间的总体相关度不为0。

# 遗憾的是，cor.test() 每次只能检验一种相关系数。
# 但幸运的是，psych包中提供的 corr.test() 函数可以一次做更多事情。
# corr.test() 函数可以使用 Pearson、Spearman 或 Kendall 方法计算样本的相关系数矩阵和显著性水平。