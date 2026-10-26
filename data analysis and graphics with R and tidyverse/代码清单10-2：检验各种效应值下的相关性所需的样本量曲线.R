# Just do it

# 代码清单10-2：检验各种效应值下的相关性所需的样本量曲线
# 结束pwr包的探讨前，我们再学习一个涉及面更广的绘图示例
# 假设对于相关系数统计显著性的检验，我们想计算一系列效应值和功效水平下所需的样本量
# 此时可用pwr.r.test()函数和for循环来完成任务
library(pwr)
r <- seq(.1, .5, .01)                                            # ①生成一系列相关系数和功效值
p <- seq(.4, .9, .1)                                             # ①生成一系列相关系数和功效值

df <- expand.grid(r, p)                           
colnames(df) <- c("r", "p")

for (i in 1:nrow(df)) {                                          # ②获取样本量
  result <- pwr.r.test(r = df$r[i],                              # ②获取样本量
                       sig.level = .05, power = df$p[i],         # ②获取样本量
                       alternative = "two.sided")                # ②获取样本量
  df$n[i] <- ceiling(result$n)                                   # ②获取样本量
}                                                                # ②获取样本量

library(ggplot2)                                                 # ④绘制功效曲线
ggplot(data = df,                                                # ④绘制功效曲线
       aes(x = r, y = n, color = factor(p))) +                   # ④绘制功效曲线
  geom_line(size = 1) +                                          # ④绘制功效曲线
  theme_bw() +                                                   # ④绘制功效曲线
  labs(title = "Sample Size Estimation for Correlation Studies", # ④绘制功效曲线
       subtitle = "Sig = 0.05 (Two-tailed)",                     # ④绘制功效曲线
       x = "Correlation Coefficient (r)",                        # ④绘制功效曲线
       y = "Sample Size (n)",                                    # ④绘制功效曲线
       color = "Power")                                          # ④绘制功效曲线

# 上述代码清单适用 seq() 函数来生成一系列的效应值r（H1时的相关系数）和功效水平p ①
# 函数 expand.grid() 对这两个变量的每一个组合生成一个数据框
# 然后，利用 for 循环来遍历数据框的行，根据各行的相关性和功效水平计算所对应的样本量，并保存结果 ②
# ggplot2 包绘制了每个功效水平下样本量与相关系数的曲线图 ③
# 图：在不同功效水平下检测到显著的相关性所需的样本量
# 线条从下往上依次代表功效水平 0.4、0.5、0.6，一直到0.9

# 从图中可以看到，在40%的置信度下，要检测到0.20的相关性，需要约75的样本量。
# 在90%的置信度下，要检测到相同的相关性，需要大约185各额外的观测（n=260）
# 做少许改动，这个方法便可以用来为许多统计检验创建样本量和功效的曲线图
