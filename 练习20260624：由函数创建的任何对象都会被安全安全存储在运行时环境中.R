# R在每一次函数求值(evaluation)时都会创建一个新环境。每当R运行该函数时都会在这个新环境中进行
# 然后带着函数运行的结果回到调用该函数时的环境。我们称这样的环境为运行时环境(runtime enviroment)
# 因为它室R在运行函数求值时创建的环境。

# 练习20260624：由函数创建的任何对象都会被安全安全存储在运行时环境中

show_env <- function(){
  a <- 1
  b <- 2
  c <- 3
  list(ran.in = environment(),
       parent = parent.env(environment()),
       objects = ls.str(environment()))
}

show_env()

## $ran.in
## <environment: 0x0000022c0c852278>
  
## $parent
## <environment: R_GlobalEnv>
  
## $objects
## a :  num 1
## b :  num 2
## c :  num 3