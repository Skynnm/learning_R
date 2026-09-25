# 无视中断

# 代码清单9-5-1：结果的可视化
# 我们可以用 ggplot2 包可视化因变量、协变量 和 因子之间的关系
fit2 <- aov(weight ~ gesttime * dose, data = litter)
pred <- predict(fit)
library(ggplot2)
ggplot(data = cbind(litter, pred),
       aes(gesttime, weight)) + geom_point() +
  facet_wrap(~ dose, nrow = 1) + geom_line(aes(y = pred)) +
  labs(title = "ANCOVA for weight by gesttime and dose") +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        legend.position = "none")
# 生成：4个药物处理组的怀孕时间和出生体重的关系图

# 从图中可以看出，每个组用怀孕时间来预测出生体重的回归拟合线相互平行，只是截距项不同。
# 随着怀孕时间增加，幼崽出生体重也会增加。
# 另外，还可以看到0剂量组截距项最大，5剂量组截距项最小。
# 由于上面的设置，直线会保持平行，如果使用以下代码
ggplot(data = litter, aes(gesttime, weight)) +
  geom_point() + geom_smooth(method = "lm", se = FALSE) +
  facet_wrap(~ dose, nrow = 1)
# 生成的图形将允许斜率和截距项依据组别而发生变化，这对可视化那些违背回归斜率同质性的示例非常有用。
