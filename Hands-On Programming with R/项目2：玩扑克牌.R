# R对象
# R的记号体系

# 项目2：玩扑克牌
# 创建一副扑克牌
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


# 一、构建发牌函数
deal <- function(cards) {
  cards[1, ]
}
deal(deck)
deal(deck)


# 二、构建洗牌函数（复制一份deck副本，对该副本进行洗牌操作）
shuffle <- function(cards) {
  random <- sample(1:52, size = 52)
  cards[random, ]
}
shuffle(deck)
shuffle(deck)


# 三、每次发牌前洗牌
deal(deck)
deck2 <- shuffle(deck)
deck2


# 四、war游戏：将 A 的点数从1变成14
deck3 <- deck
deck3$value[deck$face == "ace"] <- 14
deck3


# 五、在Hearts游戏中，除了花色为红桃的牌及黑桃Q，其他均为0
# ①所有红桃牌点数为1
# ②黑桃Q：13
deck4 <- deck
deck4$value <- 0
deck4$value[deck4$suit == "hearts"] <- 1
queen0ofSpades <- deck4$face == "queen" & deck4$suit == "spades"
deck4$value[queen0ofSpades] <- 13
deck4


# 六、Blackjack，每张数字牌的点数都与它的面值相同，每一张人头牌（K, Q 和 J）的点数都为10，而A的点数可为11也可为1，这取决于每局最后的牌面
deck5 <- deck
facecard <- deck5$face %in% c("king", "queen", "jack")
deck5$value[facecard] <- 10
deck5$value[deck$face == "ace"] <- NA
deck5
# 如果被索引的对象有名称属性，就可以采用待提取元素的名称作为索引值


# 七、探索R的运行时环境，了解这个环境的内部是什么样子：比如说它的父环境是什么，以及它包含哪些对象
deal(deck) # deal函数每次发的牌都是一样的
deal(deck) # deal函数每次发的牌都是一样的
deal(deck) # deal函数每次发的牌都是一样的
shuffle(deck) # shuffle函数的功能并不能算是洗牌（它只是复制了一份deck的副本，然后对该副本进行洗牌操作）
shuffle(deck) # shuffle函数的功能并不能算是洗牌（它只是复制了一份deck的副本，然后对该副本进行洗牌操作）
shuffle(deck) # shuffle函数的功能并不能算是洗牌（它只是复制了一份deck的副本，然后对该副本进行洗牌操作）
## 【一言以蔽之，这两个函数都使用了deck数据集，但都不直接对deck进行操作，而我们想要的是它们能够直接对deck进行操作】
show_env <- function() {                   # show_env的输出结果会告诉我们当前的运行时环境的名称，它的父环境以及该运行时环境中包含哪些对象等信息
  list(ran.in = environment(),             # R每次运行函数时，都会创造一个新的运行环境
       parent = parent.env(environment()), # 运行环境的父环境都是全局环境
       objects = ls.str(environment()))    # 运行环境都是空的，不包含任何对象
}
show_env()

show_env2 <- function() {                 
  a <- 1
  b <- 2
  c <- 3
  list(ran.in = environment(),             
       parent = parent.env(environment()), 
       objects = ls.str(environment()))   
}
show_env2()

# 用assign函数将某个对象分配到某个特定环境中
deal2 <- function() {
  card <- deck[1, ]                                   # 按作用域规则——找到（Globalenv）
  assign("deck", deck[-1, ], envir = globalenv())     # 虽然，在原环境中（Globalenv）找到了对象，但赋值发生在运行时环境
  card                                                # 【搜索 和 赋值 是两个不同的动作发生在两个不同的环境】
}
deal2()
deal2()
deal2()
deck    # 开始对deck对象本体进行操作了

DECK <- deck                                          # 在全局环境里保存的副本，容易被错误的读写
shuffle <- function() {
  random <- sample(1:52, size = 52)
  assign("deck", DECK[random, ], envir = globalenv()) # 用shuffle后的DECK替代deck本体 
}
shuffle()
DECK
deck    


# 八、闭包（closure）
# R运行函数时创建的运行时环境是保存对象的安全地方
setup <- function(deck) {
  DECK <- deck           # 在R运行函数时创建的运行环境中保存副本——安全、不易触碰
  
  DEAL <- function() {
    card <- deck[1, ]
    assign("deck", deck[-1, ], envir = globalenv())
    card
  }
  
  SHUFFLE <- function() {
    random <- sample(1:52, size = 52)
    assign("deck", DECK[random, ], envir = globalenv())
  }
}
# 现在所有的对象都被安全地放在了全局环境的一个子环境中。这样做虽然保证了对象的安全，但是不利于使用。
# 我们修改一下代码，让setup可以返回DEAL和SHUFFLE函数。返回这些函数的最佳方式就是使用【列表list】。

setup <- function(deck) {
  DECK <- deck
  
  DEAL <- function() {
    card <- deck[1, ]
    assign("deck", deck[-1, ], envir = globalenv())     # 注意此时envir = globalenv()
    card
  }
  
  SHUFFLE <- function() {
    random <- sample(1:52, size = 52)
    assign("deck", DECK[random, ], envir = globalenv()) # 注意此时envir = globalenv()
  }
  
  list(deal = DEAL, shuffle = SHUFFLE)
}
cards <- setup(deck)
# 然后你就可以将列表中的每个元素保存到全局环境中的某个专用对象中了
deal <- cards$deal
shuffle <- cards$shuffle
# 现在就可以像之前那样运行deal和shuffle函数了，而且它们的源代码与之前的函数一样
deal
#function() {
#  card <- deck[1, ]
#  assign("deck", deck[-1, ], envir = globalenv())     # 注意此时envir = globalenv()
#  card
#}
#<environment: 0x000001fd162620d8>
shuffle
#function() {
#  random <- sample(1:52, size = 52)
#  assign("deck", DECK[random, ], envir = globalenv()) # 注意此时envir = globalenv()
#}
#<environment: 0x000001fd162620d8>

# 然而，新版本的函数与旧版本相比，有一个重要的差别。新版本的原环境不再是全局环境（虽然deal和shuffle函数存储在全局环境中），而是R在运行setup函数时所创建的运行时环境。这个环境也是R创建DEAL和SHUFFLE（deal和shuffle函数的副本）的地方。
environment(deal)
# <environment: 0x000001fd162620d8>
environment(shuffle)
# <environment: 0x000001fd162620d8>
# 这一点为何如此重要呢？这是因为当运行deal或shuffle函数时，R会在<environment: 0x000001fd162620d8>的子环境中进行函数求值，这个子环境时函数的运行时环境。
# DECK和deck都在运行时环境的父环境中，这意味着deal和shuffle函数可以顺利地找到它们。
# 【DECK和deck会出现在两个函数的搜索路径上，同时其安全性得到了保障】。

# 这样的处理方式称作闭包（closure）。setup的运行时环境奖deal和shuffle函数包了起来。
# deal 和 shuffle函数都可以直接抵用这个包围式环境中的对象，但其他外部的函数几乎都不能做到这一点。这个环境不在任何R函数或环境的搜索路径上。

# 你可能已经注意到了，dael和shuffle函数仍然会更新全局环境中的deck对象。不用担心，我们一会儿就会解决这个问题。
# 我们期望的是，deal 和 shuffle函数只与它们所处环境的父环境（包围式环境）中的对象通力合作。在更新deck时，其实不需要直接指向全局环境，只需指向运行时环境的父环境即可。
setup <- function(deck) {
  DECK <- deck
  
  DEAL <- function() {
    card <- deck[1, ]
    assign("deck", deck[-1, ], envir = parent.env(environment()))     # 注意此时envir = parent.env(environment())
    card
  }
  
  SHUFFLE <- function() {
    random <- sample(1:52, size = 52)
    assign("deck", DECK[random, ], envir = parent.env(environment())) # 注意此时envir = parent.env(environment())
  }
  
  list(deal = DEAL, shuffle = SHUFFLE)
}
cards <- setup(deck)
deal <- cards$deal
shuffle <- cards$shuffle
# 现在我们终于有了一套完备的扑克牌系统。
# 你可以随意删除（或者修改）全局环境中的deck副本，而这套系统仍然可以运行。
# deal 和 shuffle函数使用的是原始的、被保护的deck版本。



# 0.作用域规则
# R搜索对象所遵循的规则，子环境、父环境、树形环境结构
# 每一个环境都与一个父环境相连，但这样的连接是单向的，只支持自下而上：globalenv() → baseenv() → emptyenv()

# 1.全局环境 .GlobalEnv
# 平时【写】代码、【定义】变量、【定义】函数，都在全局环境

# 2.函数调用 = 新建局部环境
# 每运行一次函数，立刻生成全选临时局部环境，不是复用、不是共用

# 3.作用域规则
# ①函数内优先使用自己局部环境的变量
# ②局部找不到——向外逐层词法作用域规则【搜索 和 赋值 是两个不同的动作，也发生在两个不同的环境】
# ③函数执行结束——局部环境自动销毁，临时变量消失 

# 4.闭包（closure）
# 对象存储在函数的搜索路径上