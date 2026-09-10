# 无视中断，【模型预测精度】和【模型简洁度】的调和问题

# 代码清单8-9：用anova()函数比较嵌套模型
# 当尝试获取一个回归方程时，我们实际上就面对着从众多可能的模型中做选择的问题。
# 是不是所有的变量都要包括？
# 还是去掉哪个对预测贡献不显著的变量？
# 是否需要添加多项式项和/或交互项来提高拟合度？
# 最终回归模型的选择总是会涉及【预测精度（模型尽可能地拟合数据）】与【模型简洁度（一个简单且能复用的模型）】的调和问题
# 如果有两个几乎具备相同预测精度的模型，你肯定喜欢简单的哪个。
# 本节讨论的问题就是如何在候选模型中进行筛选。
# 注意，“最佳”是打了引号的，因为没有评价的唯一标准，最终的决定需要调查者的评判。

# 用基础安装中的anova()函数可以比较两个嵌套模型的拟合优度。
# 所谓嵌套模型，即它的回归方程的项完全包含在另一个模型中。
# 在states的多元回归模型中，我们发现 Income 和 Frost 的回归系数不显著，此时我们可以检验不含着两个变量的模型与包含这两项的模型的预测效果是否一样好
states <- as.data.frame(state.x77[, c("Murder", "Population",
                                      "Illiteracy", "Income", "Frost")])
fit1 <- lm(Murder ~ Population + Illiteracy + Income + Frost, data = states)
fit2 <- lm(Murder ~ Population + Illiteracy, data = states)
anova(fit2, fit1)
#Analysis of Variance Table
#
#Model 1: Murder ~ Population + Illiteracy
#Model 2: Murder ~ Population + Illiteracy + Income + Frost
#Res.Df    RSS Df Sum of Sq      F Pr(>F)
#1     47 289.25                           
#2     45 289.17  2  0.078505 0.0061 0.9939

# 此处，模型1嵌套在模型2中。anova() 函数同时还对是否应该在 Population 和 Illiteracy 之外还要添加 Income 和 Frost到线性模型中进行了检验。
# 由于检验不显著（p = 0.994），我们可以得出结论，不需要将这两个变量添加到线性模型中，可以将它们从模型中删除