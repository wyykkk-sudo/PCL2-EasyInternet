# 修改与来源

## 上游来源

- PCL：<https://github.com/Meloong-Git/PCL>
- 主仓库提交：`6b9a50df911c9d68b69b24c979efba477fb14b67`，2.99.0.0。
- MeloongCore：`98157d65c7627721c816c02e8be96ac4fe61d615`，保留源码及其 Apache 2.0 许可。
- Logo：维护者提供的 <https://easyinternet.cn/assets/easyinternet-logo.png>，作为原始 PNG 嵌入。ICO 转换保留图像比例。

本仓库为当前修改后的独立源码快照，不包含上游完整 Git 历史；历史调查可通过下面的原提交链接核查。保留上游历史 `patches/`，不复制上游正式版 EXE 压缩包，以免与本测试构建混淆。

## 下载关闭原因

[上游提交 e4b0489a](https://github.com/Meloong-Git/PCL/commit/e4b0489a22cfd4bc57a18fc1e2ac66d5c18e7fc1) 于 2026-10-20 引入 `RestrictMcDownload = True`。安装页面在本地检查该常量并抛出含合规原因的提示，原有下载与安装模块仍保留。因此源码证据表明它是本地安装限制，不能解释为仅隐藏入口，也没有证据将其归因于远程开关。

维护版将该常量设为 False，复用现有安装逻辑，默认优先 Mojang 官方资源。上游提示的合规原因仍须尊重；本仓库不声称获得 Minecraft、Microsoft 或镜像服务的额外授权，也不通过绕过认证或第三方访问控制取得资源。

## 具体文件

| 范围 | 修改 |
| --- | --- |
| `FormMain.xaml` / `.vb`、首页、关于页、AssemblyInfo | 维护版标题、品牌标识、第三方说明；保留原作者优先署名及赞助链接 |
| `Images/BrandLogo.png`、`Images/icon.ico`、主项目文件 | 用户原图嵌入、等比例多尺寸 ICO、资源登记 |
| `ModDownload.vb`、`ModDownloadLib.vb` | 官方 v2 清单；下载原版 JSON 和资源索引时使用元数据校验 |
| `Settings.vb` | 默认官方源；原 Registry 来源的设置改存 Portable.ini；强制蓝色主题 |
| `Application.xaml.vb`、`ModBase.vb` | 本地缓存、Unicode 原生 DLL 搜索路径、维护版窗口识别；权限错误提示保留用户数据 |
| `ModSecret.vb`、`ModLaunch.vb` | 公共 Client ID 与环境覆盖；缺失配置提示；保留 Microsoft/Xbox/Minecraft 登录链 |
| 个性化设置、关于页代码 | 隐藏主题选择及未启用的赞助识别/解锁界面 |
| `App.config`、`Directory.Build.targets` | .NET Framework 4.8 运行时声明、netstandard facade 引用 |

配置迁移没有自动导入原注册表数据；搬移配置及游戏目录的行为仍待完整测试。CurseForge API Key 继续由环境变量提供，默认空；匿名遥测上报地址为空，相关依赖功能不作可用性承诺。

发布前修正设置集合初始化中的 VB 注释位置，并重新编译源码快照。仓库里的 Ookii DLL 与上游所跟踪的文件相同，未作为新增依赖升级列入修改。

用户登录测试发现 AADSTS700002 后，在设备代码请求处添加特定配置错误提示，并补充 Entra 公共客户端流设置说明。认证请求和后续正版认证链保持原流程；服务器端配置仍须维护者操作。
