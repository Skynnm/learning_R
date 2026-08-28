# 字符处理函数可以从文本型数据中抽取信息，或者为打印输出和生成报告重设文本的格式
# ignore.case 忽略大小写

# 代码清单5-4-0：字符处理函数（regular expression 正则表达式）
# 数学函数和统计函数是用来处理数值型数据的，而字符处理函数可以从文本型数据中抽取信息，或者为打印输出和生成报告重设文本的格式。
# 举例来说，我们可能希望将某人的姓和名连接在一起，并保证姓和名的首字母大写，抑或想统计可自由回答的调查反馈信息中某些实例（instance）的数量。
# 一些最有用的字符处理函数见下表：

#  函数                         描述
#  nchar(x)                     计算 x 中的字符数量
                                x <- c("ab", "cde", "fghij")  
                                length(x)   # 返回值为3
                                nchar(x[3]) # 返回值为5
  
#  substr(x, start, stop)       提取或替换一个字符向量中的子串
                                x <- "abcdef"
                                substr(x, 2, 4) # 返回值为“bcd"
                                substr(x, 2, 4) <- "22222"  # （x将变成“a222ef”）                              
                                x
                              
#  grep(pattern, x,             在 x 中搜索某种模式。若 fixed = FALSE，则 pattern 为一个正则表达式。
#    ignore.case = FALSE,       若 fixed = TRUE，则 pattern 为一个文本字符串。
#    fixed = FALSE)             返回值为匹配的下标。
                                grep("A", c("b", "A", "ac", "Aw"), fixed = TRUE) # 返回值为c(2, 4)

#  sub(pattern, replacement, x, 在 x 中搜索pattern，并以文本 replacement 将其替换。
#    ignore.case = FALSE,       若 fixed = FALSE，则pattern为一个正则表达式。
#    fixed = FALSE)             若 fixed = TRUE ，则pattern为一个文本字符串。
                                sub("\\s", ".", "Hello There") # 返回值为"Hello.There"
                                # 注意，”\s“是一个用来查找空白的正则表达式；使用"\\s”而不用”\”的原因是，后者是R中的转移字符
                                
#  strsplit(x, split,           在 split 处分隔字符向量 x 中的元素。
#    fixed = FALSE)             若 fixed = FALSE，则pattern为一个正则表达式。
#                               若 fixed = TRUE , 则pattern为一个文本字符串。
                                y <- strsplit("abc", "")
                                y         # 将返回一个含有1个成分、3个元素的列表，包含的内容为"a" "b" "c"

#  paste(..., sep = "")         连接字符串，分隔符为sep
                                paste("x", 1:3, sep = "")  # 返回值为c("x1", "x2", "x3")
                                paste("x", 1:3, sep = "M") # 返回值为c("xM1", "xM2", "xM3")
                                paste("Today is", date())  # 返回值为"Today is Mon Aug 17 22:09:20 2026"

# toupper(x)                    大写转换
                                toupper("abc")   # 返回值为"ABC"
                                
# tolower(x)                    小写转换
                                tolower("ABC")   # 返回值为“abc”


# 请注意，函数 grep()、sub() 和 strsplit() 能够搜索某个文本字符串（fixed = TRUE）或某个正则表达式（fixed = FALSE，默认值为FALSE）
# 正则表达式为文本模式的匹配提供了一套清晰且简练的语法。例如，正则表达式：
^[hc]?at
# 可匹配任意以0个或1个 h 或 c 开头、后接 at 的字符串。
# 因此，此表达式可以匹配hat、cat 和 at，但不会匹配 bat。
# 更多详情，请参考维基百科的 regular expression （正则表达式）条目。
# 也可参阅实用教程，包括 Ryans Regular Expression Tutorial（Ryans正则表达式教程）和 RegexOne上的互动教程。
