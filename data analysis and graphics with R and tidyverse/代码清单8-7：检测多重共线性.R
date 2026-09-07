# 无视中断

# 代码清单8-7：检测多重共线性
# 在即将结束回归诊断这一节前，让我们来看一个比较重要的问题，它与统计假设没有直接关联，但是对于解释多元回归的结果非常重要。
# 假设我们正在进行一项握力研究，自变量包括 DOB（Date Of Birth, 出生日期）和年龄
# 我们用握力对DOB和年龄进行回归，F检验显著，p ＜ 0.001
# 但是当我们观察DOB和年龄的回归系数时，发现它们都不显著（也就是说无法证明它们与握力相关）。到底怎么回事呢？

# 原因是DOB与年龄在四舍五入后相关性极大。
# 回归系数测量的是当其他自变量不变时，某个自变量对因变量的影响。
# 那么此处就相当于假定年龄不变，然后测量握力与年龄的关系，这种问题就称作多重共线性（multicollinearity）
# 它会导致模型参数的置信区间过大，使单个系数解释起来很困难。

# 多重共线性可用统计量VIF（variance inflation factor, 方差膨胀因子）进行检测
# 对于任何一个自变量，VIF的平方根表示变量回归参数的置信区间能膨胀为模型无关的自变量的程度（因此得名）
# car包中的 vif() 函数提供 VIF值。
# 一般原则下，vif > 10就表明存在多重共线性问题
# 代码如下，结果表明自变量不存在多重共线性问题
library(car)
states <- as.data.frame(state.x77[,c("Murder", "Population", 
                                     "Illiteracy", "Income","Frost")])
fit <- lm(Murder ~ Population + Illiteracy + Income + Frost, data = states)
vif(fit)
#Population Illiteracy     Income      Frost 
#1.245282   2.165848   1.345822   2.082547 

vif(fit) > 10 # problem?
#Population Illiteracy     Income      Frost 
#FALSE      FALSE      FALSE      FALSE 