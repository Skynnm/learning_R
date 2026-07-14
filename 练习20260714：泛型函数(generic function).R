# 清理函数输出的方法要求人工介入某个R会话（这里就是人工调用了slot_display函数）
# 有一种函数可以使这个过程自动化，即每次play函数运行结束后都自动对其输出结果进行美化。
# 这个函数就是print，它是一个【泛型函数】。

# R使用print函数的次数比你想象的要多。每次在控制台窗口显示某个输出结果时R都会调用print函数。
# 这个调用过程发生在后台，因此你可能毫不察觉，但是调用print的过程解释了为什么输出结果会出现在控制台窗口中（回想一下之前的内容，print函数总会在控制台窗口中显示其参数的内容）
# 这个调用过程也同样解释了为什么在命令行中键入某个对象之后的显示结果与调用print函数作用于该对象的显示结果是一摸一样的。

# 练习20260714：泛型函数(generic function)
deck <- data.frame(
  face = c("king", "queen", "jack", "ten", "nine", "eight", "seven", "six",
           "five", "four", "three", "two", "ace", "king", "queen", "jack", 
           "ten", "nine", "eight", "seven", "six", "five", "four", "three", 
           "two", "ace", "king", "queen", "jack", "ten", "nine", "eight",
           "seven", "six", "five", "four", "three", "two", "ace", "king",
           "queen", "jack", "ten", "nine", "eight", "seven", "six", "five",
           "four", "three", "two", "ace"),
  suit = c("spades", "spades", "spades", "spades", "spades", "spades","spades",
           "spades", "spades", "spades", "spades", "spades", "spades", "clubs", 
           "clubs", "clubs", "clubs", "clubs", "clubs", "clubs", "clubs", "clubs",
           "clubs", "clubs", "clubs", "clubs", "diamonds", "diamonds", "diamonds",
           "diamonds", "diamonds", "diamonds", "diamonds", "diamonds", "diamonds",
           "diamonds", "diamonds", "diamonds", "diamonds", "hearts", "hearts", 
           "hearts", "hearts", "hearts", "hearts", "hearts", "hearts", "hearts",
           "hearts", "hearts", "hearts", "hearts"),
  value = c(13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 13, 12, 11, 10, 9, 8, 7, 6,
            5, 4, 3, 2, 1, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 13, 12, 11,
            10, 9, 8, 7, 6, 5, 4, 3, 2, 1)
)

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
  symbols <- get_symbols()
  structure(score(symbols), symbols = symbols)
}

print(pi)
# [1] 3.141593
pi
# [1] 3.141593

print(head(deck))
#face   suit value
#101  king spades    13
#102 queen spades    12
#103  jack spades    11
#104   ten spades    10
#105  nine spades     9
#106 eight spades     8
head(deck)
#face   suit value
#101  king spades    13
#102 queen spades    12
#103  jack spades    11
#104   ten spades    10
#105  nine spades     9
#106 eight spades     8

print(play())
# [1] 0
# attr(,"symbols")
# [1] "0" "0" "0"

play()
# [1] 0
# attr(,"symbols")
# [1] "0" "0" "0"

# 通过改写print函数，你可以改变R显示老虎机程序输出结果的方式，达到应用slot_display函数的效果。
# 之后R便会用这种更简洁的方式显示输出结果。
# 但是这个方法也有副作用。在显示诸如数据框、数值型向量或者其他对象时，你可能并不想让R去调用slot_display函数。

# 好在print不是一个普通的函数，它是【泛型函数】。【这也意味着，在不同的场合，print可以完成不同的任务】
# 其实你之前以及遇到过这种类型的函数（虽然你可能自己都没有意识到）。

# 在显示无类属性的num时，print的显示结果如下：
num <- 1000000000
print(num)
# [1] 1e+09
# 如果赋给num一个类，print的显示结果便会发生改变：
class(num) <- c("POSIXct", "POSIXt")
print(num)
# [1] "2001-09-09 09:46:40 CST"

# 不妨进入print函数的源代码看看它是如何做到这一点的。你也许认为print会查找某个对象的类属性，再根据类属性的不同，使用一个if树分配合理的输出显示方式。
# 如果你真是这么想的，很好！print的工作方式其实与你想象的十分类似，但是实现机制更加简单。

print
#function (x, ...) 
#  UseMethod("print")
#<bytecode: 0x000002a51df628b0>
#  <environment: namespace:base>