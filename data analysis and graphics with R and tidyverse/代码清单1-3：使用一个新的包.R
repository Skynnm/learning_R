# 代码清单1-3：使用一个新的包
help.start() # 打开帮助文档首页，并查阅其中的"Introduction to R"
install.packages("vcd") # 安装vcd包（一个用于可视化类别数据的包）
help(package = "vcd") # 列出此包中可用的函数和数据集
library(vcd) # 载入这个包
help(Arthritis) # 阅读数据集Arthritis的描述
Arthritis # 显示数据集Arthritis的内容（直接输入一个对象的名称将列出它的内容）
example(Arthritis) # 运行数据集Arthritis自带的示例。如果不理解输出结果，也不用担心，结果基本上显示的是接受治疗的关节炎患者比接受安慰剂的患者在病情上有了更多改善
