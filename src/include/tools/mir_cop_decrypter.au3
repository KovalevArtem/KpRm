

Func LoadMirCopDecrypter()
	Dim $aKPRemoveProcessList
	Dim $aKPRemoveDesktopList
	Dim $aKPRemoveDownloadList

	Local Const $sToolName = "MirCopDecrypter"

	Local Const $sReg1 = "(?i)^MirCopDecrypter.*\.exe$"
	Local Const $sReg2 = "(?i)^MirCopDecrypter.*\.(exe|zip|txt)$"
	Local Const $sReg3 = "(?i)^MirCopDecrypter$"

	Local Const $aArr1[1][3] = [[$sToolName, $sReg1, False]]
	Local Const $aArr2[1][5] = [[$sToolName, 'file', Null, $sReg2, False]]
	Local Const $aArr3[1][5] = [[$sToolName, 'folder', Null, $sReg3, False]]

	_ArrayAdd($aKPRemoveProcessList, $aArr1)
	_ArrayAdd($aKPRemoveDesktopList, $aArr2)
	_ArrayAdd($aKPRemoveDesktopList, $aArr3)
	_ArrayAdd($aKPRemoveDownloadList, $aArr2)
	_ArrayAdd($aKPRemoveDownloadList, $aArr3)

EndFunc   ;==>LoadMirCopDecrypter

LoadMirCopDecrypter()
