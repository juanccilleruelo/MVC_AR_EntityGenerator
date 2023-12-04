@PAUSE Next : Recovery updates from repository
git pull c:\views\DEPLOYS\senCilleMVC

rmdir c:\views\senCilleMVC\Bin /S /Q

cd c:\views\senCilleMVC

@REM %comspec%  /K "C:\Program Files\Embarcadero\Studio\18.0\bin\rsvars.bat"
@SET BDS=C:\Program Files\Embarcadero\Studio\18.0
@SET BDSINCLUDE=C:\Program Files\Embarcadero\Studio\18.0\include
@SET BDSCOMMONDIR=C:\Users\Public\Documents\Embarcadero\Studio\18.0
@SET FrameworkDir=C:\Windows\Microsoft.NET\Framework\v3.5
@SET FrameworkVersion=v3.5
@SET FrameworkSDKDir=
@SET PATH=%FrameworkDir%;%FrameworkSDKDir%;C:\Program Files\Embarcadero\Studio\18.0\bin;C:\Program Files\Embarcadero\Studio\18.0\bin64;C:\Users\Public\Documents\Embarcadero\InterBase\redist\InterBaseXE7\IDE_spoof;%PATH%
@SET LANGDIR=EN
@SET PLATFORM=
@SET PlatformSDK=

MsBuild senCilleMVC.dproj /t:Clean

MsBuild senCilleMVC.dproj /t:Build /p:Configuration=Release /p:Platform=Win32

@PAUSE Next : Copy files from bin to c:\senCilleMVC
rmdir c:\views\DEPLOYS\senCilleMVC\Win32 /S /Q

xcopy c:\views\senCilleMVC\Source\scFramework\*.fmx  c:\views\DEPLOYS\senCilleMVC\Win32 /S /E /Y /I
xcopy c:\views\senCilleMVC\Source\scFramework\*.dfm  c:\views\DEPLOYS\senCilleMVC\Win32 /S /E /Y /I
xcopy c:\views\senCilleMVC\Bin\Win32\*.dcu  c:\views\DEPLOYS\senCilleMVC\Win32 /S /E /Y /I
xcopy c:\views\senCilleMVC\Bin\Win32\*.bpl  c:\views\DEPLOYS\senCilleMVC\Win32 /S /E /Y /I
xcopy c:\views\senCilleMVC\Bin\Win32\*.dcp  c:\views\DEPLOYS\senCilleMVC\Win32 /S /E /Y /I

@PAUSE Next : Now it is going to commit the updated verstion to the SVN Repository.

git commit c:\views\DEPLOYS\senCilleMVC -m "Committed a new release of the binary version of senCilleMVC"
git push   c:\views\DEPLOYS\senCilleMVC

@PAUSE Did it!
