# 自律带来自由

# 代码清单13-01-03：过度离势
# 抽样于二项分布的数据的期望方差是 σ^2 = nΠ(1-Π)，n为观测数，Π为属于 Y=1 组的概率。
# 所谓过度离势（overdispersion），是指观测到的因变量的方差大于期望的二项分布的方差。
# 过度离势会导致奇异的标准误检验和不精确的显著性检验

# 当出现过度离势时，仍可使用 glm() 函数拟合 Logistic 回归，但此时需要将二项分布改为准二项分布（quasibinominal distribution）
# 检测过度离势的一种方法是比较二项分布模型的残差偏差与残差自由度，如果比值：
Φ = 残差偏差 / 残差自由度
# 比1大很多，我们便可认为存在过度离势。回到感情危机的例子，可得：
deviance(fit.reduced) / df.residual(fit.reduced)
[1] 1.03248
# 它非常接近于1，表明没有过度离势

# 我们还可以对过度离势进行检验。
# 为此，我们需要拟合模型两次。
# 第1次使用 family = "binomial"，第2次使用 family = "quasibinomial"
# 假设第1次glm() 返回对象记为 fit，低2次返回对象记为fit.od，那么：
pchisq(summary(fit.od)$dispersion * fit$df.residual,
       fit$df.residual, lower = F)
# 提供的p值即可对零假设H0:Φ = 1 与备择假设H1:Φ ≠ 1进行检验。
# 若p很小（p ＜ 0.05），我们便可拒绝零假设。
# 我们将其应用到 Affairs 数据框，可得：
Affairs$ynaffairs <- ifelse(Affairs$affairs > 0, 1, 0)
Affairs$ynaffairs <- factor(Affairs$ynaffairs,
                            levels = c(0, 1),
                            labels = c("No", "Yes"))

fit <- glm(ynaffairs ~ age + yearsmarried + religiousness + 
             rating, family = binomial(), data = Affairs)
fit.od <- glm(ynaffairs ~ age + yearsmarried + religiousness + 
                rating, family = quasibinomial(), data = Affairs)
pchisq(summary(fit.od)$dispersion * fit$df.residual,
       fit$df.residual, lower = F)
#[1] 0.340122


# 此处p值（0.34）显然不显著（p＞0.05），这更增强了我们认为不存在过度离势的信心。
# 13.3节在介绍泊松回归时，我们还会对过度离势问题进行讨论。