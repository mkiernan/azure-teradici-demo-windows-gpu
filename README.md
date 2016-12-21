# Deploy a Windows NV VM.
# **WIP** 
## Obtain a Trial License For the Windows Graphic Agent from [here](http://connect.teradici.com/cas-trial) to put in the template parameter
<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-accessplatform-windows-gpu%2Fmaster%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-accessplatform-windows-gpu%2Fmaster%2Fazuredeploy.json" target="_blank">
    <img src="http://armviz.io/visualizebutton.png"/>
</a>
* PCOIP Client Download for Windows is [here](http://www.teradici.com/product-finder/product-details?productid=1be37e19-64a0-69f0-a533-ff0000f45ce7)
* Collection of the user dumps for the NVIDIA Display Driver 369.71  from within the VM on Display Driver Crash.
 * Details are here -> http://nvidia.custhelp.com/app/answers/detail/a_id/3335/~/tdr-(timeout-detection-and-recovery)-and-collecting-dump-files
* PCOIP RC Agent Log Collection (2.7.0.3589 ) from the Teradici System Tray (right click Teradici Icon on System Tray) and collect Agent Logs (from the pop-up)
* The PCOIP Agent Logs (v1.9) from the Office Client machine of the end-user from <code>C:\Users<user_name>\AppData\Local\Teradici\PCoIPClient\logs</code>


