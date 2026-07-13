# 【函数的输入，要符合 function 内部规定参数】
# 【当过程中对R对象等环境参数进行修改后，自然会对输出的结果产生影响】

# 【正则表达式】，反斜杠，\(正斜杠——撇丿/，反斜杠——捺\)
# 最常用基础符号

#- `.` 任意单个字符
#- `\d` 数字 0-9
#- `\w` 字母 + 数字 + 下划线
#- `\s` 空格 / 制表符
#- `^` 开头
#- `$` 结尾
#- `*` 任意多个
#- `+` 至少 1 个
#- `?` 0 或 1 个
#- `{n}` 固定 n 位
#- `[]` 范围，`[0-9]`数字

# 练习20260713：编写自定义函数来查找和使用属性
get_symbols <- function(){
  wheel <- c("DD", "7", "BBB", "BB", "B", "C", "0")
  sample(wheel, size = 3, replace = TRUE,
         prob = c(0.03, 0.03, 0.06, 0.1, 0.25, 0.01, 0.52))
}
get_symbols()

score <- function(symbols){
  # 识别情形
  same <- symbols[1] == symbols[2] && symbols[2] == symbols[3]
  bars <- symbols %in% c("B", "BB", "BBB")
  
  # 计算中奖金额
  if(same){
    payouts <- c("DD" = 100, "7" = 80, "BBB" = 40, "BB" =25,
                 "B" = 10, "C" = 10, "0" = 0)
    prize <- unname(payouts[symbols[1]])
  } else if(all(bars)){
    prize <- 5
  } else {
    cherries <- sum(symbols == "C")
    prize <- c(0, 2, 5)[cherries + 1]
  }
  
  # 根据钻石的个数调整中奖金额
  diamonds <- sum(symbols == "DD")
  prize * 2 ^ diamonds   # 书上原代码少了 print 函数 输出
}

play <- function(){
  # 步骤1：生成符号组合
  symbols <- get_symbols()
  # 步骤2：显示符号组合
  # 为了示例学习属性，在此去掉
  # 步骤3：根据符号组合计算中奖金额
  score(symbols)
}

symbols_example <- get_symbols()
symbols_example
score(symbols_example)

play <- function(){
  symbols <- get_symbols()
  prize <- score(symbols)
  attr(prize, "symbols") <- symbols
  prize
}

prize

slot_display <- function(prize){
  # 提取符号输出结果
  symbols <- attr(prize, "symbols")
  # 将所有的符号压缩成为一个字符串
  symbols <- paste(symbols, collapse = " ")
  # 用正则表达式将符号与奖金信息组合起来
  # 在正则表达式中\n表示另起一个新行（相当于是按下一个回车键）
  string <- paste(symbols, prize, sep = "\n$")
  # 在控制台上显示正则表达式的结果，但是去掉其中的括号
  cat(string)
}

slot_display(one_play) # 在这里，one_play作为输入被传递给prize参数

# 这个函数期望的输入对象是一个像 one_play 这样的既有数值也有 symbols 属性的对象。
# 函数的第一行代码会查找 symbols 属性的值，然后将该值存储到名为 symbols 的对象。
# 我们在接下来的例子中会创建一个名为 symbols 的对象，以便了解这个函数的剩余部分到底做了些什么。可以
# 利用 one_play 的symbols 属性去完成这个任务。symbols 将是一个包含三个字符的向量

symbols <- attr(one_play, "symbols")
symbols
# [1] "B" "0" "B"

# 在下一步中，slot_display 函数使用 paste 函数将 symbols 中的三个字符压缩成了一个字符串。
# paste 函数中的 collapse 参数如果被赋值，便会将一个字符串向量中的元素压缩成单个字符串。
# paste 函数会利用 collapse 参数的值作为分隔字符串向量中不同元素的分隔符。
# 因此，symbols 将变成B 0 B，即三个字符压缩成单个字符串的效果，字符间被空格隔开。

symbols <- paste(symbols, collapse = " ")
symbols
# [1] "B 0 B"

# 然后，仍然使用 paste 函数，但是用一种新的方式将符合组合 symbols 和中奖金额 prize 组合起来。
# 在 paste 函数中设置 sep 参数可以指定如何将不同的对象组合成一个字符串。
# 例如，在下面的代码中，paste 函数就会把 symbols 中的符号组合B 0 B以及prize中的中奖金额0组合成一个字符串。
# paste 会利用 sep 参数的值将新字符串中的不同元素分隔开来。
# 这个例子中的分隔符为\n$，因此最后的结果就应该是“B 0 B\n$0"。

prize <- one_play
string <- paste(symbols, prize, sep = "\n$")
string

# slot_display函数的最后一行调用 cat 函数对新字符串进行操作。
# cat 与 prize 相似，它在命令行显示其输出。
# 然而，cat 不会再输出结果的两侧添加双引号。它还会将所有的\n替换为一个新行或换行符。
# 结果如下所示。请注意，这样的输出结果与我在第7章中所建议的play函数应该具有的输出结果很相似

cat(string)

# 对于每次 play 函数的运行结果，都可以再调用 slot_display 函数进行人工清理

slot_display(play())
# 0 BB 0
# $0

slot_display(play())
# 0 0 BBB
# $0

# 这种清理函数输出的方法要求人工介入某个R会话（这里就是人工调用了slot_display函数）。
# 有一种函数可以使这个过程自动化，即每次play函数运行结束后都自动对其输出结果进行美化。
# 这个函数就是print，它是一个【泛型函数】。