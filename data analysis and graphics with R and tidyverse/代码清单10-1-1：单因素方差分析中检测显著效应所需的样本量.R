# 重复

# 代码清单10-1-1：单因素方差分析中检测显著效应所需的样本量
library(pwr)
es <- seq(.1, .5, .01)
nes <- length(es)

samsize <- NULL
for (i in 1:nes){
  result <- pwr.anova.test(k = 5, f = es[i], sig.level = .05, power = .9)
  samsize[i] <- ceiling(result$n)
}

plotdata <- data.frame(es, samsize)
library(ggplot2)
ggplot(plotdata, aes(x = samsize, y = es)) +
  geom_line(color = "red", size = 1) +
  theme_bw() +
  labs(title = "One Way ANOVA (5 groups)",
       subtitle = "Power = 0.90, Alpha = 0.05",
       x = "Sample Size (per group)",
       y = "Effect Size")
# 上面代码生成了5分组的单因素方差分析中检测各效应值所需的样本量（假定0.90的功效和0.05的显著性水平）

# 在实验设计中，这样的图形有助于估计不同条件的影响值
# 例如，从图中可以看到各组样本量高于200个观测值时，再增加样本已经效果不大了。
# 下一节我们将再看看其他图形示例