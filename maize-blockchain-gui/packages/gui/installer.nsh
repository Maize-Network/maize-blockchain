!include "nsDialogs.nsh"

; Add our customizations to the finish page
!macro customFinishPage
XPStyle on

Var DetectDlg
Var FinishDlg
Var MaizeSquirrelInstallLocation
Var MaizeSquirrelInstallVersion
Var MaizeSquirrelUninstaller
Var CheckboxUninstall
Var UninstallMaizeSquirrelInstall
Var BackButton
Var NextButton

Page custom detectOldMaizeVersion detectOldMaizeVersionPageLeave
Page custom finish finishLeave

; Add a page offering to uninstall an older build installed into the maize-blockchain dir
Function detectOldMaizeVersion
  ; Check the registry for old maize-blockchain installer keys
  ReadRegStr $MaizeSquirrelInstallLocation HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\maize-blockchain" "InstallLocation"
  ReadRegStr $MaizeSquirrelInstallVersion HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\maize-blockchain" "DisplayVersion"
  ReadRegStr $MaizeSquirrelUninstaller HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\maize-blockchain" "QuietUninstallString"

  StrCpy $UninstallMaizeSquirrelInstall ${BST_UNCHECKED} ; Initialize to unchecked so that a silent install skips uninstalling

  ; If registry keys aren't found, skip (Abort) this page and move forward
  ${If} MaizeSquirrelInstallVersion == error
  ${OrIf} MaizeSquirrelInstallLocation == error
  ${OrIf} $MaizeSquirrelUninstaller == error
  ${OrIf} $MaizeSquirrelInstallVersion == ""
  ${OrIf} $MaizeSquirrelInstallLocation == ""
  ${OrIf} $MaizeSquirrelUninstaller == ""
  ${OrIf} ${Silent}
    Abort
  ${EndIf}

  ; Check the uninstall checkbox by default
  StrCpy $UninstallMaizeSquirrelInstall ${BST_CHECKED}

  ; Magic create dialog incantation
  nsDialogs::Create 1018
  Pop $DetectDlg

  ${If} $DetectDlg == error
    Abort
  ${EndIf}

  !insertmacro MUI_HEADER_TEXT "Uninstall Old Version" "Would you like to uninstall the old version of Maize Blockchain?"

  ${NSD_CreateLabel} 0 35 100% 12u "Found Maize Blockchain $MaizeSquirrelInstallVersion installed in an old location:"
  ${NSD_CreateLabel} 12 57 100% 12u "$MaizeSquirrelInstallLocation"

  ${NSD_CreateCheckBox} 12 81 100% 12u "Uninstall Maize Blockchain $MaizeSquirrelInstallVersion"
  Pop $CheckboxUninstall
  ${NSD_SetState} $CheckboxUninstall $UninstallMaizeSquirrelInstall
  ${NSD_OnClick} $CheckboxUninstall SetUninstall

  nsDialogs::Show

FunctionEnd

Function SetUninstall
  ; Set UninstallMaizeSquirrelInstall accordingly
  ${NSD_GetState} $CheckboxUninstall $UninstallMaizeSquirrelInstall
FunctionEnd

Function detectOldMaizeVersionPageLeave
  ${If} $UninstallMaizeSquirrelInstall == 1
    ; This could be improved... Experiments with adding an indeterminate progress bar (PBM_SETMARQUEE)
    ; were unsatisfactory.
    ExecWait $MaizeSquirrelUninstaller ; Blocks until complete (doesn't take long though)
  ${EndIf}
FunctionEnd

Function finish

  ; Magic create dialog incantation
  nsDialogs::Create 1018
  Pop $FinishDlg

  ${If} $FinishDlg == error
    Abort
  ${EndIf}

  GetDlgItem $NextButton $HWNDPARENT 1 ; 1 = Next button
  GetDlgItem $BackButton $HWNDPARENT 3 ; 3 = Back button

  ${NSD_CreateLabel} 0 35 100% 12u "Maize has been installed successfully!"
  EnableWindow $BackButton 0 ; Disable the Back button
  SendMessage $NextButton ${WM_SETTEXT} 0 "STR:Let's Farm!" ; Button title is "Close" by default. Update it here.

  nsDialogs::Show

FunctionEnd

; Copied from electron-builder NSIS templates
Function StartApp
  ${if} ${isUpdated}
    StrCpy $1 "--updated"
  ${else}
    StrCpy $1 ""
  ${endif}
  ${StdUtils.ExecShellAsUser} $0 "$launchLink" "open" "$1"
FunctionEnd

Function finishLeave
  ; Launch the app at exit
  Call StartApp
FunctionEnd

; Section
; SectionEnd
!macroend
