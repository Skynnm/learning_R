# for循环并不是主要用于运行代码，而是用于将代码的运行结果填入向量和列表

# 练习20260722：计算老虎机花完钱需要多久（while循环）
# for循环在R中还有两个伙伴：while循环和repeat循环。
# while循环的特征是，只要某个条件为真，就会重复运行某段代码。
# 要编写while循环，在while循环之后的括号中间写明测试条件，并在之后的大括号中写出所要重复运动的代码，如下所示：
while (condition) {
  code
}
# while会在每一次循环之前重新运行condition，这是一个逻辑测试。
# 如果对condition求值的结果为TRUE，while就会运行大括号内的代码段，如果对condition求值的结果为FALSE，while就会结束循环。

# 那么其中的condition怎么会从TRUE变为FALSE呢？
# 【有可能是因为代码的运行改变了条件测试的结果】
# 如果代码与条件没有关系，那么while循环会一直运行下去，直到强制停止其运行为止。因此，编写while循环时要多加小心。
# 要想停止while循环的运行，可以按键盘上的Esc键，或者点击RStudio控制台面板上方的停止标志图标。这个图标只有在循环开始运行之后才会出现。

# 与for循环一样，while循环也不会返回任何结果。
# 因此，如果想让循环过程中的某个结果能保留下来，一定要事先创建好存储对象，并在循环代码中将肝兴趣的结果存储在这个对象之中。

# while循环可以做的事情包括运行不定次数的迭代过程，如结算老虎机用光你所有的浅需要多久（见下面的代码）
# 但是，从实际应用来看，while循环在R中的使用率要明显低于for循环。

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
  # 步骤2：显示符号组合
  # 为了示例学习属性，在此去掉
  # 步骤3：根据符号组合计算中奖金额
  score(get_symbols())
}

play()

plays_till_broke <- function(start_with) {
  cash <- start_with
  n <- 0
  while (cash > 0) {
    cash <- cash - 1 + play()
    n <- n + 1
  }
  n
}
plays_till_broke(100)
