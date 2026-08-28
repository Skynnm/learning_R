# 我们的目标同往常一样，都是更好地理解数据，并把得到的知识与他人沟通

# 代码清单6-2：堆积、分组 和 填充条形图
# 关节炎新疗法研究中的核心问题是：使用安慰剂和药物治疗这两种方式对病情的改善有何差异？
# 可以使用函数table()来生成变量的交叉表：
table(Arthritis$Improved, Arthritis$Treatment)
#       Placebo Treated
#None        29      13
#Some         7       7
#Marked       7      21
# 虽然这个表格很有用，但是使用条形图更易于理解结果。
# 两个分类变量之间的关系可使用堆积条形图、分组条形图 和 填充条形图 进行绘制。
library(ggplot2)
ggplot(Arthritis, aes(x = Treatment, fill = Improved)) +    # ①堆积条形图
  geom_bar(position = "stack") +                            # ①堆积条形图
  labs(title = "Stacked Bar chart",                         # ①堆积条形图
       x = "Treatment",                                     # ①堆积条形图
       y = "Frequency")                                     # ①堆积条形图

ggplot(Arthritis, aes(x = Treatment, fill = Improved)) +    # ②分组条形图
  geom_bar(position = "dodge") +                            # ②分组条形图
  labs(title = "Grouped Bar chart",                         # ②分组条形图
       x = "Treatment",                                     # ②分组条形图
       y = "Frequency")                                     # ②分组条形图

ggplot(Arthritis, aes(x = Treatment, fill = Improved)) +    # ③填充条形图
  geom_bar(position = "fill") +                             # ③填充条形图
  labs(title = "Filled Bar chart",                          # ③填充条形图
       x = "Treatment",                                     # ③填充条形图
       y = "Frequency")                                     # ③填充条形图

# 堆积条形图中，每一段代表在给定的治疗方式（Placebo、Treated）和改善情况（None、Some、Marked）组合下的病例的频数或百分比。在堆积条形图中，对于每个指令方式单独堆积图块。
# 分组条形图将每个治疗方式中代表改善情况的图块并排放在一起。
# 填充条形图是调整比例后的堆积条形图，因此每个条的高度都为1，段的高度代表百分比。

# 代码生成了：堆积、分组 和 填充条形图。

# 在比较一个分类变量的各水平在另一个分类变量各水平中的占比时，填充条形图非常有用。
# 例如上述代码生成的填充条形图清晰地展示了接受药物治疗后病情得到显著改善的患者比例大于接受安慰剂治疗的患者。
