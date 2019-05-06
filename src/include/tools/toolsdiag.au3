
Func LoadToolsDiag()
	Local Const $ToolExistCpt = "ToolsDiag"
	Dim $KPRemoveProcessList
	Dim $KPRemoveDesktopList
	Dim $KPRemoveDownloadList
	Dim $KPRemoveHomeDriveList

	Local Const $reg1 = "(?i)^toolsdiag.*\.exe$"
	Local Const $reg2 = "(?i)^ToolsDiag$"

	Local Const $arr1[1][5] = [[$ToolExistCpt, 'folder', Null, $reg2, False]]
	Local Const $arr2[1][5] = [[$ToolExistCpt, 'file', Null, $reg1, False]]
	Local Const $arr3[1][3] = [[$ToolExistCpt, $reg1, False]]

	_ArrayAdd($KPRemoveProcessList, $arr3)
	_ArrayAdd($KPRemoveDesktopList, $arr2)
	_ArrayAdd($KPRemoveDownloadList, $arr2)
	_ArrayAdd($KPRemoveHomeDriveList, $arr1)

EndFunc   ;==>LoadToolsDiag

LoadToolsDiag()
