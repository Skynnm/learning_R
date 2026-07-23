# while循环可以做的事情包括运行不定次数的迭代过程

# 练习20260723：计算老虎机花完钱需要多久（repeat循环）
# repeat循环甚至比while循环还要初级。它会一直重复运行某段代码，直到你终止循环（通过按Esc键），或者是它遇到了break命令（用来强制终止程序运行的命令）
# 你可以用repeat循环重写上面的plays_till_broke函数。该函数用于计算玩老虎机需要多久用光所有钱。

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
  repeat {
    cash <- cash - 1 + play()
    n <- n + 1
    if ( cash <= 0) {
      break
    }
  }
  n
}

plays_till_broke(100)


# 在R中可以使用for、while 和 repeat循环完成重复性任务。
# 要使用for循环，要确定循环的对象以及在循环过程中想要运行的代码。
# for循环会遍历循环输入集合中的所有元素，每次都运行一遍指定的代码段。
# 如果要保存循环的输出结果，就需要在循环运行之前创建好一个对象，并在循环代码中将想要保存的结果存储在这个对象之中。

# 实线重复性任务的自动化对于数据科学来说意义重大。它是模拟的基石，也是估计方差和概率的基础。
# 虽然创建循环并不是在R中实现重复性任务自动化的唯一途径（比如说replicate函数也可以实现），但它们是最为流行的方法之一。

# 遗憾的是，相比于其他编程语言，循环代码在R中的运行速度更慢。因此，R循环程序的口碑并不太好。
# 虽然这个坏名声有失公平，但是也说明了一个很重要的事实：对于数据分析来说，程序运行速度至关重要。
# 如果你的代码运行速度很快，那么在有限的时间和计算资源的条件下，可以分析更多的数据并承担更多的分析任务。
# 第10章将教会你编写出更块的for循环语句以及更快的R代码。你将学到如何编写向量化代码。向量化编程充分利用了R语言的优点，使代码快如闪电。