# 无视中断；单因素组内方差分析/组内重复测量方差分析→长表格式

# 代码清单9-8：单因素多元方差分析
# 【当因变量（结果变量）不止一个时，可用多元方差分析（MANOVA）对它们同时进行分析】
# 以 MASS 包中的 UScereal 数据集为例[Venables, Ripley(1999)]，我们将研究美国谷物中的卡路里、脂肪和糖含量是否会因为货架位置的不同而发生变换；
# 其中1层代表底层货架，2代表中层货架，3代表顶层货架。
# 卡路里（calories）、脂肪（fat）和糖含量（sugars）是因变量，
# 货架（shelf）是包含3各水平（1，2，3）的自变量
data(UScereal, package = "MASS")
shelf <- factor(UScereal$shelf)
shelf <- factor(shelf)
y <- cbind(UScereal$calories, UScereal$fat, UScereal$sugars)
colnames(y) <- c("calories", "fat", "sugars")
aggregate(y, by = list(shelf = shelf), FUN = mean)            # 把数据集分离为单独的子集，为每一个子集计算聚合值，然后把聚合值结合在一起返回（此为均值）
#  shelf calories       fat    sugars
#1     1 119.4774 0.6621338  6.295493
#2     2 129.8162 1.3413488 12.507670
#3     3 180.1466 1.9449071 10.856821

cov(y)                                                        # cor() 可计算3种相关系数，cov()可计算协方差
#           calories       fat     sugars
#calories 3895.24210 60.674383 180.380317
#fat        60.67438  2.713399   3.995474
#sugars    180.38032  3.995474  34.050018

fit <- manova(y ~ shelf)                                      # 对组间差异进行多元检验
summary(fit)
#          Df Pillai approx F num Df den Df    Pr(>F)    
#shelf      2 0.4021   5.1167      6    122 0.0001015 ***
#Residuals 62                                            
#---
#  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

summary.aov(fit)                                              # ①输出单变量结果
#Response calories :
#            Df Sum Sq Mean Sq F value    Pr(>F)    
#shelf        2  50435 25217.6  7.8623 0.0009054 ***
#Residuals   62 198860  3207.4                      
#---
#Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

#Response fat :
#            Df Sum Sq Mean Sq F value  Pr(>F)  
#shelf        2  18.44  9.2199  3.6828 0.03081 *
#Residuals   62 155.22  2.5035                  
#---
#Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

#Response sugars :
#            Df  Sum Sq Mean Sq F value   Pr(>F)   
#shelf        2  381.33 190.667  6.5752 0.002572 **
#Residuals   62 1797.87  28.998                    
#---
#Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

# 首先，我们将 shelf 变量转换为因子变量，从而使它在后续分析种能作为分组变量。
# 接下来，cbind()函数将3个因变量（卡路里、脂肪和糖含量）合并成一个矩阵。
# aggregate()函数可获取货架的各个均值，cov()函数则输出各谷物间的方差和协方差。

# manova() 函数能对组间差异进行多元检验。
# 上面F值显著，说明3个组的营养成分测量值不同
# 注意 shelf 变量已经转换为因子变量，因此它可以代表一个分组变量。

# 由于多元检验是显著的，我们可以使用 summary.aov() 函数对每一个变量做单因素方差分析①
# 从上述结果可以看到，3组种每种营养成分的测量值都是不同的，
# 最后，还可以用均值比较步骤（比如TukeyHSD检验）来判断对于每个因变量，哪种货架与其他货架都是不同的