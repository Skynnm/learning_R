# 在R中存储信息并非只能通过赋值的方式；创建某种特殊的行为也不一定只能通过编写函数来实现。这两种任务都可以通过R的S3系统来完成。

# 代码清单3-2-2：变量的重命名
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

# 如果对现有的变量名称不满意，我们可以交互式地或者以编程的方式修改它们。
# 假设我们希望将变量名 manager 修改为 managerID，并将 date 修改为 testDate，那么可以使用语句：
fix(leadership)
leadership <- edit(leadership)
# 来调用一个交互式的编辑器【R内置的文本编辑器】。然后单击变量名，在弹出的对话框中将其重命名。



# 若以编程方式，可以通过names()函数来重命名变量。例如语句：
names(leadership)[2] <- "testDate"  # 将重命名date为testDate，完整代码如下所示：

names(leadership)
#[1] "manager"     "data"        "country"     "gender"      "age"         "q1"         
#[7] "q2"          "q3"          "q4"          "q5"          "total_score" "mean_score" 

names(leadership)[2] <- "testDate"
leadership
#  manager testDate country gender   age q1 q2 q3 q4 q5 total_score mean_score
#1       1 10/24/08      US      M Young  5  4  5  5  5          24        4.8
#2       2 10/28/08      US      F Young  3  5  2  5  5          20        4.0
#3       3  10/1/08      UK      F Young  3  5  5  5  2          20        4.0
#4       4 10/12/08      UK      M Young  3  3  4 NA NA          NA         NA
#5       5   5/1/09      UK      F  <NA>  2  2  1  2  1           8        1.6

# 以类似的方式，以下语句：
names(leadership)[6:10] <- c("item1", "item2", "item3", "item4", "item5")
# 将重命名q1到q5为item1到item5
leadership
#  manager testDate country gender   age item1 item2 item3 item4 item5 total_score mean_score
#1       1 10/24/08      US      M Young     5     4     5     5     5          24        4.8
#2       2 10/28/08      US      F Young     3     5     2     5     5          20        4.0
#3       3  10/1/08      UK      F Young     3     5     5     5     2          20        4.0
#4       4 10/12/08      UK      M Young     3     3     4    NA    NA          NA         NA
#5       5   5/1/09      UK      F  <NA>     2     2     1     2     1           8        1.6
