# 享受过程

# 代码清单13-01-00：Logistic回归
# 当通过一系列连续型和/或类别型自变量来预测二值型因变量时，Logistic回归是一个非常有用的工具
# 以 AER 包中的数据集 Affairs 为例，我们将通过探究感情危机的数据来阐述Logistic回归过程
# 首次使用该数据前，请确保已下载和安装了 AER 包
install.packages("AER")

# Affairs 数据从601个参与者身上收集了9个变量，包括一年来出现感情危机的频率以及参与者性别、年龄、婚龄、是否有子女、宗教信仰程度（5分制，1分表示反对，5分表示非常信仰）、学历、职业（逆向编号的Hollingshead 7级分类法），还有对婚姻的自我评分（5分制，1表示很不幸福，5表示非常幸福）
# 我们先看一些描述性的统计信息：
data(Affairs, package = "AER")
summary(Affairs)
#affairs          gender         age         yearsmarried    children 
#Min.   : 0.000   female:315   Min.   :17.50   Min.   : 0.125   no :171  
#1st Qu.: 0.000   male  :286   1st Qu.:27.00   1st Qu.: 4.000   yes:430  
#Median : 0.000                Median :32.00   Median : 7.000            
#Mean   : 1.456                Mean   :32.49   Mean   : 8.178            
#3rd Qu.: 0.000                3rd Qu.:37.00   3rd Qu.:15.000            
#Max.   :12.000                Max.   :57.00   Max.   :15.000            
#religiousness     education       occupation        rating     
#Min.   :1.000   Min.   : 9.00   Min.   :1.000   Min.   :1.000  
#1st Qu.:2.000   1st Qu.:14.00   1st Qu.:3.000   1st Qu.:3.000  
#Median :3.000   Median :16.00   Median :5.000   Median :4.000  
#Mean   :3.116   Mean   :16.17   Mean   :4.195   Mean   :3.932  
#3rd Qu.:4.000   3rd Qu.:18.00   3rd Qu.:6.000   3rd Qu.:5.000  
#Max.   :5.000   Max.   :20.00   Max.   :7.000   Max.   :5.000 

table(Affairs$affairs)
#  0   1   2   3   7  12 
#451  34  17  19  42  38 

# 从这些统计信息可以看到，52%的参与者是女性，72%的人有孩子，样本年龄的中位数为32岁。
# 对于因变量，72%的参与者表示过去一年中没有感情危机（451/601），而出现感情危机的最多次数为12（占6%）
# 此处我们感兴趣的是二值型结果（有过一次感情危机/没有过感情危机）
# 按照如下代码，我们可将 affairs 转化为二值型因子 ynaffairs
Affairs$ynaffairs <- ifelse(Affairs$affairs > 0, 1, 0)
Affairs$ynaffairs <- factor(Affairs$ynaffairs,
                            levels = c(0, 1),
                            labels = c("No", "Yes"))
table(Affairs$ynaffairs)
# No Yes 
#451 150

# 这个二值型因子现可作为 Logistic 回归的因变量：
fit.full <- glm(ynaffairs ~ gender + age + yearsmarried + children +
                  religiousness + education + occupation + rating,
                data = Affairs, family = binomial())
summary(fit.full)

#Call:
#  glm(formula = ynaffairs ~ gender + age + yearsmarried + children + 
#        religiousness + education + occupation + rating, family = binomial(), 
#      data = Affairs)
#
#Coefficients:
#     Estimate Std. Error z value Pr(>|z|)    
#(Intercept)    1.37726    0.88776   1.551 0.120807    
#gendermale     0.28029    0.23909   1.172 0.241083    
#age           -0.04426    0.01825  -2.425 0.015301 *  
#yearsmarried   0.09477    0.03221   2.942 0.003262 ** 
#childrenyes    0.39767    0.29151   1.364 0.172508    
#religiousness -0.32472    0.08975  -3.618 0.000297 ***
#education      0.02105    0.05051   0.417 0.676851    
#occupation     0.03092    0.07178   0.431 0.666630    
#rating        -0.46845    0.09091  -5.153 2.56e-07 ***
#  ---
#  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#
#(Dispersion parameter for binomial family taken to be 1)
#
#Null deviance: 675.38  on 600  degrees of freedom
#Residual deviance: 609.51  on 592  degrees of freedom
#AIC: 627.51
#
#Number of Fisher Scoring iterations: 4


# 从回归系数的p值（最后一栏）我们可以看到，性别、是否有子女、学历 和 职业对方程的贡献都不显著（我们无法拒绝参数为0的假设）
# 去除这些变量重新拟合模型，我们来检验下新模型是否拟合得好：
fit.reduced <- glm(ynaffairs ~ age + yearsmarried + religiousness +
                     rating, data = Affairs, family = binomial())
summary(fit.reduced)
#Call:
#  glm(formula = ynaffairs ~ age + yearsmarried + religiousness + 
#        rating, family = binomial(), data = Affairs)
#
#Coefficients:
#  Estimate Std. Error z value Pr(>|z|)    
#(Intercept)    1.93083    0.61032   3.164 0.001558 ** 
#  age           -0.03527    0.01736  -2.032 0.042127 *  
#  yearsmarried   0.10062    0.02921   3.445 0.000571 ***
#  religiousness -0.32902    0.08945  -3.678 0.000235 ***
#  rating        -0.46136    0.08884  -5.193 2.06e-07 ***
#  ---
#  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#
#(Dispersion parameter for binomial family taken to be 1)

#Null deviance: 675.38  on 600  degrees of freedom
#Residual deviance: 615.36  on 596  degrees of freedom
#AIC: 625.36
#
#Number of Fisher Scoring iterations: 4


# 新模型的每个回归系数都非常显著（p < 0.05）
# 由于两套模型嵌套（fit.reduced 是 fit.full的一个子集）
# 我们可以用 anova() 函数对它们进行比较，对于广义线性回归，可用卡方检验
anova(fit.reduced, fit.full, test = "Chisq")
#Analysis of Deviance Table
#
#Model 1: ynaffairs ~ age + yearsmarried + religiousness + rating
#Model 2: ynaffairs ~ gender + age + yearsmarried + children + religiousness + 
#  education + occupation + rating
#Resid. Df Resid. Dev Df Deviance Pr(>Chi)
#1       596     615.36                     
#2       592     609.51  4   5.8474   0.2108


# 结果的卡方值不显著（p=0.21），表明4个自变量的新模型与9个完整自变量的模型拟合程度一样好。
# 这使得我们更加坚信添加性别、是否有子女、学历 和 职业变量不会显著提高方程的预测精度，因此我们可以依据更简单的模型进行解释