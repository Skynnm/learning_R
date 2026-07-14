# 代码清单2-6演示了普通因子和有序因子的不同是如何影响数据分析的

# 代码清单2-6：因子的使用
patientID <- c(1, 2, 3, 4)                                     # (1)
age <- c(25, 34, 28, 52)
diabetes <- c("Type1", "Type2", "Type1", "Type1")
status <- c("Poor", "Improved", "Excellent", "Poor")
diabetes <- factor(diabetes)
status <- factor(status, ordered = TRUE)
patientdata <- data.frame(patientID, age, diabetes, status)
str(patientdata)                                               # (2)
#'data.frame':	4 obs. of  4 variables:
#  $ patientID: num  1 2 3 4
#$ age      : num  25 34 28 52
#$ diabetes : Factor w/ 2 levels "Type1","Type2": 1 2 1 1
#$ status   : Ord.factor w/ 3 levels "Excellent"<"Improved"<..: 3 2 1 3
summary(patientdata)                                          #  (3)
#patientID         age         diabetes       status 
#Min.   :1.00   Min.   :25.00   Type1:3   Excellent:1  
#1st Qu.:1.75   1st Qu.:27.25   Type2:1   Improved :1  
#Median :2.50   Median :31.00             Poor     :2  
#Mean   :2.50   Mean   :34.75                          
#3rd Qu.:3.25   3rd Qu.:38.50                          
#Max.   :4.00   Max.   :52.00     

# (1)以向量形式输入数据
# (2)显示对象的结构
# (3)显示对象的统计概要
# 首先，以向量的形式输入数据(1)。然后，将diabetes和status分别指定为一个普通因子和一个有序因子。
# 最后，将数据合并为一个数据框。函数 str(object) 可提供 R 中某个对象（本例中为数据框）的信息(2)。
# 它清楚地显示 diabetes 是一个因子，而 status 是一个有序因子，并显示此数据框再内部是如何进行编码的。
# 注意，函数 summary() 会分别对待各个变量(3)。它显示了连续型变量 age 的最小值、最大值、均值和各四分位数，并显示了分类变量 diabetes 和 status（各水平）的频数值