# Tips3：从GitHub下载R包






if(!require(remotes)) install.packages("remotes")
remotes::install_github("rkabacoff/ggpie")







# 逐行拆解代码
```r
if(!require(remotes)) install.packages("remotes")
remotes::install_github("rkabacoff/ggpie")
```

## 第一行：`if(!require(remotes)) install.packages("remotes")`
### `require(remotes)`
- `require(包名)`：尝试**加载包**。
- 如果电脑已经安装`remotes`：加载成功，返回值 `TRUE`
- 如果没安装：加载失败，返回值 `FALSE`，同时在控制台输出警告信息。

### `!require(remotes)`
`!` 是R的**逻辑非（取反）**
  - 已安装remotes：`require(remotes)` → `TRUE`，`!TRUE` → `FALSE` → if条件不成立，不执行安装。
- **未安装remotes**：`require(remotes)` → `FALSE`，`!FALSE` → `TRUE` → if条件成立，运行`install.packages("remotes")`。

> 整句含义：**如果remotes包没有安装，就执行安装；已经装好就跳过安装步骤。**
  
  > 📌小辨析：
> - `library(remotes)`：包不存在直接报错，脚本直接终止。
> - `require(remotes)`：包不存在返回FALSE，不会直接中断代码，适合用在if判断。

---
  
  ## 第二行：`remotes::install_github("rkabacoff/ggpie")`
  1. `remotes::install_github()`
`::` 符号：调用remotes包里面的`install_github()`函数，**不需要写library(remotes)** 提前加载整个包。

2. `"rkabacoff/ggpie"`
GitHub仓库格式：`用户名/仓库名`
- `rkabacoff`：github作者账号
- `ggpie`：仓库名字，就是这个饼图扩展包。

作用：**直接从GitHub源码下载、编译、安装ggpie包**。

> 重点：`install.packages()`只能安装CRAN平台上的包；很多开发版/小众包只放在GitHub，必须用`remotes::install_github()`。

---
  
  # 完整逻辑流程图
  ```
运行第一行
↓
尝试require加载remotes
├─✅加载成功 → 跳过install.packages
└─❌加载失败 → 执行install.packages("remotes")安装
↓
remotes包可用
↓
remotes::install_github("rkabacoff/ggpie")
↓
访问GitHub，下载源码包，本地编译安装ggpie
```

# 常见坑点
1. 国内网络访问GitHub超时 → 安装失败，需要镜像代理。
2. Windows系统：GitHub源码包需要 **Rtools工具链**，没有会直接报错安装失败。
3. Mac系统需要安装xcode命令行工具。
4. 这个代码**只负责安装包**，安装完画图还需要手动写 `library(ggpie)` 加载包。

# 等价的另一种写法（方便理解）
```r
# 判断remotes是否可用
if (!requireNamespace("remotes")) {
  install.packages("remotes")
}
remotes::install_github("rkabacoff/ggpie")
```
> `requireNamespace("remotes")`更推荐用于条件判断，不会输出警告信息。

### 记忆小结
- `!require(pkg)`：没装就装；
- `pkg::fun()`：不用library，直接调用包里函数；
- `install_github()`：安装github上的R包，区别于CRAN的`install.packages()`。