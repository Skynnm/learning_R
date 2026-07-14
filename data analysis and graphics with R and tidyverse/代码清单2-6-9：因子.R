# 因子本质是【有固定取值范围的分类变量】
# 因子的作用是告诉R：“这是分类数据，取值范围固定，按类别处理”
# level代表变量的实际值，而labels表示包含了理想值标签的字符向量



# 代码清单2-5-1：因子

# 如你所见，变量可归结为名义变量、顺（有）序变量或连续型变量。
# 名义变量（nominal variable）是没有顺序之分的分类变量。Diabetes（Type1、Type2）是名义变量的一例。即使在数据中Type1编码为1而Type2编码为2，这也并不意味着二者是有序的。
# 有序变量（ordinal variable）表示一种顺序关系，而非数量关系。poor、improved、excellent（表示病情）是顺序变量的一个上佳示例。我们明白，病情为poor（较差）的病人状态不如improved（病情好转）的病人，但并不知道他们之间相差多少。
# 连续型变量（continuous variable）可以呈现为某个范围内的任意值，并同时表示了顺序和数量。Age（年龄）就是一个连续型变量，它能够表示像14.5或22.8这样的值以及其间的其他任意值。很清楚，15岁的人比14岁的人年长一岁。

# 【分类变量（名义变量）和有序的分类变量（顺序变量）在R中称为因子（factor）】
# 因子在R中非常重要，因为它决定了数据的分析方式以及如何进行视觉呈现。我们将在本书中通篇看到这样的例子

# 函数 factor() 以一个整数向量的形式存储类别值，整数的取值范围是[1...k]（其中k是名义变量中唯一值的个数）。同时，一个由字符串（原始值）组成的内部向量将映射到这些整数上。举例来说，假设有向量
diabetes <- c("Type1", "Type2", "Type1", "Type1")
diabetes <- factor(diabetes)
# 语句 diabetes <- factor(diabetes) 将此向量存储为(1, 2, 1, 1)，并在内部将其关联为 1 = Type1 和 2 = Type2（【具体赋值根据字母顺序而定】）。针对向量 diabetes 进行的任何分析都会将其作为名义变量对待，并自动选择适合这一测量尺度的统计方法，
# 要表示顺序变量，需要为函数 factor() 指定参数 ordered = TRUE。给定向量：
status <- c("Poor", "Improved", "Excellent", "Poor")
status <- factor(status, ordered = TRUE)
# 语句 status <- factor(status, ordered = TRUE) 会将向量编码为(3, 2, 1, 3)，并在内部将这些值关联为 1 = Excellent、2 = Improved 以及 3 = Poor。
# 另外，针对此向量进行的任何分析都会将其作为顺序变量对待，并自动选择合适的统计方法。

# 对于【字符向量，因子的水平默认依字母顺序创建】。这对于因子 status 是有意义的，因为"Excellent""Improved""Poor"的排序方式恰好与逻辑顺序一致。如果"Poor"被编码为"Ailing"，会有问题，因为顺序将为"Ailing""Excellent""Improved"。如果理想中的顺序是"Poor""Improved""Excellent"，则会出现类似的问题。按默认的字母顺序的因子很少能够让人满意。
# 我们可以通过指定 levels 选项来覆盖默认排序（升序覆盖）。例如：
status <- factor(status, ordered = TRUE,
                 levels = c("Poor", "Improved", "Excellent"))
# 各水平的赋值将为 1 = Poor、2 = Improved、3 = Excellent。请保证指定的水平的赋值与数据中的真实值相匹配，因为任何在数据中出现而未在参数中列举的数据都将被设为缺失值。
# 数值型变量可以用参数 levels 和 labels 来编码成因子。如果男性编码成1，女性被编码成2，则以下语句：
sex <- factor(sex, levels = c(1, 2), labels = c("Male", "Female"))
# 把变量转换成一个无序因子。我们需要注意，标签的顺序必须和水平相一致。在这个例子中，性别将被当成分类变量，标签“Male”和"Female"将替代 1 和 2 在结果中输出，而且所有不是1或2的性别变量将被设为缺失值 
