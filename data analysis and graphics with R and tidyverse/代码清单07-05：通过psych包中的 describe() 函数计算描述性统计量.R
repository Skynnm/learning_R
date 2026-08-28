# 统计学的核心是——见微知著（部分推断总体）：
# 你不知道一个对象，只知道它的一部分信息，却要研究这个对象必然具有什么结构

# 代码清单7-5：通过psych包中的 describe() 函数计算描述性统计量
install.packages("psych")
library(psych)
#载入程序包：‘psych’

#The following object is masked from ‘package:Hmisc’:
  
#  describe
myvars <- c("mpg", "hp", "wt")
describe(mtcars[myvars])
#vars  n   mean    sd median trimmed   mad   min    max  range skew kurtosis    se
#mpg    1 32  20.09  6.03  19.20   19.70  5.41 10.40  33.90  23.50 0.61    -0.37  1.07
#hp     2 32 146.69 68.56 123.00  141.19 77.10 52.00 335.00 283.00 0.73    -0.14 12.12
#wt     3 32   3.22  0.98   3.33    3.15  0.77  1.51   5.42   3.91 0.42    -0.02  0.17
Hmisc::describe(mtcars[myvars])
psych::describe(mtcars[myvars])


# 在前面的示例中，psych包和hmisc包均提供了名为describe()的函数
# R如何直到使用哪一个呢？简言之，如代码清单7-5所示，【最后载入的包优先】。【R的环境树】
# 在这里，psych包在Hmisc包之后被载入，然后显示了一条信息，提示Hmisc包中的describe()函数被psych包中的同名函数所屏蔽（masked）
# 输入 describe() 后，R 在搜索这个函数时将首先找到 psych 包中的函数并执行它。
# 如果我们还是想使用 Hmisc 包中的版本，可以输入 Hmisc::describe(mt)
# 这个函数仍然在那里，我们只是需要给予R更多信息来找到它
