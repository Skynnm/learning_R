# 如果有两个以上的分类变量，那么就是在处理多维列联表。

# 代码清单7-9：三维列联表
# table() 和 xtabs() 都可以基于3个或更多的分类变量生成多维列联表。
# 函数 margin.table()、prop.table() 和 addmargins() 可以自然地推广到高于二维的情况。
# 另外，ftable() 函数可以以一种紧凑且吸引人的方式输出多维列联表
mytable <- xtabs(~ Treatment + Sex + Improved, data = Arthritis)               # ①各单元格的频数
mytable
#, , Improved = None
#
#Sex
#Treatment Female Male
#Placebo     19   10
#Treated      6    7
#
#, , Improved = Some
#
#Sex
#Treatment Female Male
#Placebo      7    0
#Treated      5    2
#
#, , Improved = Marked
#
#Sex
#Treatment Female Male
#Placebo      6    1
#Treated     16    5

ftable(mytable)
#Improved None Some Marked
#Treatment Sex                             
#Placebo   Female            19    7      6
#          Male              10    0      1
#Treated   Female             6    5     16
#          Male               7    2      5

margin.table(mytable, 1)                                                       # ②边际频数
#Treatment
#Placebo Treated 
#43      41 

margin.table(mytable, 2)
#Sex
#Female   Male 
#59     25 

margin.table(mytable, 3)
#Improved
#None   Some Marked 
#42     14     28 

margin.table(mytable, c(1, 3))                                                 # ③治疗方式（Treatment）x 改善情况（Improved）的边际频数
#             Improved
#Treatment None Some Marked
#Placebo   29    7      7
#Treated   13    7     21

ftable(prop.table(mytable, c(1, 2)))                                           # ④治疗方式（Treatment）x 性别（Sex）的各类改善情况比例
#                 Improved       None       Some     Marked
#Treatment Sex                                             
#Placebo   Female          0.59375000 0.21875000 0.18750000
#          Male            0.90909091 0.00000000 0.09090909
#Treated   Female          0.22222222 0.18518519 0.59259259
#          Male            0.50000000 0.14285714 0.35714286

ftable(addmargins(prop.table(mytable, c(1, 2)), 3))
#                 Improved       None       Some     Marked        Sum
#Treatment Sex                                                        
#Placebo   Female          0.59375000 0.21875000 0.18750000 1.00000000
#Male                      0.90909091 0.00000000 0.09090909 1.00000000
#Treated   Female          0.22222222 0.18518519 0.59259259 1.00000000
#Male                      0.50000000 0.14285714 0.35714286 1.00000000    

# 第①部分代码生成了三维分组各单元格的频数。这段代码同时演示了如何使用 ftable() 函数输出更为紧凑和吸引人的表格
# 第②部分代码为治疗方式（Treatment）、性别（Sex）和改善情况（Improved）生成了边际频数。由于使用公式~Treatment + Sex + Improve 创建了这个表，所以Treatment需要通过下标1来引用，Sex通过下标2来引用，Improved通过下标3来引用。
# 第③部分代码为治疗方式（Treatment） x 改善情况（Improved）分组的边际频数，由不同性别（Sex）的单元加和而成。每个Treatment x Sex组合中改善情况为 None、Some 和 Marked 患者的比例由④给出。在这里可以看到治疗组的男性中有36%有了显著改善，女性为59%。一般来说，比例将被添加到不在 prop.table()调用中的下标上（本例中是第3各下标，或称Improved）。在最后一个例子中可以看到这一点，我们在那里为第3各下标添加了边际和。

# 如果像得到百分比而不是比例，可以将结果表格乘以100。例如语句：
ftable(addmargins(prop.table(mytable, c(1, 2)), 3)) * 100
#                 Improved       None       Some     Marked        Sum
#Treatment Sex                                                        
#Placebo   Female           59.375000  21.875000  18.750000 100.000000
#          Male             90.909091   0.000000   9.090909 100.000000
#Treated   Female           22.222222  18.518519  59.259259 100.000000
#          Male             50.000000  14.285714  35.714286 100.000000

# 【列联表可以告诉我们组成表格的各种变量组合的频数和比例】
# 不过我们可能还会对列联表中的变量是否相关或独立感兴趣，可以做独立性检验