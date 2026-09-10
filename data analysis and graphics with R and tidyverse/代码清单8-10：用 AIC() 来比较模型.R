# lm() 中的表达式 就是想要拟合的模型

# 代码清单8-10：用 AIC() 来比较模型
# AIC（Akaike Information Criterion，赤池信息量准则）也可以用来比较模型，它考虑了模型的统计拟合度以及用来拟合的参数数目。
# AIC值较小的模型要优先选择，它说明模型用较少的参数获得了足够的拟合度。
# 该准则可用 AIC() 函数实现

fit1 <- lm(Murder ~ Population + Illiteracy + Income + Frost,
           data = states)
fit2 <- lm(Murder ~ Population + Illiteracy, data = states)
AIC(fit1, fit2)
#     df      AIC
#fit1  6 241.6429
#fit2  4 237.6565

# 此处，AIC值表明没有 Income 和 Frost 的模型更佳。
# 【注意，ANOVA需要嵌套模型，而AIC方法不需要】
# 比较两模型相对来说更为直接，但如果有4个、10个 或者 100个可能的模型该怎么办呢？
# 这便是8.6.2节的主题——变量选择