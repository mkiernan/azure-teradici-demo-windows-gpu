<# Install NVIDIA Drivers, PCOIP Agent and download Leostream Agent/OpendTect #>
param (
    [string]$leostreamAgentVer,
    [string]$teradiciAgentVer,
    [string]$nvidiaVer,	
    [string]$storageAcc,
    [string]$conName
)
<#
$dest = "C:\Downloadinstallers"
$leostreamAgentVer = $Args[0]
$teradiciAgentVer = "2.7.0.3589"
$nvidiaVer = "369.71"
$storageAcc = "tdcm16sg112leo8193ls102"
$conName = "tdcm16sg112leo8193ls102"
#>
$dest = "C:\Downloadinstallers"
$leostreamAgentVer = $Args[0]
$teradiciAgentVer = $Args[1]
$nvidiaVer = $Args[2]
$storageAcc = $Args[3]
$conName = $Args[4]

New-Item -Path $dest -ItemType directory

wget https://$storageAcc.blob.core.windows.net/$conName/"$nvidiaVer"_grid_win10_server2016_64bit_international.exe -OutFile C:\Downloadinstallers\"$nvidiaVer"_grid_win10_server2016_64bit_international.exe
wget http://download.opendtect.org/relman/OpendTect_Installer_win64.exe -OutFile C:\Downloadinstallers\OpendTect_Installer_win64.exe
wget https://$storageAcc.blob.core.windows.net/$conName/PCoIP_agent_release_installer_"$teradiciAgentVer"_graphics.exe -OutFile C:\Downloadinstallers\PCoIP_agent_release_installer_"$teradiciAgentVer"_graphics.exe

wget https://$storageAcc.blob.core.windows.net/$conName/LeostreamAgentSetup$leostreamAgentVer.exe -OutFile C:\Downloadinstallers\LeostreamAgentSetup$leostreamAgentVer.exe


C:\Downloadinstallers\*_grid_win10_server2016_64bit_international.exe /s
Set-Location "C:\NVIDIA\*"
.\setup.exe -s
Start-Sleep -s 90
C:\Downloadinstallers\PCoIP_agent_release_installer_* /S
Start-Sleep -s 90
& 'C:\Program Files (x86)\Teradici\PCoIP Agent\bin\RestartAgent.bat'
net stop nvsvc
Start-Sleep -s 90
net start nvsvc
