#RequireAdmin

#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=assets\bug.ico
#AutoIt3Wrapper_Outfile=KpRm.exe
#AutoIt3Wrapper_Res_Description=KpRm By Kernel-Panik
#AutoIt3Wrapper_Res_Fileversion=38
#AutoIt3Wrapper_Res_ProductName=KpRm
#AutoIt3Wrapper_Res_ProductVersion=1.8.3
#AutoIt3Wrapper_Res_CompanyName=kernel-panik
#AutoIt3Wrapper_Res_requestedExecutionLevel=requireAdministrator
#AutoIt3Wrapper_Res_Icon_Add=.\assets\bug.ico
#AutoIt3Wrapper_Res_File_Add=.\assets\bug.gif
#AutoIt3Wrapper_Res_File_Add=.\config\tools.xml
#AutoIt3Wrapper_Res_File_Add=.\binaries\hobocopy32\HoboCopy.exe
#AutoIt3Wrapper_Res_File_Add=.\binaries\hobocopy32\msvcp100.dll
#AutoIt3Wrapper_Res_File_Add=.\binaries\hobocopy32\msvcr100.dll
#AutoIt3Wrapper_Res_File_Add=.\binaries\hobocopy64\HoboCopy.exe
#AutoIt3Wrapper_Res_File_Add=.\binaries\hobocopy64\msvcp100.dll
#AutoIt3Wrapper_Res_File_Add=.\binaries\hobocopy64\msvcr100.dll
#AutoIt3Wrapper_Res_LegalCopyright=kernel-panik
#AutoIt3Wrapper_Run_Au3Stripper=y
#Au3Stripper_Parameters=/rm /sf=1 /sv=1
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include-once
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <StringConstants.au3>
#include <WindowsConstants.au3>
#include <InetConstants.au3>
#include <MsgBoxConstants.au3>
#include <AutoItConstants.au3>
#include <FileConstants.au3>
#include <GuiStatusBar.au3>
#include <Date.au3>
#include <WinAPI.au3>
#include <WinAPIShellEx.au3>
#include <WinAPIFiles.au3>
#include <WinAPIEx.au3>
#include <SendMessage.au3>
#include <Array.au3>
#include <File.au3>

Global $sTmpDir = @TempDir & "\KPRM"

If FileExists($sTmpDir) Then
	DirRemove($sTmpDir, $DIR_REMOVE)
EndIf

DirCreate($sTmpDir)

FileInstall(".\assets\bug.gif", $sTmpDir & "\kprm-logo.gif")

Global $bKpRmDev = False
Global $sKprmVersion = "1.8.3"

If $bKpRmDev = True Then
	AutoItSetOption("MustDeclareVars", 1)
EndIf

Local Const $sLang = GetLanguage()

If $sLang = "fr" Then
	#include "locales\fr.au3"
ElseIf $sLang = "de" Then
	#include "locales\de.au3"
ElseIf $sLang = "it" Then
	#include "locales\it.au3"
ElseIf $sLang = "es" Then
	#include "locales\es.au3"
ElseIf $sLang = "pt" Then
	#include "locales\pt.au3"
Else
	#include "locales\en.au3"
EndIf

#include "libs\UAC.au3"
#include "libs\SystemRestore.au3"
#include "libs\Permissions.au3"
#include "libs\_XMLDomWrapper.au3"
#include "libs\HTTP.au3"
#include "includes\utils.au3"
#include "includes\progress_bar.au3"
#include "includes\restore_points.au3"
#include "includes\registry_backup.au3"
#include "includes\restore_uac.au3"
#include "includes\restore_system_settings.au3"
#include "includes\tools_remove.au3"
#include "includes\tools_import.au3"

#Region ### START Koda GUI section ### Form=C:\Users\IEUser\Desktop\kpRemover\gui\Form1.kxf

If Not IsAdmin() Then
	MsgBox(16, $lFail, $lAdminRequired)
	QuitKprm()
EndIf

If $bKpRmDev = False Then
	CheckVersionOfKpRm()
EndIf

Global $sProgramName = "KpRm"
Global $sKPLogFile = "kprm-" & @YEAR & @MON & @MDAY & @HOUR & @MIN & ".txt"

Local Const $oMainWindow = GUICreate($sProgramName & " v" & $sKprmVersion & " by kernel-panik", 500, 235, 202, 112)
Local Const $oGroup1 = GUICtrlCreateGroup("Actions", 8, 8, 400, 153)
Local Const $oRemoveTools = GUICtrlCreateCheckbox($lDeleteTools, 16, 40, 129, 17)
Local Const $oRemoveRP = GUICtrlCreateCheckbox($lDeleteSystemRestorePoints, 16, 80, 190, 17)
Local Const $oCreateRP = GUICtrlCreateCheckbox($lCreateRestorePoint, 16, 120, 190, 17)
Local Const $oBackupRegistry = GUICtrlCreateCheckbox($lSaveRegistry, 220, 40, 137, 17)
Local Const $oRestoreUAC = GUICtrlCreateCheckbox($lRestoreUAC, 220, 80, 137, 17)
Local Const $oRestoreSystemSettings = GUICtrlCreateCheckbox($lRestoreSettings, 220, 120, 180, 17)
Local Const $mHelpMenu = GUICtrlCreateMenu("?")
Local Const $idContribute = GUICtrlCreateMenuItem("Contribute", $mHelpMenu)
Local Const $idDonation = GUICtrlCreateMenuItem("Donation", $mHelpMenu)
Global $oHStatus = _GUICtrlStatusBar_Create($oMainWindow)
Global $oProgressBar = GUICtrlCreateProgress(8, 170, 480, 17)

GUICtrlCreateGroup("", -99, -99, 1, 1)

GUICtrlSetState($oRemoveTools, 1)

Local Const $oPic1 = GUICtrlCreatePic($sTmpDir & "\kprm-logo.gif", 415, 16, 76, 76)
Local Const $oRunKp = GUICtrlCreateButton($lRun, 415, 120, 75, 40)

GUISetState(@SW_SHOW)

#EndRegion ### END Koda GUI section ###

While 1

	Local $nMsg = GUIGetMsg()

	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $idContribute
			ShellExecute("https://github.com/KernelPan1k/KpRm")
		Case $idDonation
			ShellExecute("https://github.com/KernelPan1k/KpRm#donation")
		Case $oRunKp
			KpRemover()
	EndSwitch
WEnd

Func CreateKPRMDir()
	Local Const $sDir = @HomeDrive & "\KPRM"

	If Not FileExists($sDir) Then
		DirCreate($sDir)
	EndIf

	If Not FileExists($sDir) Then
		MsgBox(16, $lFail, $lRegistryBackupError)
		Exit
	EndIf
EndFunc   ;==>CreateKPRMDir

Func Init()
	CreateKPRMDir()
	LogMessage("# Run at " & _Now())
	LogMessage("# KpRm (Kernel-panik) version " & $sKprmVersion)
	LogMessage("# Website https://kernel-panik.me/tool/kprm/")
	LogMessage("# Run by " & @UserName & " from " & @WorkingDir)
	LogMessage("# Computer Name: " & @ComputerName)
	LogMessage("# OS: " & GetHumanVersion() & " " & @OSArch & " (" & @OSBuild & ") " & @OSServicePack)

	ProgressBarInit()
EndFunc   ;==>Init

Func UpdateStatuBar($sText)
	_GUICtrlStatusBar_SetText($oHStatus, $sText)
EndFunc   ;==>UpdateStatuBar

Func KpRemover()
	Dim $sTmpDir

	Init()

	ProgressBarUpdate()

	If GUICtrlRead($oBackupRegistry) = $GUI_CHECKED Then
		CreateBackupRegistry()
	EndIf

	ProgressBarUpdate()

	If GUICtrlRead($oRemoveTools) = $GUI_CHECKED Then
		RunRemoveTools(False)
		RunRemoveTools(True)
	Else
		ProgressBarUpdate(32)
	EndIf

	ProgressBarUpdate()

	If GUICtrlRead($oRestoreSystemSettings) = $GUI_CHECKED Then
		RestoreSystemSettingsByDefault()
	EndIf

	ProgressBarUpdate()

	If GUICtrlRead($oRestoreUAC) = $GUI_CHECKED Then
		RestaureUACByDefault()
	EndIf

	ProgressBarUpdate()

	If GUICtrlRead($oRemoveRP) = $GUI_CHECKED Then
		ClearRestorePoint()
	EndIf

	ProgressBarUpdate()

	If GUICtrlRead($oCreateRP) = $GUI_CHECKED Then
		CreateRestorePoint()
	EndIf

	GUICtrlSetData($oProgressBar, 100)
	UpdateStatuBar("Finish")

	MsgBox(64, "OK", $lFinish)

	QuitKprm(True)
EndFunc   ;==>KpRemover
