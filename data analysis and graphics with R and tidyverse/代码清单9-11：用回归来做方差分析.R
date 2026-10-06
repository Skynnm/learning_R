# 无视中断（投身革命即为家，血雨腥风应有涯）

# 代码清单9-11：用回归来做方差分析
# 【方差分析 和 回归 都是广义线性模型的特例】
# 因此，本章所有的设计都可以用 lm() 函数来分析。
# 但是，为了更好地理解输出结果，需要弄明白在拟合模型时，R 是如何处理分类变量的。

# 以单因素方差分析问题为例，比较5种降低胆固醇药物疗法（trt）的影响
library(multcomp)
levels(cholesterol$trt)
#[1] "1time"  "2times" "4times" "drugD"  "drugE" 

# 首先，用 aov() 函数拟合模型：
fit.aov <- aov(response ~ trt, data = cholesterol)
summary(fit.aov)
#                Df Sum Sq Mean Sq F value   Pr(>F)    
#    trt          4 1351.4   337.8   32.43 9.82e-13 ***
#    Residuals   45  468.8    10.4                     
#---
#  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1


# 现在，用 lm() 函数拟合同样的模型
fit.lm <- lm(response ~ trt, data = cholesterol)
summary(fit.lm)
#Call:
#  lm(formula = response ~ trt, data = cholesterol)
#
#Residuals:
#  Min      1Q  Median      3Q     Max 
#-6.5418 -1.9672 -0.0016  1.8901  6.6008 
#
#Coefficients:
#  Estimate Std. Error t value Pr(>|t|)    
#(Intercept)    5.782      1.021   5.665 9.78e-07 ***
#  trt2times      3.443      1.443   2.385   0.0213 *  
#  trt4times      6.593      1.443   4.568 3.82e-05 ***
#  trtdrugD       9.579      1.443   6.637 3.53e-08 ***
#  trtdrugE      15.166      1.443  10.507 1.08e-13 ***
#  ---
#  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#
#Residual standard error: 3.227 on 45 degrees of freedom
#Multiple R-squared:  0.7425,	Adjusted R-squared:  0.7196 
#F-statistic: 32.43 on 4 and 45 DF,  p-value: 9.819e-13

# 我们能发现什么？因为线性模型要求自变量是数值型，当 lm() 函数碰到因子时，它会用一系列与因子水平相对应的数值型对照变量来代替因子。
# 如果因子有k个水平，将会创建k-1个对照变量。
# R提供了5种创建对照变量的内置方法（见下表），我们也可以自己重新创建
# 默认情况下，对照处理用于无序因子，正交多项式多用于有序因子

####  内置对照  ####
# 对照变量创建方法    描述
# contr.helmert       第二个水平对照第一个水平，第三个水平对照前两个的均值，第四个水平对照前三个均值，以此类推
# contr.poly          基于正交多项式的对照，用于趋势分析（线性、二次、三次等）和等距水平的有序因子
# contr.sum           对照变量之和限制为0。也称作离差对照，对各水平的均值与所有水平的均值进行比较
# contr.treatment     各水平对照基线水平（默认第一个水平）。也称作虚拟
# contr.SAS           类似于 contr.treatment，只是基线水平变成了最后一个水平。生成的系数类似于大部分SAS过程中使用的对照变量。

# 以药物疗法对照（treatment  contrast）为例，因子的第一个水平变成了参考组，随后的每个水平都与它进行比较。
# 可以通过 contrasts() 函数查看它的编码过程
contrasts(cholesterol$trt)
#       2times 4times drugD drugE
#1time       0      0     0     0
#2times      1      0     0     0
#4times      0      1     0     0
#drugD       0      0     1     0
#drugE       0      0     0     1

# 若患者处于 drugD条件下，则变量 drugD 等于1，其他变量 2times、4times 和 drugE 都等于0
# 无需列出第一组的变量值，因为其他4个变量都为0，这已经说明患者处于1time条件

# 在代码清单9-9中，变量trt2times 表示水平 1time 和 2time 的一个对照。
# 类似地，trt4times 是 1time 和 4times的一个对照，其余以此类推。
# 从输出的概率值来看，各药物条件与第一组（1time）显著不同

# 通过设定 contrasts 选项，我们可以修改 lm() 中默认的对照方法。例如，使用 Helmert对照：
fit.lm <- lm(response ~trt, data = cholesterol, contrasts = "contr.helmert")
# 我们还能通过 Options() 函数修改R会话中的默认对照方法。例如
options(contrasts = c("contr.SAS", "contr.helmert")
# 设定无序因子的默认对照方法为 contr.SAS，有序因子的默认对照方法为 contr.helmert.
# 虽然我们一直都在线性模型范围中讨论对照方法的使用，但是在R中，我么完全可以将齐应用到其他建模函数中，包括第13章将会介绍的广义线性模型




#### 小结 ####
# 【】方差分析是一套统计学方法，常用于分析来自实验设计和准实验设计研究中的数据
# 【】在研究一个连续型因变量和一个或多个分类自变量之间的关系时，方差分析非常有用
# 【】如果连续型因变量与具有两个以上水平的分类自变量相关，那么将进行事后检验（post hoctests）以确定哪些水平/分组在此结果上会有所不同
# 【】如果有两个或两个以上分类自变量，则使用多因素方差分析研究它们对因变量的各自影响和共同影响
# 【】【在统计学上，控制（删除）了一个或多个连续型干扰变量后的设计称为协方差分析】
# 【】因变量不止一个的设计称为多元方差分析或多元协方差分析
# 【】方差分析和多元回归是广义线性模型的两种等效的分析方法。
#     这两种方法的不同术语、R函数 和 输出格式反映出它们在不同研究领域中有各自的起源。
#     当研究的重点在组间差异时，方差分析结果通常更容易理解，也更容易传递给他人