# Microsoft 登录配置

当前维护者提供的公共 Client ID：`f919d72a-dc30-453e-807f-31ff34eea057`。

源码 `ModSecret.vb` 默认使用该 ID，启动环境可通过 `PCL_MS_CLIENT_ID` 覆盖。Client ID 是公开应用标识，可以出现在源码中；密码、令牌与客户端密钥不得提交到仓库。

登录仍使用上游设备代码登录和 Xbox Live → XSTS → Minecraft 的认证流程，没有跳过正版认证。仅填写一个 GUID 不足以保证登录成功：维护者需要在 Microsoft Entra 的应用注册中核实个人 Microsoft 账号支持及公共客户端/device code 流，并确认该应用符合 Minecraft 服务当前的接入与审核要求。

如需注册自己的应用，可从 [Microsoft Entra 管理中心](https://entra.microsoft.com/)进入“应用注册”，获取“应用程序（客户端）ID”，再按 Microsoft 文档配置公共客户端认证。面向桌面公共客户端的登录不得依赖保存在 EXE 中的客户端密钥。Minecraft 服务接入要求应以 Mojang/Microsoft 当前官方说明为准；当前 ID 的资格尚未验证。

没有有效 Client ID 时，会影响新增 Microsoft 登录、令牌刷新及需要在线认证的正版账号启动；Minecraft 版本清单和官方游戏文件下载本身不依赖 Client ID。已有令牌的短期可用性不代表后续刷新能够成功。

本项目尚未完成此 ID 的实际登录验收，不承诺配置后即可登录。
