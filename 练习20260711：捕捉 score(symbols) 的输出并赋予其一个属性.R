# 面向目标编程，学习的最好方式就是上手实践它
# paste() 函数的用法

# 练习20260711：捕捉 score(symbols) 的输出并赋予其一个属性

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

prize <- score(symbols_example)

play()

two_play <- play()

two_play
# 即使将结果复制给一个新的对象，这两个信息也会始终在一起显示