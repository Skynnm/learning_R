# 列联表可以告诉我们组成表格的各种变量组合的频数或比例
# 不过我们可能还会对了列联表中的变量是否相关或独立感兴趣——独立性检验

# 代码清单7-10-0：卡方独立性检验
# R 提供了多种检验分类变量独立性的方法（即分类变量间的相关性）
# 本节中描述的3种检验方法分别为：卡方独立性检验、Fisher 精确检验 和 Cochran-Mantel-Haenszel 检验

# 我们可以使用 chisq.test() 函数对二维表的行变量和列变量进行卡方独立性检验
install.packages("vcd")
library(vcd)
mytable <- xtabs(~ Treatment + Improved, data = Arthritis)
mytable
#             Improved
#Treatment None Some Marked
#Placebo   29    7      7
#Treated   13    7     21

chisq.test(mytable)
#          Pearson's Chi-squared test
#
#data:  mytable
#X-squared = 13.055, df = 2, p-value = 0.001463              ①治疗方式（Treatment）和改善情况（improved）不相互独立

mytable <- xtabs(~ Improved + Sex, data = Arthritis)
chisq.test(mytable)

#             Pearson's Chi-squared test
#
#data:  mytable
#X-squared = 4.8407, df = 2, p-value = 0.08889               ②性别（Sex）和改善情况（improved）独立
#
#警告信息:
#In chisq.test(mytable) : Chi-squared近似算法有可能不准


# 在结果①种，患者接受的治疗和改善情况看上去存在某种关系（p < 0.01）
# 而患者性别和改善情况之间却不存在关系（p > 0.05）②
# 【这里的p值表示从从提种抽取的样本行变量与列变量是相互独立的概率】
# 因为①的概率值很小，所以我们拒绝了治疗类型和治疗结果相互独立的原假设
# 由于②的概率不够小，因此没有足够理由说明治疗结果和性别之间是不独立的。
# 代码7-10-0种产生警告信息的原因是，表中的6个单元格之一（男性-一定程度上的改善）有一个小于5的期望值，这可能会使卡方近似无效