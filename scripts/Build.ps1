param(
    [string]$MSBuildPath,
    [string]$SdkRoot,
    [string]$FrameworkReferenceRoot
)

$ErrorActionPreference = 'Stop'
$taskRepoRoot = Split-Path -Parent $PSScriptRoot
if (-not $MSBuildPath) {
    $taskVsWhere = Join-Path ${env:ProgramFiles(x86)} 'Microsoft Visual Studio/Installer/vswhere.exe'
    if (-not (Test-Path -LiteralPath $taskVsWhere)) { throw 'Install Visual Studio 2022 or Build Tools with .NET desktop build tools, or specify -MSBuildPath.' }
    $MSBuildPath = & $taskVsWhere -latest -products '*' -requires Microsoft.Component.MSBuild -find 'MSBuild/**/Bin/MSBuild.exe' | Select-Object -First 1
}
if (-not $MSBuildPath -or -not (Test-Path -LiteralPath $MSBuildPath)) { throw 'MSBuild.exe was not found.' }
if ($SdkRoot) {
    $env:DOTNET_ROOT = (Resolve-Path -LiteralPath $SdkRoot).Path
    $taskSdk = Get-ChildItem -LiteralPath (Join-Path $env:DOTNET_ROOT 'sdk') -Directory |
        Where-Object { $_.Name -match '^9\.0\.\d+$' } |
        Sort-Object { [version]$_.Name } -Descending | Select-Object -First 1
    if (-not $taskSdk) { throw 'The specified SDK directory must contain .NET SDK 9.0.' }
    $env:MSBuildSDKsPath = Join-Path $taskSdk.FullName 'Sdks'
    $env:MSBuildEnableWorkloadResolver = 'false'
}
$taskBuildArgs = @(
    (Join-Path $taskRepoRoot 'Plain Craft Launcher 2/Plain Craft Launcher 2.vbproj'),
    '-restore', '-t:Rebuild', '-p:Configuration=Release', '-p:PlatformTarget=x64', '-v:minimal', '-nologo'
)
if ($FrameworkReferenceRoot) {
    $taskReferenceRoot = (Resolve-Path -LiteralPath $FrameworkReferenceRoot).Path
    $taskFramework = Join-Path $taskReferenceRoot '.NETFramework/v4.8'
    if (-not (Test-Path -LiteralPath (Join-Path $taskFramework 'mscorlib.dll'))) { throw 'FrameworkReferenceRoot must contain .NETFramework/v4.8 reference assemblies.' }
    $taskBuildArgs += "-p:TargetFrameworkRootPath=$taskReferenceRoot\"
    $taskBuildArgs += "-p:FrameworkPathOverride=$taskFramework"
}
& $MSBuildPath @taskBuildArgs
if ($LASTEXITCODE -ne 0) { throw "Build failed with exit code $LASTEXITCODE." }
$taskDist = Join-Path $taskRepoRoot 'dist'
New-Item -ItemType Directory -Force -Path $taskDist | Out-Null
$taskExeName = 'PCL2-易联厅长维护版.exe'
$taskExe = Join-Path $taskDist $taskExeName
Copy-Item -LiteralPath (Join-Path $taskRepoRoot 'Plain Craft Launcher 2/bin/Plain Craft Launcher 2.exe') -Destination $taskExe -Force
$taskHash = (Get-FileHash -LiteralPath $taskExe -Algorithm SHA256).Hash.ToLowerInvariant()
[IO.File]::WriteAllText((Join-Path $taskDist 'SHA256SUMS.txt'), "$taskHash  $taskExeName`n", [Text.UTF8Encoding]::new($false))
Write-Output "Built testing EXE: $taskExe"
Write-Output "SHA256: $taskHash"
