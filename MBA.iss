   ; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "Meetn Bonus App"
#define MyAppVersion "1.0"
#define MyAppPublisher "Rick Raddatz, Meetn"
#define MyAppURL "https://www.meetn.com/"
#define MyAppExeName "Meetn Bonus App.exe"
#define MyAppAssocName MyAppName + " File"
#define MyAppAssocExt ".myp"
#define MyAppAssocKey StringChange(MyAppAssocName, " ", "") + MyAppAssocExt

[Setup]
; NOTE: The value of AppId uniquely identifies this application. Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{F4D99716-40B1-473E-8C8E-9EB4BEE679EA}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={autopf}\{#MyAppName}
; "ArchitecturesAllowed=x64compatible" specifies that Setup cannot run
; on anything but x64 and Windows 11 on Arm.
ArchitecturesAllowed=x64compatible
; "ArchitecturesInstallIn64BitMode=x64compatible" requests that the
; install be done in "64-bit mode" on x64 or Windows 11 on Arm,
; meaning it should use the native 64-bit Program Files directory and
; the 64-bit view of the registry.
ArchitecturesInstallIn64BitMode=x64compatible
ChangesAssociations=yes
DisableProgramGroupPage=yes
LicenseFile=license.txt
InfoBeforeFile=before.txt
InfoAfterFile=after.txt
; Uncomment the following line to run in non administrative install mode (install for current user only.)
;PrivilegesRequired=lowest
PrivilegesRequired=admin  
OutputDir=G:\must
OutputBaseFilename=Meetn Bonus App
SetupIconFile=G:\Projects\CALL\Virtual_camera\MBA.ico
Compression=lzma
SolidCompression=yes
WizardStyle=modern


[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: checkedonce
;Name: "RestartPC"; Description: "Restart the Computer"; GroupDescription: "Post Installation Options"; Flags: checkedonce;

[Files]
Source: "C:\Users\Kanoi\.u2net\u2netp.onnx"; DestDir: "C:\Users\{username}\.u2net"; Flags: ignoreversion
Source: "G:\Projects\CALL\HEY\*"; DestDir: "{userpf}\MBA"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "G:\Projects\CALL\Virtual_camera\dist\Meetn Bonus App\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
; NOTE: Don't use "Flags: ignoreversion" on any shared system files  
Source: "itdownload.dll"; Flags: dontcopy  

[Registry]
; Add ffmpeg path to environment variable  
Root: HKLM; Subkey: "SYSTEM\CurrentControlSet\Control\Session Manager\Environment"; \
    ValueType: expandsz; ValueName: "Path"; ValueData: "{userpf}\MBA\Dependency\ffmpeg\bin;{olddata}"; Flags: preservestringtype;  \
    Check: NeedsAddPath('{userpf}\MBA\Dependency\ffmpeg\bin')
; Add AkVCamManager path based on system architecture
Root: HKLM; Subkey: "SYSTEM\CurrentControlSet\Control\Session Manager\Environment"; \
    ValueType: expandsz; ValueName: "Path"; ValueData: "{userpf}\MBA\Dependency\AkVirtualCamera\{code:GetArch};{olddata}"; Flags: preservestringtype;  \
    Check: NeedsAddPath('{userpf}\MBA\Dependency\AkVirtualCamera\{code:GetArch}')

Root: HKA; Subkey: "Software\Classes\{#MyAppAssocExt}\OpenWithProgids"; ValueType: string; ValueName: "{#MyAppAssocKey}"; ValueData: ""; Flags: uninsdeletevalue
Root: HKA; Subkey: "Software\Classes\{#MyAppAssocKey}"; ValueType: string; ValueName: ""; ValueData: "{#MyAppAssocName}"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\{#MyAppAssocKey}\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\{#MyAppExeName},0"
Root: HKA; Subkey: "Software\Classes\{#MyAppAssocKey}\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\{#MyAppExeName}"" ""%1"""
Root: HKA; Subkey: "Software\Classes\Applications\{#MyAppExeName}\SupportedTypes"; ValueType: string; ValueName: ".myp"; ValueData: ""

[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
; Install AkVCamassistant to make the virtual camera working
Filename: "{userpf}\MBA\Dependency\AkVirtualCamera\{code:GetArch}\AkVCamAssistant.exe"; Parameters: "-i"; Flags: runhidden runascurrentuser; statusMsg: "Installing assistant program..."
; Run AkVCamManager to remove devices after installation is complete
Filename: "{cmd}"; Parameters: "/C {userpf}\MBA\Dependency\AkVirtualCamera\{code:GetArch}\AkVCamManager remove-devices"; Flags: runhidden runascurrentuser; StatusMsg: "Removing cameras..."
; Update the AkVCamManager
Filename: "{cmd}"; Parameters: "/C {app}\Dependency\AkVirtualCamera\{code:GetArch}\AkVCamManager update"; Flags: runhidden runascurrentuser; StatusMsg: "Updating devices..."
; Add a Virtual Camera device
Filename: "{cmd}"; Parameters: "/C {userpf}\MBA\Dependency\AkVirtualCamera\{code:GetArch}\AkVCamManager add-device -i ""AkVCamVideoDevice0"" ""Meetn Virtual Camera"""; Flags: runhidden runascurrentuser; StatusMsg: "Adding Virtual Camera..."
; Add a video format to the first virtual camera device  
Filename: "{cmd}"; Parameters: "/C {userpf}\MBA\Dependency\AkVirtualCamera\{code:GetArch}\AkVCamManager add-format AkVCamVideoDevice0 RGB24 640 480 30"; Flags: runhidden runascurrentuser; StatusMsg: "Adding video format..."  
; Update the configuration again  
Filename: "{cmd}"; Parameters: "/C {userpf}\MBA\Dependency\AkVirtualCamera\{code:GetArch}\AkVCamManager update"; Flags: runhidden runascurrentuser; StatusMsg: "Updating configuration..."  
; Set a default picture  
Filename: "{cmd}"; Parameters: "/C {userpf}\MBA\Dependency\AkVirtualCamera\{code:GetArch}\AkVCamManager set-picture ""{userpf}\MBA\Dependency\default_picture.jpg"""; Flags: runhidden runascurrentuser; StatusMsg: "Setting default picture..."  


[Code] 
#ifdef UNICODE
  #define AW "W"
#else
  #define AW "A"
#endif

  
function GetArch(Value: string): string;  
begin  
  if IsWin64 then  
    Result := 'x64'  
  else  
    Result := 'x32';  
end;  

function NeedsAddPath(Param: string): boolean;
var
  OrigPath: string;
begin
  if not RegQueryStringValue(HKEY_LOCAL_MACHINE,
    'SYSTEM\CurrentControlSet\Control\Session Manager\Environment',
    'Path', OrigPath)
  then begin
    Result := True;
    exit;
  end;
  { look for the path with leading and trailing semicolon }
  { Pos() returns 0 if not found }
  Result := Pos(';' + Param + ';', ';' + OrigPath + ';') = 0;
end;

procedure CurStepChanged(CurStep: TSetupStep);  
var  
  intResultCode: Integer;  
begin  
  if CurStep = ssDone then  
  begin  
    // Display a message box informing the user that the system will restart  
    // and wait for their confirmation (optional)  
    if SuppressibleMsgBox(  
      'Setup must restart your computer to complete the installation.' + #13#10 + #13#10 +  
      'Would you like to restart now?',  
      mbConfirmation, MB_YESNO, IDYES) = IDYES then  
    begin  
      // Execute the shutdown command to restart the computer immediately  
      Exec('shutdown.exe', '-r -t 0', '', SW_HIDE, ewNoWait, intResultCode);  
    end;  
  end;  
end; 

