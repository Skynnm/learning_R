# 看代码、理解代码的时间，远多于写代码的时间

# 代码清单6-4-0：带误差线的均值条形图
# 在绘制如均值等描述性统计量时，提供这些统计量的离散程度是一个很好的做法。
# 衡量离散程度的一个指标是统计量的标准差——在假设重复样本中对统计量离散程度的数学期望的估计。
# 下列代码添加了表示均值标准差的误差线。
plotdata <- states %>%                                                  # ①分地区计算均值与标准差
  group_by(state.region) %>%                                            # ①分地区计算均值与标准差
  summarise(n = n(),                                                    # ①分地区计算均值与标准差
            mean = mean(Illiteracy),                                    # ①分地区计算均值与标准差
            se = sd(Illiteracy) / sqrt(n))                              # ①分地区计算均值与标准差
plotdata
#  A tibble: 4 × 4
#state.region      n  mean     se
#<fct>         <int> <dbl>  <dbl>
#  1 Northeast         9  1    0.0928
#2 South            16  1.74 0.138 
#3 North Central    12  0.7  0.0408
#4 West             13  1.02 0.169 

ggplot(plotdata, aes(x = reorder(state.region, mean), y = mean)) +      # ②绘制均值的排序条形图
  geom_bar(stat = "identity", fill = "skyblue") +
  geom_errorbar(aes(ymin = mean - se, ymax = mean + se), width = 0.2) + # ③添加误差线
  labs(x = "Region",
       y = "",
       title = "Mean Illiteracy Rate",
       subtitle = "with standard error bars")

# 代码清单6-4首先计算了每个地区的均值和标准差①。
# 然后按文盲率的升序绘制条形图。条形的颜色从默认的深灰色逐渐变浅（天蓝色），以便突出显示在下一步中添加的误差线②。
# 最后绘制了误差线③。
# 函数 geom_errorbar()中的选项width控制误差线的水平宽度，这只是为了在视觉上更好看，并没有任何统计学上的意义。
# 除了显示平均文盲率，我们还可以看到中北部地区的均值是最可靠的（离散程度最小），西部地区的均值最不可靠（离散程度最大）

# 图片生成了：美国各地区平均文盲率排序条形图。每个条形添加了均值的标准差。
