# 读书学习就是糟糕生活最好的慰藉

# 代码清单5-6：数据处理难题的一套解决方案
# 要讨论数值和字符处理函数，让我们先来看一个数据处理问题。
# 一组学术参加了数学、科学 和 英语考试。
# 为了给所有学生确定一个成绩衡量指标，需要将这些刻面的成绩组合起来。
# 另外，我们还想将前 20% 的学术评定为 A，接下来 20% 的学术评定为 B，以此类推。
# 最后，我们希望按字母顺序对学生排序。相关数据如下所示：

#  学生姓名              数学               科学                英语
#  John Davis            502                95                  25
#  Angela Williams       600                99                  22
#  Bullwinkle Moose      412                80                  18
#  David Jones           358                82                  15
#  Janice Markhammer     495                75                  20
#  Cheryl Cushing        512                85                  28
#  Reuven Ytzhak         410                80                  15
#  Greg Knox             625                95                  30
#  Joel England          573                89                  27
#  Mary Rayburn          522                86                  18

# 观察此数据，我们马上可以发现一些明显的问题。
# 第一，3 科考试成绩是无法比较的，因为它们的均值和标准差相去甚远，所以对它们求平均值是没有意义的。我们在组合这些考试成绩之前，必须将其转换为可比较的单元。
# 其次，为了评定等级，我们需要一种方法来确定某个学生在前述得分上百分比排名。
# 再次，表示姓名的字段只有一个，这让排序任务复杂化了。为了正确地将其排序，需要将姓和名拆开。

# 以上每个任务都可以巧妙地利用R中的数值和字符处理函数完成。

# 发现、提炼、总结、抽象、拆分、解决科学问题如下:
# 将学生的各科考试成绩组合为单一的成绩衡量指标，基于相当名词（前20%、后20%，等等）给出从A 到 F评分
# 并根据学生姓氏和名字的首字母对花名册进行排序。下面的代码给出了一种解决方案：
options(digits = 2)                                            # ①

Students <- c("John Davis", "Angela Williams", "Bullwinkle Moose", "David Jones", "Janice Markhammer", "Cheryl Cushing", "Reuven Ytzhak", "Greg Knox", "Joel England", "Mary Rayburn")
Math <- c(502, 600, 412, 358, 495, 512, 410, 625, 573, 522)
Science <- c(95, 99, 80, 82, 75, 85, 80, 95, 89, 86)
English <- c(25, 22, 18, 15, 20, 28, 15, 30, 27, 18)

roster <- data.frame(Students, Math, Science, English, stringsAsFactors = FALSE)

z <- scale(roster[, 2:4])                                      # ②④
score <- apply(z, 1, mean)                                     # ③④
roster <- cbind(roster, score)                                 # ③④
y <- quantile(score, c(.8, .6, .4, .2))                        # ⑤⑦
roster$grade <- NA                                             # ⑥⑦
roster$grade[score >= y[1]] <- "A"                             # ⑥⑦
roster$grade[score < y[1] & score >= y[2]] <- "B"              # ⑥⑦
roster$grade[score < y[2] & score >= y[3]] <- "C"              # ⑥⑦
roster$grade[score < y[3] & score >= y[4]] <- "D"              # ⑥⑦
roster$grade[score <= y[4]] <- "F"                             # ⑥⑦

name <- strsplit((roster$Students), " ")                       # ⑧⑩
Lastname <- sapply(name, "[", 2)                               # ⑨⑩
Firstname <- sapply(name, "[", 1)                              # ⑨⑩
roster <-cbind(Firstname, Lastname, roster[, -1])              # ⑨⑩

roster <- roster[order(Lastname, Firstname),]                  # (11)(12)
roster
#    Firstname   Lastname Math Science English score grade
#6      Cheryl    Cushing  512      85      28  0.35     C
#1        John      Davis  502      95      25  0.56     B
#9        Joel    England  573      89      27  0.70     B
#4       David      Jones  358      82      15 -1.16     F
#8        Greg       Knox  625      95      30  1.34     A
#5      Janice Markhammer  495      75      20 -0.63     D
#3  Bullwinkle      Moose  412      80      18 -0.86     D
#10       Mary    Rayburn  522      86      18 -0.18     C
#2      Angela   Williams  600      99      22  0.92     A
#7      Reuven     Ytzhak  410      80      15 -1.05     F


# ①步骤1
# ②步骤2
# ③步骤3
# ④计算综合得分
# ⑤步骤4
# ⑥步骤5
# ⑦对学生评分
# ⑧步骤6
# ⑨步骤7
# ⑩提取姓氏和名字
# (11)步骤8
# (12)根据姓氏和名字排序


# 以上代码写的比较紧凑，逐步分解如下：
# 【步骤1】 原始的学生花名册已经给出了。options(digits = 2)限定了小数点后数字的位数，并且让输出更容易阅读:
options(digits = 2)
roster
#            Students Math Science English
#1         John Davis  502      95      25
#2    Angela Williams  600      99      22
#3   Bullwinkle Moose  412      80      18
#4        David Jones  358      82      15
#5  Janice Markhammer  495      75      20
#6     Cheryl Cushing  512      85      28
#7      Reuven Ytzhak  410      80      15
#8          Greg Knox  625      95      30
#9       Joel England  573      89      27
#10      Mary Rayburn  522      86      18

# 【步骤2】 由于数学、科学 和 英语考试的分值不同（均值 和 标准差相去甚远），在组合之前需要先让它们变得可以比较。
#           一种方法是将变量进行标准化，这样每科考试的成绩就都是用单位标准差来表示，而不是以原始的尺度来表示了。这个过程可以使用 scale() 函数来实现。
z <- scale(roster[, 2:4])
z           
#       Math Science English
#[1,]  0.013   1.078   0.587
#[2,]  1.143   1.591   0.037
#[3,] -1.026  -0.847  -0.697
#[4,] -1.649  -0.590  -1.247
#[5,] -0.068  -1.489  -0.330
#[6,]  0.128  -0.205   1.137
#[7,] -1.049  -0.847  -1.247
#[8,]  1.432   1.078   1.504
#[9,]  0.832   0.308   0.954
#[10,]  0.243  -0.077  -0.697
#attr(,"scaled:center")
#Math Science English 
#501      87      22 
#attr(,"scaled:scale")
#Math Science English 
#86.7     7.8     5.5 


#  【步骤3】 然后，可以通过函数 mean() 来计算各行的均值以获得综合得分，并使用函数 cbind() 将其添加到花名册中：
score <- apply(z, 1, mean)
roster <- cbind(roster, score)
roster
#            Students Math Science English score
#1         John Davis  502      95      25  0.56
#2    Angela Williams  600      99      22  0.92
#3   Bullwinkle Moose  412      80      18 -0.86
#4        David Jones  358      82      15 -1.16
#5  Janice Markhammer  495      75      20 -0.63
#6     Cheryl Cushing  512      85      28  0.35
#7      Reuven Ytzhak  410      80      15 -1.05
#8          Greg Knox  625      95      30  1.34
#9       Joel England  573      89      27  0.70
#10      Mary Rayburn  522      86      18 -0.18


#  【步骤4】 函数quantile() 给出了学生综合得分的百分位数。可以看到，成绩为 A 的分界点为0.74，B 的分界点为0.44，等等。
y <- quantile(roster$score, c(0.8, 0.6, 0.4, 0.2))
y
#   80%   60%   40%   20% 
#  0.74  0.44 -0.36 -0.89 


#  【步骤5】  通过使用逻辑运算符，我们可以将学生的百分位数排名重编码为一个新的分类成绩变量。下面在数据框 roster 中创建了变量 grade.
roster$grade <- NA                                          
roster$grade[score >= y[1]] <- "A"                              
roster$grade[score < y[1] & score >= y[2]] <- "B"               
roster$grade[score < y[2] & score >= y[3]] <- "C"               
roster$grade[score < y[3] & score >= y[4]] <- "D"               
roster$grade[score <= y[4]] <- "F" 
roster
#            Students Math Science English score grade
#1         John Davis  502      95      25  0.56     B
#2    Angela Williams  600      99      22  0.92     A
#3   Bullwinkle Moose  412      80      18 -0.86     D
#4        David Jones  358      82      15 -1.16     F
#5  Janice Markhammer  495      75      20 -0.63     D
#6     Cheryl Cushing  512      85      28  0.35     C
#7      Reuven Ytzhak  410      80      15 -1.05     F
#8          Greg Knox  625      95      30  1.34     A
#9       Joel England  573      89      27  0.70     B
#10      Mary Rayburn  522      86      18 -0.18     C


#  【步骤6】  使用函数 strsplit() 以空格为界把学生姓名拆分为姓氏和名字。把 strsplit() 应用到一个字符串组成的向量上会返回一个列表：
name <- strsplit((roster$Students), " ")
name
#[[1]]
#[1] "John"  "Davis"
#
#[[2]]
#[1] "Angela"   "Williams"
#
#[[3]]
#[1] "Bullwinkle" "Moose"     
#
#[[4]]
#[1] "David" "Jones"
#
#[[5]]
#[1] "Janice"     "Markhammer"
#
#[[6]]
#[1] "Cheryl"  "Cushing"
#
#[[7]]
#[1] "Reuven" "Ytzhak"
#
#[[8]]
#[1] "Greg" "Knox"
#
#[[9]]
#[1] "Joel"    "England"
#
#[[10]]
#[1] "Mary"    "Rayburn"


#  【步骤7】  我们可以使用函数 saplly() 提取列表中每个成分的第 1 个原始，放入一个存储名字的向量 Firstname，并提取每个成分的第2个元素，放入一个存储姓氏的向量 Lastname。
#             “[”是一个可以提取某个对象的一部分的函数——在这里它是用来提取列表 name 各成分中的第1个或第2个元素。
#             我们将使用 cbind() 把它们添加到花名册中。由于已经不再需要 student 变量，可以将其丢弃（在下标中使用-1）
Lastname <- sapply(name, "[", 2)                               
Firstname <- sapply(name, "[", 1)                              
roster <-cbind(Firstname, Lastname, roster[, -1])              
roster
#    Firstname   Lastname Math Science English score grade
#1        John      Davis  502      95      25  0.56     B
#2      Angela   Williams  600      99      22  0.92     A
#3  Bullwinkle      Moose  412      80      18 -0.86     D
#4       David      Jones  358      82      15 -1.16     F
#5      Janice Markhammer  495      75      20 -0.63     D
#6      Cheryl    Cushing  512      85      28  0.35     C
#7      Reuven     Ytzhak  410      80      15 -1.05     F
#8        Greg       Knox  625      95      30  1.34     A
#9        Joel    England  573      89      27  0.70     B
#10       Mary    Rayburn  522      86      18 -0.18     C


#  【步骤8】  最后，可以使用函数 order() 依姓氏和名字对数据集进行排序：
roster[order(Lastname, Firstname),]
#    Firstname   Lastname Math Science English score grade
#6      Cheryl    Cushing  512      85      28  0.35     C
#1        John      Davis  502      95      25  0.56     B
#9        Joel    England  573      89      27  0.70     B
#4       David      Jones  358      82      15 -1.16     F
#8        Greg       Knox  625      95      30  1.34     A
#5      Janice Markhammer  495      75      20 -0.63     D
#3  Bullwinkle      Moose  412      80      18 -0.86     D
#10       Mary    Rayburn  522      86      18 -0.18     C
#2      Angela   Williams  600      99      22  0.92     A
#7      Reuven     Ytzhak  410      80      15 -1.05     F


#  怎么样？小事一桩吧！
#  完成这样的方式有许多，只是以上代码体现了相应函数的设计初衷。现在到学习控制结构和自定义函数的时候了。