# 看代码、理解代码的时间远多于写代码时间

# 代码清单8-5：有显著交互项的多元线性回归（即中介效应、调节效应）
# 许多有趣的研究都会涉及自变量的交互项。
# 以 mtcars 数据框中的汽车数据为例，若你对汽车重量和发动机效率感兴趣，可以把它们当作自变量，并包含交互项来拟合回归模型
fit <- lm(mpg ~ hp + wt + hp:wt, data = mtcars)

summary(fit)
#Call:
#  lm(formula = mpg ~ hp + wt + hp:wt, data = mtcars)
#
#Residuals:
#  Min      1Q  Median      3Q     Max 
#-3.0632 -1.6491 -0.7362  1.4211  4.5513 
#
#Coefficients:
#  Estimate Std. Error t value Pr(>|t|)    
#(Intercept) 49.80842    3.60516  13.816 5.01e-14 ***
#  hp          -0.12010    0.02470  -4.863 4.04e-05 ***
#  wt          -8.21662    1.26971  -6.471 5.20e-07 ***
#  hp:wt        0.02785    0.00742   3.753 0.000811 ***
#  ---
#  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#
#Residual standard error: 2.153 on 28 degrees of freedom
#Multiple R-squared:  0.8848,	Adjusted R-squared:  0.8724 
#F-statistic: 71.66 on 3 and 28 DF,  p-value: 2.981e-13


# 我们可以看到 Pr(>|t|) 栏中，发动机效率与汽车重量的交互项是显著的，这意味着什么呢？
# 【若两个自变量的交互项显著，说明因变量与其中一个自变量的关系依赖于另外一个自变量的水平】
# 因此此例说明，每加仑汽油行驶英里数与汽车发动机效率的关系依汽车重量不同而不同

# 预测 mpg 的模型为 mpg(hat) = 49.81 - 0.12 x hp - 8.22 x wt + 0.03 x hp x wt
# 为更好地理解交互项，可以赋给 wt 不同的值，并简化方程。
# 例如，可以试试 wt 的均值（3.2），少于均值一个标准差和多于均值一个标准差的值（分别是2.2和4.2）
# 若 wt = 2.2，则方程可以化简为 mpg(hat) = 49.81 - 0.12 x hp - 8.22 x (2.2) + 0.03 x hp x (2.2) = 31.41 - 0.06 x hp
# 若 wt = 3.2，则变成了 mpg(hat) = 23.37 - 0.03 x hp
# 若 wt = 4.2，则方程为 mpg(hat) = 15.33 - 0.003 x hp
# 我们将发现，随着汽车重量的增加（2.2、3.2、4.2），hp 每增加一个单位引起的 mpg 预期改变却在减少（0.06、0.03、0.003）

# 通过 effects 包中的 effect() 函数，我们可以用图形展示交互项的结果。格式为：
plot(effect(term, mod,, xlevels), multiline = TRUE)
# term 即模型要绘制的项，mod为通过 lm() 拟合的模型，xlevels 是一个列表，指定变量要设定的常量值，multiline = TRUE选项表示添加相应直线
# lines 选项指定每条线的线条类型（其中1为实线，2为虚线，3为点线），即
install.packages("effects")
library(effects)
plot(effect("hp:wt", fit,, list(wt = c(2.2, 3.2, 4.2))),
     lines = c(1, 2, 3), multiline = TRUE)

# 从图中可以很清晰地看出，随着汽车重量的增加，发动机功率与每加仑汽油行驶英里数的关系减弱了。
# 当 wt = 4.2 时，直线几乎是水平的，表明随着 hp 的增加，mpg不会发生改变

# 然而，拟合模型只不是分析的第一步，一旦拟合了回归模型，在信心十足地进行推断之前，必须对方法中暗含的统计假设进行检验。这正是8.3节的主题。