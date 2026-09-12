# 名词 + 动词 构成故事

# 代码清单8-13：R平方的k重交叉验证函数
# 深层次分析：模型泛化能力【交叉验证】 、 自变量相对重要性
# 在8.6节中，我么学习了为回归方程选择变量的方法。
# 若我们最初的目标只是描述性分析，那么只需要做回归模型的选择和解释
# 但当目标时预测时，我们肯定会问：”这个方程在真实世界中表现如何呢？”提这样的问题也是无可厚非的

# 从定义来看，回归方法本就是用来从一堆数据中获取最优的模型参数。
# 对于OLS回归，通过使得预测误差（残差）平方和最小和对因变量的解释度（R平方）最大，可获得模型参数
# 因为方程只是最优化给出的数据，所以在新数据集上表现并不一定好

# 在本章开始，我们讨论了一个例子，运动生理学家想通过个体锻炼时长和强度、年龄、性别 与 BMI来预测消耗的卡路里数。
# 如果用OLS回归方程来拟合该数据，那么我们获得的仅仅是一个特定的观测值集合最大化R平方的模型参数。
# 但是，研究员想用该方程预测一般个体消耗的卡路里数，而不是原始研究中的卡路里数。
# 我们知道该方程对于新观测值表现并不一定好，但是预测的损伤会是多少呢？我们可能并不知道。
# 通过交叉验证法，我们便可以评估回归方程的泛化能力

# 所谓【交叉验证】，是指将一定比例的数据挑选出来作为训练样本，另外的样本作保留样本，现在训练样本上获取回归方程，然后在保留样本上做预测。
# 由于保留样本不涉及模型参数的选择，该样本可获得比新数据更为精确的估计

# 在【k重交叉验证】中，样本被分为k个子样本，轮流将k-1个子样本组合作为训练集，另外1个子样本作为保留集
# 这样会获得k个预测方程，记录k个保留样本的预测表现效果，然后求其平均值。
# （当n是观测值总数目，且k等于n时，该方法又称作刀切法，jackknifing）

# bootstrap 包中的 crossval() 函数可以实现k重交叉验证，下列代码中，shrinkage() 函数对模型的R平方统计量做了k重交叉验证
states <- as.data.frame(state.x77[,c("Murder", "Population", 
                                     "Illiteracy", "Income","Frost")])
fit <- lm(Murder ~ Population + Illiteracy + Income + Frost, data = states)

install.packages("bootstrap")
shrinkage <- function(fit, k = 10, seed = 1) {
  require(bootstrap)
  
  theta.fit <- function(x, y)(lsfit(x, y))
  theta.predict <- function(fit, x){cbind(1, x)%*%fit$coef}

  x <- fit$model[, 2:ncol(fit$model)]
  y <- fit$model[, 1]
  
  set.seed(seed)
  results <- crossval(x, y, theta.fit, theta.predict, ngroup = k)
  r2 <- cor(y, fit$fitted.values)^2
  r2cv <- cor(y, results$cv.fit)^2
  cat("Original R-square =", r2, "\n")
  cat(k, "Fold Cross-Validated R-square =", r2cv, "\n")
}

# 代码清单定义了shrinkage()函数，创建了一个包含自变量和预测值的矩阵，可获得初始R平方和残差标准误，以及交叉验证的R平方和残差标准误。（第12章将更详细地讨论自助法）
# 对 states 数据集中的所有自变量进行回归，然后再用 shrinkage()函数做10重交叉验证
shrinkage(fit)
#Original R-square = 0.5669502 
#10 Fold Cross-Validated R-square = 0.3564904 

# 可以看到，基于初始样本的R平方（0.567）过于乐观了。
# 对新数据更好的方差解释估计是交叉验证后的R平方（0.356）
# (注意，观测值被随机分配到k个群组中，因此用随机数种子可让结果可重现)

# 通过选择有更好泛化能力的模型，还可以用交叉验证来挑选变量。
# 例如，含两个自变量（Population 和 Illiteracy）的模型，比全变量模型R平方减少得更少
fit2 <- lm(Murder ~ Population + Illiteracy, data = states)
shrinkage(fit2)
#Original R-square = 0.5668327 
#10 Fold Cross-Validated R-square = 0.514864

# 这使得双自变量模型显得更有吸引力
# 其他情况类似，基于大训练样本的回归模型和更接近与感兴趣分布的回归模型，其交叉验证效果更好。R平方减少得越少，预测则越精确。
