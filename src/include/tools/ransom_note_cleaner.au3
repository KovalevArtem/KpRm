

Func LoadRansomNoteCleaner()

	Local Const $sToolExistCpt = "RansomNoteCleaner"

	Dim $aKPRemoveProcessList
	Dim $aKPRemoveDesktopList
	Dim $aKPRemoveDownloadList

	Local Const $sReg1 = "(?i)^RansomNoteCleaner.*\.exe$"
	Local Const $sReg2 = "(?i)^RansomNoteCleaner.*\.(log|exe|zip)$"
	Local Const $sReg3 = "(?i)^RansomNoteCleaner$"

	Local Const $aArr1[1][3] = [[$sToolExistCpt, $sReg1, False]]
	Local Const $aArr2[1][5] = [[$sToolExistCpt, 'file', Null, $sReg2, False]]
	Local Const $aArr3[1][5] = [[$sToolExistCpt, 'folder', Null, $sReg3, False]]

	_ArrayAdd($aKPRemoveProcessList, $aArr1)
	_ArrayAdd($aKPRemoveDesktopList, $aArr2)
	_ArrayAdd($aKPRemoveDesktopList, $aArr3)
	_ArrayAdd($aKPRemoveDownloadList, $aArr2)
	_ArrayAdd($aKPRemoveDownloadList, $aArr3)
EndFunc   ;==>LoadRansomNoteCleaner

LoadRansomNoteCleaner()
