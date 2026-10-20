# 构建说明

## 环境

- 64 位 Windows。
- Visual Studio 2022 或 Build Tools 2022，包含 .NET 桌面开发、VB/WPF 构建工具和 .NET Framework 4.8 targeting pack。
- .NET SDK 9.0，维护构建使用 9.0.319。MeloongCore 使用 C# 13；仅安装 .NET Framework 运行时不足以构建。
- 可访问 NuGet。第三方源码 `MeloongCore` 已直接包含在仓库内。

在仓库根目录运行：

```powershell
pwsh -File ./scripts/Build.ps1
```

脚本通过 Visual Studio 安装信息定位 MSBuild，执行 Release/x64 还原与重新构建，再复制 EXE 到 `dist/` 并生成 SHA-256。

使用独立 SDK 或 NuGet 提供的 .NET Framework 参考程序集时，可显式指定路径：

```powershell
pwsh -File ./scripts/Build.ps1 -SdkRoot 'D:/Tools/dotnet' -FrameworkReferenceRoot 'D:/Tools/net48/build'
```

`FrameworkReferenceRoot` 应包含 `.NETFramework/v4.8/`。此次本机构建使用 `Microsoft.NETFramework.ReferenceAssemblies.net48` 1.0.3 的参考程序集、MSBuild 17.14.37411.7 和 .NET SDK 9.0.319；SDK、NuGet 缓存和工具安装目录均不随仓库发布。

## 打包方式

主程序仍使用原有嵌入资源和 `AssemblyResolve` 加载方式，托管依赖嵌入 EXE。WebP 原生 DLL 在需要时释放到 `PCL/Cache/Native/`。内部程序集名保留为 `Plain Craft Launcher 2`，以维持原有 WPF pack URI；分发文件名为 `PCL2-易联厅长维护版.exe`。

单 EXE 分发仍依赖系统 .NET Framework 4.8；启动后会生成正常的配置、缓存和游戏文件，不意味着永久只有一个文件。游戏运行另需与所选 Minecraft 版本相适配的 Java。

当前二进制为未签名测试构建，不含游戏、Java、账号或个人配置。`dist/SHA256SUMS.txt` 用于校验构建文件。

## CI

`.github/workflows/build.yml` 提供手动触发的 Windows Release 构建。原上游工作流保存在 `docs/UPSTREAM_BUILD.reference.yml`，仅供参考；维护版不采用其帮助库替换和私密参数注入步骤。

本地构建通过不能替代运行、下载、认证及游戏启动验收，请同时阅读测试记录。
