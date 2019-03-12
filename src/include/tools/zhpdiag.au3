
Func RemoveZHPDiag()
	Dim $KPDebug

	If $KPDebug Then logMessage(@CRLF & "- Search ZHPDiag Files -" & @CRLF)

	Local $return = 0

	$return += CloseProcessAndWait("ZHPDiag.exe")
	$return += CloseProcessAndWait("ZHPDiag3.exe")

	Local Const $desciptionPattern = "(?i)^ZHPDiag"

	$return += RemoveFile(@DesktopDir & "\ZHPDiag.txt")
	$return += RemoveFile(@DesktopDir & "\ZHPDiag.lnk")
	$return += RemoveGlobFile(@DesktopDir, "ZHPDiag?.exe", "^ZHPDiag3?.exe$", $desciptionPattern)
	$return += RemoveGlobFile(@DesktopDir, "ZHPDiag (?).exe", "^ZHPDiag \([0-9]\).exe$", $desciptionPattern)
	$return += RemoveGlobFile(@DesktopDir, "ZHPDiag3 (?).exe", "^ZHPDiag3 \([0-9]\).exe$", $desciptionPattern)

	Local Const $userDownloadFolder = @UserProfileDir & "\Downloads"
	Local Const $iFileExists = FileExists($userDownloadFolder)

	If $iFileExists Then
		$return += RemoveFile($userDownloadFolder & "\ZHPDiag.txt")
		$return += RemoveGlobFile($userDownloadFolder, "ZHPDiag?.exe", "^ZHPDiag3?.exe$", $desciptionPattern)
		$return += RemoveGlobFile($userDownloadFolder, "ZHPDiag (?).exe", "^ZHPDiag \([0-9]\).exe$", $desciptionPattern)
		$return += RemoveGlobFile($userDownloadFolder, "ZHPDiag3 (?).exe", "^ZHPDiag3 \([0-9]\).exe$", $desciptionPattern)
	EndIf

	$return += RemoveFolder(@AppDataDir & "\ZHP")
	$return += RemoveFolder(@LocalAppDataDir & "\ZHP")

	Local Const $localUsers = _GetLocalUsers()

	If $localUsers <> 0 Then
		For $i = 1 To UBound($localUsers) - 1
			Local $uDesktop = TryResolveUserDesktop($localUsers[$i])
			$return += RemoveFile($uDesktop & "\ZHPDiag.lnk")
		Next
	EndIf

	$return += RemoveSoftwareKey("ZHP")

	If $return > 0 Then
		If Not $KPDebug Then logMessage(@CRLF & "- Search ZHPDiag Files -" & @CRLF)
		Local $errors = ""

		If FileExists(@AppDataDir & "\ZHP") Then
			$errors += " [X] The folder " & @AppDataDir & "\ZHP still exists" & @CRLF
		EndIf

		If FileExists(@LocalAppDataDir & "\ZHP") Then
			$errors += " [X] The folder " & @LocalAppDataDir & "\ZHP still exists" & @CRLF
		EndIf

		If $errors <> "" Then
			logMessage($errors)
		Else
			logMessage("  [OK] ZHPDiag has been successfully removed")
		EndIf

	EndIf

	ProgressBarUpdate()
EndFunc   ;==>RemoveZHPDiag
