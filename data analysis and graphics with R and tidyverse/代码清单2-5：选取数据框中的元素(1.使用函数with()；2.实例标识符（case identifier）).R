# 选取数据框中元素的方式有若干种，我们可以使用前述（如矩阵种的）下标记号，也可直接指定列名

# 代码清单2-5：选取数据框中的元素(1.使用函数with()；2.实例标识符（case identifier）)
patientID <- c(1, 2, 3, 4)
age <- c(25, 34, 28, 52)
diabetes <- c("Type1", "Type2", "Type1", "Type1")
status <- c("Poor", "Improved", "Excellent", "Poor")
patientdata <- data.frame(patientID, age, diabetes, status)

patientdata[1:2] # 通过正整数索引（单个默认是i[列]）选取数据框中的特定列

patientdata[c("diabetes", "status")] # 通过名称选取数据框中的特定列

patientdata$age # 通过【美元符号$】选取patientdata数据框中的变量age

table(patientdata$diabetes, patientdata$status) # 生成糖尿病类型变量diabetes和病情变量status的列联表（各种变量组合的频数/比例）


# 在每个变量名前都输入一次patientdata$可能会让人生厌，所以不妨走一些捷径，比如，可以使用函数with()来简化代码
# 1.使用函数with() 【一次性创建数据内所有变量】
# 我们以内置的数据框mtcars为例。这个数据框中包含了32种车型的燃油效率数据。以下代码汇总了mpg（每加仑汽油行驶英里数）变量，还绘制了mpg与disp（发动机排量）和wt（汽车重量）之间关系的图形
summary(mtcars$mpg)
plot(mtcars$mpg, mtcars$disp)
plot(mtcars$mpg, mtcars$wt)
# 我们可以将以上代码模式简写如下：
with(mtcars, {
  summary(mpg)
  plot(mpg, disp)
  plot(mpg, wt)
})
# 花括号{}之间的语句都针对数据框mtcars执行。如果仅有一条语句（例如summary(mpg)），那么花括号{}可以省略
# 函数with()的局限性在于，赋值仅在此函数的括号内生效。请看以下代码：
with(mtcars, {
  stats <- summary(mpg)
  stats
})
stats
# 如果需要创建在with()结构以外存在的对象，那么我们使用特殊赋值符（<<-）替代标准赋值符（<-）即可，它可将对象保存到with()之外的全局环境中。以下代码演示了这一技巧
with(mtcars, {
  nokeepstats <- summary(mpg)
  keepstats <<- summary(mpg)
})
nokeepstats
keepstats

# 2.实例标识符（case identifier）
# 在病例数据集中，patientID用于区分数据集中不同的观测值。在R中，实例标识符（case identifier）可通过函数data.frame()中的rowname选项指定。例如
patientdata <- data.frame(patientID, age, diabetes,
                          status, row.names = patientID) # 将patientID指定为R中标记各类打印输出和图形中实例名称所用的变量