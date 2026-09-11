# 休息 + 重复 

# 代码清单8-15：relweights()函数的应用
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

# 测试
states <- as.data.frame(state.x77[, c("Murder", "Population",
                                      "Illiteracy", "Income", "Frost")])
fit <- lm(Murder ~ Population + Income + Illiteracy + Frost, data = states)
relweights(fit)
#                  V1
#Income      5.488962
#Population 14.723401
#Frost      20.787442
#Illiteracy 59.000195

# 上述代码生成图：states多元回归中各变量相对权重的点图。较大的权重图表明这些自变量相对而言更加重要。例如，Illiteracy 占总解释方差的59%（0.567），Income 占5.49%。因此在这个模型中Illiteracy比Income相对更重要。

# 通过图，可以看到各个自变量对模型方差的解释程度（R-square = 0.567），Illiteracy 解释了59% 的R平方，Frost 解释了20.79%，等等。
# 根据相对权重法，Illiteracy 有最大的相对重要性，余下依次是 Frost、Population 和 Income

# 相对重要性的测量（特别是相对权重法）有广泛的应用，它比标准回归系数更为直观。
