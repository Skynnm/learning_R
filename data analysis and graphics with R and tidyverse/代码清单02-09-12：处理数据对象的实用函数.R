# 在因子factor中（数值型向量）：level代表变量的实际值，而labels表示包含了理想值标签的字符向量

# 代码清单2-9-93：处理数据对象的实用函数
# 简要小结处理函数的实用函数

length(object)              # 显示对象中元素/成分的数量
dim(object)                 # 显示某个对象的维度
str(object)                 # 显示某个对象的结构
class(object)               # 显示某个对象的类或类型
mode(object)                # 显示某个对象的模式
names(object)               # 显示某对象中中各成分的名称
c(object, object, ...)      # 将对象合并入一个向量
cbind(object, object, ...)  # 按列合并对象
rbind(object, object, ...)  # 按行合并对象
object                      # 输出某个对象
head(object)                # 列出某个对象的开始部分
tail(object)                # 列出某个对象的最后部分
ls()                        # 删除一个或更多个对象。语句rm(list = ls()) 将删除当前工作环境中的几乎所有对象
newobject <- edit(object)   # 编辑对象并另存为newobject
fix(object)                 # 直接编辑对象
view(object)                # 或直接点击环境窗口查看
