# transform() 函数
# 所有变量需申明或定义，$表示索引

# 代码清单3-2-0：创建新变量【transform()函数】
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

leadership$total_score <- leadership$q1 + leadership$q2 + leadership$q3 +
  leadership$q4 + leadership$q5

leadership$mean_score <- (leadership$q1 + leadership$q2 + leadership$q3 +
  leadership$q4 + leadership$q5)/5

leadership <- transform(leadership, 
                        total_score = q1 + q2 + q3 + q4 + q5,
                        mean_score = (q1 + q2 + q3 + q4 + q5)/5)
