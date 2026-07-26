# 脚本是一个纯文本文件，可以用它编写和保存代码

#         单一数据类型           多种数据类型
# 一维    向量（vector）         列表（list）
# 二维    矩阵（matrix）         数据框（dataframe）
# 三维    数组（array）

# 项目3：老虎机
# （1）将复杂的任务分解为一些简单的子任务：A.有序步骤（sequential step）;B.同类情况（parallel case）
# （2）使用实例
# （3）用通俗的语言描述解决方案，然后将其转换成R代码
# 程序就是指导计算机一步步执行操作的指令集合。将这些指令凑在一起，可以解决一些非常非常复杂的问题。

# 步骤1：生成符号组合
# 步骤2：显示符号组合
# 步骤3：根据符号组合计算中奖金额

get_symbols <- function() {
  wheel <- c("DD", "7", "BBB", "BB", "B", "C", "0")
  sample(wheel, size = 3, replace = TRUE,
         prob = c(0.03, 0.03, 0.06, 0.1, 0.25, 0.01, 0.52))
}

score <- function(symbols) {
  # 识别情形
  same <- symbols[1] == symbols[2] && symbols[2] == symbols[3]
  bars <- symbols %in% c("B", "BB", "BBB")
  
  # 计算中奖金额
  if (same) {
    payouts <- c("DD" = 100, "7" = 80, "BBB" = 40, "BB" = 25,  # 查找表（lookup table）：隐式向量循环 + 名称索引
                 "B" = 10, "C" = 10, "0" = 0)                  # 也是向量化代码的原理：逻辑测试、取子集、元素方式执行
    prize <- unname(payouts[symbols[1]])
  } else if (all(bars)) {
    prize <- 5
  } else {
    cherries <- sum(symbols == "C")
    prize <- c(0, 2, 5)[cherries + 1]
  }
  
  # 根据钻石的个数调整中奖金额
  diamonds <- sum(symbols == "DD")
  prize * 2 ^ diamonds
}

play <- function() {
  symbols <- get_symbols()
  structure(score(symbols), symbols = symbols)
}
play()

slot_display <- function(prize) {
  # 提取符号输出结果
  symbols <- attr(prize, "symbols")
  
  # 将所有的符号压缩为一个字符串
  symbols <- paste(symbols, collapse = " ")
  
  # 用正则表达式将符号与奖金信息组合起来
  # 在正则表达式中\n表示另起一个新行（相当于是按下回车键）
  string <- paste(symbols, prize, sep = "\n")
  
  # 在控制台上显示正则表达式的结果，但是去掉其中的引号
  cat(string)
}

slot_display(play())

# 用if 和 else语句处理不同的情形
# 用R对象和取子集的方法创建一个查找表
# 用#给代码添加注释
# 用function函数将所写的程序包装成函数

# R 的S3系统有三个组成部分：属性（attribute）（尤其是class属性）、泛型函数（generic function） 和 方法（method）
# 由泛型函数、方法 和 基于类的分派方式所构成的系统就是R的S3系统，S3系统使得R函数能够在不同的场合有不同的表现。
# 每一个S3方法的名称都包含两个部分。前一部分指明该方法对应的函数，后一部分则指明类属性。这两个部分的名称用英文句点.分隔：print.function、summary.matrix
# UseMethod

# 在R中存储信息并非只能通过赋值的方式；创建某种特殊的行为也不一定只能通过编写函数来实现。这两个任务都可以通过R的S3系统来完成。

# for循环可以重复运行某段代码一定的次数，重复次数取决于循环的输入中有多少个元素。
# for循环相当于是在告诉R：对于这个输入空间内的每个值都运行一遍这个代码。
# R会遍历输入集合中的所有元素，每一次都运行一遍指定代码。

# 快速的R代码经常用到三大法宝：逻辑测试、取子集 和 元素方式执行
# 向量化代码：代码可以接受一个含有多个值的向量作为输入，并且同时操作向量中的每一个元素。