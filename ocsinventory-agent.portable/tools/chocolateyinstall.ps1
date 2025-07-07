$ErrorActionPreference = 'Stop'

#####
# Download archive from github
#####

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url = 'https://github.com/OCSInventory-NG/WindowsAgent/releases/download/2.11.0.1/OCS-Windows-Agent-2.11.0.1_x86-Portable.zip'
$url64 = 'https://github.com/OCSInventory-NG/WindowsAgent/releases/download/2.11.0.1/OCS-Windows-Agent-2.11.0.1_x64-Portable.zip'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'zip'
  url           = $url
  url64bit      = $url64

  softwareName  = 'OCS Inventory NG Agent*'

  checksum      = '853AFA6821D27B964A615DFEC30C202DFE039498B5DDCA8868657C5223DBCBDA'
  checksumType  = 'sha256'
  checksum64    = '4C49376D418326BD366CBCFA11EFCDFCD9E76A26E50D98F89389C5FE11F1BD30'
  checksumType64= 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

#####
# Install extracted exe
#####

$pp = Get-PackageParameters
$args = "/S"

Write-Host $pp

$file = Join-Path $toolsDir -ChildPath 'OCS-Windows-Agent-2.11.0.1_x86-Portable' | Join-Path -ChildPath 'OCSInventory.exe'
$file64 = Join-Path $toolsDir -ChildPath 'OCS-Windows-Agent-2.11.0.1_x64-Portable' | Join-Path -ChildPath 'OCSInventory.exe'

if ([Environment]::Is64BitOperatingSystem) {
  Start-Process -FilePath $file64 -ArgumentList $args
} else {
  Start-Process -FilePath $file -ArgumentList $args
}