# 原假设：H0:两变量相互独立，不相关（两变量之间不存在某种关系）

# 代码清单7-10-2：Cochran-Mantel-Haenszel检验
# mantelhaen.test()函数可用来进行 Cochran-Mantel-Haenszel 卡方检验
# 其原假设是：两个名义变量在第3个变量的每一层都是条件独立的
# 下列代码可以检验治疗方式和改善情况在性别的每一水平下是否独立。
# 此检验假设不存在三阶交互作用（治疗方式 x 改善情况 x 性别）
mytable <- xtabs(~ Treatment + Improved + Sex, data = Arthritis)
mytable
#, , Sex = Female
#
#Improved
#Treatment None Some Marked
#Placebo   19    7      6
#Treated    6    5     16
#
#, , Sex = Male
#
#Improved
#Treatment None Some Marked
#Placebo   10    0      1
#Treated    7    2      5

mantelhaen.test(mytable)
#                 Cochran-Mantel-Haenszel test
#
#data:  mytable
#Cochran-Mantel-Haenszel M^2 = 14.632, df = 2, p-value = 0.0006647

# 结果表明，患者接受的治疗与得到的改善在性别的每一水平下并不独立（从性别来看，接受用药治疗的患者较接受安慰剂治疗的患者有了更多的改善）