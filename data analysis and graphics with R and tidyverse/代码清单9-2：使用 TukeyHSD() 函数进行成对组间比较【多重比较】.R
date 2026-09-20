# 拥抱AI

# 代码清单9-2：使用 TukeyHSD() 函数进行成对组间比较【多重比较】
# 虽然 ANOVA 对各疗法的F检验表明 5种药物疗法效果不同，但是并没有告诉我们哪种疗法与其他疗法不同。
# 多重比较可以解决这个问题。
# 例如，TukeyHSD () 函数提供了对各组均值差异的成对检验。
fit <- aov(response ~ trt, data = cholesterol)   

pairwise <- TukeyHSD(fit)                                            # ①计算成对比较结果
pairwise
#$trt
#diff        lwr       upr     p adj
#2times-1time   3.44300 -0.6582817  7.544282 0.1380949
#4times-1time   6.59281  2.4915283 10.694092 0.0003542
#drugD-1time    9.57920  5.4779183 13.680482 0.0000003
#drugE-1time   15.16555 11.0642683 19.266832 0.0000000
#4times-2times  3.14981 -0.9514717  7.251092 0.2050382
#drugD-2times   6.13620  2.0349183 10.237482 0.0009611
#drugE-2times  11.72255  7.6212683 15.823832 0.0000000
#drugD-4times   2.98639 -1.1148917  7.087672 0.2512446
#drugE-4times   8.57274  4.4714583 12.674022 0.0000037
#drugE-drugD    5.58635  1.4850683  9.687632 0.0030633

plotdata <- as.data.frame(pairwise[[1]])                             # ②创建结果数据集
plotdata$conditions <- row.names(plotdata)                           # ②创建结果数据集

library(ggplot2)
ggplot(data= plotdata, aes(x = conditions, y = diff)) +              # ③绘制结果图
  geom_point(size = 3, color = "red") +                              # ③绘制结果图
  geom_errorbar(aes(ymin = lwr, ymax = upr, width = .2)) +           # ③绘制结果图
  geom_hline(yintercept = 0, color = "red", linetype = "dashed") +   # ③绘制结果图
  labs(y = "Difference in mean levels", x = "",                      # ③绘制结果图
       title = "95% family-wise confidence level") +                 # ③绘制结果图
  theme_bw() +                                                       # ③绘制结果图
  coord_flip()                                                       # ③绘制结果图

# 可以看到，1time 和 2times 的平均胆固醇降低量差异不显著（p = 0.138），而 1time 和 4times 间差异非常显著（p < 0.001）

# 代码同时生成了：Tukey HSD 检验均值成对比较图
# 在这个图形中，置信区间包含0的疗法说明差异不显著（p > 0.5），最大的均值差异发生在drugE和1time之间，差异显著（置信区间不包括0）

# 在继续学习之前，我应该说明的是我们可以使用基础图像创建上述图形。
# 如果这样，我们可以简单地绘制代码的图形（成对绘制）
# ggplot2方法的优点是它可以创建更有吸引力的图形，允许我们完全自定义图形来满足自己的需求。





# multcomp包中的glht()函数提供了多重均值比较更为全面的方法，既适用于线性模型（如本章各例），又适用于广义线性模型（见第13章）。
# 下面的代码重现了 Tukey HSD检验，并用一个不同的图形对结果进行展示
library(multcomp)
tuk <- glht(fit, linfct = mcp(trt = "Tukey"))
summary(tuk)
#
#Simultaneous Tests for General Linear Hypotheses
#
#Multiple Comparisons of Means: Tukey Contrasts
#
#
#Fit: aov(formula = response ~ trt, data = cholesterol)
#
#Linear Hypotheses:
#  Estimate Std. Error t value Pr(>|t|)    
#2times - 1time == 0     3.443      1.443   2.385 0.138116    
#4times - 1time == 0     6.593      1.443   4.568 0.000339 ***
#  drugD - 1time == 0      9.579      1.443   6.637  < 1e-04 ***
#  drugE - 1time == 0     15.166      1.443  10.507  < 1e-04 ***
#  4times - 2times == 0    3.150      1.443   2.182 0.205069    
#drugD - 2times == 0     6.136      1.443   4.251 0.000991 ***
#  drugE - 2times == 0    11.723      1.443   8.122  < 1e-04 ***
#  drugD - 4times == 0     2.986      1.443   2.069 0.251211    
#drugE - 4times == 0     8.573      1.443   5.939  < 1e-04 ***
#  drugE - drugD == 0      5.586      1.443   3.870 0.003046 ** 
#  ---
#  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#(Adjusted p values reported -- single-step method)

labels1 <- cld(tuk, levels = .5)$mcletters$Letters
labels2 <- paste(names(labels1), "\n", labels1)
ggplot(data = fit$model, aes(x = trt, y = response)) +
  scale_x_discrete(breaks = names(labels1), labels = labels2) + 
  geom_boxplot(fill= "lightgrey") + 
  theme_bw() +
  labs(x = "Treatment",
       title = "Distribution of Response Scores by Treatment",
       subtitle = "Groups without overlapping letters differ significantly (p < .05)")
# 上面的代码中，cld()函数中的level选项设置了使用的显著水平（0.05，即本例中的95%置信区间）
# 有相同字母的组（用箱线图表示）说明均值差异不显著。
# 可以看到，1time 和 2times 差异不显著（有相同的字母a），2times 和 4times差异也不显著（有相同的字母b），而1time和4times差异显著（它们没有共同的字母）
# 个人认为，图9-4比图9-3更好理解，它还提供了各组得分的分布信息。

# 从结果来看，使用降低胆固醇的药物时，每天4次 5mg 剂量比每天1次 20mg剂量效果更佳，也优于候选药物drugD，但药物drugE比其他药物和疗法都更优。






#### 评估检验的假设条件 ####
# 上一章已经提过，我们对于结果的信心依赖于做统计检验时数据满足假设条件的程度。
# 单因素方差分析中，我们假设因变量服从正太分布，各组方差相等。
# 可以使用Q-Q图来检验正态性假设：
library(car)
fit <- aov(response ~ trt, data = cholesterol)
qqPlot(fit, simulate = TRUE, main = "Q-Q  Plot")
# 代码生成了学生化残差的正态性检验。残差为实际值减去预测结果，学生化残差为残差除以其标注差估计值后得到的数值。如果学生残差呈正太分布，那么这些残差点应聚集在拟合线的两侧。
# 图中标注了学生化残差最大的两个观测值在数据框中的行号。
# 图中默认标注了学生化残差最大的两个观测值在数据框中的行号。
# 数据落在95%置信区间范围内，说明满足正态性假设。

# R提供了一些可用来做方差齐性检验的函数。例如，可以通过如下代码来做Bartlett检验：
bartlett.test(response ~ trt, data = cholesterol)
#
#Bartlett test of homogeneity of variances
#
#data:  response by trt
#Bartlett's K-squared = 0.57975, df = 4, p-value = 0.9653

# Barlett检验表明5组的方差并没有显著不同（p ≈ 0.97）
# 其他检验如 Fligner-Killeen检验（fligner.test()函数）和Brown-Forsythe检验（HH包中的hov()函数）
# 此处没有做演示，但它们获得的结果与Barlett检验相同。
# 最后，方差齐性分析对离群点非常敏感。可利用car包中的 outlierTest() 函数来检测离群点：
library(car)
outlierTest(fit)
#No Studentized residuals with Bonferroni p < 0.05
#Largest |rstudent|:
#  rstudent unadjusted p-value Bonferroni p
#19 2.251149           0.029422           NA

# 从输出结果来看，并没有证据说明数据中含有离群点（当p>1时将产生NA）
# 因此根据Q-Q图、Barlett检验和离群点检验，该数据似乎可以用ANOVA模型拟合得很好
# 这些方法反过来增强了我们对于所得结果的信心。