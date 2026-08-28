# 公共索引 → 共有变量

# 代码清单3-5-4：切分数据集
# R 拥有强大的索引特性，可以用于访问对象中的元素。我们也可以利用这些特性对变量或观测值进行选入和排除。以下几节演示了对变量和观测值进行保留或删除的若干方法。

#### 选取变量
# 从一个大型数据集中选择有限数量的变量来创建一个新的数据集是常有的事。
# 在第2章中，数据框中的元素是通过 dataframe[row indices, column indices] 这样的表示法来访问的。我们可以沿用这种方法来选择变量。例如：
newdata <- leadership[ , c(6:10)]
# 从 leadership 数据框中选择了变量q1, q2, q3, q4 和 q5，并将它们保存到了数据框 newdata 中。将行下标留空( , )表示默认选择所有行

# 语句
vars <- c("q1", "q2", "q3", "q4", "q5")
newdata <- leadership[ , vars]
# 实现了等价的变量选择。这里，（引号中的）变量名充当了列的下标，因此选择的列是相同的

# 如果只提供了数据框中的一组下标，则 R 认为我们要取列的子集。在下面的语句中，假设使用了逗号，并提取了相同子集的变量。
newdata <- leadership[vars]

# 最后，我们可以写：
myvars <- paste("q", 1:5, sep = "")
newdata <- leadership(myvars)
# 本例使用 paste() 函数创建了与上例中相同的字符型向量。paste() 函数作用是：【连接字符串，分隔符为sep】



#### 剔除变量
# 剔除变量的原因有很多。举例来说，如果某个变量中有很多缺失值，我们可能就想在进一步分析之前将其丢弃。下面是一些剔除变量的方法。
# 我们可以使用语句：
myvars <- names(leadership) %in% c("q3", "q4")
newdata <- leadership[!myvars]

# 剔除变量 q3 和 q4。为了理解以上语句的原理，我们需要把它拆解如下：
# （1）names(leadership)生成了一个包含所有变量名的字符型向量：
c("managerID", "testDate", "country", "gender", "age", "q1", "q2", "q3", "q4", "q5")
# （2）names(leadership) %in% c("q3", "q4") 返回了一个逻辑型向量，names(leadership)中每个匹配q3或q4的元素值为TRUE，反之为FALSE：
c(FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, TRUE, TRUE, FALSE)
# （3）运算符非（!）将逻辑值反转：
c(TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, FALSE, FALSE, TRUE)
# （4）leadership[c(TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, FALSE, FALSE, TRUE)]选择了逻辑值为TRUE的列，于是q3和q4被剔除了

# 在知道q3和q4是第8个和第9个变量的情况下，可以使用语句：
newdata <- leadership[c(-8, -9)]
# 将它们剔除。这种方式的工作原理是，在某一列的下标之前加一个减号（-）就会剔除那一列。

# 相同的变量删除工作也可通过：
leadership$q3 <- leadership$q4 <- NULL
# 来完成。这回我们将q3和q4两列设为了未定义（NULL）。注意，NULL与NA（表示缺失值）是不同的

# 丢弃变量是保留变量的逆操作。选择哪一种方式进行变量筛选依赖于两种方式的编码难易程度。如果有许多变量需要丢弃，那么直接保留需要留下的变量可能更简单，反之亦然。



#### 选入观测值
# 选入或剔除观测值（行）通常是成功的数据准备和数据分析的一个关键方面。
# 代码清单3-6：选入观测值
newdata <- leadership[1:3, ]                        # ①选择第1行到第3行（前三个观测值）
newdata <- leadership[leadership$gender == "M" &    # ②③选择所有30岁以上的男性
                        leadership$age > 30, ]      # ③选择所有30岁以上的男性
# 在以上每个示例中，我们只提供了行下标，并将列下标留空（故选入了所有列）。我们来拆解②处代码以便理解它：
# （1）逻辑比较 leadership$gender == "M" 生成了向量 c(TRUE, FALSE, FALSE, TRUE, FALSE)
# （2）逻辑比较 leadership$age > 30 生成了向量c(TRUE, TRUE, FALSE, TRUE, TRUE)
# （3）逻辑比较 c(TRUE, FALSE, FALSE, TRUE, FALSE) & c(TRUE, TRUE, FALSE, TRUE, TRUE) 生成了向量 c(TRUE, FALSE, FALSE, TRUE, FALSE)
# （4）leadership[c(TRUE, FALSE, FALSE, TRUE, FALSE), ]从数据框中选择了第 1 个和第 4 个观测值（当对应行的索引是 TRUE，这一行被选入；当对应行的索引是FALSE，这一行被剔除）。这就满足了我们的选取标准（30岁以上的男性）


# 在本章开始的部分，我们曾经提到，我们可能希望将研究范围限定在 2009年1月1日 到 2009年12月31日 之间收集的观测值上。怎么做呢？这里有一个办法。
leadership$date <- as.Date(leadership$date, "%m / %d / %y")   # ①将读入的字符型日期值转换为 mm/dd/yy 形式的日期型变量
startdate <- as.Date("2009-01-01")                            # ②创建开始日期
enddate <- as.Date("2009-12-31")                              # ③创建结束日期
newdata <- leadership[which(leadership$date >= startdate &    # ④按照上例的方法选择满足条件的个案
                              leadership$date <= enddate), ]  # ④按照上例的方法选择满足条件的个案
# 注意，由于 as.Date() 函数的默认格式就是 yyyy-mm-dd，所以无需在这里提供这个参数

## subset() 函数
# 前两节中的示例很重要，这些示例辅助描述了逻辑型向量和比较运算符在R中的解释方式。
# 【理解这些例子的工作原理在总体上将有助于我们对R代码的解读】
# 既然我们已经用笨办法完成了任务，现在不妨来看一种简便方法。
# 【使用subset()函数大概是选择变量和观测值的最简单的办法了】
# 两个示例如下：
newdata <- subset(leadership, age >= 35 | age < 23,           # ①选择年龄在35岁（含）以上或23岁（不含）以下的所有观测值，并保留了变量q1到q4
                  select = c(q1, q2, q3, q4))                 # ①选择年龄在35岁（含）以上或23岁（不含）以下的所有观测值，并保留了变量q1到q4

newdata <- subset(leadership, gender == "M" & age > 25,       # ②选择年龄在25岁（不含）以上的男性，并保留了变量gender到q4（变量gender和q4，以及两个变量之间的所有列）
                  select = gender:q4)                         # ②选择年龄在25岁（不含）以上的男性，并保留了变量gender到q4（变量gender和q4，以及两个变量之间的所有列）
# 我们在第2章中已经看到了用来生成一系列数值的冒号运算符。在取子集函数中，from:to返回数据框中变量from到变量to包含的所有变量，同时包括这两个变量

## 随机抽样
# 在数据挖掘和机器学习领域，从更大的数据集中抽样是很常见的作法。举例来说，我们可能希望选择两份随机样本，使用其中一份样本构建预测模型，使用另一份样本验证模型的有效性。
# sample() 函数能够让我们从数据集中（有放回或无放回地）抽取大小为n的一个随机样本。
# 我们可以使用以下语句从 leadership 数据框中随机抽取一个大小为 3 的样本：
mysample <- leadership[sample(1:nrow(leadership), 3, replace = FALSE),]
# sample() 函数中的第1个参数是一个由要从中抽样的元素组成的向量。在这里，这个向量是1到数据框中观测值的数量，第2个参数是要抽取的元素数量，第3个参数表示无放回抽样。
# sample() 函数会返回随机抽样得到的元素，之后即可用于选择数据框中的行
# R 中拥有齐全的抽样工具，包括抽取和校正调查样本（见sampling包）以及分析复杂调查数据（见 survey包）的工具。其他依赖于抽样的方法，包括重抽样统计方法和自助法，详见第12章


