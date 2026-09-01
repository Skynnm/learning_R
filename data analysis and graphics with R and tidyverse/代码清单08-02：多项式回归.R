# ①简单线性回归；②多项式回归；③多元线性回归

# 代码清单8-2：多项式回归
# 代码清单8-1生成的图片表明，我们可以通过添加一个二次项（即X^2）来提高回归的预测精度。
# 如下代码可以拟合含二次项的方程：
fit2 <- lm(weight ~ height + I(height^2), data = women)
# I(height^2)表示想预测方程添加一个身高的平方项。I函数将括号的内容看作R的一个常规表达式。
# 因为^符号在表达式中有特殊的含义（表示交互项达到某个次数），会调用并不需要的东西，所以此处必须要用这个函数。
fit2 <- lm(weight ~ height + I(height^2), data = women)
summary(fit2)
#Call:
#  lm(formula = weight ~ height + I(height^2), data = women)
#
#Residuals:
#  Min       1Q   Median       3Q      Max 
#-0.50941 -0.29611 -0.00941  0.28615  0.59706 
#
#Coefficients:
#  Estimate Std. Error t value Pr(>|t|)    
#(Intercept) 261.87818   25.19677  10.393 2.36e-07 ***
#  height       -7.34832    0.77769  -9.449 6.58e-07 ***
#  I(height^2)   0.08306    0.00598  13.891 9.32e-09 ***
#  ---
#  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#
#Residual standard error: 0.3841 on 12 degrees of freedom
#Multiple R-squared:  0.9995,	Adjusted R-squared:  0.9994 
#F-statistic: 1.139e+04 on 2 and 12 DF,  p-value: < 2.2e-16

plot(women$height, women$weight,
     xlab = "Height (in inches)",
     ylab = "Weight (in lbs)")
lines(women$height, fitted(fit2))

# 新的预测方程为：
# weight(hat) = 261.88 - 7.35xHeight + 0.083xHeight^2
# 在 p < 0.001水平下，回归系数都非常显著。模型的方程解释率以及增加到了99.9%。
# 二次项的显著性（t = 13.89, p < 0.001）表明包含二次项提高了模型的拟合度。从图片中也能看出曲线确实拟合得比较好。

#【一般来说，n次多项式生成一个带有n-1个弯曲的曲线】拟合三次多项式，可用：
fit3 <- lm(weight ~ height + I(height^2) +I(height^3), data = women)
plot(women$height, women$weight,
     xlab = "Height (in inches)",
     ylab = "Weight (in lbs)")
lines(women$height, fitted(fit3))
# 虽然更高次的多项式也可用，但我发现使用比三次更高的项几乎没有必要




####-------------------------线性模型与非线性模型--------------------------####
# 多项式方程仍可认为时线性回归模型，因为方程仍是预测变量的加权和形式（本例中是身高和身高的平方）。即使这样的模型：
Y(hat)i = β(hat)0 + β(hat)ilogeXi + β(hat)2xSinX2
# 仍可认为是线性模型（参数项是线性的），能用这样的表达式进行拟合：
Y ~ log(Xi) + sin(X2)
# 相反，下面的例子才能算是真正的非线性模型：
Y(hat)i = β(hat)0 + β(hat)1e^(x/β(hat)2)
# 这种非线性模型可用nls()函数进行拟合
