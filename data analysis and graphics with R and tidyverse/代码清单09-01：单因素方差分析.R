# 物质、能量、信息

# 代码清单9-1：单因素方差分析
# 单因素方差分析中，我们感兴趣的使比较分类因子定义的两个或多个组别中的因变量均值。
# 以 multcomp 包中的 cholesterol 数据集为例，50位患者均接受降低胆固醇药物的治疗（trt）5种疗法中的一种疗法，
# 其中3种治疗条件使用的药物相同，分别使 20mg 一天一次（1time）、10mg 一天两侧（2times）  和 5mg 一天4次（4times）
# 剩下的两种方式（drugD 和 drugE）代表候选药物。
# 哪种疗法对胆固醇的下降量（因变量）贡献最大呢？
install.packages("multcomp")                               # ①各组样本量、各组均值、各组标准差 和 95%置信区间
library(dplyr)                                             # ①各组样本量、各组均值、各组标准差 和 95%置信区间
data(cholesterol, package = "multcomp")                    # ①各组样本量、各组均值、各组标准差 和 95%置信区间
plotdata <- cholesterol %>%                                # ①各组样本量、各组均值、各组标准差 和 95%置信区间
  group_by(trt) %>%                                        # ①各组样本量、各组均值、各组标准差 和 95%置信区间
  summarise(n = n(),                                       # ①各组样本量、各组均值、各组标准差 和 95%置信区间     
            mean = mean(response),                         # ①各组样本量、各组均值、各组标准差 和 95%置信区间  
            sd = sd(response),                             # ①各组样本量、各组均值、各组标准差 和 95%置信区间
            ci = qt(0.975, df = n - 1) * sd / sqrt(n))     # ①各组样本量、各组均值、各组标准差 和 95%置信区间
plotdata
## A tibble: 5 × 5
#trt        n  mean    sd    ci
#<fct>  <int> <dbl> <dbl> <dbl>
#  1 1time     10  5.78  2.88  2.06
#2 2times    10  9.22  3.48  2.49
#3 4times    10 12.4   2.92  2.09
#4 drugD     10 15.4   3.45  2.47
#5 drugE     10 20.9   3.35  2.39

fit <- aov(response ~ trt, data = cholesterol)             # ②检验组间差异（ANOVA）

summary(fit)
#Df Sum Sq Mean Sq F value   Pr(>F)    
#trt          4 1351.4   337.8   32.43 9.82e-13 ***
#  Residuals   45  468.8    10.4                     
#---
#  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

library(ggplot2)                                           # ③绘制各组均值及其置信区间的图形
ggplot(plotdata,                                           # ③绘制各组均值及其置信区间的图形
       aes(x = trt, y = mean, group = 1)) +                # ③绘制各组均值及其置信区间的图形
  geom_point(size = 3, color = "red") +                    # ③绘制各组均值及其置信区间的图形  
  geom_line(linetype = "dashed",  color = "darkgrey") +    # ③绘制各组均值及其置信区间的图形
  geom_errorbar(aes(ymin = mean - ci,                      # ③绘制各组均值及其置信区间的图形
                    ymax = mean + ci),                     # ③绘制各组均值及其置信区间的图形
                width = .1) +                              # ③绘制各组均值及其置信区间的图形
  theme_bw() +                                             # ③绘制各组均值及其置信区间的图形
  labs(x = "Treatment",                                    # ③绘制各组均值及其置信区间的图形
       y = "Response",                                     # ③绘制各组均值及其置信区间的图形
       title = "Mean Plot with 95% Confidence Interval")   # ③绘制各组均值及其置信区间的图形


# 从结果可以看到，每10位患者接受其中一种药物疗法①
# 均值显示 drugE 降低胆固醇最多，而 1times 降低胆固醇最少②，各组的标准差相对恒定，在2.88到3.48间浮动。
# 我们假设这项研究中的每个治疗组都是来自可以接受治疗的大规模潜在患者群中的一组样本。
# 针对每种疗法，样本均值+/- ci 所得到的区间在 95%的置信度上包含总体均值。
# ANOVA 对治疗方式(trt)的F检验非常显著（p < 0.0001），说明5种疗法的效果不同②。

# ggplot2函数可以用来绘制带有置信区间的组均值图形③。
# 图形展示了带有95%的置信区间的各疗法均值，我们可以清楚地看到它们之间的差异。
# 代码生成了：5种降低胆固醇药物疗法的均值，含95%的置信区间
# 图中，我们一并输出了置信区间，显示了对总体均值估计的确定（或不确定）的程度。
