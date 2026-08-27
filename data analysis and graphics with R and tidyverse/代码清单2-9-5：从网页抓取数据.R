# Web数据抓取：web scraping
# 应用程序接口：application programming Interface, API
# API制定了软件组件间如何互相进行交互

# 代码清单2-9-5：从网页抓取数据
# 我们可以通过 Web数据抓取（web scraping）的过程，或者使用 应用程序接口（application programming Interface, API）来获取网络上的数据。
# Web数据抓取过程中，用户从互联网上提取嵌入在网页中的信息，而 API 则让我们的程序和 Web 服务或在线数据存储进行交互。


# 一般地说，在 Web 数据抓取过程中，用户从互联网上提取嵌入在网页中的信息，并将其保存为R中的数据结构以做进一步的分析。

# 比如，一个网页上的文字可以使用函数 readLines() 来下载到一个R的字符向量中
# 然后使用如 grep() 和 gsub() 一类的函数处理它。
## readLines(url) 仅极少数 http 站点勉强能用，全部 https 站点基本都会失败；爬网页永远不要直接用 readLines (网址)



# rvest包提供的函数可以简化从网页提取数据的过程，这个包参考了Python的Beatiful Soup库。
# 我们还可以使用RCurl包和XML包来提取其中想要的信息。更多信息示例，请参阅“Examples of Web Scraping with R”一文
install.packages("httr")
install.packages("rvest")
library(httr)
library(rvest)

url <- "https://r-project.org"
ua <- "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/120.0.0.0 Safari/537.36"

res <- GET(url, add_headers(`User-Agent` = ua))
html <- read_html(content(res, as="text", encoding="UTF-8"))

# 提取内容
html |> html_elements("p") |> html_text(trim=TRUE) |> head()



#  API指定了软件组件间如何互相进行交互。
# 有很多R包使用这个方法来从网上资源中获取数据。这些资源包括生物、医药、地球科学、物理科学、经济学，以及商业、金融、文学、销售、新闻和运动等的数据源。


# 比如说，如果对社交媒体感兴趣，我们可以用twitterR包来获取Twitter数据，
# 用Rfacebook包来获取Facebook数据
# 用Rflicker包来获取Flicker数据
# 其他包可以用来访问如 Google、Amazon、Dropbox、Salesforce等所提供的广受欢迎的网络服务。
# 可以查看CRAN Task View中子板块 Web Tecknologies and Services（Web 技术与服务）来获得一个全面的列表，此列表列出能帮助我们获取网上资源的各种R包。