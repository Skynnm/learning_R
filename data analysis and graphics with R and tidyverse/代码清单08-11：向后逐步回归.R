# 模型预测精度（模型尽可能地拟合数据）  与   模型简洁度（一个简单而且能复用的模型） 的调和问题

# 代码清单8-11：向后逐步回归
# 从大量候选变量中选择最终的自变量有以下两种流行的方法：
# （1） 逐步回归法（stepwise method）
# （2） 全子集回归（all-subsets regression）

# 【逐步回归中，模型会一次添加或者删除一个变量，直到达到某个判停准则为止】。例如，
# 【向前逐步回归（forward stepwise method）】每次添加一个自变量到模型中，直到添加变量不会使模型有所改进为止。
# 【向后逐步回归（backward stepwise method）】从模型包含所有自变量开始，一次删除一个变量，直到会降低模型质量为止。
# 【向前向后逐步回归（stepwise stepwise regression, 通常称作逐步回归，以免听起来太冗长）】结合了向前逐步回归和向后逐步回归的方法：变量每次进入一个，但是每一步中，变量都会被重新评估，对模型没有贡献的变量将会被删除；自变量可能会被添加、删除好几次，直到获得最优模型为止。

# 逐步回归法的实践依据增删变量的准则不同而不同。
# R基础包中的 step() 函数可以实现逐步回归模型（向前、向后 和 向前向后），依据的是AIC准则。
# 下面代码中，我们用向后逐步回归来处理多元回归问题
states <- as.data.frame(state.x77[, c("Murder", "Population",
                                      "Illiteracy", "Income", "Frost")])

fit <- lm(Murder ~ Population + Illiteracy + Income + Frost,
          data = states)

step(fit, direction = "backward")
#Start:  AIC=97.75
#Murder ~ Population + Illiteracy + Income + Frost
#
# Df Sum of Sq    RSS     AIC
#- Frost       1     0.021 289.19  95.753
#- Income      1     0.057 289.22  95.759
#<none>                    289.17  97.749
#- Population  1    39.238 328.41 102.111
#- Illiteracy  1   144.264 433.43 115.986

#Step:  AIC=95.75
#Murder ~ Population + Illiteracy + Income
#
#Df Sum of Sq    RSS     AIC
#- Income      1     0.057 289.25  93.763
#<none>                    289.19  95.753
#- Population  1    43.658 332.85 100.783
#- Illiteracy  1   236.196 525.38 123.605
#
#Step:  AIC=93.76
#Murder ~ Population + Illiteracy

#Df Sum of Sq    RSS     AIC
#<none>                    289.25  93.763
#- Population  1    48.517 337.76  99.516
#- Illiteracy  1   299.646 588.89 127.311

#Call:
#  lm(formula = Murder ~ Population + Illiteracy, data = states)

#Coefficients:
#  (Intercept)   Population   Illiteracy  
#   1.6515497    0.0002242    4.0807366

# 开始时模型包含4个（全部）自变量，然后每一步中，AIC列提供了删除一个行中变量后模型的AIC值，<none>中的AIC值表示没有变量被删除时模型的AIC。
#【（每一行的是删除相应变量后剩下模型的AIC值）】
# 第 1 步，Frost被删除，AIC从97.75降低到95.75；
# 第 2 步，Income被删除，AIC继续下降，成为93.76.
# 然后再删除变量将会增加AIC，因此终止选择过程

# 逐步回归法其实存在争议，虽然它可能会找到一个好的模型，但是不能保证模型就是最佳模型，因为不是每一个可能的模型都被评估了。
# 为了解决这个问题，便有了【全子集回归（all-subset regression）】
