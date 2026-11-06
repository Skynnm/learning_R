# 自律带来自由

# 代码清单13-01-02：评价自变量对结果概率的影响
# 对于我们大多数人来说，以概率的方式思考比使用优势比更直观。
# 使用predict()函数可以让我们观测某个自变量在各个水平时对结果概率的影响。
# 首先，创建一个包含我们感兴趣的自变量值的虚拟数据集，然后对该数据集使用 predict() 函数，以预测这些值的结果概率

# 现在，我们使用该方法评价对婚姻的自我评分对感情危机概率的影响。
# 首先，创建一个虚拟数据集，设定年龄、婚龄 和 宗教信仰为它们的均值，对婚姻的自我评分范围为1 ~ 5
testdata <- data.frame(rating = c(1, 2, 3, 4, 5), age = mean(Affairs$age),
                       yearsmarried = mean(Affairs$yearsmarried),
                       religiousness = mean(Affairs$religiousness))
testdata
#  rating      age yearsmarried religiousness
#1      1 32.48752     8.177696      3.116473
#2      2 32.48752     8.177696      3.116473
#3      3 32.48752     8.177696      3.116473
#4      4 32.48752     8.177696      3.116473
#5      5 32.48752     8.177696      3.116473


# 接下来，使用虚拟数据集预测相应的概率
testdata$prob <- predict(fit.reduced, newdata = testdata, type = "response")
testdata
#  rating      age yearsmarried religiousness      prob
#1      1 32.48752     8.177696      3.116473 0.5302296
#2      2 32.48752     8.177696      3.116473 0.4157377
#3      3 32.48752     8.177696      3.116473 0.3096712
#4      4 32.48752     8.177696      3.116473 0.2204547
#5      5 32.48752     8.177696      3.116473 0.1513079

# 从这些结果我们可以看到，当对婚姻的自我评分从1（很不幸福）变为5（非常幸福）时，感情危机概率从0.53降低到了0.151（假定年龄、婚龄 和 宗教信仰程度不变）
# 下面我们再看看年龄的影响：
testdata <- data.frame(rating = mean(Affairs$rating),
                       age = seq(17, 57, 10),
                       yearsmarried = mean(Affairs$yearsmarried),
                       religiousness = mean(Affairs$religiousness))
testdata
#   rating age yearsmarried religiousness
#1 3.93178  17     8.177696      3.116473
#2 3.93178  27     8.177696      3.116473
#3 3.93178  37     8.177696      3.116473
#4 3.93178  47     8.177696      3.116473
#5 3.93178  57     8.177696      3.116473


testdata$prob <- predict(fit.reduced, newdata = testdata, type = "response")
testdata
#   rating age yearsmarried religiousness      prob
#1 3.93178  17     8.177696      3.116473 0.3350834
#2 3.93178  27     8.177696      3.116473 0.2615373
#3 3.93178  37     8.177696      3.116473 0.1992953
#4 3.93178  47     8.177696      3.116473 0.1488796
#5 3.93178  57     8.177696      3.116473 0.1094738

# 此处我们可以看到，当其他变量不变时，年龄从17岁增加到57岁时，感情危机的概率将从0.35降低到0.109.
# 利用该方法，我们可探究每一个自变量对结果概率的影响。