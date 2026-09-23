# 数学是逻辑的语言

# 代码清单9-4：对用户定义的对照的多重比较
# 和上一节的单因素方差分析例子一样，剂量的F检验虽然表明了不同的处理方式幼崽的体重均值不同，
# 但无法告知我们哪种处理方式与其他方式不同。
# 同样，我们使用multcomp包来对所有均值进行成对比较。
# 另外，multcomp包还可以用来检验用户自定义的均值假设。

# 假定我们对未用药条件与其他3种用药条件的影响是否不同感兴趣，我们可以使用代码清单9-4来检验我们的假设
library(mult)
contrast <- rbind("no drug vs. drug" = c(3, -1, -1, -1))
summary(glht(fit, linfct = mcp(dose = contrast)))
#
#Simultaneous Tests for General Linear Hypotheses
#
#Multiple Comparisons of Means: User-defined Contrasts
#
#
#Fit: aov(formula = weight ~ gesttime + dose, data = litter)
#
#Linear Hypotheses:
#  Estimate Std. Error t value Pr(>|t|)  
#no drug vs. drug == 0    8.284      3.209   2.581    0.012 *
#  ---
#  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#(Adjusted p values reported -- single-step method)

# 对照列表c(3, -1, -1, -1)是指将第1组和其他3组的均值进行比较
# 具体而言，要检验的假设为：
# 3μ0 - 1μ5 - 1μ50 - 1μ500 = 0 【原假设】
# 或者：μ0 = (μ5 + μ50 + μ500)/3
# 其中μn为剂量n的平均幼崽出生体重。
# 假设检验的t统计量（2.581）在p < 0.05水平下显著，因此，可以得出未用药组比其他用药条件下的的出生体重高的结论。
# 也可以将其他对照列表添加到rbind()函数进行比较（详见help(glht)）
