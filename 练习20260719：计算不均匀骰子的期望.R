# 期望值、expand.grid、for循环、while循环

# 练习20260719：计算不均匀骰子的期望
die <- c(1, 2, 3, 4, 5, 6)  # 数据对象die是一个骰子的点数集合

rolls <- expand.grid(die, die) # R中的expand.grid函数可以方便快捷地写出n个向量元素的所有组合
rolls # expand.grid会返回一个含有两个骰子所有可能点数组合的数据框

rolls$value <- rolls$Var1 + rolls$Var2
head(rolls, 3)

prob <- c("1" = 1/8, "2" = 1/8, "3" = 1/8, "4" = 1/8, "5" = 1/8, "6" = 3/8)

prob
#1     2     3     4     5     6 
#0.125 0.125 0.125 0.125 0.125 0.375 

rolls$Var1 # 如果将rolls$Var1作为索引值对这个查找表取子集，就可以得到Var1中所有点数对应的概率值

prob[rolls$Var1] # 【向量循环】

rolls$prob1 <- prob[rolls$Var1]
head(rolls, 3)


rolls$prob2 <- prob[rolls$Var2] # 用同样的查找表方法找到Var2中点数对应的概率值
head(rolls, 3)

rolls$prob <- rolls$prob1 * rolls$prob2 # 通过prob1和prob2相乘得到每个点数组合的概率值
head(rolls, 3)

sum(rolls$value * rolls$prob)
#[1] 8.25