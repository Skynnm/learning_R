# 无视中断

# 代码清单8-14：用于计算自变量的相对权重的 relweights() 函数
# 本章到目前为止我们一直都有一个疑问：“哪些变量对预测有用呢？”
# 但我们内心真正感兴趣的其实是：“哪些变量对预测最为重要？”
# 潜台词就是想根据相对重要性对自变量进行排序。
# 我们有实际的理由提出这个问题。例如，假设我们能对成功的团队组织所需的领导特质依据相对重要性进行排序，那么就可以帮助管理者关注它们最需要改进的行为

# 若自变量不相关，过程就相对简单得多，我们可以根据自变量与因变量的相关系数来进行排序。
# 但大部分情况中，自变量之间有一定相关性，这就使得评估变得复杂很多。

# 统计学家构造出很了很多种方法用于评估自变量的相对重要性
# 其中最简单的是比较自变量的标准回归系数，即在控制其他自变量为常量的情况下，计算某个自变量发生一个标准差的变化时，因变量的期望变化量（以标准差为单位）
# 在进行回归分析前，可用 scale() 函数将数据标准化为均值为0、标准差为1的数据集，这样用R回归即可获得标准回归系数。
# （注意，scale() 函数返回的是一个矩阵，而 lm() 函数要求一个数据框，我们需要用一个中间步骤来转换一下）
# 代码和多元回归的结果如下：
states <- as.data.frame(state.x77[, c("Murder", "Population",
                                      "Illiteracy", "Income", "Frost")])
zstates <- as.data.frame(scale(states))
zfit <- lm(Murder ~ Population + Income + Illiteracy + Frost, data = zstates)
coef(zfit)
#(Intercept)    Population        Income    Illiteracy         Frost 
#-2.054026e-16  2.705095e-01  1.072372e-02  6.840496e-01  8.185407e-03 

# 此处可以看到，当人口、收入和结霜天数不变时，文盲率每增加一个标准差将会使谋杀率增加0.68个标准差。
# 根据标准回归系数，我们可认为 Illiteracy 是最重要的自变量，而 Frost 是最不重要的

# 还有许多其他方法可定量分析相对重要性。
# 比如，可以将相对重要性看作每个自变量（本身或与其他自变量组合）对R平方的贡献

# 相对权重（relative weight）是一种比较有前景的新方法。
# 它是对所有可能子模型添加一个自变量引起的R平方平均增加量的一个近似值。
# 代码清单8-14提供了一个生成相对权重的函数
relweights <- function(fit, ...) {
  R <- cor(fit$model)
  nvar <- ncol(R)
  rxx <- R[2:nvar, 2:nvar]
  rxy <- R[2:nvar, 1]
  svd <- eigen(rxx)
  evec <- svd$vectors   # 修正：特征向量矩阵，不是values！
  ev <- svd$values
  delta <- diag(sqrt(ev))
  lambda <- evec %*% delta %*% t(evec)
  lambdasq <- lambda ^ 2   # 修正拼写 lambad -> lambda
  beta <- solve(lambda) %*% rxy
  rsquare <- colSums(beta ^ 2)
  rawwgt <- lambdasq %*% beta ^ 2
  import <- (rawwgt / rsquare) * 100
  import <- as.data.frame(import)
  row.names(import) <- names(fit$model[2:nvar]) # 给变量名
  import <- import[order(import[,1]), 1, drop = FALSE] # orderv→order，False→FALSE
  dotchart(import[,1], labels = row.names(import),
           xlab = "% of R-square", pch = 19,
           main = "Relative Importance of Predictor Variable",
           sub = paste("Total R-square =", round(rsquare, digits = 3)),
           ...)
  return(import)
}

# 代码清单8-14中的代码改编自Johnson博士提供的SPSS程序