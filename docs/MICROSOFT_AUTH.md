# Microsoft 登录配置

当前维护者提供的公共 Client ID：`f919d72a-dc30-453e-807f-31ff34eea057`。

源码 `ModSecret.vb` 默认使用该 ID，启动环境可通过 `PCL_MS_CLIENT_ID` 覆盖。Client ID 是公开应用标识，可以出现在源码中；密码、令牌与客户端密钥不得提交到仓库。

登录仍使用上游设备代码登录和 Xbox Live → XSTS → Minecraft 的认证流程，没有跳过正版认证。仅填写一个 GUID 不足以保证登录成功：维护者需要在 Microsoft Entra 的应用注册中核实个人 Microsoft 账号支持及公共客户端/device code 流，并确认该应用符合 Minecraft 服务当前的接入与审核要求。

如需注册自己的应用，可从 [Microsoft Entra 管理中心](https://entra.microsoft.com/)进入“应用注册”，获取“应用程序（客户端）ID”，再按 Microsoft 文档配置公共客户端认证。面向桌面公共客户端的登录不得依赖保存在 EXE 中的客户端密钥。Minecraft 服务接入要求应以 Mojang/Microsoft 当前官方说明为准；当前 ID 的资格尚未验证。

没有有效 Client ID 时，会影响新增 Microsoft 登录、令牌刷新及需要在线认证的正版账号启动；Minecraft 版本清单和官方游戏文件下载本身不依赖 Client ID。已有令牌的短期可用性不代表后续刷新能够成功。

## 实测错误 AADSTS700002

2026-10-20，用户测试新增 Microsoft 登录，设备代码端点返回 HTTP 401、`invalid_client`、`AADSTS700002`，说明应用没有按此流程所需的公共客户端类型配置。

请应用管理员按以下步骤修复：

1. 打开 Microsoft Entra → 应用注册，选中客户端 ID 为 `f919d72a-dc30-453e-807f-31ff34eea057` 的应用。
2. 打开“身份验证（Authentication）”。
3. 在“高级设置（Advanced settings）”中，将“允许公共客户端流（Allow public client flows）”设为“是（Yes）”。
4. 保存后，在现有 EXE 中重新点击登录。

设备代码流不需要重定向 URI。上述配置参见 [Microsoft 官方桌面应用注册说明](https://learn.microsoft.com/en-us/entra/identity-platform/scenario-desktop-app-registration#enable-public-client-flow)。此设置在服务器端生效，不要求更换 Client ID 或重新编译 EXE。

维护版识别该错误并提示修复步骤，其他错误继续保留原处理。启用公共客户端流仅解决这一阶段的配置错误，完整 Minecraft 登录仍需后续验证。

## 后续第 4 步失败

用户后续测试已通过 Microsoft、Xbox Live 和 XSTS，失败发生在请求 Minecraft 登录令牌的第 4 步。实际日志中出现 403 和 TLS 连接关闭。

- TLS 连接关闭说明该次连接没有正常完成，不能由它推断 Client ID 错误。检查代理、加速器和网络出口后重试。
- 403 表示服务拒绝请求。检查网络出口和 Minecraft 对应用的访问资格；仅启用公共客户端流不足以证明 Minecraft 已接受该应用。
- 在同一机器使用不含个人令牌的请求已成功连接此端点，但没有验证真实登录成功。

登录设备代码是一次性凭据，用户应在 Microsoft 官方登录页面自行输入，无需写入源码或交给维护者。
