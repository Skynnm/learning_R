
# (1)方法一：通过内置函数的两次 print 输出符号组合；（2）方法二：通过添加属性输出
# attr 接受两个参数：一个 R 对象和某个属性的名称（以字符的形式）
# 要赋予 R 对象具有指定名称的某个属性，需要将某个值保存到 attr 的输出结果

# 练习20260710：用 attr 函数给某个对象添加任何属性，用 attr 查询某个对象查询某个对象所包含的属性
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

symbols_example <- get_symbols()
symbols_example
score(symbols_example)

one_play <- play()
one_play
# [1] 0

attributes(one_play)
# NULL

attr(one_play, "symbols") <- c("B", "0", "B")
# 赋予one_play一个名为symbols的属性，该属性包含一个字符串向量
attributes(one_play)
# $symbols
# [1] "B" "0" "B"


# 如果想查找某个属性的取值，同样可以利用 attr 函数，并提供一个 R 对象的名称和想要查找的属性名称
attr(one_play, "symbols")
# [1] "B" "0" "B"

# 如果将某个属性赋给一个原子型向量，如one_play，R 通常会将该属性显示在这个向量值的下方
# 但是，如果该属性改变了这个向量的类，R 可能会用一种新的方式显示这个向量所包含的所有信息（参考POSIXct）
one_play
# [1] 0
# attr(,"symbols")
# [1] "B" "0" "B"

# 除非你赋予某个属性一个R函数能够找到的名称，比如names或者class，否则R通常会忽略这个属性
# 例如，在你对one_play进行操作时，R 会忽略掉它的 symbols 属性
one_play + 1
# [1] 1
# attr(,"symbols")
# [1] "B" "0" "B"