# 核心思想：向量化运算：R原生擅长对整列操作，尽量不要写for循环。
# 坏例子：逐个遍历；好例子：df$score*2

# 练习20260628：闭包
setup <- function(deck){
  DECK <- deck
  
  DEAL <- function(){
    card <- deck[1,c]
    assign("deck", deck[-1, ], envir = globalenv())
    card
  }
  
  SHUFFLE <- function(){
    random <- sample(1:52, size = 52)
    assign("deck", DECK[random, ], envir = globalenv())
  }
  
  list(deal = DEAL, shuffle <- SHUFFLE)
}

cards <- setup(deck) 

cards
