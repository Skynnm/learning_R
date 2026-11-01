# 重塑大脑

# 代码清单13-0-2：glm() 函数
# R中可通过 glm() 函数（还可用其他专门的函数）拟合广义线性模型。
# 它的形似与lm()类似，只是多了一些参数。该函数的基本形式为：
glm(formula, family = family(link = function), data =)
# 下表列出了概率分布（family）和相应默认的连接函数（function）

#                   glm() 的参数
# 分布族               默认的连接函数
# binomial             (link = "logit")
# gaussian             (link = "identity")
# gamma                (link = "inverse")
# inverse.gaussian     (link = "1/mu^2")
# poisson              (link = "log")
# quasi                (link = "identity", variance = "constant")
# quasibinomial        (link = "logit")
# quasipoisson         (link = "log")

# glm() 函数可以拟合许多流行的模型，比如 Logistic 回归、泊松回归 和 生存分析（此处不考虑最后一个模型）
# 下面对前两个模型进行阐述。
# 假设有1个因变量（Y）、3个自变量（X1、X2、X3）和一个包含数据的数据框（mydata）

# Logistic 回归适用于二值因变量（0和1）。模型假设Y服从二项分布，线性模型的拟合形式为：
loge(Π/(1-Π)) = β0 + Σj=1 p βjXJ  # 此处Π是概率的符号
# 其中，Π = μY是Y的条件均值（给定一系列X的值时Y=1的概率），（Π/1-Π）为Y=1时的优势比，
# loge(Π/(1-Π))为对数优势比，或logit.
# 本例中，loge(Π/(1-Π))为连接函数，概率分布为二项分布，可用如下代码拟合 Logistic 回归模型：
glm(Y ~ X1 + X2 + X3, family = binomial(link = "logit"), data = mydata)
# Logistic 回归在13.2节有更详细的介绍


# 泊松回归适用于在给定时间内因变量为事件发生数目的情形。它假设Y服从泊松分布，线性模型的拟合形式为：
loge(λ) = β0 + Σjj=1 p βjXj
# 其中λ是Y的均值（也等于方差）。此时，连接函数为log(λ)，概率分布为泊松分布，可用如下代码拟合泊松回归模型：
glm(Y ~ X1 + X2 + X3, family = poisson(link = "log"), data = mydata)
# 泊松回归在13.3节有介绍


# 值得注意的是，标准线性模型也是广义线性模型的一个特例。
# 如果令连接函数g(μY) = μY 或 恒等函数，并设定概率分布为正太（高斯）分布，那么：
glm(Y ~ X1 + X2 + X3, family = gaussian(link = "identity"), data = mydata)
# 生成的结果与下列代码的结果相同；
lm(Y ~ X1 + X2 +X3, data = mydata)
# 总之，广义线性模型通过拟合因变量的条件均值的一个函数（不是因变量的条件均值），
# 假设因变量服从指数分布族中的某个分布（并不仅限于正太分布），极大地扩展了标准线性模型。
# 模型参数估计的推导依据是极大似然估计，而非最小二乘法
