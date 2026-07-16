# 一个由泛型函数、方法和基于类的分派方式所构成的系统就是R的S3系统，S3系统使得R函数能够在不同的场合有不同的表现

# 练习20260716：方法分派
# UseMethod 在匹配方法与函数时都使用了一个非常简单的系统
# 每一个S3方法的名称都包含两个部分。前一部分指明该方法对应的函数，后一部分则指明类属性。
# 这两个部分的名称用英文句点.分隔。比如说，处理类属性为函数（function）的print方法为print.function，处理类属性为矩阵（matrix）的summary方法名为summary.matrix，以此类推。

# 当UseMethod需要调用某个方法时，它会搜索是否存在一个R函数的名称符合以上所描述的S3风格。这个函数不需要有什么特别之处，它只需要一个正确的名称。

# 不妨着手写一个你自己的函数，并为其取一个S3风格的名称。比如说，让我们赋给one_play一个新的类属性。这个类属性的名称并不重要，只要是一个字符串即可。这里我们假设类属性的名称是slots。
class(one_play) <- "slots"

# 现在让我们为slots类属性写一个S3型的print类方法函数。这个函数不需要有什么特别之处，它甚至都不需要真正显示one_play的内容。但是必须将它命名为print.slots，否则UseMethod就不知道如何找到它。并且，这个类方法函数所接受的输入参数与print函数一致，否则在传递参数时R会报错。
args(print)
#function (x, ...) 
#NULL

print.slots <- function(x, ...){
  cat("I'm using the print.slots method")
}
# 这个类方法函数可以工作吗？当然，R就是使用它来显示one_play中的内容的。然而，这个函数不是十分有用，我暂时将其删除。稍后会有机会写一个更好的版本。
print(one_play)
# I'm using the print.slots method
one_play
# I'm using the print.slots method
rm(one_play)


# 有些R对象具有多个类属性。比如说，Sys.time的输出结果就具有两个类属性。那么对于这种情况，UseMethod该如何找到对应的类方法呢》
now <- Sys.time()
attributes(now)
# $class
# [1] "POSIXct" "POSIXt" 

# UseMethod会首先寻找并匹配该对象类属性向量中的第一个属性。如果找不到一个对应的类方法，UseMethod就会尝试匹配第二个类属性（如果该对象的类属性向量中有很多类属性，那么以此规则往后寻找并匹配）

# 在print函数运行时，如果对象的类没有匹配的print方法，那么UseMethod将调用一个名为print.default的特殊方法，该方法专门用于处理一般情况。

# 就让我们使用这样一套系统来为老虎机程序的输出结果编写一个更好的print方法吧
# 因为我们以及花费大力气写出了 slot_display 函数，再编写一个合理的 print.slots 类方法函数其实就比较轻松了。
# 说轻松，你可能会觉得很意外。不妨看看下面的例子，如此简单的一个类方法函数就可以满足我们的需求。
# 只需要保证它的名称为 print.slots，以便 UseMethod 可以顺利找到它。确保它所接受的参数与 print 所接受的参数相同，从而使 UseMethod 可以顺利地将参数传递给 print.slots 函数。
print.slots <- function(x, ...){
  slot_display(x)
}
# 现在 R 在显示类属性为 slots 的对象时，会自动找到并使用 slot_display 函数（并且只显示类属性为 slots 的对象）
class(one_play) <- "slots"

# 让我们确保老虎机程序的输出中，所有的对象都具有 slots 类属性
# 修改 play 函数，使其输出结果具有名为 slots 的类属性。
play <- function(){
  symbols <- get_symbols()
  structure(score(symbols), symbols = symbols)
}
# 你可以在设置输出结果的symbols属性时，同时设置它的类属性。只需要在structure函数中添加 class = "slots"参数语句即可。
play <- function(){
  symbols <- get_symbols()
  structure(score(symbols), symbols = symbols, class = "slots")
}
# 现在我们每次运行 play 函数，其输出结果都将具有 slots 类属性
class(play())

# 因此，R 会选用与其匹配的显示方式
play()
play()