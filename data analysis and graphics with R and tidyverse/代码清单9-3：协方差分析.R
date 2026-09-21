# 规律/限制就在那里，人类只能尽量发现并用其（例如创造工具）来达成自己的目的 

# 代码清单9-3：协方差分析
# 单因素协方差分析（ANCOVA）扩展了单因素方差分析（ANOVA），包含一个或多个连续型协变量。
# 下面的例子来自于multcomp包中的litter数据集（Westfall et al., 1999）
# 怀孕小鼠被分为4各小组，每个小组接受不同剂量（0、5、50 或 500）的药物
# 产下幼崽的体重均值为因变量，怀孕时间为协变量。分析代码如下：
library(multcomp)
library(dplyr)
litter %>%
  group_by(dose) %>%
  summarise(n = n(), mean = mean(gesttime), sd = sd(gesttime))
## A tibble: 4 × 4
#dose      n  mean    sd             # 此处均值是怀孕时间
#<fct> <int> <dbl> <dbl>
#1 0        20  22.1 0.438
#2 5        19  22.2 0.451
#3 50       18  21.9 0.404
#4 500      17  22.2 0.431

litter %>%
  group_by(dose) %>%
  summarise(n = n(), mean = mean(weight), sd = sd(weight))
## A tibble: 4 × 4
#dose      n  mean    sd
#<fct> <int> <dbl> <dbl>
#1 0        20  32.3  2.70
#2 5        19  29.3  5.09
#3 50       18  29.9  3.76
#4 500      17  29.6  5.40


fit <- aov(weight ~ gesttime + dose, data = litter)
summary(fit)
#             Df   Sum Sq  Mean Sq  F value  Pr(>F)   
#  gesttime     1   134.3  134.30   8.049    0.00597 **
#  dose         3   137.1   45.71   2.739    0.04988 * 
#  Residuals   69  1151.3   16.69                   
#---
#  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

# 利用summarise()函数，我们可以看到每种剂量下所产的幼崽数并不相同：
# 0剂量时（未用药）产崽20个，500剂量时产崽17个。
# 根据各组均值，我么可以发现未用药组幼崽出生体重均值最高（32.3）

# ANCOVA的F检验表明：
# (a)怀孕时间与幼崽出生体重相关；
# (b)控制怀孕时间，药物剂量与出生体重相关。控制怀孕时间，确实发现每种药物剂量下幼崽出生体重均值不同。

# 由于使用了协变量，我么可能想要获取调整的组均值，即去除协变量效应后的组均值。
# 可使用 effects 包中的 effects() 函数来计算调整的均值：
library(effects)
effect("dose", fit)
#dose effect
#dose
#0        5       50      500 
#32.35367 28.87672 30.56614 29.33460 

# 这是在对怀孕时间的初始差异进行统计学调整后，每种剂量下的平均幼崽出生体重。
# 本例中，调整的均值明显不同于 summarise() 函数得出的未调整的均值。
# 总之，effects 包为复杂的实验设计提供了强大的计算调整均值的方法，并能将结果可视化，更多细节可参考 CRAN 上的文档。

# 和上一节的单因素方差分析例子一样，剂量的F检验虽然表明了不同的处理方式幼崽的体重均值不同，单无法告知我们哪种处理方式与其他方式不同。
# 同样我们使用multcomp包来对所有均值进行成对比较。另外，multcomp包还额可以用来检验用户自定义的均值假设。