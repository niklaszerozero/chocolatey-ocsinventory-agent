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

# Service
sc.exe delete "OCS Inventory Service"

# Directories
$item = "${Env:ProgramData}\OCS Inventory NG"
if (Test-Path $item) {
  Remove-Item -Path $item -Recurse -Force
}

$item = "${Env:ProgramData}\OCS Inventory"
if (Test-Path $item) {
  Remove-Item -Path $item -Recurse -Force
}

$item = "${Env:ProgramFiles(x86)}\OCS Inventory Agent"
if (Test-Path $item) {
  Remove-Item -Path $item -Recurse -Force
}

$item = "$Env:ProgramFiles\OCS Inventory Agent"
if (Test-Path $item) {
  Remove-Item -Path $item -Recurse -Force
}

# Registry
$item = "HKLM\SOFTWARE\OCS Inventory"
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

$item = "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\OCS Inventory NG Agent"
if (Test-Path $item) {
  Remove-Item -Path $item -Recurse -Force
}

$item = "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\OCS Inventory NG Agent"
if (Test-Path $item) {
  Remove-Item -Path $item -Recurse -Force
}