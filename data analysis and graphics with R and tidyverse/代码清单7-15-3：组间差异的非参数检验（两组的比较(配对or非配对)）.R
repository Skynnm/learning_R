# 代码清单7-15-3：组间差异的非参数检验（两组的比较(配对/非配对)）
# 如果数据无法满足t检验或ANOVA的参数假设，可以转而使用非参数方法。
# 举例来说，如果结果变量在本质上就严重偏倚或呈现有序关系，那么我们可能会希望使用本节中的方法。

# 若两组数据独立，可以使用Wilcoxon秩和检验（更广为人知的名字是 Mann-Whitenet U检验）
# 来评估观测值是否是从相同的概率分布中抽得的，即在一个总体中获得更高得分的概率是否比另一个总体要大。
# 调用格式为：
wilcox.test(y ~ x, data)
# 其中的y是数值型变量，而x是一个二分变量。
# 调用格式或为：
wilcox.test(y1, y2)
# 其中的y1和y2为各组的结果变量。
# 可选参数data的取值为一个包含了这些变量的矩阵或数据框。
# 默认进行一个双侧检验。
# 我们可以添加参数 exact 来进行精确检验，指定 alternative = "less"或 alternative = "greater"进行有方向的检验

# 如果我们使用Mann-Whitney U检验回答7.4节中关于监禁率的问题，将得到这些结果：
with(UScrime, by(Prob, So, median))
#So: 0
#[1] 0.038201
#------------------------------------------------------------------ 
#So: 1
#[1] 0.055552

wilcox.test(Prob ~ So, data = UScrime)
#                Wilcoxon rank sum exact test
#
#data:  Prob by So
#W = 81, p-value = 8.488e-05
#alternative hypothesis: true location shift is not equal to 0

# 我们可以再次拒绝南方各州和非南方各州监禁率相同的假设（p＜0.001）



####
# Wilcoxon符号秩和检验是非独立样本t检验的一种非参数替代方法。
# 它适用于两组成本数据和无法保证正太分布假设的情境。调用格式与 Mann-Whiteney U检验完全相同，不过还可以添加参数 paired = TRUE。让我们用它来解答7.4节中的失业率的问题：
sapply(UScrime[c("U1","U2")], median)
#U1 U2 
#92 34

with(UScrime, wilcox.test(U1, U2, paired = TRUE))
#                Wilcoxon signed rank exact test
#
#data:  U1 and U2
#V = 1128, p-value = 1.421e-14
#alternative hypothesis: true location shift is not equal to 0

# 我们再次得到了与配对t检验相同的结论
# 在本例中，含参的t检验和与其作用相同的非参数检验得到了相同的结论。
# 【当t检验的假设合理时，参数检验的功效更强（更容易发现存在的差异）】
# 【而非参数检验在假设非常不合理时（如对于等级有序数据）更适用】