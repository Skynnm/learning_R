# 【之前是定性（是否独立），现在是定量（相关性强弱）】

# 代码清单7-11：二维列联表的相关性度量
# 显著性检验评估了是否存在充分的证据以拒绝变量间相互独立的原假设。
# 【如果可以拒绝原假设，那么我们的兴趣就会自然而然地转向用以衡量相关性强弱的相关性度量】
# vcd包中的assocstats()函数可以用来计算二维列联表的phi系数、列联系数 和 Cramer’s V系数
library(vcd)
mytable <- xtabs(~ Treatment + Improved, data = Arthritis)
mytable
#             Improved
#Treatment None Some Marked
#Placebo   29    7      7
#Treated   13    7     21

assocstats(mytable)
#                     X^2 df  P(> X^2)
#Likelihood Ratio 13.530  2 0.0011536
#Pearson          13.055  2 0.0014626
#
#Phi-Coefficient   : NA                 phi系数
#Contingency Coeff.: 0.367              列联系数
#Cramer's V        : 0.394              Cramer's V系数

# 总体来说，较大的值意味着较强的相关性。vcd包提供了一个 kappa() 函数，可以计算混淆矩阵的 Cohen's kappa 值以及加权的kappa值。
# （举例来说，混肴矩阵可以表示两位评判者对一系列对象进行分类所得结果的一致程度。）
