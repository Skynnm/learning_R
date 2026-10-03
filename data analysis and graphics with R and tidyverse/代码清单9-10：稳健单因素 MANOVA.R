# 无视中断（此去泉台招旧部，旌旗十万斩阎罗）

# 代码清单9-10：稳健单因素 MANOVA
# 如果多元正太性或者方差-协方差矩阵同质性假设都不满足，或者我们担心多元离群点，那么可以考虑用稳健或非参数版本的 MANOVA 检验。
# 稳健单因素 MANOVA 可通过 rrcov 包中的 wilks.test() 函数实现。
# vegan 包中的 adonis() 函数则提供了非参数 MANOVA 的同等形式
library(rrcov)
data(UScereal, package = "MASS")
shelf <- factor(UScereal$shelf)
shelf <- factor(shelf)
y <- cbind(UScereal$calories, UScereal$fat, UScereal$sugars)
colnames(y) <- c("calories", "fat", "sugars")

Wilks.test(y, shelf, method = "mcd")
#data:  x
#Wilks' Lambda = 0.42394, Chi2-Value = 21.4464, DF = 4.1051, p-value =
#0.0002873
#sample estimates:
#  calories       fat    sugars
#1 118.1432 0.7449005  5.100422
#2 126.7149 1.0724502 12.761427
#3 160.1003 1.6591192  9.913359

# 从结果来看，稳健检验对离群点和违反 MANOVA 假设的情况不敏感，且再一次验证了存储在货架顶部、中部 和 底部的谷物营养成分测量值不同。