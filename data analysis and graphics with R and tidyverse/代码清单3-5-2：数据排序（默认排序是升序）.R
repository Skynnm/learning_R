# 方程是物理的诗歌，代码是编程的诗歌

# 代码清单3-5-2：数据排序（默认排序是升序）
# 有些情况下，查看排序后的数据集可以获得相当多的信息。例如，哪些经理人最具服从意识？
# 在R中，可以使用 order() 函数对一个数据框进行排序。
# 默认的排序顺序是升序，在排序变量的前边加一个减号即可得到降序的排序结果
leadership <- data.frame(
  manager = c(1, 2, 3, 4, 5),
  data    = c("10/24/08", "10/28/08", "10/1/08", "10/12/08", "5/1/09"),
  country = c("US", "US", "UK", "UK", "UK"),
  gender  = c("M", "F", "F", "M", "F"),
  age     = c(32, 45, 25, 39, 99),
  q1      = c(5, 3, 3, 3, 2),
  q2      = c(4, 5, 5, 3, 2),
  q3      = c(5, 2, 5, 4, 1),
  q4      = c(5, 5, 5, NA, 2),
  q5      = c(5, 5, 2, NA, 1)
)

newdata <- leadership[order(leadership$age),] # 创建了一个新的数据集，其中各行依经理人的年龄升序排序
newdata

newdata <- leadership[order(leadership$gender, leadership$age),] # 将各行依女性到男性、同样性别中按年龄升序排序

newdata <- leadership[order(leadership$gender, -leadership$age)] # 将各行依女性到男性、同样性别中按年龄降序排序
