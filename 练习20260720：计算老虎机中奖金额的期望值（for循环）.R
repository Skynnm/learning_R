# 期望值、expand.grid、for循环、while循环

# 练习20260720：计算老虎机中奖金额的期望值（for循环）
wheel <- c("DD", "7", "BBB", "BB", "B", "C", "0")


# 要想生成一个数据框并使其包含所有可能的三个符合的组合，你需要运行expand.grid函数，并且输入向量wheel的三个副本。结果将是一个343行的数据框，每一行都是三个符合的某种组合
combos <- expand.grid(wheel, wheel, wheel, stringsAsFactors = FALSE) # 在调用expand.grid函数时，设置参数stringsAsFactors = FALSE，否则expand.grid会将所有可能的组合以因子的形式存储在数据框中，score函数将无法处理这种情况。

combos
#Var1 Var2 Var3
#1     DD   DD   DD
#2      7   DD   DD
#3    BBB   DD   DD
#4     BB   DD   DD
#5      B   DD   DD
#6      C   DD   DD
#...
#331    7    C    D
#332  BBB    C    D
#333   BB    C    D
#[ reached 'max' / getOption("max.print") -- omitted 10 rows ]


# 现在让我们计算一下每种符号组合出现的概率。可以利用get_symbols函数中的prob参数，它决定了每一种符号被老虎机选中的概率。这些概率值是在对曼尼托巴的视频彩票终端的345次游戏结果进行观测后得到的结论。0出现的概率最大（0.52），而C出现的概率最小（0.01）
get_symbols <- function(){
  wheel <- c("DD", "7", "BBB", "BB", "B", "C", "D")
  sample(wheel, size = 3, replace = TRUE,
         prob = c(0.03, 0.03, 0.06, 0.1, 0.25, 0.01, 0.52))
}


# 你所使用的名称应该与你想要查找的符号的名称一致，你的查找表【lookup table，利用名称索引+向量循环】应该如下所示
prob <- c("DD" = 0.03, "7" = 0.03, "BBB" = 0.06, 
          "BB" = 0.1, "B" = 0.25, "C"  = 0.01, "0" = 0.52)

# 记住，在查找表中使用R的取值记号得到想要的值。取值结果将和你所使用的索引值一一对应。
combos$prob1 <- prob[combos$Var1]
combos$prob2 <- prob[combos$Var2]
combos$prob3 <- prob[combos$Var3]
combos
#Var1 Var2 Var3 prob1 prob2 prob3
#1   DD   DD   DD  0.03  0.03  0.03
#2    7   DD   DD  0.03  0.03  0.03
#3  BBB   DD   DD  0.06  0.03  0.03

# 通过R的元素方式执行一次性计算所有符号组合的概率
combos$prob <- combos$prob1 * combos$prob2 * combos$prob3
head(combos$prob, 3)
combos$prob

# 所有可能的符号组合对应的概率值之和等于1，这意味着我们的计算无误
sum(combos$prob)
#[1] 1


# 在计算最后的期望值之前，你只需要做一件事：确定combos中每个符号组合对应的中奖金额，可以用score函数来计算。比如说，使用如下代码可以计算出combos第一行符号组合对应的中奖金额：
symbols <- c(combos[1, 1], combos[1, 2], combos[1, 3])
symbols
# [1] "DD" "DD" "DD"

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

score(symbols)
# [1] 800


# 然而，数据框中一共有343行，如果这样每一行都手动计算的话，工作量是很大的。假若能让R将这种重复性任务自动化，就会提高工作效率。这可以用for循环来实现。


# for循环可以重复运行某段代码一定的次数，重复次数取决于循环的输入中有多少个元素。
# 【for循环相当于是在告诉R：对于这个输入空间内的每个值都运行一遍这个代码。】
# 用R的语法表述如下：
# for (value in that){
#     this
#}
# 这里的 that 应该是一个对象集合（通常是一个包含数值或字符串的向量）。
# 对于出现在 that 中的每一个值，for 循环都会运行一遍位于两个大括号之间的代码。比如说，下面的 for 循环，对于每一个字符串向量中的每一个元素，都会运行一遍 print("one run")：
for (value in c("My", "first", "for", "loop")) {
  print("one run")
}
#[1] "one run"
#[1] "one run"
#[1] "one run"
#[1] "one run"
#### 这个 for 循环中的value符号就相当于函数中的参数。
#### 【对于每一次循环，for 循环都会创建一个名为 value 的对象并为其赋新值。】
#### 该循环的代码每次都会调用这个 value 对象，以获取它最新的取值。


# for循环会为value赋何值呢？它会遍历该循环输入集合中的所有元素。
# for会从输入集合的第一个值开始循环，首先将一个值赋给value，然后每循环到下一步都将输入集合中的下一个元素赋给value，直到穷尽输入集合中的所有值。
# 比如说，下面的for循环会运行print(value)四次，依次显示向量c("My", "second", "for", "loop")中的元素：
for (value in c("My", "second", "for", "loop")) {
  print(value)
}
#[1] "My"
#[1] "second"
#[1] "for"
#[1] "loop"

# 在第一次运行时，for将"My"赋给value，然后再传递给print(value)；进入第二次运行时，value的值变成了second，以此类推，直至穷尽。

# 再循环结束之后，如果查看value的取值，会发现它仍然是输入集合中最后一个元素的值
value
#[1] "loop"


# 我的for循环所使用的循环符号是value，但其实它的选用没有什么讲究。
# 你可以用你喜欢的任意名称，只要将这个名称置于for之后的括号内，并将其放在in之前即可。
# 比如说，下面的代码与之前的效果是等同的。
for (word in c("My", "second", "for", "loop")) {
  print(word)
}
for (string in c("My", "second", "for", "loop")) {
  print(string)
}
for (i in c("My", "second", "for", "loop")) {
  print(i)
}
# 小心选择循环符号！如果你的循环使用了该环境中已经存在的对象名称，就会发生冲突。

# 其他编程语言，for循环处理整数；R编程语言，for循环处理集合


# for循环是很实用的编程技术，因为它将一段代码和某个集合中的每一个元素都连接了起来。
# 比如说，我们可以用for循环对combos数据框的每一行都运行一遍score函数。
# 但是，在使用for循环之前有必要了解它的一个缺点：for循环不会返回输出结果。


# for循环类似于赌城拉斯维加斯：在for循环内部发生的事，就留在for循环里。
# 如果想使用一个for循环的结果，就必须在循环代码中明确保存你想要的对象。


# 之前的例子看似输出了一些结果，但这只是表面现象，不要被它迷惑了。它之所以输出结果是因为我们在循环代码中调用了print函数。
# 该函数总是会在控制台中显示输入的参数（即便是在其他函数或for循环中调用print函数，也会如此。）
# 如果将调用print的语句移除，那么我们的for循环不会返回任何结果。
for (value in c("My", "third", "for", "loop")) {
    value  
}
#
# 要想保存for循环的运行结果，你必须编写好for循环，使之在运行过程中保存自己的结果。
# 要想实现这一点，可以在运行for循环之前先创建一个空的向量或列表，然后用for循环的结果填满该向量或列表。
# 但for循环运行结束之后，你可以通过这个向量或列表获取循环过程的输出结果。
# 我们看一个实例，下面的代码创建了一个长度为4的空向量：
chars <- vector(length = 4)
# 接下来的循环会用字符串将这个空向量填满：
words <- c("My", "fourth", "for", "loop")

for (i in 1:4) {
    chars[i] <- words[i]
}

chars
# [1] "My"     "fourth" "for"    "loop"
# 这个方法经常要求你更改执行for循环时所在的集合。与其用某些R对象作为输入集合，不如直接使用一个整数集，这些整数在循环中既可以作为某个R对象的索引值，也可以作为存储向量的索引值。
# 这个方法在R中十分常见。
# 【在实践中你会发现，for循环并不是主要用于运行代码，而是用于将代码的运行结果填入向量和列表】


# 让我们利用for循环计算combos的每一行对应的中奖金额。开始之前，先在combos中创建一个新列用来存储for循环的输出结果。
combos$prize <- NA
head(combos, 3)
# 上面的代码创建了一个名为prize的新列，并且暂时用缺失值符号NA填满。
# 虽然这里只用了一个NA赋值，但是R会利用其循环规则将该列的所有位置都填上NA。

# 要对combos的每一行应用score函数，可以用下面的代码。
nrow(combos)
for (i in 1:nrow(combos)) {
    symbols <- c(combos[i, 1], combos[i, 2], combos[i, 3])
    combos$prize[i] <- score(symbols)
}
test_symbols <- c(combos[i, 1], combos[i, 2], combos[i, 3])
test_symbols
combos$prize[i] <- score(test_symbols)
# 循环结束之后，combos$prize就包含了原数据框的每一行对应的正确奖金值。该练习同时也测试了score函数。
# 这里看起来score函数没有问题，它正确计算出了每一种老虎机符号组合对应的中奖金额。 
head(combos, 3)
#Var1 Var2 Var3 prob1 prob2 prob3    prob prize
#1   DD   DD   DD  0.03  0.03  0.03 2.7e-05   800
#2    7   DD   DD  0.03  0.03  0.03 2.7e-05     0
#3  BBB   DD   DD  0.06  0.03  0.03 5.4e-05     0
combos
combos[343,]
print(combos)

# 现在我们已经做好了计算期望值的准备了。期望值就等于combos$prize所有值的加权平均值，权值为combos$prob。期望值也就是老虎机的返还率。
sum(combos$prize * combos$prob)
# [1] 0.538014
# 期望值约为0.54，也就意味着从长期来看，我们的老虎机每收取一美元，返还给玩家的奖金只有54美分。这是否意味着曼尼托巴老虎机的制造商撒谎了吗？
# 其实不然，因为我们在编写score函数的时候忽视了老虎机游戏的一个重要特征：钻石符号可以被当作百搭符号。也就是说，钻石符号DD是通配的，只要能够提高符号组合的奖金值，它可以代表任何一个符号。只有一个情形例外：除非你已经有了一个樱桃符号C，否则不能将DD通配为C（如若不然，只要有了DD符号便可以凭空赢得至少2美元）

# DD的可人之处在于它的奖金效应是可以累加的。比如说，考虑B DD B这样的符号组合。DD可以被看作B，因此中奖金额为10美元；此外，DD还可以将奖金翻倍为20美元。

# 下面就是能够处理百搭钻石符号的score函数：
score <- function(symbols){
  diamonds <- sum(symbols == "DD")
  cherries <- sum(symbols == "C")
  # 识别情形
  # 因为钻石符号是百搭符号，因此只考虑没有砖石的情况
  # 三个符号相同以及都是杠的情形
  slots <- symbols[symbols != "DD"]
  same <- length(unique(slots)) == 1
  bars <- slots %in% c("B", "BB", "BBB")
  
  # 分配奖金值
  if (diamonds == 3) {
    prize <- 100    
  } else if (same) {
    payouts <- c("7" = 80, "BBB" = 40, "BB" = 25,
                 "B" = 10, "C" = 10, "0" = 0)
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
  prize * 2^diamonds
}
# 要更新期望值，只需要更新combos$prize列即可。
for (i in 1:nrow(combos)) {
  symbols <- c(combos[i, 1], combos[i, 2], combos[i, 3])
  combos$prize[i] <- score(symbols)
}
combos
# 然后重新计算期望值
sum(combos$prize * combos$prob)
[1] 0.934356
# 证实了厂商的说法