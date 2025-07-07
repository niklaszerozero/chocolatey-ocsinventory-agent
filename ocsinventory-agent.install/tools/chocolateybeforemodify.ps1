#####
# Stop currently active OCS Inventory NG Agent
#####

if (Get-Service -Name "OCS Inventory Service" -ErrorAction SilentlyContinue) {
  Stop-Service -Name "OCS Inventory Service"
}

Stop-Process -Name "Ocs*" -Force