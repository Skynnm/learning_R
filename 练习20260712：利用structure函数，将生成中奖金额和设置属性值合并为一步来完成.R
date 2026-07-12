# structure创建的是带有一组属性的 R 对象
# 该函数的第一个参数应该是一个 R 对象或者对象的取值，剩下的参数是你想要添加给这个对象的属性
# 属性的名称可以任意设置，structure会将你提供的参数名称作为属性名称赋给该对象

# 练习20260712：利用structure函数，将生成中奖金额和设置属性值合并为一步来完成
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
  print(prize * 2 ^ diamonds)   # 书上原代码少了 print 函数 输出
}

play <- function(){
  # 步骤1：生成符号组合
  symbols <- get_symbols()
  # 步骤2：显示符号组合
  # 为了示例学习属性，在此去掉
  # 步骤3：根据符号组合计算中奖金额
  score(symbols)
}

play <- function(){
  symbols <- get_symbols()
  structure(score(symbols), symbols = symbols)
}

three_play <- play()
three_play
# [1] 0
# attr(,"symbols")
# [1] "0" "0" "0"