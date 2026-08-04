# 网页三大基础：HTML、CSS、JavaScript

# 代码清单3-5-0：日期值
# 日期值通常以字符串的形式输入到R中，然后转换为以数值形式存储的日期变量。
# 函数 as.Date() 用于执行这种转换。其语法为 as.Date(x, "input_format")，其中 x 是字符型数据
# input_format 则给出了用于读入日期的适当格式：
# 符号              含义                    示例
# %d          数字表示的日期（0-31）        01-31
# %a          缩写的星期名                  Mon
# %A          非缩写星期名                  Monday
# %m          月份（01-12）                 00-12
# %b          缩写的月份                    Jan
# %B          非缩写的月份                  January
# %y          两位数的年份                  07
# %Y          四位数的年份                  2007

# 日期值的默认输入格式为 yyyy-mm-dd，语句为：
mydates <- as.Date(c("2007-06-22", "2004-02-13")) # 将字符型数据转换为了默认格式的对应日期
mydates                                           # 将字符型数据转换为了默认格式的对应日期

# 相反
strDates <- c("01/05/1965", "08/16/1975")         # 使用mm/dd/yyyy的格式读取数据
dates <- as.Date(strDates, "%m /%d /%Y")          # 使用mm/dd/yyyy的格式读取数据
dates                                             # 使用mm/dd/yyyy的格式读取数据

# 在leadership数据框中，日期是以 mm/dd/yy 的格式编码为字符型变量的。因此：
leadership <- data.frame(
  manager = c(1, 2, 3, 4, 5),
  date    = c("10/24/08", "10/28/08", "10/1/08", "10/12/08", "5/1/09"),
  country = c("US", "US", "UK", "UK", "UK"),
  gender  = c("M", "F", "F", "M", "F"),
  age     = c(32, 45, 25, 39, 99),
  q1      = c(5, 3, 3, 3, 2),
  q2      = c(4, 5, 5, 3, 2),
  q3      = c(5, 2, 5, 4, 1),
  q4      = c(5, 5, 5, NA, 2),
  q5      = c(5, 5, 2, NA, 1)
)

myformat <- "%m / %d / %y"

leadership$date <- as.Date(leadership$date, myformat)
# 使用指定格式读取字符型变量，并将其作为一个日期变量替换到数据框中。
# 这种转换一旦完成，我们就可以使用后续各章中讲到的诸多分析方法对这些日期进行分析和绘图。


# 有两个函数对于处理时间戳数据特别实用。
# Sys.Date() 可以返回当天的日期，而 date() 则返回当前的日期和实践
Sys.Date()                       # 返回当天的日期
#[1] "2026-08-04"
date()                           # 放回当前的日期和时间
#[1] "Tue Aug  4 20:24:33 2026"

# 我们可以使用函数 format(x, format = "output_format")来输出指定格式的日期值，并且可以提取日期值中的某些部分：
today <- Sys.Date()
format(today, format = "%B %d %Y")
# [1] "八月 04 2026"
format(today, format = "%A")
# [1] "星期二"
# format() 函数可以接受一个参数（本例中是一个日期）并按某种格式输出结果


# R 的内部在存储日期时，是使用自 1070年1月1日以来的天数表示的，更早的日期则表示为负数。
# 这意味着可以在日期值上执行算术运算：
startdate <- as.Date("2020-02-13")
enddate <- as.Date("2021-01-22")
days <- enddate - startdate
days
# Time difference of 344 days # 显示了从2020月2月13日到2021年1月22日之间的天数


# 最后，也可以使用函数 difftime() 来计算时间间隔，并以星期、天、时、分、秒来表示。
# 假设我出生于1956年10月12日，我现在有多大呢？
today <- Sys.Date()
dob <- as.Date("1956-10-12")
difftime(today, dob, units = "weeks")
# Time difference of 3642.571 weeks

#### 将日期变量转换为字符型变量
# 我们同样可以将日期变量转换为字符型变量。函数 as.character() 可将日期值转换为字符型：
strDates <- as.character(dates)
# 进行转换后，即可使用一系列字符处理函数处理数据（比如取子集、替换、连接等）

#### 更进一步
# 要了解字符型数据转换为日期值的更多细节，请查看 help(as.Date) 和 help(strftime)。
# 要了解更多关于日期和时间格式的知识，请参阅 help(ISOdatetime) 。
# lubridate 包中包含了许多简化日期处理的函数，可以用于识别和解析日期-时间数据，抽取日期-时间成分（例如年份、月份、日期、小时 和分钟等），以及对日期-时间值进行算术运算。
# 如果我们需要对日期进行复杂的计算，那么 timeDate 包可能会有帮助。它提供了大量的日期处理函数，可以同时处理多个时区，并且提供了丰富的功能。