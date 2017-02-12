<# Install NVIDIA Drivers, PCOIP Agent and download Leostream Agent/Demo packages #>

<#-- uncomment for testing --
$dest = "C:\Downloadinstallers"
$leostreamAgentVer = "6-2-7-0"
$teradiciAgentVer = "2.7.0.4060"
$nvidiaVer = "369.71"
$license = "344F-D342-7928-30A2"
-- uncomment for testing -- #>
$dest = "C:\Downloadinstallers\"
$leostreamAgentVer = $args[0]
$teradiciAgentVer = $args[1]
$nvidiaVer = $args[2]
$license = $args[3]
$registryPath = "HKLM:\Software\Teradici\PCoIP"
$Name = "pcoip_admin"
$value = "8"
Write-Host "$(Get-Date): Your inputs are '$leostreamAgentVer' and '$teradiciAgentVer' with '$nvidiaVer', '$license'"

# First install .NET 3.5 Framework
Install-WindowsFeature Net-Framework-Core

# Create C:\Downloadinstallers
New-Item -Path $dest -ItemType directory

$nvidiaUrl = [System.String]::Format("https://teradicidemopackages.blob.core.windows.net/packages/{0}_grid_win10_server2016_64bit_international.exe", $nvidiaVer)
$teradiciAgentUrl = [System.String]::Format("https://teradicidemopackages.blob.core.windows.net/packages/PCoIP_agent_release_installer_{0}_graphics.exe", $teradiciAgentVer)
$leostreamAgentUrl = [System.String]::Format("https://teradicidemopackages.blob.core.windows.net/packages/LeostreamAgentSetup{0}.exe", $leostreamAgentVer)
$nvidiaExeName = [System.IO.Path]::GetFileName($nvidiaUrl)
$teradiciExeName = [System.IO.Path]::GetFileName($teradiciAgentUrl)
$leostreamExeName = [System.IO.Path]::GetFileName($leostreamAgentUrl)
$nvidiaExePath = [System.String]::Format("{0}\{1}", $dest, $nvidiaExeName)
$teradiciExePath = [System.String]::Format("{0}\{1}", $dest, $teradiciExeName)
$leostreamExePath = [System.String]::Format("{0}\{1}", $dest, $leostreamExeName)
Write-Host "The NVIDIA Driver exe Url  is '$nvidiaUrl'"
Write-Host "The NVIDIA exe name is '$nvidiaExeName'"
Write-Host "The Teradici Agent exe  Url  is '$teradiciAgentUrl'"
Write-Host "The Teradici Agent exe name is '$teradiciExeName'"
Write-Host "The Leostream Agent exe Url is '$leostreamAgentUrl'"
Write-Host "The Leostream Agent exe name is '$leostreamExeName'"
Write-Host "The NVIDIA exe downloaded location is '$nvidiaExePath'"
Write-Host "The Teradici Agent exe downloaded location is '$teradiciExePath'"
Write-Host "The Leostream Agent exe downloaded location is '$leostreamExePath'"
Write-Host "All Demo Packages will be installed in C:\Downloadinstallers"

# Grab NVIDIA, Teradici & Leostream Packages
wget $nvidiaUrl -OutFile $nvidiaExePath
wget $teradiciAgentUrl -OutFile $teradiciExePath
wget $leostreamAgentUrl -OutFile $leostreamExePath
Write-Host "Driver download complete at $(Get-Date)"

Start-Sleep -s 360
& $nvidiaExePath  /s
Start-Sleep -s 60
$NVIDIAfolder = [System.String]::Format("C:\NVIDIA\{0}", $nvidiaVer)
Write-Host "The NVIDIA Folder name is '$NVIDIAfolder'"
Set-Location $NVIDIAfolder
.\setup.exe -s -noreboot -clean
Start-Sleep -s 180
& $teradiciExePath /S /NoPostReboot
Start-Sleep -s 90 
Write-Host "teradiciagent install over"
cd 'C:\Program Files (x86)\Teradici\PCoIP Agent\licenses\'
Write-Host "pre-activate"
.\appactutil.exe -served -comm soap -commServer https://teradici.flexnetoperations.com/control/trdi/ActivationService -entitlementID $license
Write-Host "activation over"
if ($teradiciAgentVer -match "2.7.0.4060") {
    IF(!(Test-Path $registryPath))
    {
        New-Item -Path $registryPath -Force | Out-Null
        New-ItemProperty -Path $registryPath -Name $name -Value $value -PropertyType DWORD -Force | Out-Null
    }

    ELSE {
        New-ItemProperty -Path $registryPath -Name $name -Value $value -PropertyType DWORD -Force | Out-Null
    }
}
else { 
    Write-Host  "No Registry entry required ."
}
Write-Host "Driver configuration complete at $(Get-Date)"

# Grab Demo Packages
wget https://teradicidemopackages.blob.core.windows.net/packages/Unigine_Heaven-4.0.zip -OutFile C:\Downloadinstallers\Unigine_Heaven-4.0.zip
wget https://teradicidemopackages.blob.core.windows.net/packages/Tetra4D.zip -OutFile C:\Downloadinstallers\Tetra4D.zip
wget https://teradicidemopackages.blob.core.windows.net/packages/Unity_Turbine.zip -OutFile C:\Downloadinstallers\Unity_Turbine.zip
wget https://teradicidemopackages.blob.core.windows.net/packages/SetupFaceWorks.exe -OutFile C:\Downloadinstallers\SetupFaceWorks.exe
wget http://download.opendtect.org/relman/OpendTect_Installer_win64.exe -OutFile C:\Downloadinstallers\OpendTect_Installer_win64.exe
# http://ftp.lstc.com/anonymous/outgoing/lsprepost/4.3/win64/LS-PrePost-4.3-x64_setup.exe
wget https://teradicidemopackages.blob.core.windows.net/nvdemo/LS-PrePost-4.3-x64_setup.exe -OutFile C:\Downloadinstallers\LS-PrePost-4.3-x64_setup.exe
wget https://teradicidemopackages.blob.core.windows.net/nvdemo/LS-PrePost-4.3dp-x64_setup.exe -OutFile C:\Downloadinstallers\LS-PrePost-4.3dp-x64_setup.exe
$Date = Get-Date
Write-Host "Demo Software downloads complete at $(Get-Date)"

# Reboot
Write-Host "Rebooting in 60 seconds..."
C:\WINDOWS\system32\shutdown.exe -r -f -t 60
Write-Host "end script"