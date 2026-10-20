# PCL2 - 易联厅长维护版

原作者：**龙腾猫跃** · [支持原作者](https://meloong.com/afd/a/LTCat) · [PCL 官方源码](https://github.com/Meloong-Git/PCL)

这是易联厅长基于 PCL 公开源码独立修改的第三方维护版本，非 PCL 官方发行版本。当前仓库发布源码和 Windows x64 测试构建；**完整安装、Microsoft 登录和游戏启动尚未完成验收**。

![易联厅长 Logo](Plain%20Craft%20Launcher%202/Images/BrandLogo.png)

## 获取与运行

- 测试版：[dist/PCL2-易联厅长维护版.exe](dist/PCL2-%E6%98%93%E8%81%94%E5%8E%85%E9%95%BF%E7%BB%B4%E6%8A%A4%E7%89%88.exe)
- 需要 64 位 Windows 和 .NET Framework 4.8；运行目录应可写。
- 将单个 EXE 放入空目录运行。配置、缓存和 Minecraft 文件会在运行时生成，搬移时应连同生成的数据目录一起搬移。
- 构建文件未进行代码签名。该测试版不代表所有功能已经可用。

## 当前修改

- 保留原版 WPF 页面、动画、版本管理及登录/启动架构，加入维护版名称、原始 PNG Logo 和 EXE 图标。
- 接入 Mojang 官方 v2 版本清单，版本 JSON 和资源索引加入元数据 SHA-1 校验，默认优先官方源，沿用原有下载调度与镜像回退。
- 调整公开源码中的本地安装开关。上游关闭下载的提交明确提到合规原因；该修改不构成接口授权或法律许可，使用者仍须遵守资源提供方条款。
- 将原注册表来源的启动器设置保存到运行目录的 `PCL/Portable.ini`；缓存和 WebP 原生依赖改为运行目录内存储。
- 保留原作者署名、赞助链接和正版购买劝导，固定蓝色主题并隐藏赞助解锁相关入口。
- 配置维护者提供的 Microsoft 公共客户端 ID，可由 `PCL_MS_CLIENT_ID` 环境变量覆盖。Client ID 不属于密码或客户端密钥；其应用配置及 Minecraft 服务访问资格仍待验证。

## 文档

- [构建说明](docs/BUILD.md)与 [构建脚本](scripts/Build.ps1)
- [测试记录与待验证项](docs/TEST_REPORT.md)
- [修改说明及上游下载限制调查](docs/CHANGES.md)
- [Microsoft 登录配置](docs/MICROSOFT_AUTH.md)
- [许可与署名说明](docs/LICENSE_NOTES.md)、[原许可/合理使用指南](LICENCE)
- [原项目 README](docs/UPSTREAM_README.md)

源码基于上游 `6b9a50df911c9d68b69b24c979efba477fb14b67`（2.99.0.0）。`MeloongCore` 以普通目录包含其 `98157d65c7627721c816c02e8be96ac4fe61d615` 的源码，克隆本仓库无需初始化子模块。

本项目保留 PCL 的有限分发许可及合理使用指南，**不是将整个项目重新授权为 MIT 或 Apache 2.0**。修改版问题请提交到本仓库。

<!-- 上游项目介绍见 docs/UPSTREAM_README.md。 -->
