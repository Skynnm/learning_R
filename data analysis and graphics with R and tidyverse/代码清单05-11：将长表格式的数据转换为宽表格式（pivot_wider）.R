# 临床医学、基础医学  和  预防医学是三套不同的逻辑

# 代码清单5-11：将长表格式的数据转换为宽表格式（pivot_wider）
# tidyr包中的函数spread()将长表格式数据框转换为宽表格式数据框，语法如下，其中：
# 【】longdata 是想要转换的数据
# 【】key是包含变量名的列
# 【】value是包含变量值的列
# 继续采用前述例子，代码清单5-11将长表格式的数据框转换为宽表格式
data_wide <- data.frame(ID = c("FR", "BE", "GER"),
                        Country = c("France", "Belgium", "Germany"),
                        LExp1990 = c(77.0, 76.1, 75.3),
                        LExp2000 = c(79.2, 77.8, 78.2),
                        LExp2010 = c(81.8, 80.3, 80.5))
data_wide
#   ID Country LExp1990 LExp2000 LExp2010
#1  FR  France       77       79       82
#2  BE Belgium       76       78       80
#3 GER Germany       75       78       80
data_long <- gather(data_wide, key = "Variable", value = "Life_Exp",
                    c(LExp1990, LExp2000, LExp2010))
data_long
#   ID Country Variable Life_Exp
#1  FR  France LExp1990       77
#2  BE Belgium LExp1990       76
#3 GER Germany LExp1990       75
#4  FR  France LExp2000       79
#5  BE Belgium LExp2000       78
#6 GER Germany LExp2000       78
#7  FR  France LExp2010       82
#8  BE Belgium LExp2010       80
#9 GER Germany LExp2010       80

data_wide <- spread(data_long, key = Variable, value = Life_Exp)
data_wide
#   ID Country LExp1990 LExp2000 LExp2010
#1  BE Belgium       76       78       80
#2  FR  France       77       79       82
#3 GER Germany       75       78       80
