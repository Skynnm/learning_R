# 遗憾的是，cor.test() 每次只能检验一种相关系数。但幸运的是，psych包中提供的 corr.test() 函数可以一次做更多事情。
# corr.test() 函数可以使用 Pearson、Spearman 或 Kendall 方法计算样本的相关系数矩阵和显著性水平。

# 代码清单7-14：通过 corr.test() 计算相关矩阵并进行显著性检验
library(psych)
corr.test(states, use = "complete")
#Call:corr.test(x = states, use = "complete")
#Correlation matrix 
#Population Income Illiteracy Life Exp Murder HS Grad
#Population       1.00   0.21       0.11    -0.07   0.34   -0.10
#Income           0.21   1.00      -0.44     0.34  -0.23    0.62
#Illiteracy       0.11  -0.44       1.00    -0.59   0.70   -0.66
#Life Exp        -0.07   0.34      -0.59     1.00  -0.78    0.58
#Murder           0.34  -0.23       0.70    -0.78   1.00   -0.49
#HS Grad         -0.10   0.62      -0.66     0.58  -0.49    1.00
#Sample Size 
#[1] 50
#Probability values (Entries above the diagonal are adjusted for multiple tests.) 
#Population Income Illiteracy Life Exp Murder HS Grad
#Population       0.00   0.59       1.00      1.0   0.10       1
#Income           0.15   0.00       0.01      0.1   0.54       0
#Illiteracy       0.46   0.00       0.00      0.0   0.00       0
#Life Exp         0.64   0.02       0.00      0.0   0.00       0
#Murder           0.01   0.11       0.00      0.0   0.00       0
#HS Grad          0.50   0.00       0.00      0.0   0.00       0

#To see confidence intervals of the correlations, print with the short=FALSE option

# 参数 use = 的取值可为“pairwise”或“complete”（分别表示对缺失值执行成对删除或行删除）
# 参数 method = 的取值可为“pearson”（默认值）、“spearman”或“kendall”。
# 这里可以看到，文盲率和预期寿命的相关系数（-0.59）显著不为0（p = 0.00），表明随着文盲率的上升，预期寿命趋于下降。
# 但是，人口和高中毕业率的相关系数（-0.10）并不显著地不为0（p = 0.5）


#### 其他显著性检验 ####
# 我们关注了偏相关系数。在多元正态性的假设下，ggm 包中的pcor.test() 函数可以用来检验在控制一个或多个额外变量时两个变量之间的独立性。使用格式为：
pcor.test(r, q, n)
# 其中的 r 是由pcor()函数计算得到的偏相关系数，q为控制的变量数，n为样本量。

# 在结束这个话题之前应当指出的是，psych包中的r.test()函数提供了多种实用的显著性检验方法。此函数可用来检验：
# （1）某个相关系数的显著性；
# （2）两个独立相关系数的差异是否显著；
# （3）两个基于一个共享变量得到的非独立相关系数的差异是否显著；
# （4）两个基于完全不同的变量得到的非独立相关系数的差异是否显著。
