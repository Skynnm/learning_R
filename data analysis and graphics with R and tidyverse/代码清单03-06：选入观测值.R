# 数据框是可以存储多种数据类型的数据结构，数据框的列本质上是向量

# 代码清单3-6：选入观测值
newdata <- leadership[1:3, ]                      # ①选择第1行到第3行（前3个观测值）
newdata <- leadership[leadership$gender == "M" &  # ②③选择所有30岁以上的男性
                        leadership$age > 30, ]    # ③选择所有30岁以上的男性
# 在以上每个示例中，我们只提供了行下标，并将下标留空（故选入了所有列）
# 我们来拆解②处代码以便理解它：
# ①逻辑比较 leadership$gender == "M" 生成了向量 c(TRUE, FALSE, FALSE, TRUE, FALSE)
# ②逻辑比较 leadership$age > 30 生成了向量 c(TRUE, TRUE, FALSE, TRUE, TRUE)
# ③逻辑比较 c(TRUE, FALSE, FALSE, TRUE, FALSE) & c(TRUE, TRUE, FALSE, TRUE, TRUE) 生成了向量c(TRUE, FALSE, FALSE, TRUE, FALSE)
# ④leadership[c(TRUE, FALSE, FALSE, TRUE, FALSE), ] 从数据框中选择了第1个和第4个观测值（当对应行是TRUE，这一行被选入；当对应行的索引是FALSE，这一行被剔除）。这就满足了我们的选取准则（30岁以上男性）
