# setwd 设置工作空间【建工作目录】

# 代码清单2-9-2：从带分隔符的文本文件导入数据
# 我们可以使用 read.table() 从带分隔符的文本文件中导入数据。
# 此函数可读入一个表格格式的文件并将其保存为一个数据框。表格的每一行分别出现在文件中的每一行。其语法如下：
# mydataframe <- read.table(file, options)
# 其中，file 是一个带分隔符的 ASCII 文本文件，options 是控制如何处理数据的选项。
#StudentID,	First,	Last,	Math,	Science,	Social Studies
#011,	Bob,	Smith,	90,	80,	67
#012,	Jane,	Weary,	75,	 ,	80
#010,	Dan,	"Thornton, III"	65,	75,	70
#040,	Mary,	O'Leary,	90,	95,	92
# 这个文件可以用以下语句导入到一个数据库

studentgradestxt <- "StudentID	First	Last	Math	Science	Social Studies
011	Bob	Smith	90	80	67
012	Jane	Weary	75		80
010	Dan	Thornton, III	65	75	70
040	Mary	O'Leary	90	95	92"

studentgrades <- read.delim(text = studentgradestxt, fill = TRUE, na.strings = "")
studentgrades

write.csv(
  studentgrades, 
  file = "studentgrades.csv", 
  row.names = FALSE,  # 不输出R自动生成的行号列
  na = ""  # 空值保持空白，不输出"NA"字符串，和原数据格式一致
)

getwd()
setwd("C:\\Users\\peng\\Desktop\\R_work\\R语言实战")
# 这个文件可以用以下语句导入到一个数据框
grades <- read.table("studentgrades.csv", header = TRUE,
                     row.names = "StudentID", sep = ",")
grades
#First          Last Math Science Social.Studies
#11   Bob         Smith   90      80             67
#12  Jane         Weary   75      NA             80
#10   Dan Thornton, III   65      75             70
#40  Mary       O'Leary   90      95             92
str(grades)
#'data.frame':	4 obs. of  5 variables:
#  $ First         : chr  "Bob" "Jane" "Dan" "Mary"
#$ Last          : chr  "Smith" "Weary" "Thornton, III" "O'Leary"
#$ Math          : int  90 75 65 90
#$ Science       : int  80 NA 75 95
#$ Social.Studies: int  67 80 70 92


# 如何导入数据有很多有趣的要点。根据 R 的惯例，变量名 Social Studies 被自动地重命名。
# 列 Student ID 现在是行名，不再有标签，也失去了前置的0。Jane 缺失的科学课成绩被正确地识别为缺失值。
# 我需要将 Dan 的姓用双引号包围住，从而避免 Thornton 和 III 之间的逗号。否则，R 会在那一行读出7个值而不是6个值。
# 我也要使用双引号将 O’Leary 包围住，否则，R会把单引号读取为分隔符（而不是我想要的）。


# stringAsFactors 选项【新版本 R 不会将字符型变量自动转为因子】【因子很难进行文本挖掘】
# 在函数 read.table()、data.frame() 和 as.data.frame()中，选项 stringAsFactors 用于控制是否自动将字符型变量转换为因子。在R 4.0.0以前的版本中，默认设置为TRUE。从R 4.0.0开始，默认设置为FALSE。如果你用的是R的就版本，那么在前面的示例中，变量 First 和 Last 的类型是因此，而不是字符型。
# 有时，我们可能不需要将字符型转换为因子。例如，我们不需要将值为回复值评论的字符型变量转换为因子。另外，我们可能需要操作或挖掘变量中的文本，如果将字符型变量转换为因子则很难进行。
# 我们可以用几种方法取消这个默认的转换操作。添加选项 stringAsFactors = FALSE 可以对所有的字符变量取消这个转换操作。我们还可以用 colClassess 选项为每一列指定一个类（比如逻辑型、数值型、字符型或因子型）。


# 我们来重新导入上面的数据，并同时为每个变量指定一个类：
grades <- read.table("studentgrades.csv", header = TRUE,
                     row.names = "StudentID", sep = ",",
                     colClasses = c("character", "character", "character",
                                    "numeric", "numeric", "numeric"))
grades
#First          Last Math Science Social.Studies
#11   Bob         Smith   90      80             67
#12  Jane         Weary   75      NA             80
#10   Dan Thornton, III   65      75             70
#40  Mary       O'Leary   90      95             92
str(grades)
#'data.frame':	4 obs. of  5 variables:
#  $ First         : chr  "Bob" "Jane" "Dan" "Mary"
#$ Last          : chr  "Smith" "Weary" "Thornton, III" "O'Leary"
#$ Math          : num  90 75 65 90
#$ Science       : num  80 NA 75 95
#$ Social.Studies: num  67 80 70 92

# 这时，行名保留了前缀0，且 First 和 Last 不再是因子（即使是R的旧版本也是如此）。此外，grades 作为实数而不是整数来进行排序。
# 函数 read.table() 还拥有许多微调数据导入方式的追加选项。更多详情，请参阅 help(read.table)。



# 用连接来导入数据
# 本章中的许多示例都是从用户计算机上已经存在的文件中导入数据。R 也提供了若干通过连接来访问数据的机制。
# 例如，函数 file()、gzfile()、bzfiel()、xzfile()、unz() 和 url() 可以作为文件名参数使用。
# 函数 file() 允许我们访问文件、剪贴板和C级别的标准输入。函数 gzfile()、bzfiel()、xzfile() 和 unz()允许我们读取压缩文件。
# 函数 url() 能够通过一个含有 http://、ftp:// 或 file://的完整URL访问网络上的文件，还可以为HTTP和FTP连接指定代理。
# 为了方便，（用双引号包围住的）完整的URL也经常直接用来代替文件名使用。更多详情，请参阅help(file)。



# 基础R还提供了函数 read.csssv() 和 read.delim()。这两个函数是用来导入二维文本文件，是对函数 read.table() 的简单封装，提供了一些参数的默认值。比如，read.csv()调用read.table()时，默认header = TRUE、sep = “,”，而read.delim()调用read.table()时，默认header = TRUE、sep = "\t"。更多详情，请参阅 read.table() 帮助文件。
# 相较于上面用来读取二维文本文件的R基础函数，readr包则是一个功能强大的替代方案，其中主要函数为 read_delim()，辅助函数 read_csv() 和 read_tsv() 分别读取逗号分隔文本文件和制表符分隔文件。安装 readr 包后，前面提到的数据可以用如下代码来读取：
library(readr)
grades <- read_csv("studentgrades.csv")
# 这个包还可以导入固定宽度文件（在特定列显示数据）、表格文件（用空格分隔列）和 Web 日志文件。
# 与 R 基础函数相比，readr包中的函数具有很多优点。首先，这些函数的处理速度快得多。这在读取大量数据文件时是一个巨大的优势。其次，这些函数还可以推测每一列的数据类型（数值型、字符型、日期型和时间型）。
# 最后，与 R 4.0.0 以前版本的基础函数不同，readr包的这些函数默认不将字符型数据转化为因子，同时其返回值是tibble数据框（具有一些特殊功能的数据框）。更多详情，请参阅 tidyverse 官网。
