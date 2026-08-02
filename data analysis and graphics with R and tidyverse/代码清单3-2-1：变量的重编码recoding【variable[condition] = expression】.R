# 语句variable[condition] <- expression 将仅在condition的值为TRUE时执行赋值
# 变量（选中的列作为向量）遍历判断（condition产生的TRUE/FALSE的向量）

# 函数 within() 与函数 with() 类似，不同的是它允许我们修改数据框。

# 代码清单3-2-1：变量的重编码recoding【variable[condition] <- expression】
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

leadership <- transform(leadership, 
                        total_score = q1 + q2 + q3 + q4 + q5,
                        mean_score = (q1 + q2 + q3 + q4 + q5)/5)

leadership$age[leadership$age == 99] <- NA

leadership$age[leadership$leadership > 75] <- "Elder"

leadership$age[leadership$age >= 55 &
                 leadership$age <= 75] <- "Middle Aged"

leadership$age[leadership$age < 55] <- "Young"

leadership <- within(leadership, {
  agecat <- NA
  agecat[age > 75]             <- "Elder"
  agecat[age >=55 & age <= 75] <- "Middle Aged"
  agecat[age < 55]             <- "Young"
})
