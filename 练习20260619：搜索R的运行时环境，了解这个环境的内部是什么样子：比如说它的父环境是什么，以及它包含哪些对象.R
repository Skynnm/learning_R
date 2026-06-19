# R存储对象的树形环境结构（环境树）

# 练习20260619：搜索R的运行时环境，了解这个环境的内部是什么样子：比如说它的父环境是什么，以及它包含哪些对象

show_env <- function(){
  list(ran.in = environment(),
       parent = parent.env(environment()),
       objects = ls.str(environment()))
}
 
show_env()
