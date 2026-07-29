# 逗号分隔文本文件：.CSV
# 制表符分隔文本文件：.txt / .tsv

# 练习20260729：导入Excel数据
# 读取一个Excel文件的最好办法，就是在Excel中将其导出为一个逗号分隔文本文件（csv），并使用前文描述的方式将其导入R中。
# 此外，我们可以用【readxl包】直接导入Excel工作表。请确保在第一次使用之前下载和安装了readxl包。

# readxl包可以用来读取 .xls 和 .xlsx 版本的Excel文件。
# 函数 read_excel() 可以将工作表一对一地导入到 tibble 数据框中。
# 最简单的形式是 read_excel(file, n)，其中 file 是 Excel 工作簿的所在路径，n 则为要导入的工作表序号，工作表的第一行为变量名。
# 比如在 Windows 上，以下代码：
install.packages("readxl")
library("readxl")
workbook <- "C:\\Users\\peng\\Desktop\\R_work\\R语言实战\\studentgrades.xlsx"
mydataframe <- read_xlsx(workbook, 1)
# 从位于C盘目录的文件中的工资薄studentgrades.xlsx中导入了第一个工作表，并将其保存为一个数据框mydataframe。

# 函数 read_excel() 的选项可以用来指定某个单元区域（例如range = "Mysheet!B2:G14"），或者设置每个列的类（col_types）。更多详情，请参阅help(read_excel)。

# 还有其他包——比如xlsx、XLConnect 和 openxlsx 包——都可以用来处理Excel文件；xlsx 和 XLConnect 这两个包需要依赖 Java，而 openxlsx 则不需要。
# 与readxl不同，所有这些包不仅可以导入 Excel 文件，而且可以创建和操作 Excel 文件。
# 程序员如果需要开放 R 和 Excel的接口程序，那么可以使用这些包中的一个或多个。