# Tips5：summary() 计算描述性统计量
# 在描述性统计量的计算方面，R种的选择夺得数不过来。我们先使用基础安装中包含的函数，然后查看那些用户贡献包中的扩展函数。
# 在基础安装程序中，我们可以使用summary()来获取描述性统计量
myvars <- c("mpg", "hp", "wt")
summary(mtcars[myvars])
#  mpg           hp            wt     
#Min.   :10   Min.   : 52   Min.   :1.5  
#1st Qu.:15   1st Qu.: 96   1st Qu.:2.6  
#Median :19   Median :123   Median :3.3  
#Mean   :20   Mean   :147   Mean   :3.2  
#3rd Qu.:23   3rd Qu.:180   3rd Qu.:3.6  
#Max.   :34   Max.   :335   Max.   :5.4 
mtcars
# 【summary() 函数提供了用来描述数值型变量的最小值、最大值、四分位数 和 均值，以及用来描述因子向量和逻辑型向量的频数统计】