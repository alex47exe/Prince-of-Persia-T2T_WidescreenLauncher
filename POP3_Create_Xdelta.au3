#include <array.au3>
#include <file.au3>

$POP_original = @ScriptDir
$POP_original = $POP_original & "\POP3.exe"
$Xdelta_exe = @ScriptDir & "\Xdelta\xdelta3-x86-32.exe"

$POP_4_by_3 = @ScriptDir & "\1.33 (4 by 3 aspect ratio)"
$POP_4_by_3_xdelta = $POP_4_by_3 & " xdelta"

$POP_4_by_3_array = _FileListToArray($POP_4_by_3, "*", 1)
$POP_4_by_3_array_count = UBound($POP_4_by_3_array)-1

$POP_4_by_3_txt = $POP_4_by_3_xdelta & "\1.txt"

For $i = 1 To $POP_4_by_3_array_count

	$POP_4_by_3_name = $POP_4_by_3_array[$i]
	DirCreate($POP_4_by_3_xdelta)
	RunWait($xdelta_exe & ' -e -9 -s ' & '"' & $POP_original & '"' & ' ' & '"' & $POP_4_by_3 & '\' & $POP_4_by_3_array[$i] & '"' & ' ' & '"' & $POP_4_by_3_xdelta & '\' & StringTrimRight($POP_4_by_3_array[$i], 4) & '.xd3' & '"', @ScriptDir, @SW_HIDE)
	$hFile = FileOpen($POP_4_by_3_txt, 1) ; open '.txt' in WRITE mode (append to end of file)
	FileWriteLine($POP_4_by_3_txt, StringTrimRight($POP_4_by_3_name, 4))
	FileClose($hFile)

Next

$POP_5_by_4 = @ScriptDir & "\1.25 (5 by 4 aspect ratio)"
$POP_5_by_4_xdelta = $POP_5_by_4 & " xdelta"

$POP_5_by_4_array = _FileListToArray($POP_5_by_4, "*", 1)
$POP_5_by_4_array_count = UBound($POP_5_by_4_array)-1

$POP_5_by_4_txt = $POP_5_by_4_xdelta & "\1.txt"

For $i = 1 To $POP_5_by_4_array_count

	$POP_5_by_4_name = $POP_5_by_4_array[$i]
	DirCreate($POP_5_by_4_xdelta)
	RunWait($xdelta_exe & ' -e -9 -s ' & '"' & $POP_original & '"' & ' ' & '"' & $POP_5_by_4 & '\' & $POP_5_by_4_array[$i] & '"' & ' ' & '"' & $POP_5_by_4_xdelta & '\' & StringTrimRight($POP_5_by_4_array[$i], 4) & '.xd3' & '"', @ScriptDir, @SW_HIDE)
	$hFile = FileOpen($POP_5_by_4_txt, 1) ; open '.txt' in WRITE mode (append to end of file)
	FileWriteLine($POP_5_by_4_txt, StringTrimRight($POP_5_by_4_name, 4))
	FileClose($hFile)

Next

$POP_16_by_10 = @ScriptDir & "\1.60 (16 by 10 aspect ratio)"
$POP_16_by_10_xdelta = $POP_16_by_10 & " xdelta"

$POP_16_by_10_array = _FileListToArray($POP_16_by_10, "*", 1)
$POP_16_by_10_array_count = UBound($POP_16_by_10_array)-1

$POP_16_by_10_txt = $POP_16_by_10_xdelta & "\1.txt"

For $i = 1 To $POP_16_by_10_array_count

	$POP_16_by_10_name = $POP_16_by_10_array[$i]
	DirCreate($POP_16_by_10_xdelta)
	RunWait($xdelta_exe & ' -e -9 -s ' & '"' & $POP_original & '"' & ' ' & '"' & $POP_16_by_10 & '\' & $POP_16_by_10_array[$i] & '"' & ' ' & '"' & $POP_16_by_10_xdelta & '\' & StringTrimRight($POP_16_by_10_array[$i], 4) & '.xd3' & '"', @ScriptDir, @SW_HIDE)
	$hFile = FileOpen($POP_16_by_10_txt, 1) ; open '.txt' in WRITE mode (append to end of file)
	FileWriteLine($POP_16_by_10_txt, StringTrimRight($POP_16_by_10_name, 4))
	FileClose($hFile)

Next

$POP_16_by_9_a = @ScriptDir & "\1.77 (16 by 9 aspect ratio)"
$POP_16_by_9_a_xdelta = $POP_16_by_9_a & " xdelta"

$POP_16_by_9_a_array = _FileListToArray($POP_16_by_9_a, "*", 1)
$POP_16_by_9_a_array_count = UBound($POP_16_by_9_a_array)-1

$POP_16_by_9_a_txt = $POP_16_by_9_a_xdelta & "\1.txt"

For $i = 1 To $POP_16_by_9_a_array_count

	$POP_16_by_9_a_name = $POP_16_by_9_a_array[$i]
	DirCreate($POP_16_by_9_a_xdelta)
	RunWait($xdelta_exe & ' -e -9 -s ' & '"' & $POP_original & '"' & ' ' & '"' & $POP_16_by_9_a & '\' & $POP_16_by_9_a_array[$i] & '"' & ' ' & '"' & $POP_16_by_9_a_xdelta & '\' & StringTrimRight($POP_16_by_9_a_array[$i], 4) & '.xd3' & '"', @ScriptDir, @SW_HIDE)
	$hFile = FileOpen($POP_16_by_9_a_txt, 1) ; open '.txt' in WRITE mode (append to end of file)
	FileWriteLine($POP_16_by_9_a_txt, StringTrimRight($POP_16_by_9_a_name, 4))
	FileClose($hFile)

Next

$POP_16_by_9_b = @ScriptDir & "\1.78 (16 by 9 aspect ratio)"
$POP_16_by_9_b_xdelta = $POP_16_by_9_b & " xdelta"

$POP_16_by_9_b_array = _FileListToArray($POP_16_by_9_b, "*", 1)
$POP_16_by_9_b_array_count = UBound($POP_16_by_9_b_array)-1

$POP_16_by_9_b_txt = $POP_16_by_9_b_xdelta & "\1.txt"

For $i = 1 To $POP_16_by_9_b_array_count

	$POP_16_by_9_b_name = $POP_16_by_9_b_array[$i]
	DirCreate($POP_16_by_9_b_xdelta)
	RunWait($xdelta_exe & ' -e -9 -s ' & '"' & $POP_original & '"' & ' ' & '"' & $POP_16_by_9_b & '\' & $POP_16_by_9_b_array[$i] & '"' & ' ' & '"' & $POP_16_by_9_b_xdelta & '\' & StringTrimRight($POP_16_by_9_b_array[$i], 4) & '.xd3' & '"', @ScriptDir, @SW_HIDE)
	$hFile = FileOpen($POP_16_by_9_b_txt, 1) ; open '.txt' in WRITE mode (append to end of file)
	FileWriteLine($POP_16_by_9_b_txt, StringTrimRight($POP_16_by_9_b_name, 4))
	FileClose($hFile)

Next

MsgBox(64, "POP", "Finished")
