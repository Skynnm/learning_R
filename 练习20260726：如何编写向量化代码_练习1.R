# 要对对象object有一个清晰具体认知
# R 的算术运算符和赋值符都是向量化的，因此可以用它们同时操作和更新多个数值

# 练习20260726：如何编写向量化代码_练习1
# 下面这个函数的功能是将一个包含老虎机符号的向量转换成一批新的符号。你能尝试将这段代码向量化吗？向量化之后的代码比原代码快了多少？
change_symbols <- function(vec) {
  for (i in 1:length(vec)) {
    if (vec[i] == "DD") {
      vec[i] <- "joker"
    } else if (vec[i] == "C") {
      vec[i] <- "ace"
    } else if (vec[i] == "7") {
      vec[i] <- "king"
    } else if (vec[i] == "B") {
      vec[i] <- "queen"
    } else if (vec[i] == "BB") {
      vec[i] <- "jack"
    } else if (vec[i] == "BBB") {
      vec[i] <- "ten"
    } else {
      vec[i] <- "nine"
    }
  }
  vec
}

vec <- c("DD", "C", "7", "B", "BB", "BBB", "0")

change_symbols(vec)  
#[1] "joker" "ace"   "king"  "queen" "jack"  "ten"   "nine" 

many <- rep(vec, 1000000)

system.time(change_symbols(many))
#用户  系统  流逝 
#10.07  0.30 10.92


# change_symbols 函数使用一个for循环将符号分成了七种情况。
# 要向量化 change_symbols，首先针对每一种情况创建一个逻辑测试【change_symbols针对不同的情况进行不同的转换处理】
vec[vec == "DD"]
#[1] "DD"

vec[vec == "C"]
#[1] "C"

vec[vec == "7"]
#[1] "7"

vec[vec == "B"]
#[1] "B"

vec[vec == "BB"]
#[1] "BB"

vec[vec == "BBB"]
#[1] "BBB"

vec[vec == "0"]
#[1] "0"


# 然后，针对每一种情况写出更改符号的代码
vec[vec == "DD"] <- "joker"
vec[vec == "C"] <- "ace"
vec[vec == "7"] <- "king"
vec[vec == "B"] <- "queen"
vec[vec == "BB"] <- "jack"
vec[vec == "BBB"] <- "ten"
vec[vec == "0"] <- "nine"

# 把这两个步骤整合为一个函数就得到了向量化版本的change_symbols，它的运行速度更快
change_vec <- function(vec) {
  vec[vec == "DD"] <- "joker"
  vec[vec == "C"] <- "ace"
  vec[vec == "7"] <- "king"
  vec[vec == "B"] <- "queen"
  vec[vec == "BB"] <- "jack"
  vec[vec == "BBB"] <- "ten"
  vec[vec == "0"] <- "nine"
  
  vec
}

system.time(change_vec(many))
#用户 系统 流逝 
#0.61 0.08 0.68


# 有一个更好的解决方案，就是使用查找表。查找表也是一种向量化的方法，因为它所依赖的选择操作，在R中也是向量化的。