# vibe coding，生成式软件工程

# 代码清单8-4：多元线性回归
states <- as.data.frame(state.x77[,c("Murder", "Population",
                                     "Illiteracy", "Income", "Frost")])

fit <- lm(Murder ~ Population + Illiteracy + Income + Frost, 
          data = states)

summary(fit)
#Call:
#  lm(formula = Murder ~ Population + Illiteracy + Income + Frost, 
#     data = states)
#
#Residuals:
#  Min      1Q  Median      3Q     Max 
#-4.7960 -1.6495 -0.0811  1.4815  7.6210 
#
#Coefficients:
#  Estimate Std. Error t value Pr(>|t|)    
#(Intercept) 1.235e+00  3.866e+00   0.319   0.7510    
#Population  2.237e-04  9.052e-05   2.471   0.0173 *  
#  Illiteracy  4.143e+00  8.744e-01   4.738 2.19e-05 ***
#  Income      6.442e-05  6.837e-04   0.094   0.9253    
#Frost       5.813e-04  1.005e-02   0.058   0.9541    
#---
#  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#
#Residual standard error: 2.535 on 45 degrees of freedom
#Multiple R-squared:  0.567,	Adjusted R-squared:  0.5285 
#F-statistic: 14.73 on 4 and 45 DF,  p-value: 9.133e-08

# 当自变量不止一个时，回归系数的含义为：一个自变量增加一个单位，其他自变量保持不变时，因变量将要增加的数量。
# 例如本例中，文盲率的回归系数为4.14，表示控制人口、收入 和 结霜天数不变时，文盲率每上升1%，谋杀率将会上升4.14%，它的系数在p<0.001的水平下显著不为0。
# 相反，结霜天数的系数没有显著不为0（p = 0.954），表明当控制其他变量不变时，结霜天数与谋杀率不呈线性相关。
# 总体来看，所有的自变量解释了各州谋杀率57%的方差

# 以上分析，我们没有考虑自变量的交互项。在接下来的一节中，我们将考虑一个包含交互项的例子。