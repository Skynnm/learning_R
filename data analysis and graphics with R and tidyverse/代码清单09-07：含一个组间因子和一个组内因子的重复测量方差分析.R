# 重复测量方差分析 = 单因素组内方差分析

# 代码清单9-7：含一个组间因子和一个组内因子的重复测量方差分析
# 【所谓重复测量方差分析，即受试者被测量不止一次】
# 本节重点关注含一个组内和一个组间因子的重复测量方差分析（这是一个常见的设计）
# 示例来源于生理生态学领域，研究方向是生命系统的生理和生化过程如何影响环境因素的变异（此为应对全球变暖的一个非常重要的研究领域）
# R 基础安装包中的 CO2 数据集包含了北方和南方牧草类植物 Echinochloa crus-galli（Potvin、Lechowicz、Tardif，1990）的寒冷容忍度研究结果，在某浓度二氧化碳的环境中，对寒带植物与非寒带植物的光合作用率进行了比较。
# 研究所用植物一半来自于加拿大的魁北克省（Quebec），另一半来自美国的密西西比州（Mississippi）

# 在本例中，我们关注寒带植物。因变量是二氧化碳吸收量（uptake），单位为 ml/L
# 自变量是植物类型 Type（魁北克省 VS. 密西西比州）和 7种水平（95-1000 μmol/m^2sec）的二氧化碳浓度（conc）
# 另外，Type 是组间因子，conc是组内因子。
# Type已经被存储为一个因子变量，但我们还需要先将conc转换为因子变量。
data(CO2)
CO2$conc <- factor(CO2$conc)
w1b1 <-subset(CO2, Treatment == 'chilled')
fit <- aov(uptake ~ conc*Type + Error(Plant/(conc)), w1b1)         # Error（）内是组内因子
summary(fit)
#Error: Plant
#          Df Sum Sq Mean Sq F value  Pr(>F)   
#Type       1 2667.2  2667.2   60.41 0.00148 **                    # 主效应类型
#Residuals  4  176.6    44.1                   
#---
#Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#
#Error: Plant:conc
#          Df Sum Sq Mean Sq F value   Pr(>F)    
#conc       6 1472.4  245.40   52.52 1.26e-12 ***                  # 主效应浓度
#conc:Type  6  428.8   71.47   15.30 3.75e-07 ***                  # 交叉效应
#Residuals 24  112.1    4.67                     
#---
#Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

library(dplyr)
stats <- CO2 %>%
  group_by(conc, Type) %>%
  summarise(mean_conc = mean(uptake))

library(ggplot2)
ggplot(data = stats, aes(x = conc, y = mean_conc,
                         group = Type, color = Type, linetype = Type)) +
  geom_point(size = 2) +
  geom_line(size = 1) +
  theme_bw() + theme(legend.position = "top") +
  labs(x = "Concentration", y = "Mean Uptake",
       title = "Interaction Plot for Plant Type and Concentration")
# 方差分析表表明在 0.01 的水平下，主效应类型和浓度及交叉效应（类型 x 浓度）都非常显著
# 代码生成了：二氧化碳浓度和植物类型对二氧化碳吸收量的交互影响
# 该图展示了交互效应，在该图中，省略去了置信区间，使图形看上去更简洁



# 若想展示交互效应的不同侧面，可以使用 geom_boxplot() 函数对相同的数据绘制图形
library(ggplot2)
ggplot(data = CO2, aes(x = conc, y = uptake, fill = Type)) +
  geom_boxplot() +
  theme_bw() + theme(legend.position = "top") +
  scale_fill_manual(values = c("aliceblue", "deepskyblue")) +
  labs(x = "Concentration", y = "Uptake",
       title = "Chilled Quebec and Mississippi Plants")
# 以上代码生成了：二氧化碳浓度和植物类型对二氧化碳吸收量的交互影响。


# 从以上任意一幅图都可以看出，魁北克省的植物比密西西比州的植物二氧化碳吸收量高，而且随着二氧化碳浓度的升高，差异越来越明显。

#### 注意 ####
# 通常处理的数据集是【宽格式（wide format）】，即列是变量，行是观测值，而且一行一个受试者。9.4节中的litter数据集就是一个很好的例子。
# 不过在处理重复测量设计时，需要有长格式（long format）数据才能拟合模型。
# 在长格式中，因变量的没测测量都要放到它独有的行中，CO2数据集遵循这种格式。
# 幸运的是，第 5 章（5.5.2节）介绍的tidyr包可方便地将数据转换为所需的格式


#### 混合模型设计的各种方法 ####
# 在分析本节关于二氧化碳的例子时，我们使用了传统的重复测量方差分析。
# 该方法假设任意组内的协方差矩阵遵循一种称为球形的特定格式。
# 具体而言，该方法假设任意组内因子两水平间的方差之差都相等。
# 但在现实中这种假设不可能被满足，于是衍生了一系列备选方法：
#【】使用lme4包中的lmer()函数拟合线性混合模型；
#【】使用car包中的Anova()函数调整传统检验统计量以弥补球形假设的不满足的缺陷（例如Geisser-Greenhouse校正）；
#【】使用nlme包中的gls()函数拟合给定方差-协方差结构的广义最小二乘模型；
#【】用多元方差分析对重复测量数据进行建模。
