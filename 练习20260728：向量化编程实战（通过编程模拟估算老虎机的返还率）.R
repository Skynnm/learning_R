# 快速R代码的三大法宝：逻辑测试、取子集 和 元素方式执行
# 向量化代码指代码可以接受一个含有多个值的向量作为输入，并且同时操作向量中的每一个元素

# 练习20260728：向量化编程实战（通过编程模拟估算老虎机的返还率）
# 之前用概率的方法准确计算出了老虎机的返还率，但其实返还率也可以通过编程模拟来估算
# 如果玩这个老虎机游戏足够多的次数，那么所获奖金的平均值应该就是真实返还率的一个合理的估计值
# 这种估计方法的理论基础是统计学中的大数定律，许多其他的统计模拟方法也都是基于这个理论
get_symbols <- function() {
  wheel <- c("DD", "7", "BBB", "BB", "B", "C", "0")
  sample(wheel, size = 3, replace = TRUE,
         prob = c(0.03, 0.03, 0.06, 0.1, 0.25, 0.01, 0.52))
}

# 下面是能够处理百搭符号的score函数
score <- function(symbols) {
  
  diamonds <- sum(symbols == "DD")
  cherries <- sum(symbols == "C")
  
  # 识别情形
  # 因为钻石符号是百搭符号，因此只考虑没有钻石的情况
  # 三个符号相同以及都是杠的情形
  slots <- symbols[symbols != "DD"]
  same <- length(unique(slots)) == 1
  bars <- slots %in% c("B", "BB", "BBB")
  
  # 分配奖金值
  if (diamonds == 3) {
    prize <- 100
  } else if (same) {
    payouts <- c("7" = 80, "BBB" = 40, "BB" = 25,  # 查找表（lookup table）：隐式向量循环 + 名称索引
                 "B" = 10, "C" = 10, "0" = 0)                  # 也是向量化代码的原理：逻辑测试、取子集、元素方式执行
    prize <- unname(payouts[slots[1]])
  } else if (all(bars)) {
    prize <- 5
  } else if (cherries > 0) {
    # 如果有一个樱桃
    # 则将钻石当作樱桃
    prize <- c(0, 2, 5)[cherries + diamonds + 1]
  } else {
    prize <- 0
  }
  
  # 根据钻石的数量，把奖金翻倍
  prize * 2 ^ diamonds
}

play0 <- function() {
  symbols <- get_symbols()
  score(symbols)
}
play0()

# 用概率的方法准确计算出老虎机的返还率
wheel <- c("DD", "7", "BBB", "BB", "B", "C", "0")
combos <- expand.grid(wheel, wheel, wheel, stringsAsFactors = FALSE)
prob <- c("DD" = 0.03, "7" = 0.03, "BBB" = 0.06, 
          "BB" = 0.1, "B" = 0.25, "C" = 0.01, "0" = 0.52)
combos$prob1 <- prob[combos$Var1]
combos$prob2 <- prob[combos$Var2]
combos$prob3 <- prob[combos$Var3]

combos$prob <- combos$prob1 * combos$prob2 * combos$prob3

sum(combos$prob)

combos$prize <- NA # R会用元素方式执行规则将该列的所有位置都填上NA
for (i in 1:nrow(combos)) {
  symbols <- c(combos[i, 1], combos[i, 2], combos[i, 3])
  combos$prize[i] <- score(symbols)
}
sum(combos$prize * combos$prob)
# [1] 0.934356

# 通过编程模拟来估算返还率
winnings <- vector(length = 1000000)
for (i in 1:1000000) {
  winnings[i] <- play0()
}
mean(winnings)
#[1] 0.939863


# 模拟了100万次后，返还率的估计值约为0.939863，非常接近于之前通过概率方法计算得到返还率。
# 请注意，这里使用的是修正版本的score函数（它考虑了钻石符号对中奖金额的影响）

# 在运行这个模拟时，还会发现一段时间才能完成，这并不是一个理想的速度。利用向量化编程，完全可以加快它的运行速度
system.time(for (i in 1:1000000) {
  winnings[i] <- play0()
})
# 用户  系统  流逝 
#18.23  1.43 20.24 

# 我们现在用的score函数并没有被向量化。对于老虎机转出的每一个符号组合，它都用if数结构找到并赋予对应的奖金值
# 这种if数与for循环的组合其实就是告诉你，它是可以被向量化的。你可以一次性处理多个符号组合，利用逻辑值取子集的方法一次性得到所有符号组合所对应的奖金值。

# 举例来说，你可以重写 get_symbols 函数以生成n个老虎机符号组合，并且将结果置于一个n x 3的矩阵之中，代码如下：
# 这个矩阵的每一行都包含三个符号，每一行的符号组合都对应一个奖金值：
get_many_symbols <- function(n) {
  wheel <- c("DD", "7", "BBB", "BB", "B", "C", "0")
  vec <- sample(wheel, size = 3 * n, replace = TRUE,
         prob = c(0.03, 0.03, 0.06, 0.1, 0.25, 0.01, 0.52))
  matrix(vec, ncol =  3)
}

get_many_symbols(5)
#     [,1]  [,2] [,3]
#[1,] "BB"  "0"  "0" 
#[2,] "B"   "0"  "B" 
#[3,] "BBB" "B"  "0" 
#[4,] "DD"  "0"  "BB"
#[5,] "0"   "BB" "B" 

# 你还可以重新编写一个 play 函数，它的参数为 0。该函数在一个数据框中输出 n 个奖金值
play_many <- function(n) {
  symb_mat <- get_many_symbols(n = n)
  data.frame(w1 = symb_mat[ , 1], w2 = symb_mat[ , 2],
             w3 = symb_mat[ , 3], prize = score_many(symb_mat))
}

# 在这个新函数的帮助下，模拟100万次或者1000万次老虎机游戏就变得很轻松了，这也正是我们所期望的。当模拟结束之后，立即就可以算出返还率
# plays <- play_many(10000000)
# mean(play$prize)

# 现在你只需要再写一个向量化（或者是矩阵化？）版本的score函数，它可以接受一个 n x 3矩阵作为输入，并输出n个奖金值。
# 我们暂且将这个函数命名为 score_many。这个任务其实并不容易，因为 score 函数本身已经比较复杂了。
# 可以考虑再score_many函数的代码中使用rowSums函数，用来计算一个矩阵每一行的所有数值（或者逻辑值）之和

# 尝试理解这段代码之中每一部分的原理，以及不同的部分是如何协同完成向量化任务的。为了理解这段代码，我们先生成一个实例。

# score_many 就是 score 函数的一个向量化版本。
# 符号组合应该是一个矩阵，该矩阵的每一列对应一个老虎机窗口
score_many <- function(symbols) {
  # 第1步：根据樱桃和钻石的出现情况分配基础金额 --------------------------------
  ## 计算在每个符号组合中樱桃和钻石出现的次数
  cherries <- rowSums(symbols == "C")
  diamonds <- rowSums(symbols == "DD")
  
  ## 将百搭的钻石视为樱桃，计算樱桃出现的次数
  prize <- c(0, 2, 5)[cherries + diamonds + 1]
  
  ## 但当一个樱桃都没有时例外
  ###(当cherries == 0时，cherries被强制转换为FALSE)
  prize[!cherries] <- 0
  
  # 第2步：当符号组合是三个相同的符号时，改变奖金值 ----------------------------
  same <- symbols[ , 1] == symbols[ , 2] &
    symbols[ , 2] == symbols[ , 3]
  payoffs <- c("DD" = 100, "7" = 80, "BBB" = 40, 
               "BB" = 25, "B" = 10, "C" = 10, "0" = 0)
  prize[same] <- payoffs[symbols[same, 1]]
  
  # 第3步：当符号组合都是杠时，改变奖金值 --------------------------------------
  bars <- symbols == "B" | symbols == "BB" | symbols == "BBB"
  all_bars <- bars[ , 1] & bars[ , 2] & bars[ , 3] & !same
  prize[all_bars] <- 5
  
  # 第4步：处理百搭符号 --------------------------------------------------------
  
  ## 当有两个钻石符号
  two_wilds <- diamonds == 2
  
  ### 识别出非百搭符号
  one <- two_wilds & symbols[ , 1] != symbols[ , 2] &
    symbols[ , 2] == symbols[ , 3]
  two <- two_wilds & symbols[ , 1] != symbols[ , 2] &
    symbols[ , 1] == symbols[ , 3]
  three <- two_wilds & symbols[ , 1] == symbols[ , 2] &
    symbols[ , 2] != symbols[ , 3]
  
  ### 当作三个相同的符号处理
  prize[one] <- payoffs[symbols[one, 1]]
  prize[two] <- payoffs[symbols[two, 2]]
  prize[three] <- payoffs[symbols[three, 3]]
  
  ## 当有一个钻石时
  one_wild <- diamonds == 1
  
  ### 当作全是杠来处理（如果合适的话）
  wild_bars <- one_wild & (rowSums(bars) == 2)
  prize[wild_bars] <- 5
  
  ### 当作三个相同的符号处理（如果合适的话）
  one <- one_wild & symbols[ , 1] == symbols[ , 2]
  two <- one_wild & symbols[ , 2] == symbols[ , 3]
  three <- one_wild & symbols[ , 3] == symbols[ , 1]
  prize[one] <- payoffs[symbols[one, 1]]
  prize[two] <- payoffs[symbols[two, 2]]
  prize[three] <- payoffs[symbols[three, 3]]
  
  # 第5步：根据组合中出现的钻石个数，加倍奖金值 --------------------------------
  unname(prize * 2 ^ diamonds)
}

play_many(10000000)

sum_play_many <- play_many(10000000)

mean(sum_play_many$prize)
#[1] 0.933723

system.time(play_many(10000000))
#用户 系统 流逝 
#7.01 0.36 7.59 