# Pearson 近似卡方：大样本、理论频数够（≥5）
# Fihser精确检验：样本小、期望频数低
# Cochran-Mantel-Haenszel：需要控制混杂因素

# 代码清单7-10-1：Fisher 精确检验
# 可以使用 fisher.test() 函数进行FFisher 精确检验。
# Fisher 精确检验的原假设是：边际函数的列联表中行和列是相互独立的，其调用格式为 fisher.test(mytable)，其中mytable是一个二维列联表。
mytable <- xtabs(~ Treatment + Improved, data = Arthritis)
mytable
#Improved
#Treatment None Some Marked
#Placebo   29    7      7
#Treated   13    7     21

fisher.test(mytable)
#      Fisher's Exact Test for Count Data
#
#data:  mytable
#p-value = 0.001393
#alternative hypothesis: two.sided

# 与许多统计软件不同的是，这里的 fisher.test() 函数可以在任意行列数大于等于 2 的二维列联表上使用，而不仅仅用于 2x2 的列联表
