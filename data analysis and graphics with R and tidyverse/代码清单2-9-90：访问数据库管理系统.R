# 数据库管理系统：Database management system, DBMS
# 开放数据库互连：Open database connectivity，ODBC【统一的数据库通用接口】
# 数据库接口：Database interface，DBI 

# 代码清单2-9-9：访问数据库管理系统
# R中有多种面向关系型数据库管理系统（DBMS）的接口，包括 Microsoft SQL Server、Microsoft Access、MySQL、Oracle、Post-greSQL、DB2、Teradata 以及 SQLite，其中一些包通过原生的数据库驱动来提供访问功能，另一些则是通过ODBC或JDBC来实现访问。
# 使用R来访问存储在外部数据库中的数据是一种分析大型数据集的有效手段（参阅附录 F），并且能够发挥SQL和R各自的优势。



# 1.ODBC 接口
# 在 R 中通过 RODBC 包访问一个数据库也许是最流行的方式，这种方式允许 R 连接到任意一种拥有 ODBC 驱动的数据库，这包含了前文所讨论的所有数据库
# 第一步是针对自己的系统和数据库类型安装和配置合适的 ODBC 驱动。这些驱动程序并不是 R 的一部分。如果操作系统尚未安装必要的驱动，上网搜索一下就可以找到。
# 针对选择的数据库安装并配置好驱动后，请安装 RODBC 包。我们可以使用命令 install.packages("RODBC")来安装它。

# RODBC 包允许 R 和一个通过 ODBC 连接的 SQL 数据库之间进行双向通信
# 这就意味着我们不仅可以读取数据库中的数据到 R 中，同时也可以使用 R 修改数据库中的内容。
# 假设我们要将某个数据库中的两个表（Crime 和 Punishment）分别导入 R 中的两个名为 crimedat 和 pundat 的数据框，可以通过如下代码完成这个任务：
install.packages("RODBC")
library("RODBC")
myconn <- odbcConnect("mydsn", uid = "Rob", pwd = "aardvark")
crimedat <- sqlFetch(myconn, Crime)
pundat <- sqlQuery(myconn, "select * from Punishment")
close(myconn)
# 这里首先载入了 RODBC 包，并通过一个已注册的数据源名称（mydsn）和用户名（Rob）以及密码（aardvark）打开了一个 ODBC 数据库连接。
# 连接字符串被传递给函数 sqlFetch() ，该函数将 Crime 表复制到 R 数据框 crimedat 中。
# 然后，我们对 Punishment 表执行 SQL 语句 select，并将结果保存到数据框 pundat 中。
# 最后，我们关闭了连接。

# 函数 sqlQuery() 非常强大，因为其中可以插入任意的有效 SQL 语句。
# 这种灵活性让我们可以方便地选择指定变量、对数据集取子集、创建新变量，以及重编码和重命名现有变量。




# 2.DBI 相关包
# DBI（数据库接口）相关包为访问数据库提供了一个通用且一致的客户端接口。
# 构建于这个框架之上的 RJDBC 包提供了通过 JDBC 驱动访问数据库的方案。
# 使用时请确保安装了与操作系统和数据库相匹配的 JDBC 驱动。
# 其他有用的、基于 DBI 的包有RMySQL、ROracle、RPostgreSQL 和 RSQLite。
# 这些包都为对应的数据库提供了原生的数据库驱动，但可能不是在所有系统上都可用。
# 更多详情，请参阅 CRAN 上的相应文档。
