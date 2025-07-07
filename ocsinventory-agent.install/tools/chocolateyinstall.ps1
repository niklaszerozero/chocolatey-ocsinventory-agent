$ErrorActionPreference = 'Stop'

#####
# Stop currently active OCS Inventory NG Agent
#####

if (Get-Service -Name "OCS Inventory Service" -ErrorAction SilentlyContinue) {
  Stop-Service -Name "OCS Inventory Service"
}

Stop-Process -Name "Ocs*" -Force

#####
# Remove currently installed OCS Inventory NG Agent
#####

sc.exe delete "OCS Inventory Service"

$item = "${Env:ProgramFiles(x86)}\OCS Inventory Agent"
if (Test-Path $item) {
  Remove-Item -Path $item -Recurse -Force
}

$item = "$Env:ProgramFiles\OCS Inventory Agent"
if (Test-Path $item) {
  Remove-Item -Path $item -Recurse -Force
}

$item = "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\App Paths\OCSInventory.exe"
if (Test-Path $item) {
  Remove-Item -Path $item -Recurse -Force
}

$item = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\OCSInventory.exe"
if (Test-Path $item) {
  Remove-Item -Path $item -Recurse -Force
}

#####
# Download archive from github
#####

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url = 'https://github.com/OCSInventory-NG/WindowsAgent/releases/download/2.11.0.1/OCS-Windows-Agent-2.11.0.1_x86.zip'
$url64 = 'https://github.com/OCSInventory-NG/WindowsAgent/releases/download/2.11.0.1/OCS-Windows-Agent-2.11.0.1_x64.zip'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'zip'
  url           = $url
  url64bit      = $url64

  softwareName  = 'OCS Inventory NG Agent*'

  checksum      = 'C665F2A9F2F1ED29744B80C950AF6F64EB6608F7AF05016B22D34BB45A6234B6'
  checksumType  = 'sha256'
  checksum64    = '50273E19EDDD63EB235DFBA9114411E16A38EA6F5FDB96CEC151A3769C449D01'
  checksumType64= 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

#####
# Install extracted exe
#####

$file = Join-Path $toolsDir -ChildPath 'OCS-Windows-Agent-2.11.0.1_x86' | Join-Path -ChildPath 'OCS-Windows-Agent-Setup-x86.exe'
$file64 = Join-Path $toolsDir -ChildPath 'OCS-Windows-Agent-2.11.0.1_x64' | Join-Path -ChildPath 'OCS-Windows-Agent-Setup-x64.exe'

$installArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'exe'
  file          = $file
  file64        = $file64

  softwareName  = 'OCS Inventory NG Agent*'

  silentArgs     = '/S /NOSPLASH'
  validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @installArgs