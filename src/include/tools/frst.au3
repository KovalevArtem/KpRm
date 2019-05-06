
Func LoadFRST()
	Local Const $ToolExistCpt = "frst"
	Dim $KPRemoveProcessList
	Dim $KPRemoveDesktopList
	Dim $KPRemoveDesktopFolderList
	Dim $KPRemoveDownloadList
	Dim $KPRemoveDownloadFolderList
	Dim $KPRemoveHomeDriveList

	Local Const $descriptionPattern = "(?i)^Farbar"
	Local Const $reg1 = "(?i)^FRST.*\.exe$"
	Local Const $reg2 = "(?i)^FRST-OlderVersion$"
	Local Const $reg3 = "(?i)^(FRST|fixlist|fixlog|Addition|Shortcut).*\.(exe|txt)$"
	Local Const $reg4 = "(?i)^FRST"

	Local Const $arr1[1][3] = [[$ToolExistCpt, $reg1, False]]
	Local Const $arr2[1][5] = [[$ToolExistCpt, 'file', $descriptionPattern, $reg3, False]]
	Local Const $arr3[1][5] = [[$ToolExistCpt, 'folder', Null, $reg2, False]]
	Local Const $arr4[1][5] = [[$ToolExistCpt, 'folder', Null, $reg4, True]]

	_ArrayAdd($KPRemoveProcessList, $arr1)
	_ArrayAdd($KPRemoveDesktopList, $arr2)
	_ArrayAdd($KPRemoveDownloadList, $arr2)
	_ArrayAdd($KPRemoveDesktopList, $arr3)
	_ArrayAdd($KPRemoveDownloadList, $arr3)
	_ArrayAdd($KPRemoveHomeDriveList, $arr4)

EndFunc   ;==>LoadFRST

LoadFRST()
