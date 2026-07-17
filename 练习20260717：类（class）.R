# 面向目标编程
# 算法千千万万

# 练习20260717：类（class）
# 你可以利用R的S3系统位对象创建一个稳健的类（class）。R会以一致且合理的方式对待同属一类的对象。要想创建一个类，应该执行以下操作：
# （1）给类起一个名称。
# （2）给属于该类的每个对象赋class属性。
# （3）为属于该类的对象编写常用泛型函数的类方法。

# 【许多R包都建立在以类似的方式创建的类上】。类的创建工作看起来简单，但其实做起来并不轻松。试想一下，R中存在多少已经定义好的类方法？

# 你可以针对某个类调用methods函数并指定想要查找的class属性作为其参数，也就是一个字符串。methods函数会返回R中已经存在的针对该类的所有方法。但要注意，如果某个R包事先没有经过加载，那么其中的方法就不会出现在methods的返回结果中。
methods(class = "factor")
# [1] [             [[            [[<-          [<-           all.equal     as.character 
# [7] as.data.frame as.Date       as.list       as.logical    as.POSIXlt    as.vector    
# [13] c             coerce        droplevels    format        initialize    is.na<-      
# [19] length<-      levels<-      Math          Ops           plot          print        
# [25] relevel       relist        rep           show          slotsFromS3   summary      
# [31] Summary       xtfrm        
# see '?methods' for accessing help and source code

# 从这个返回结果可以看出，要想创建一个可靠、运行良好的类，需要做很多工作。通常来说，你需要为R中的每一个基本操作编写对应的类方法函数。

# 在尝试编写类方法函数时，你会立即遇到两个挑战。首先，R在将多个对象组合成一个向量时会丢弃对象的属性（如类属性）
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
  print(symbols) # 为了示例学习属性，在此去掉
  # 步骤3：根据符号组合计算中奖金额
  score(symbols)
}
get_symbols()
play <- function(){
  # 生成符号组合
  symbols <- get_symbols()
  # 根据符号组合计算中奖金额
  prize <- score(symbols)
  # 将所有的符号压缩成为一个字符串
  attr(prize, "symbols") <- symbols
  symbols <- paste(symbols, collapse = " ")
  # 用正则表达式将符号与奖金信息组合起来
  # 在正则表达式中\n表示另起一个新行（相当于是按下一个回车键）
  string <- paste(symbols, prize, sep = "\n$")
  # 在控制台上显示正则表达式的结果，但是去掉其中的括号
  cat(string)
}
play()

play1 <- play()
#0 B 0
#$0

play2 <- play()
#0 0 BB
#$0

c(play1, play2) # 组合对象时会丢弃属性
#NULL
# 这里，R显示最后的组合向量时没有使用print.slots函数，因为c(play1, play2)这个向量不再具有slots类属性。


# 第二个挑战时，R在对某个对象取子集时也会丢弃其属性（如类属性）
play1[1]
# NULL


# 虽然可以再写一个c.slots和一个[.slots类方法函数，但是类似的挑战会迅速地累积起来。
# 比如说，如何把多次游戏积累下来的symbols属性放在一个向量之下？
# 如何修改print.slots函数以适应具有多个向量的输出结果？
# 这些问题是真实存在的，等着你去挑战。然而，作为一名数据科学家，你通常不必去挑战这种大规模编程。

# 在我们的例子中，当我们将很多组符号组合成一个向量时，让具有slots类属性的对象恢复成单独的奖金值是十分有用的。