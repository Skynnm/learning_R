# 无视中断

# 代码清单10-0-7：用pwr包做功效分析-比例检验
# 当比较两个比例时，我们可使用 pwr.2p.test() 函数进行功效分析。格式为：
pwr.2p.test(h =, n =, sig.level =, power =)
# 其中，h是效应值，n是各组相同的样本量。效应值h定义如下
# h=2arcsin(\textit{\sqrt{\textit{p_1}}})−2arcsin(\textit{\sqrt{\textit{p_2}}})
# 我们可用ES.h(p1, p2)函数进行计算
# 当各组中n不相同时，则使用函数：
pwr.2p2n.test(h =, n1 =, n2 =, sig.level =, power =)
# alternative = 选项可以设定检验是双侧检验（“two.sided”）还是单侧检验（“less”或“greater”）。默认是双侧检验

# 假定我们对某流行药物能缓解60%的使用者的症状感到怀疑。
# 而一种更贵的新药如果能缓解65%的使用者的症状，就会被投放到市场中，
# 此时，在研究中我们需要多少受试者才能够检测到两种药物存在这一特定的差异？

# 假设我们想有90%的把握得出新药更有效的结论，并且希望有 95%的把握不会误得结论
# 我们只对评价新药是否比标准药物更好感兴趣，因此只需用单侧检验，代码如下：
pwr.2p.test(h = ES.h(.65, .6), sig.level = .05, power = .9,
            alternative = "greater")
#Difference of proportion power calculation for binomial distribution (arcsine transformation) 
#
#h = 0.1033347
#n = 1604.007
#sig.level = 0.05
#power = 0.9
#alternative = greater
#
#NOTE: same sample sizes

# 根据结果可知，为满足以上要求，在本研究中需要1605个人试用新药，1605个人试用已有药物