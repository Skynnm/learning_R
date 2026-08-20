# 计算机系统层次结构

# 代码清单5-7：控制流（一个switch示例）
# 在正常情况下，R 中的语句是从上至下顺序执行的。但是，有时我们可能希望重复执行某些语句，仅在满足特定条件的情况下执行另外的语句。这就是控制流结构发挥作用的地方了。
# R 则拥有一般现代编程语言中都有的标准控制结构。首先，我们将看到用于循环执行的结构，接下来，学习用于条件执行的结构。
# 为了理解贯穿本节的语法示例，请牢记以下概念：
# 【】语句（statement）是一条单独的R语句或一组复合语句（包含在花括号{}中的一组R语句，使用分号分隔）
# 【】条件（cond）是一条最终被解析为真（TRUE）或假（FALSE）的表达式
# 【】表达式（expr）是一条数值或字符串的求值语句
# 【】序列（seq）是一个数值或字符串序列
# 在讨论过控制流的构造后，我们将学习如何自定义函数

######## 重复和循环 ########
# 循环结构重复地执行一个或一系列语句，直到某个条件不为真为止。循环结构包括 for 结构 和 while 结构。

#### for 结构 ## 
# for循环重复地执行一个语句，直到某个变量的值不再包含在序列 seq 中为止。语法为：
for (variable in vector) {
  statement
}
# 在下例中：
for (i in 1:10) print("Hello")  # 单词 Hello 被输出了10次

#### while 结构 ##
# while循环重复地执行一个语句，直到条件不为真为止。语法为：
while (cond) statement
# 作为第2个示例，代码：
i <- 10
while (i > 0) {print("Hello") ; i <- i - 1}
# 又将单词Hello输出了10次。请确保括号内 while 的条件语句能够改变，即让它在某个时刻不再为真，否则循环将用不停止！在上例中，语句：
i <- i - 1
# 在每步循环中为对象 i 减去 1，这样在 10 次循环过后，它就不再大于 0 了。反之，如果再每步循环都加 1 的话，R将不停地输出Hello。这也是while循环可能较其他循环结构更加危险的原因。
# 【在处理大型数据集中的行和列时，R 中的循环可能比较低效。只要可能，最好联用R中的内建数值/字符处理函数和apply族函数】


######## 条件执行 ########
# 在条件执行结构中，一条或一组语句仅在满足一个指定条件时执行。条件执行结构包括if-else、ifelse 和 switch

#### if-else结构 ##
# 控制结构if-else在某个给定条件为真时执行语句，也可以同时在条件为假时执行另外的语句。语法为：
if (cond) statement
if (cond) statement else statement2
# 在此举两个示例：
if (is.character(grade)) grade <- as.factor(grade)
if (!is.factor(grade)) grade <- as.factor(grade) else print("Grade already is a factor")
# 在第1个示例中，如果 grade 是一个字符向量，它就会被转换为一个因子。在第2个示例中，两个语句择其一执行。如果grade不是一个因子（注意符号！），它就会被转换为一个因子，如果它是因子，就会输出一段信息

#### ifelse结构 ##
# ifelse结构是if-else结构比较紧凑的向量化版本，其语法为：
ifelse(cond, statement1, statement2)
# 若cond为TRUE，则执行第1个语句；若cond为FALSE，则执行第2个语句。示例如下：
ifelse(score > 0.5, print("Passed"), print("Failed"))
outcome <- ifelse(score > 0.5, "Passed", "Failed")
# 在程序的行为是二元时，或者希望结构的输入和输出均为向量时，请使用ifelse

#### switch结构 ##
# switch 根据一个表达式的值选择语句执行。语法为：
switch (expr, ...)
# 其中的...表示与expr的各种可能输出值绑定的语句。通过观察代码清单5-7中的代码，可以轻松地理解switch的工作原理
feelings <- c("sad", "afraid")
for (i in feelings) {
  print(
    switch (i,
      happy = "I am glad you are happy",
      afraid = "There is nothing to fear",
      sad = "Cheer up",
      angry = "Calm down now"
    )
  )
}
#[1] "Cheer up"
#[1] "There is nothing to fear"

# 虽然这个示例比较幼稚，但它展示了 switch 的主要功能。我们将在下一节中学习如何使用 switch 自定义函数。