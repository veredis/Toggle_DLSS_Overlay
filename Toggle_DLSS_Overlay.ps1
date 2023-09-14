# Check if running as administrator; if not, relaunch as admin
$isAdmin = ([System.Security.Principal.WindowsIdentity]::GetCurrent()).Groups -match "S-1-5-32-544"
if (-not $isAdmin) {
    Start-Process -FilePath wt -ArgumentList "powershell.exe -NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    Exit
}

# Check if the script is running with administrator privileges
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if ($isAdmin) {
    # Define the Registry path and value
    $registryPath = "HKLM:\SOFTWARE\NVIDIA Corporation\Global\NGXCore"
    $registryValueName = "ShowDlssIndicator"
    
    # Check if the DLSS overlay is currently enabled
    $dlssIndicatorEnabled = (Get-ItemProperty -Path $registryPath -Name $registryValueName -ErrorAction SilentlyContinue).$registryValueName
    
    if ($dlssIndicatorEnabled -eq 1024) {
        # Disable DLSS overlay by setting the value to 0
        Set-ItemProperty -Path $registryPath -Name $registryValueName -Value 0
        Write-Host "DLSS overlay disabled."
    }
    else {
        # Enable DLSS overlay by setting the value to 1024
        Set-ItemProperty -Path $registryPath -Name $registryValueName -Value 1024
        Write-Host "DLSS overlay enabled."
    }
}
else {
    Write-Host "Please run this script as an administrator to modify the registry."
}

# Add this line to keep the PowerShell window open
Read-Host "Press Enter to exit"