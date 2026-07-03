# 利用下面3个简单的策略就可以简化这个任务以及其他同样复杂的编程任务
#（1）将复杂的任务分解为一些简单的子任务
#【有序步骤（sequential step） 和 同类情况（parallel case）】
#（2）使用实例
#（3）用通俗的语言描述解决方案，然后将其转换成 R 代码

# 练习20260703：老虎机
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
  prize * 2 ^ diamonds
}


play <- function(){
  
  # 步骤1：生成符号组合
  symbols <- get_symbols()
  
  # 步骤2：显示符号组合
  print(symbols)
  
  # 步骤3：根据符号组合计算中奖金额
  score(symbols)
}

play()  
play()
play()
play()
