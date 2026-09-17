# 组间因子
# 组内因子
# 均衡设计（balanced design）
# 非均衡设计（unbalanced design）
# 单因素方差设计（one-way ANOVA）
# 单因素组间方差设计
# 单因素组内方差设计（one-way within-groups ANOVA）——重复测量方差分析（repeated measures ANOVA）
# 因素方差分析设计（factorial ANOVA design）：当设计包含两个甚至更多因子时
# 混合模型方差分析（mixed-model ANOVA）：包含两个甚至更多因子，而且又有组内因子，又有组间因子

# 混淆因素（confounding factor）
# 干扰变量（nuisance variable）

# 协方差分析（analysis of covariance）：对混淆因素/干扰变量的组间差异进行统计性调整

# 多元方差分析（MANOVA）：因变量不止一个
# 多元协方差分析（MANCOVA）


# 代码清单9-0-2：aov() 函数
# 【虽然方差分析和回归方法都是独立发展而来的，但是从函数形式上，他们都是广义线性模型的特例】
# 用第 8 章讨论回归时用到的 lm() 函数也能分析 ANOVA 模型
# 不过，本章中，我们基本都使用 aov() 函数。
# 两个函数的结果是等同的，但 ANOVA 的使用者更熟悉 aov() 函数展示结果的格式
# 为保证完整性，在本章最后我们将提供一个使用 lm() 的例子


# 【aov() 函数的语法为 aov(formula, data = dataframe)】
# 下表列举了表达式中可以使用的特殊符号
# 下表中的 y 是因变量，字母 A、B、C 代表因子

# 符号      用法
# ~         分隔符号，左边为因变量，右边为自变量。例如，用A、B 和 C 预测 y，代码为：y ~ A + B + C
# :         表示变量的交互项。例如，用A、B 和 A与B的交互项来预测y，代码为：y ~ A + B + A:B
# *         表示所有可能交互项。代码y ~ A*B*C 可展开为：y ~ A + B + C + A:B + A:C + B:C + A:B:C
# ^         表示交互项达到某个次数。代码 y ~ （A + B + C)^2 可展开为 y ~ A + B + C + A:B + A:C + B:C
# .         表示包含除因变量外的所有变量。例如，若一个数据框包含变量y、A、B 和 C，代码 y ~ . 可展开为 y ~ A + B + C



# 下表列举了一些常见的实验设计表达式。（下表中，小写字母表示连续型变量，大写字母表示分组因子，Subject是对受试者进行唯一标识的标识变量）
# 设计                                                 表达式
# 单因素 ANOVA                                          y ~ A
# 含单个协变量的单因素 ANOVA                            y ~ x + A
# 双因素 ANOVA                                          y ~ A*B
# 含两个协变量的双因素 ANOVA                            y ~ x1 + x2 + A*B
# 随机化区组                                            y ~ B + A（B为分组因子）
# 单因素组内 ANOVA                                      y ~ A + Error(Subject/A)
# 含单个组内因子(W)和单个组间因子(B)的重复测量 ANOVA    y ~ B*W + Error(Subject/W)