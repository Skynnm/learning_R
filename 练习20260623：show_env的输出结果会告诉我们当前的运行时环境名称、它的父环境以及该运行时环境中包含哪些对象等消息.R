# assign(x, value, envir)
# x：字符串格式的变量名字
# value：你要存进去的数据 / 值
# envir：存到哪个环境
# 把【值】，存到指定环境里，并且在这个环境里起名叫【变量名】

# R在每一次运行函数时，都会创建一个新的活动环境，函数的运行时在新环境中进行的


# 练习20260623：show_env的输出结果会告诉我们当前的运行时环境名称、它的父环境以及该运行时环境中包含哪些对象等消息
show_env <- function(){
list(ran.in = environment(),
     parent = parent.env(environment()),
     objects = ls.str(environment()))
}

show_env()

## $ran.in
## <environment: 0x0000022c10625770> 
# R每次运行函数时，都会创造一个新的运行环境

  
## $parent
## <environment: R_GlobalEnv>
# 运行环境的父环境都是全局环境


## $objects
# 运行环境都是空的，不包含任何对象