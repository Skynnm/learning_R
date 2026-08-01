# 当过程中对 R 对象等环境参数进行修改后，自然会对输出结果产生影响

# 练习20260801：数据集的标注【变量标签-拓展包，值标签-因子】
# 为了使结果更易解读，数据分析人员通常会对数据集进行标注。
# 这种标注包括为变量名添加描述性的标签，以及为分类变量中的编码添加值标签。
# 例如，对于变量 age，我们可能想附加一个描述更详细的标签“Age at hospitalization (in years)”（入院年龄）。
# 对于编码为1或2的变量gender，我们可能想将其关联到标签“male”和“female"上



# 1.变量标签【拓展包】
# names() / colnames() 只能设置列名（变量短名称），不能作为「变量标签（variable label）」。
# 二者是两套独立属性，不要混淆
# 变量标签（variable label）是拓展元数据，基础 R 数据框本身没有原生支持变量标签，依靠扩展包实现：
# haven / labelled 包：主流，兼容 SPSS/SAS 导出标签

# (1)方式 1：labelled 包（推荐）
install.packages("labelled")
library(labelled)

df <- data.frame(x = c(1,2,3))
# 设置变量标签
var_label(df$x) <- "家庭年收入（万元）"

# 查看标签
var_label(df$x)
# 列名依然是x，标签是附加信息
names(df)

# (2)方式 2：haven（处理 SPSS 数据最常用）
library(haven)
df <- data.frame(x = 1:3)
attr(df$x, "label") <- "家庭年收入（万元）"

# 读取标签
attr(df$x, "label")



# 2.值标签【因子 factor】
# 函数 factor() 可为分类变量创建值标签。
# 假设有一个名为 gender 的变量，其中 1 表示男性，2 表示女性。我们可以使用代码来创建值标签：
patientdata$gender <- factor(patientdata$gender,
                             levels = c(1, 2),
                             labels = c("male", "female"))
# 这里，levels代表变量的实际值，而labels表示了包含了理想值标签的字符型向量