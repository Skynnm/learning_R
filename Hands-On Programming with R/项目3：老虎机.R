# 脚本是一个纯文本文件，可以用它编写和保存代码

#         单一数据类型           多种数据类型
# 一维    向量（vector）         列表（list）
# 二维    矩阵（matrix）         数据框（dataframe）
# 三维    数组（array）

# 项目3：老虎机

# 每玩一次老虎机游戏需要花费1美元。转出的符号组合决定了玩家所能获得的中奖金额。
# 钻石符号（DD）是可以百搭的，并且能够将最终的金额翻倍。*表示任意符号。
# DD    DD    DD     100
# 7     7     7      80
# BBB   BBB   BBB    40
# BB    BB    BB     25
# B     B     B      10
# C     C     C      10
# 杠的任意组合       5
# C     C     *      5
# C     *     C      5
# *     C     C      5
# C     *     *      2
# *     C     *      2
# *     *     C      2

# （1）三个符号完全相同（但不能是符号零）
# （2）三个带杠的符号（任意组合）
# （3）一个或多个樱桃
# 如果不能满足以上三种情形中的任意一种，玩家将一无所获

# 具体的奖金额度由不同的符号组合决定，而且还与钻石是否出现密切相关。
# 钻石相当于是“百搭牌”，这也就意味着玩家可以将钻石当作任何一个符号以获取奖金或者提高奖金额度。
# 举个例子，如果玩家转出的符号组合是7 7 DD，那么如果把DD当作7，就相当于有了7 7 7组合，这就符合中奖要求。
# 但百搭牌的使用有一个例外：除非组合中已经有了一个樱桃，否则钻石不能被当作樱桃。这个规定是为了防止无用组合无端变成中奖组合。比如说转到的组合是0 DD 0，如果没有这个规定，它就可以被当作0 C 0这样的中奖组合。

# 钻石符号还有另一个功能。只要中奖组合中出现了钻石，奖金都会翻倍。
# 因此，7 7 DD对应的实际奖金将比7 7 7对应的奖金高。三个7的奖金是80美元，而7 7 DD的奖金翻倍为160美元。如果是一个7和两个钻石，奖金会继续翻倍，达到320美元。如果玩家转到DD DD DD，就中了头奖，奖金将在100美元的基础上三次翻倍，达到800美元


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

# 查找表（lookup table）：隐式向量循环 + 名称索引
# 也是向量化代码的原理：逻辑测试、取子集、元素方式执行