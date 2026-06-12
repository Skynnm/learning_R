# 1.配置环境----
# 清理当前工作环境并重新开始
rm(list = ls(all.names = TRUE))
gc()  # 垃圾回收释放内存
# 关闭所有图形设备以避免图形错误
while (!is.null(dev.list())) dev.off()

options() #显示当前的选项设置情况
options(digits = 3) #格式化数字，显示为具有小数点后3位有效数字的格式

# 合并包列表并一次性检查安装
required_packages <- c(
  "tidyverse",   # 包含dplyr, ggplot2, tidyr, purrr, stringr, lubridate等
  "openxlsx", 
  "readxl", 
  "MatchIt", 
  "viridis", 
  "mgcv", 
  "broom", 
  "tableone", 
  "effsize", 
  "psych", 
  "ggpubr", 
  "rstatix", 
  "gridExtra",
  "caret"
)

# 包安装检查
new_packages <- required_packages[!sapply(required_packages, requireNamespace, quietly = TRUE)]
# 最内层：单个包检查 requireNamespace(pkg, quietly = TRUE) 根据包的安装装填返回一组逻辑值
# requireNamespace()只检查，不安装 / library()、require()既检查，又安装
# 中间层：批量检查所有包：sapply(待循环的对象, 循环执行函数, ...) 返回一个与待循环对象相同长度的逻辑向量
# 外层：筛选未安装的包：!sapply()
# 最外层：提取包名【R中向量的逻辑索引规则：仅保留索引为TRUE的元素】
if(length(new_packages)) install.packages(new_packages)
# length()返回对象长度, 实际用法依据对象/methods不同而不同


# 加载所有包（使用purrr减少重复代码）
purrr::walk(required_packages, library, character.only = TRUE)
getwd() #显示当前工作目录
setwd("C:/Users/peng/Desktop/BC横断面肾功能") #设置当前工作目录
# 2.按格式导入数据----
# 导入乳腺癌人群
Raw_data1 <- "C:\\Users\\peng\\Desktop\\BC横断面肾功能\\data原始数据文件\\1.乳腺癌研究人群.xlsx"
cases <- read_xlsx(Raw_data1, 1)
# cases是7052例乳腺癌患者

# 导入女性体检人群
Raw_data2 <- "C:\\Users\\peng\\Desktop\\BC横断面肾功能\\data原始数据文件\\2.体检女性研究人群.xlsx"
controls <- read_xlsx(Raw_data2, 1)
#summary(controls$肌酐1)
#> summary(controls$肌酐1)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 12      51      56      64      62   30455 
# controls是女性体检人群
# 极端情况：血肌酐＞2000 μmol/L（罕见，但危及生命）
# 少数情况下（如急性肾损伤未及时救治，或慢性肾衰竭患者完全停止透析且未治疗），
# 血肌酐可能突破 2000 μmol/L，甚至达到 3000~4000 μmol/L（约 34~45 mg/dL）；

# 3.按年龄匹配----
# 设置随机种子保证可重复性
set.seed(123)

# 在抽样前随机化数据顺序，以避免顺序偏差
controls <- controls[sample(nrow(controls)),]

# 标准化数据格式
class(cases$首确诊)
class(controls$首确诊)
cases$首确诊 <- as.numeric(cases$首确诊)
class(controls$首确诊)

class(cases$血小板)
class(controls$血小板)
controls$血小板 <- as.numeric(controls$首确诊)
class(controls$血小板)

class(cases$肾脏疾病)
class(controls$肾脏疾病)
cases$肾脏疾病 <- as.numeric(cases$肾脏疾病)
# 合并病例组和对照组（标记病例组为1，对照组为0）
cases$group <- 1
controls$group <- 0
combined_data <- bind_rows(cases, controls) %>%
  mutate(group = as.factor(group))  # 必须转换为因子

# 重要设置：解除匹配大小限制
options("optmatch_max_problem_size" = Inf)

# 执行1:10年龄匹配（修复版）
match_result <- matchit(
  group ~ 年龄,            # 按年龄匹配
  data = combined_data,        # 使用清洗后的数据
  method = "nearest",       # 最近邻匹配
  distance = "euclidean",   # 使用欧氏距离
  ratio = 10,               # 1:10匹配
  replace = FALSE,          # 无放回抽样
  caliper = c(年龄 = 0.2),   # 关键修正：命名卡钳变量
  std.caliper = TRUE        # 卡钳值以标准差为单位
)

# 提取匹配结果
matched_data <- match.data(match_result)

# 检查匹配质量
summary(match_result)

# 查看匹配分布
table(matched_data$group)

# 定义适用于偏态分布的标准化差异函数（基于中位数和IQR）
median_smd <- function(x, y) {
  # 计算中位数（替代均数）
  med_x <- median(x, na.rm = TRUE)
  med_y <- median(y, na.rm = TRUE)
  
  # 计算四分位距IQR（替代标准差）
  iqr_x <- IQR(x, na.rm = TRUE)
  iqr_y <- IQR(y, na.rm = TRUE)
  
  # 用IQR/1.35近似标准差（基于正态分布特性的稳健估计）
  sd_approx_x <- iqr_x / 1.35
  sd_approx_y <- iqr_y / 1.35
  
  # 计算合并近似标准差（参考传统SMD的合并逻辑）
  sd_combined <- sqrt((sd_approx_x^2 + sd_approx_y^2) / 2)
  
  # 计算基于中位数的标准化差异
  abs(med_x - med_y) / sd_combined
}

# 计算匹配后年龄的标准化差异（适用于偏态分布）
age_median_smd <- median_smd(
  matched_data$年龄[matched_data$group == 1],
  matched_data$年龄[matched_data$group == 0]
)

# 输出结果
cat("匹配后年龄（偏态适应）标准化差异:", round(age_median_smd, 4))


# 保存结果
write.xlsx(matched_data, "3.匹配后总表（原始文件）.xlsx", rowNames = FALSE)

new_matched_data <- matched_data[-c(2:7053), ]
write.xlsx(new_matched_data, "6.匹配后体检人群.xlsx", rowNames = FALSE)

Raw_data3 <- "C:\\Users\\peng\\Desktop\\BC横断面肾功能\\data原始数据文件\\6.匹配后体检人群.xlsx"
controls1 <- read_xlsx(Raw_data3, 1)

# 提取病例组和对照组的年龄数据
mydataframe <- matched_data
age_case <- mydataframe %>% filter(group == 1) %>% pull(年龄)
age_control <- mydataframe %>% filter(group == 0) %>% pull(年龄)
mean(age_case)
sd(age_case)
mean(age_control)
sd(age_control)

# 正态性检验（使用Kolmogorov-Smirnov检验，适合大样本）
ks_case <- ks.test(age_case, "pnorm", mean = mean(age_case), sd = sd(age_case))
ks_control <- ks.test(age_control, "pnorm", mean = mean(age_control), sd = sd(age_control))

cat("病例组年龄正态性检验 p值:", ks_case$p.value, "\n")
cat("对照组年龄正态性检验 p值:", ks_control$p.value, "\n")

# 根据正态性结果选择检验方法
if(ks_case$p.value > 0.05 & ks_control$p.value > 0.05) {
  # 方差齐性检验
  var_test <- var.test(age_case, age_control)
  
  # 独立样本t检验
  if(var_test$p.value > 0.05) {
    t_test <- t.test(age_case, age_control, var.equal = TRUE)
    cat("\n年龄组间比较(t检验) p值:", t_test$p.value, "\n")
  } else {
    t_test <- t.test(age_case, age_control, var.equal = FALSE)
    cat("\n年龄组间比较(Welch t检验) p值:", t_test$p.value, "\n")
  }
} else {
  # Mann-Whitney U检验
  mw_test <- wilcox.test(age_case, age_control, exact = FALSE)
  cat("\n年龄组间比较(Mann-Whitney U检验) p值:", mw_test$p.value, "\n")
}

# 可视化年龄分布
ggplot(mydataframe, aes(x = 年龄, fill = factor(group))) +
  geom_density(alpha = 0.5) +
  scale_fill_manual(values = c("blue", "red"), 
                    labels = c("体检人群", "乳癌人群"),
                    name = "分组") +
  labs(title = "图片3.女性乳腺癌人群和按年龄1：10匹配女性体检人群年龄分布核密度图", x = "年龄", y = "核密度值") +
  theme_minimal()

