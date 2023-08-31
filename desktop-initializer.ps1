# Env Vars
$GIT_USERNAME = " "
$GIT_EMAIL = " "

# Desired softwares
$softwares = @(
    "microsoft-windows-terminal",
    "vscode",
    "git",
    "python",
    "postman",
    "docker",
    "kubernetes-cli",
    "kubernetes-helm",
    "lens",
    "azure-cli",
    "drawio",
    "7zip.install",
    "pulumi",
    "sql-server-management-studio",
    "dbeaver",
    "ServiceBusExplorer",
    "dotnet-6.0-sdk",
    "openjdk"
)

# Chocolatey installation 
try {
    Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1')) 
}
catch {
    Write-Output "Couldn't install Chocolatey. Probrably because script execution policy is disabled :("
    Write-Output "Enable it through this command: Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force"
    Write-Output "(Copy and paste in a Powershell terminal open as admin, after that execute the script again.)"
}

# Softwares installation
choco install -y $softwares

# Configuring environment
Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1
refreshenv
if ("git" -in $softwares) {
    git config --global core.autocrlf false 
    git config --global http.sslVerify false
    git config --global user.name $GIT_USERNAME
    git config --global user.email $GIT_EMAIL
}
if ("python" -in $softwares) {
    py -m ensurepip --upgrade
    py -m pip install --upgrade pip
    pip install wheel
    pip install --upgrade setuptools
}
