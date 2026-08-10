# 程序员看代码/理解代码的时间，远多于写代码的时间

# 代码清单3-7：使用dplyr操作数据
# 到目前为止，我们使用基本的R函数来操作R数据框，而dplyr包提供了一系列快捷方式，让我们能够以简便的的方式完成相同的数据管理任务。dplyr包正迅速成为数据管理中最受欢迎的R包
# dplyr包提供了一系列函数，这些函数可用于选取变量和观测值、转换变量、重命名变量和对行进行排序等任务。

#### 用于操作数据框的dplyr函数
#    函数                     用途
#    select()                 选择变量/列
#    filter()                 选择观测值/行
#    mutate()                 转换或重编码变量【新增变量】
#    rename()                 重命名变量/列
#    recode()                 重编码变量值
#    arrange()                按编码值对行进行排序（默认升序）
#    group_by()
#    summarize()

install.packages("dplyr")
library("dplyr")                                                               # ①加载dplyr包

leadership <- data.frame(
  manager = c(1, 2, 3, 4, 5),
  date = c("10/24/08", "10/28/08", "10/1/08", "10/12/08", "5/1/09"),
  country = c("US", "US", "UK", "UK", "UK"),
  gender = c("M", "F", "F", "M", "F"),
  age = c(32, 45, 25, 39, 99),
  q1 = c(5, 3, 3, 3, 2),
  q2 = c(4, 5, 5, 3, 2),
  q3 = c(5, 2, 5, 4, 1),
  q4 = c(5, 5, 5, NA, 2),
  q5 = c(5, 5, 2, NA, 1)
)

leadership <- mutate(leadership,                                               # ②创建两个汇总变量
                     total_score = q1 + q2 + q3 + q4 + q5,                     # ②创建两个汇总变量
                     mean_score = total_score / 5)                             # ②创建两个汇总变量

leadership$gender <- recode(leadership$gender,                                 # ③将M和F重编码为Male和Female
                            "M" = "male", "F" = "female")                      # ③将M和F重编码为Male和Female

leadership <- rename(leadership, ID = "manager", sex = "gender")               # ④重命名变量manager和gender

leadership <- arrange(leadership, sex, total_score)                            # ⑤根据性别以及各性别的总分对数据排序

leadership_ratings <- select(leadership, ID, mean_score)                       # ⑥新建数据框，其中包含了评分所需的变量

leadership_men_high <- filter(leadership,                                      # ⑦新建数据框，其中包含了总分大于10的男性样本
                              sex == "male" & total_score > 10)                # ⑦新建数据框，其中包含了总分大于10的男性样本





# 首先，加载dplyr包。然后，使用函数mutate()创建总分和平均分。格式为：
dataframe <- mutate(dataframe,                                                 # 添加新变量
                    newvar1 = expression,                                      # 添加新变量
                    newvar2 = expression, ...)                                 # 添加新变量
# 新变量就添加到数据框中了


# 下一步，使用函数 recode() 修改变量 gender 的值，格式为：
vector <- recode(vector,                                                       # 修改旧变量
                 oldvalue1 = newvalue2,                                        # 修改旧变量
                 oldvalue2 = newvalue2, ...)                                   # 修改旧变量


# 未指定新值的向量值保持不变。例如：
x <- c("a", "b", "c")
x <- recode(x, "a" = "apple", "b" = "banana")
x
# [1] "apple"  "banana" "c"  
# 对于数值，使用反引号来引用原始值：
y <- c(1, 2, 3)
y <- recode(y, '1' = 10, '2' = 15)
y
# [1] 10 15  3


# 下一步，使用函数rename()更改变量名，格式为：
dataframe <- rename(dataframe,
                    newname1 = "oldname1",
                    newname2 = "oldname2", ...)


# 之后，使用函数 arrange() 对数据进行排序。首先，按性别的升序（先女性，后男性）对行进行排序。然后，在每个性别组中分别按total_score的升序（从低分到高分）对行进行排序。函数desc()用于降序排序。例如：
leadership <- arrange(leadership, sex, desc(total_score))
# 这一行代码按性别的升序对数据进行排序，对每个性别中的数据则是进行降序排序（从高分到低分）


# select语句用来选取或剔除变量（列）。在本例中，选取了变量ID和mean_score。函数select()的格式为：
dataframe <- select(dataframe, variablelist1, variablelist2, ...)
# 通常，变量清单为不带引号的变量名。冒号（：）可以用来选择一系列变量。
# 另外，可以使用函数选择包含特定文本字符串的变量。例如语句：
leadership_subset <- select(leadership,
                            ID, country:age, starts_with("q"))
# 选择变量ID、country、sex、age、q1、q2、q3、q4和q5。有关可以用于选择变量的函数清单，请参阅 help(select_helpers)。
# 减号（-）用于剔除变量。语句：
leadership_subset <- select(leadership, -sex, -age)
# 包含除sex和age以外的所有变量。


# 最后，函数 filter() 用于选择数据框中满足指定的一组条件的观测值或行。在这里，保留总分大于10的男性。格式为：
dataframe <- filter(dataframe, expression)
# 如果表达式结果为TRUE，则保留行。可以使用任意逻辑运算符，并且可以用圆括号来表明运算符的优先级。例如：
extreme_men <- filter(leadership,
                      sex == "male" &
                        (mean_score < 2 | mean_score > 4))
# 创建了包含所有平均分低于2或高于4的男性经理人的数据框。






#### 使用观点操作符对语句进行串接
# dplyr包允许我们以紧凑的格式来编写代码，即使用由 magrittr 包提供的管道运算符（%>%）。请看以下三条语句：
high_potentials <- filter(leadership, total_score > 10)
high_potentials <- select(high_potentials, ID, country, mean_score)
high_potentials <- arrange(high_potentials, country, mean_score)
# 这3条语句可以使用管道符重写为一条语句：
high_potentials <- filter(leadership, total_score > 10) %>%
  select(ID, country, mean_score) %>%
  arrange(country, mean_score)
# 运算符 %>% （发音和 THEN 相同）将左边的结果传递给右边的函数的第一个参数。以这种方式重写的语句通常更简单易读。
# 虽然我们已经讨论了基本的 dplyr 函数，但是 dplyr 包中还包含用于汇总、合并 和 重组数据的函数。