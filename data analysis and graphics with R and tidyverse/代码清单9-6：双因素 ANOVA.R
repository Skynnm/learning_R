# 无视中断

# 代码清单9-6：双因素 ANOVA
# 在双因素方差分析中，受试者被分配到两因子的交叉类别中。
# 我们以基础安装中的ToothGrowth数据集为例演示双因素方差分析。
# 我们随机分配60只豚鼠，分别采用两种喂食方法（橙汁或维生素C），各喂食方法中抗坏血酸含量有 3种水平（0.5mg、1mg 或 2mg），每种处理方式组合都被分配10只豚鼠。
# 牙齿长度为因变量。
library(dplyr)
data("ToothGrowth")
ToothGrowth$dose <- factor(ToothGrowth$dose)                  # ①准备数据
stats <- ToothGrowth %>%                                      # ②计算汇总统计量
  group_by(supp, dose) %>%                                    # ②计算汇总统计量
  summarise(n = n(), mean = mean(len), sd = sd(len),          # ②计算汇总统计量
            ci = qt(0.975, df = n - 1) * sd / sqrt(n))        # ②计算汇总统计量
stats
## A tibble: 6 × 6
## Groups:   supp [2]
#supp  dose      n  mean    sd    ci
#<fct> <fct> <int> <dbl> <dbl> <dbl>
#  1 OJ    0.5      10 13.2   4.46  3.19
#2 OJ    1        10 22.7   3.91  2.80
#3 OJ    2        10 26.1   2.66  1.90
#4 VC    0.5      10  7.98  2.75  1.96
#5 VC    1        10 16.8   2.52  1.80
#6 VC    2        10 26.1   4.80  3.43

fit <- aov(len ~ supp*dose, data = ToothGrowth)               # ③拟合双因素 ANOVA模型
summary(fit)
#                 Df Sum Sq Mean Sq F value   Pr(>F)    
#  supp         1  205.4   205.4  15.572 0.000231 ***
#  dose         2 2426.4  1213.2  92.000  < 2e-16 ***
#  supp:dose    2  108.3    54.2   4.107 0.021860 *  
#  Residuals   54  712.1    13.2                     
#---
#  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1


# 首先，dose 变量转换为因子变量，这样 aov() 函数就会将它当作一个分组变量，而不是一个数值型协变量①。
# 接下来，计算每种处理方式组合的汇总统计量（n、均值、标准差 和 均值的置信区间）②
# 样本量表明我们采用的是均衡设计（每个设计单元的样本量相同）
# 对数据进行双因素 ANOVA 模型拟合③
# summary() 函数表明主效应（supp. 和 dose）和因子之间的交互效应都非常显著。

# 我们可以用多种方式对结果进行可视化处理，包括基础 R 中的 interaction.plot() 函数、gplots包中的plotmeans()函数和HH包中的interaction2wt()函数。
# 下面的代码中我们用ggplot2绘制双因素方差分析的均值及其95%置信区间。
# 使用ggplot2的一个好处是我们可以自定义图形以满足我们的研究需要和审美需求。
library(ggplot2)
pd <- position_dodge(0.2)
ggplot(data = stats,
        aes(x = dose, y = mean,
            group = supp,
            color = supp,
            linetype = supp)) + 
  geom_point(size = 2,
             position = pd) +
  geom_line(position = pd) +
  geom_errorbar(aes(ymin = mean - ci, ymax = mean + ci),
                width = .1,
                position = pd) +
  theme_bw() +
  scale_color_manual(values = c("blue", "red")) +
  labs(x = "Dose",
       y = "Mean length",
       title = "Mean Plot with 95% Confidence Interval")
# 代码生成了：喂食方法和含量对牙齿生长的交互作用。牙齿长度的均值图是使用 ggplot2 函数创建的。

# 代码生成的图表明随着橙汁和维生素C中的抗坏血酸含量的增加，牙齿长度变长。
# 对于 0.5mg 和 1mg 含量，橙汁比维生素C更能促进牙齿生长；对于2mg含量的抗坏血酸，在使用两种喂食方法时牙齿长度增长相同。

# 虽然此处没有涵盖模型假设检验和均值比较的内容，但是它们是之前方法的自然延申。
# 此外，该设计是均衡的，故而不用担心效应顺序的影响。