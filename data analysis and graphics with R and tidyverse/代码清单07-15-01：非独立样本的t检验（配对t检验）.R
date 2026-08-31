# 参数检验/非参数检验：结果变量为连续型的组间比较

# 代码清单7-15-1：非独立样本的t检验（配对t检验）
# 再举个例子，我们可能会问：较年轻（14-24岁）男性的失业率是否比年长（35-39岁）男性的失业率更高？
# 在这种情况下，这两组数据并不独立。我们不能说亚拉巴马州的年轻男性和年长男性的失业率之间没有关系。
# 【当两组的观测值相关时，我们获得的是一个非独立组设计（dependent groups design）】
# 【前-后测设计（pre-post design）或重复测量设计（repeated measures design）同样会产生非独立的组】

# 非独立样本的t检验假定组间的差异呈正太分布。对于本例，检验的调用格式为：
t.test(y1, y2, paired = TRUE)
# 其中，y1和y2为两个非独立组的数值向量。结果如下：
install.packages("MASS")
library(MASS)
sapply(UScrime[c("U1", "U2")], function(x) (c(mean = mean(x), sd = sd(x))))
#           U1       U2
#mean 95.46809 33.97872
#sd   18.02878  8.44545
with(UScrime, t.test(U1, U2, paired = TRUE))
#                        Paired t-test
#
#data:  U1 and U2
#t = 32.407, df = 46, p-value < 2.2e-16
#alternative hypothesis: true mean difference is not equal to 0
#95 percent confidence interval:
#  57.67003 65.30870
#sample estimates:
#  mean difference 
#61.48936 

# 差异的均值（约61.5）足够大，可以保证拒绝年长男性和年轻男性的平均失业率相同的假设。
# 年轻男性的失业率更高。事实上，若总体均值相等，获取一个差异如此大的样本的概率小于2.2e-16。
