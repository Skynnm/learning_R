# 不妨进入 print 函数的源代码看看它是如何做到这一点的。你也许认为 print 会查找某个对象的类属性，
# 再根据类属性的不同，使用一个 if 树分配合理的输出显示方式。如果你真是这么想的，很好！print 的
# 工作方式其实与你想象的十分类似，但是实现机制更加简单。

# 练习20260715：方法（UseMethod）
# 当你调用 print 函数时，它其实调用了一个特别的函数，叫作 UseMethod（意即“使用方法”）
print
#function (x, ...) 
#  UseMethod("print")
#<bytecode: 0x000002a51df628b0>
#  <environment: namespace:base>

# UseMethod 检查你提供给 print 函数的第一个参数的类属性，然后再将你所提供的待输出对象交给一个新函数来处理，
# 这个新函数专门用于处理具有某种类属性的输入对象。比如说，当你向 print 提供一个类属性为 POSIXct 的对象时，
# UseMethod 会将 print 函数的所有参数交给 print.POSIXct 函数处理。R 随后会运行 print.POSIXct 函数并返回针对
# POSIXct 类属性的输出结果。

print.POSIXct
#function (x, tz = "", usetz = TRUE, max = NULL, ...) 
#{
#  if (is.null(max)) 
#    max <- getOption("max.print", 9999L)
#  FORM <- if (missing(tz)) 
#    function(z) format(z, usetz = usetz)
#  else function(z) format(z, tz = tz, usetz = usetz)
#  if (max < length(x)) {
#    print(FORM(x[seq_len(max)]), max = max + 1, ...)
#    cat(" [ reached 'max' / getOption(\"max.print\") -- omitted", 
#        length(x) - max, "entries ]\n")
#  }
#  else if (length(x)) 
#    print(FORM(x), max = max, ...)
#  else cat(class(x)[1L], "of length 0\n")
#  invisible(x)
#}
#<bytecode: 0x000002a5230f43d0>
#  <environment: namespace:base>

# 如果对一个类属性为因子（factor）的对象调用 print 函数，UseMethod 会将 print 的所有参数交给 print.factor 函数
# 来进行处理。R 随后会运行 print.factor 函数并返回结果。
print.factor
#function (x, quote = FALSE, max.levels = NULL, width = getOption("width"), 
#          ...) 
#{
#  ord <- is.ordered(x)
#  if (length(x) == 0L) 
#    cat(if (ord) 
#      "ordered"
#      else "factor", "()\n", sep = "")
#  else {
#    xx <- character(length(x))
#    xx[] <- as.character(x)
#    keepAttrs <- setdiff(names(attributes(x)), c("levels", 
#                                                 "class"))
#    attributes(xx)[keepAttrs] <- attributes(x)[keepAttrs]
#    print(xx, quote = quote, ...)
#  }
#  maxl <- max.levels %||% TRUE
#  if (maxl) {
#    n <- length(lev <- encodeString(levels(x), quote = ifelse(quote, 
#                                                              "\"", "")))
#    colsep <- if (ord) 
#      " < "
#    else " "
#    T0 <- "Levels: "
#    if (is.logical(maxl)) 
#      maxl <- {
#        width <- width - (nchar(T0, "w") + 3L + 1L + 
#                            3L)
#        lenl <- cumsum(nchar(lev, "w") + nchar(colsep, 
#                                               "w"))
#        if (n <= 1L || lenl[n] <= width) 
#          n
#        else max(1L, which.max(lenl > width) - 1L)
#      }
#    drop <- n > maxl
#    cat(if (drop) 
#      paste(format(n), ""), T0, paste(if (drop) 
#        c(lev[1L:max(1, maxl - 1)], "...", if (maxl > 1) lev[n])
#        else lev, collapse = colsep), "\n", sep = "")
#  }
#  if (!isTRUE(val <- .valid.factor(x))) 
#    warning(val)
#  invisible(x)
#}
#<bytecode: 0x000002a5230dcf50>
#  <environment: namespace:base>


# print.POSIXct 和 print.factor 被称为 print 函数的方法（method）。这两个函数本身是普通的 R 函数。
# 然而，它们的特别之处在于，UseMethod 会调用它们去处理具有对应类属性的对象。
# 请注意，print.POSIXct 和 print.factor 做了两件不同的事情。
# 正因如此，print 函数能够针对不同类属性的对象进行不同的操作。
# print 会调用 UseMethod 函数，该函数会检查 print 的第一个参数的类属性，并根据该类属性调用特定的方法进行处理。


# 将某个泛型函数作为输入对象运行 methods 函数，可以看到该泛型函数所支持的方法。
# 比如说，print 函数就支持将近200种方法（你可以据此想象一下 R 中有多少种不同的类属性）
methods(print)
#  [1] print.acf*                                          
#  [2] print.activeConcordance*                            
#  [3] print.anova*
#  ...
#  [243] print.xgettext*                                     
#  [244] print.xngettext*                                    
#  [245] print.xtabs*                                        
#  see '?methods' for accessing help and source code




# 【这样一个由泛型函数、方法和基于类的分派方式所构成的系统就是 R 的 S3 系统】。
# 之所以叫作 S3 是由于它起源于S语言的第三个版本，S语言是 S-PLUS 和 R 语言的前身。
# 许多常见的 R 函数都是 S3 泛型函数，它们可以支持多种不同的类方法函数。
# 比如说，summary 和 head 就会调用 UseMethod 函数以识别对象的类属性。
# 许多非常基本的R函数，像c、+、- 和 < 等，其工作方式也类似于泛型函数，只是它们不会调用UseMethod函数，而会调用.primitive函数

# 【S3系统使得R函数能够再不同的场合有不同的表现】
# 可以利用 S3 系统进一步美化老虎机程序的输出格式。
# 要实现这一点，首先将类属性赋给输出结果；然后针对该类属性编写一个 print 类方法。
# 要想就此写出高效的代码，你需要大致了解 UseMethod 选择类方法函数的方式。