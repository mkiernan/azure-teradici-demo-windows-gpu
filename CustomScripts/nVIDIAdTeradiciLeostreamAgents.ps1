<# Install NVIDIA Drivers, PCOIP Agent and download Leostream Agent/OpendTect #>
<#param (
    [string]$leostreamAgentVer,
    [string]$teradiciAgentVer,
    [string]$nvidiaVer,	
    [string]$storageAcc,
    [string]$conName
)
#>
<#
$dest = "C:\Downloadinstallers"
$leostreamAgentVer = $Args[0]
$teradiciAgentVer = "2.7.0.3589"
$nvidiaVer = "369.71"
$storageAcc = "tdcm16sg112leo8193ls102"
$conName = "tdcm16sg112leo8193ls102"
#>
$dest = "C:\Downloadinstallers\"
$leostreamAgentVer = $args[0]
$teradiciAgentVer = $args[1]
$nvidiaVer = $args[2]
$storageAcc = $args[3]
$conName = $args[4]
$license = $args[5]
$Date = Get-Date
<#
Write-Host "You inputs are '$leostreamAgentVer' and '$teradiciAgentVer' with '$nvidiaVer', '$storageAcc', '$conName', '$license'  on '$Date'"

New-Item -Path $dest -ItemType directory

wget https://$storageAcc.blob.core.windows.net/$conName/"$nvidiaVer"_grid_win10_server2016_64bit_international.exe -OutFile C:\Downloadinstallers\"$nvidiaVer"_grid_win10_server2016_64bit_international.exe
wget http://download.opendtect.org/relman/OpendTect_Installer_win64.exe -OutFile C:\Downloadinstallers\OpendTect_Installer_win64.exe
wget https://$storageAcc.blob.core.windows.net/$conName/PCoIP_agent_release_installer_"$teradiciAgentVer"_graphics.exe -OutFile C:\Downloadinstallers\PCoIP_agent_release_installer_"$teradiciAgentVer"_graphics.exe

wget https://$storageAcc.blob.core.windows.net/$conName/LeostreamAgentSetup$leostreamAgentVer.exe -OutFile C:\Downloadinstallers\LeostreamAgentSetup$leostreamAgentVer.exe


C:\Downloadinstallers\"$nvidiaVer"_grid_win10_server2016_64bit_international.exe /s
Start-Sleep -s 90
Set-Location "C:\NVIDIA\$nvidiaVer"
.\setup.exe -s
Start-Sleep -s 90
C:\Downloadinstallers\PCoIP_agent_release_installer_"$teradiciAgentVer"_graphics.exe /S
Start-Sleep -s 90
& 'C:\Program Files (x86)\Teradici\PCoIP Agent\bin\RestartAgent.bat'
net stop nvsvc
Start-Sleep -s 90
net start nvsvc
& 'C:\Program Files (x86)\Teradici\PCoIP Agent\licenses\appactutil.exe' appactutil.exe -served -comm soap -commServer https://teradici.flexnetoperations.com/control/trdi/ActivationService -entitlementID $license
#>

$nvidiaUrl = [System.String]::Format("https://{0}.blob.core.windows.net/{1}/{2}_grid_win10_server2016_64bit_international.exe", $storageAcc, $conName, $nvidiaVer)
$teradiciAgentUrl = [System.String]::Format("https://{0}.blob.core.windows.net/{1}/PCoIP_agent_release_installer_{2}_graphics.exe", $storageAcc, $conName, $teradiciAgentVer)
$leostreamAgentUrl = [System.String]::Format("https://{0}.blob.core.windows.net/{1}/LeostreamAgentSetup{2}.exe", $storageAcc, $conName, $leostreamAgentVer)
$nvidiaExeName = [System.IO.Path]::GetFileName($nvidiaUrl)
$teradiciExeName = [System.IO.Path]::GetFileName($teradiciAgentUrl)
$leostreamExeName = [System.IO.Path]::GetFileName($leostreamAgentUrl)
$nvidiaExePath = [System.String]::Format("{0}{1}", $dest, $nvidiaExeName)
$teradiciExePath = [System.String]::Format("{0}{1}", $dest, $teradiciExeName)
$leostreamExePath = [System.String]::Format("{0}{1}", $dest, $leostreamExeName)
Write-Host "The Url name is '$nvidiaUrl'"
Write-Host "The exe name is '$nvidiaExeName'"
Write-Host "The Url name is '$teradiciAgentUrl'"
Write-Host "The exe name is '$teradiciExeName'"
Write-Host "The Url name is '$leostreamAgentUrl'"
Write-Host "The exe Full Path is '$leostreamExeName'"
Write-Host "The exe name is '$nvidiaExePath'"
Write-Host "The exe Full Path is '$teradiciExePath'"
Write-Host "The exe Full Path is '$leostreamExePath'"
wget $nvidiaUrl -OutFile $nvidiaExePath
wget $teradiciAgentUrl -OutFile $teradiciExePath
wget $leostreamAgentUrl -OutFile $leostreamExePath
Start-Sleep -s 90
& $nvidiaExePath  /s
Start-Sleep -s 90
$NVIDIAfolder = [System.String]::Format("C:\NVIDIA\{0}", $nvidiaVer)
Write-Host "The NVIDIA Folder name is '$NVIDIAfolder'"
Set-Location $NVIDIAfolder
setup.exe -s -noreboot -clean
Start-Sleep -s 90
& $teradiciExePath /S
Start-Sleep -s 90
& 'C:\Program Files (x86)\Teradici\PCoIP Agent\bin\RestartAgent.bat'
net stop nvsvc
Start-Sleep -s 90
net start nvsvc
& 'C:\Program Files (x86)\Teradici\PCoIP Agent\licenses\appactutil.exe' appactutil.exe -served -comm soap -commServer https://teradici.flexnetoperations.com/control/trdi/ActivationService -entitlementID $license

