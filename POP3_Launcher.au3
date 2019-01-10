#NoTrayIcon
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=icon.ico
#AutoIt3Wrapper_Outfile=POP3_Launcher.exe
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_UPX_Parameters=-9 --strip-relocs=0 --compress-exports=0 --compress-icons=0
#AutoIt3Wrapper_Res_Description=Prince of Persia T2T Launcher
#AutoIt3Wrapper_Res_Fileversion=1.0.0.47
#AutoIt3Wrapper_Res_ProductVersion=1.0.0.47
#AutoIt3Wrapper_Res_LegalCopyright=2014, SalFisher47
#AutoIt3Wrapper_Res_requestedExecutionLevel=asInvoker
#AutoIt3Wrapper_Res_SaveSource=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#Region ;**** Pragma Compile ****
#pragma compile(AutoItExecuteAllowed, true)
#pragma compile(Compression, 9)
#pragma compile(Compatibility, vista, win7, win8, win81, win10)
#pragma compile(InputBoxRes, true)
#pragma compile(CompanyName, 'SalFisher47')
#pragma compile(FileDescription, 'Prince of Persia T2T Launcher')
#pragma compile(FileVersion, 1.0.0.47)
#pragma compile(InternalName, 'Prince of Persia T2T Launcher')
#pragma compile(LegalCopyright, '2014, SalFisher47')
#pragma compile(OriginalFilename, POP3_Launcher.exe)
#pragma compile(ProductName, 'Prince of Persia T2T Launcher')
#pragma compile(ProductVersion, 1.0.0.47)
#EndRegion ;**** Pragma Compile ****
; === UniCrack Installer.au3 =======================================================================================================
; Title .........: Prince of Persia T2T Launcher
; Version .......: 1.0.0.47
; AutoIt Version : 3.3.14.5
; Language ......: English
; Description ...: Prince of Persia T2T Widescreen Launcher
;				   - based on UniWS
; Author(s) .....: SalFisher47
; Last Compiled .: January 01, 2019
; ==================================================================================================================================
#include <array.au3>
#include <file.au3>

If Not FileExists(@AppDataCommonDir & "\SalFisher47\7za") Then DirCreate(@AppDataCommonDir & "\SalFisher47\7za")
FileInstall("WidescreenLauncher\RequiredSoftware\7za.exe", @AppDataCommonDir & "\SalFisher47\7za\7za.exe", 0)
FileInstall("WidescreenLauncher\RequiredSoftware\7-Zip.chm", @AppDataCommonDir & "\SalFisher47\7za\7-Zip.chm", 0)
FileInstall("WidescreenLauncher\RequiredSoftware\License.txt", @AppDataCommonDir & "\SalFisher47\7za\License.txt", 0)
FileInstall("WidescreenLauncher\RequiredSoftware\Readme.txt", @AppDataCommonDir & "\SalFisher47\7za\Readme.txt", 0)

;If Not FileExists(@AppDataCommonDir & "\SalFisher47\xd3") Then DirCreate(@AppDataCommonDir & "\SalFisher47\xd3")
;FileInstall("WidescreenLauncher\RequiredSoftware\xd3.exe", @AppDataCommonDir & "\SalFisher47\xd3\xd3.exe", 0)

If Not FileExists(@AppDataCommonDir & "\SalFisher47\RunFirst") Then DirCreate(@AppDataCommonDir & "\SalFisher47\RunFirst")
FileInstall("RunFirst\RunFirst.exe", @AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", 0)
FileInstall("RunFirst\RunFirst.txt", @AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.txt", 0)

If Not StringInStr(RegRead("HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers", @AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe"), "RUNASADMIN") Then
	RegWrite("HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers", @AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", "REG_SZ", "RUNASADMIN")
EndIf

$exe32bit = @ScriptDir & "\PrinceOfPersia.exe"
If Not StringInStr(RegRead("HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers", $exe32bit), "RUNASADMIN") Then
	RegWrite("HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers", $exe32bit, "REG_SZ", "RUNASADMIN")
EndIf

$widescreen_fix_ini = @ScriptDir & "\POP3_Launcher.ini"
FileInstall("POP3_Launcher.ini", $widescreen_fix_ini, 0)
$iniResX = IniRead($widescreen_fix_ini, "MAIN", "X", 0)
$iniResY = IniRead($widescreen_fix_ini, "MAIN", "Y", 0)
If ($iniResX == 0) And ($iniResY == 0) Then
	$iniResX = @DesktopWidth
	$iniResY = @DesktopHeight
ElseIf ($iniResX == 0) Or ($iniResY == 0) Then
	IniWrite($widescreen_fix_ini, "MAIN", "X", " 0")
	IniWrite($widescreen_fix_ini, "MAIN", "Y", " 0")
	$iniResX = @DesktopWidth
	$iniResY = @DesktopHeight
EndIf
$desktopX = $iniResX
$desktopY = $iniResY
$desktopRatio = Round($desktopX/$desktopY, 2)
$supported_res = 0
$HUD_Fix_CanStretchRect = IniRead($widescreen_fix_ini, "GAME", "CanStretchRect", 0)
$Fog_Fix_ForceVSFog = IniRead($widescreen_fix_ini, "GAME", "ForceVSFog", 1)
$Fog_Fix_InvertFogRange = IniRead($widescreen_fix_ini, "GAME", "InvertFogRange", 0)
$RunFirst = IniRead($widescreen_fix_ini, "GAME", "RunFirst", 0)
$patched = IniRead($widescreen_fix_ini, "EXE", "patched", 0)
DirCreate(@AppDataCommonDir & "\SalFisher47\WidescreenLauncher")
FileInstall("POP3_ProgramData.ini", @AppDataCommonDir & "\SalFisher47\WidescreenLauncher\POP3.ini", 0)
$patched_ProgramData = IniRead(@AppDataCommonDir & "\SalFisher47\WidescreenLauncher\POP3.ini", "EXE", "patched", 0)
If Not FileExists($exe32bit) Then
	MsgBox(16, "Prince of Persia T2T Launcher", "Executable not found:" & @CRLF & "..\POP3.exe")
	Exit
EndIf
Local $POP3_Backup = @ScriptDir & "\WidescreenLauncher\POP3_aspect_ratio.7z"
;Local $POP3_Blank = @ScriptDir & "\WidescreenLauncher\POP3_Blank.7z"
Switch $desktopRatio
	Case 1.33   ; 4:3 aspect ratio, 1024x768
		FileInstall("POP3_Launcher.ini", $widescreen_fix_ini, 0)
		FileInstall("POP3_ProgramData.ini", @AppDataCommonDir & "\SalFisher47\WidescreenLauncher\POP3.ini", 0)
		FileInstall("Hardware.ini", @ScriptDir & "\Hardware.ini", 0)
		If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", "") <> $HUD_Fix_CanStretchRect Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", $HUD_Fix_CanStretchRect)
		If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", "") <> $Fog_Fix_ForceVSFog Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", $Fog_Fix_ForceVSFog)
		If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", "") <> $Fog_Fix_InvertFogRange Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", $Fog_Fix_InvertFogRange)

		$POP3_4_by_3_name = "POP3_1.33 (4 by 3 aspect ratio)"

		If $patched == 1 Then
			If $patched_ProgramData == 1 Then
				If $RunFirst == 1 Then
					ShellExecute(@AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", '"' & $exe32bit & '"' & " " & $CmdLineRaw, @ScriptDir, "", @SW_HIDE)
				Else
					ShellExecute($exe32bit, " " & $CmdLineRaw, @ScriptDir)
				EndIf
			Else
				$7z_unpack_line = ' x -y -o' & '"' & @TempDir & '\POP3_WidescreenLauncher' &  '"' & ' ' & '"' & $POP3_Backup & '"' & ' ' & '"' & $POP3_4_by_3_name & '\*' & '"'
				ShellExecuteWait("7za.exe", $7z_unpack_line, @AppDataCommonDir & "\SalFisher47\7za", "", @SW_HIDE)
				FileCopy(@TempDir & '\POP3_WidescreenLauncher\' & $POP3_4_by_3_name & '\POP3.exe', @ScriptDir & '\POP3.exe', 1)
				DirRemove(@TempDir & '\POP3_WidescreenLauncher', 1)

				IniWrite(@AppDataCommonDir & "\SalFisher47\WidescreenLauncher\POP3.ini", "EXE", "patched", " 1")
				IniWrite($widescreen_fix_ini, "EXE", "patched", " 1")
				FileMove(@ScriptDir & "\POP3.exe", @ScriptDir & "\POP3_.exe", 0)
				FileInstall("Blank.exe", @ScriptDir & "\POP3.exe", 0)
				ShellExecuteWait($exe32bit, " " & $CmdLineRaw, @ScriptDir)
				If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", "") <> $HUD_Fix_CanStretchRect Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", $HUD_Fix_CanStretchRect)
				If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", "") <> $Fog_Fix_ForceVSFog Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", $Fog_Fix_ForceVSFog)
				If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", "") <> $Fog_Fix_InvertFogRange Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", $Fog_Fix_InvertFogRange)
				FileMove(@ScriptDir & "\POP3_.exe", @ScriptDir & "\POP3.exe", 1)
				If $RunFirst == 1 Then
					ShellExecute(@AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", '"' & $exe32bit & '"' & " " & $CmdLineRaw, @ScriptDir, "", @SW_HIDE)
				Else
					ShellExecute($exe32bit, " " & $CmdLineRaw, @ScriptDir)
				EndIf
			EndIf
		Else
			$7z_unpack_line = ' x -y -o' & '"' & @TempDir & '\POP3_WidescreenLauncher' &  '"' & ' ' & '"' & $POP3_Backup & '"' & ' ' & '"' & $POP3_4_by_3_name & '\*' & '"'
			ShellExecuteWait("7za.exe", $7z_unpack_line, @AppDataCommonDir & "\SalFisher47\7za", "", @SW_HIDE)
			FileCopy(@TempDir & '\POP3_WidescreenLauncher\' & $POP3_4_by_3_name & '\POP3.exe', @ScriptDir & '\POP3.exe', 1)
			DirRemove(@TempDir & '\POP3_WidescreenLauncher', 1)

			IniWrite(@AppDataCommonDir & "\SalFisher47\WidescreenLauncher\POP3.ini", "EXE", "patched", " 1")
			IniWrite($widescreen_fix_ini, "EXE", "patched", " 1")
			FileMove(@ScriptDir & "\POP3.exe", @ScriptDir & "\POP3_.exe", 0)
			FileInstall("Blank.exe", @ScriptDir & "\POP3.exe", 0)
			ShellExecuteWait($exe32bit, " " & $CmdLineRaw, @ScriptDir)
			If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", "") <> $HUD_Fix_CanStretchRect Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", $HUD_Fix_CanStretchRect)
			If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", "") <> $Fog_Fix_ForceVSFog Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", $Fog_Fix_ForceVSFog)
			If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", "") <> $Fog_Fix_InvertFogRange Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", $Fog_Fix_InvertFogRange)
			FileMove(@ScriptDir & "\POP3_.exe", @ScriptDir & "\POP3.exe", 1)
			If $RunFirst == 1 Then
				ShellExecute(@AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", '"' & $exe32bit & '"' & " " & $CmdLineRaw, @ScriptDir, "", @SW_HIDE)
			Else
				ShellExecute($exe32bit, " " & $CmdLineRaw, @ScriptDir)
			EndIf
		EndIf

	Case 1.25   ; 5:4 aspect ratio, 1280x1024
		FileInstall("POP3_Launcher.ini", $widescreen_fix_ini, 0)
		FileInstall("POP3_ProgramData.ini", @AppDataCommonDir & "\SalFisher47\WidescreenLauncher\POP3.ini", 0)
		FileInstall("Hardware.ini", @ScriptDir & "\Hardware.ini", 0)
		If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", "") <> $HUD_Fix_CanStretchRect Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", $HUD_Fix_CanStretchRect)
		If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", "") <> $Fog_Fix_ForceVSFog Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", $Fog_Fix_ForceVSFog)
		If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", "") <> $Fog_Fix_InvertFogRange Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", $Fog_Fix_InvertFogRange)

		$POP3_5_by_4_name = "POP3_1.25 (5 by 4 aspect ratio)"

		If $patched == 1 Then
			If $patched_ProgramData == 1 Then
				If $RunFirst == 1 Then
					ShellExecute(@AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", '"' & $exe32bit & '"' & " " & $CmdLineRaw, @ScriptDir, "", @SW_HIDE)
				Else
					ShellExecute($exe32bit, " " & $CmdLineRaw, @ScriptDir)
				EndIf
			Else
				$7z_unpack_line = ' x -y -o' & '"' & @TempDir & '\POP3_WidescreenLauncher' &  '"' & ' ' & '"' & $POP3_Backup & '"' & ' ' & '"' & $POP3_5_by_4_name & '\*' & '"'
				ShellExecuteWait("7za.exe", $7z_unpack_line, @AppDataCommonDir & "\SalFisher47\7za", "", @SW_HIDE)
				FileCopy(@TempDir & '\POP3_WidescreenLauncher\' & $POP3_5_by_4_name & '\POP3.exe', @ScriptDir & '\POP3.exe', 1)
				DirRemove(@TempDir & '\POP3_WidescreenLauncher', 1)

				IniWrite(@AppDataCommonDir & "\SalFisher47\WidescreenLauncher\POP3.ini", "EXE", "patched", " 1")
				IniWrite($widescreen_fix_ini, "EXE", "patched", " 1")
				FileMove(@ScriptDir & "\POP3.exe", @ScriptDir & "\POP3_.exe", 0)
				FileInstall("Blank.exe", @ScriptDir & "\POP3.exe", 0)
				ShellExecuteWait($exe32bit, " " & $CmdLineRaw, @ScriptDir)
				If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", "") <> $HUD_Fix_CanStretchRect Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", $HUD_Fix_CanStretchRect)
				If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", "") <> $Fog_Fix_ForceVSFog Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", $Fog_Fix_ForceVSFog)
				If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", "") <> $Fog_Fix_InvertFogRange Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", $Fog_Fix_InvertFogRange)
				FileMove(@ScriptDir & "\POP3_.exe", @ScriptDir & "\POP3.exe", 1)
				If $RunFirst == 1 Then
					ShellExecute(@AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", '"' & $exe32bit & '"' & " " & $CmdLineRaw, @ScriptDir, "", @SW_HIDE)
				Else
					ShellExecute($exe32bit, " " & $CmdLineRaw, @ScriptDir)
				EndIf
			EndIf
		Else
			$7z_unpack_line = ' x -y -o' & '"' & @TempDir & '\POP3_WidescreenLauncher' &  '"' & ' ' & '"' & $POP3_Backup & '"' & ' ' & '"' & $POP3_5_by_4_name & '\*' & '"'
			ShellExecuteWait("7za.exe", $7z_unpack_line, @AppDataCommonDir & "\SalFisher47\7za", "", @SW_HIDE)
			FileCopy(@TempDir & '\POP3_WidescreenLauncher\' & $POP3_5_by_4_name & '\POP3.exe', @ScriptDir & '\POP3.exe', 1)
			DirRemove(@TempDir & '\POP3_WidescreenLauncher', 1)

			IniWrite(@AppDataCommonDir & "\SalFisher47\WidescreenLauncher\POP3.ini", "EXE", "patched", " 1")
			IniWrite($widescreen_fix_ini, "EXE", "patched", " 1")
			FileMove(@ScriptDir & "\POP3.exe", @ScriptDir & "\POP3_.exe", 0)
			FileInstall("Blank.exe", @ScriptDir & "\POP3.exe", 0)
			ShellExecuteWait($exe32bit, " " & $CmdLineRaw, @ScriptDir)
			If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", "") <> $HUD_Fix_CanStretchRect Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", $HUD_Fix_CanStretchRect)
			If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", "") <> $Fog_Fix_ForceVSFog Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", $Fog_Fix_ForceVSFog)
			If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", "") <> $Fog_Fix_InvertFogRange Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", $Fog_Fix_InvertFogRange)
			FileMove(@ScriptDir & "\POP3_.exe", @ScriptDir & "\POP3.exe", 1)
			If $RunFirst == 1 Then
				ShellExecute(@AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", '"' & $exe32bit & '"' & " " & $CmdLineRaw, @ScriptDir, "", @SW_HIDE)
			Else
				ShellExecute($exe32bit, " " & $CmdLineRaw, @ScriptDir)
			EndIf
		EndIf

	Case 1.77   ; 16:9 aspect ratio, 1360x768
		FileInstall("POP3_Launcher.ini", $widescreen_fix_ini, 0)
		FileInstall("POP3_ProgramData.ini", @AppDataCommonDir & "\SalFisher47\WidescreenLauncher\POP3.ini", 0)
		FileInstall("Hardware.ini", @ScriptDir & "\Hardware.ini", 0)
		If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", "") <> $HUD_Fix_CanStretchRect Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", $HUD_Fix_CanStretchRect)
		If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", "") <> $Fog_Fix_ForceVSFog Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", $Fog_Fix_ForceVSFog)
		If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", "") <> $Fog_Fix_InvertFogRange Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", $Fog_Fix_InvertFogRange)

		$POP3_16_by_9_name = "POP3_1.77 (16 by 9 aspect ratio)"

		If $patched == 1 Then
			If $patched_ProgramData == 1 Then
				If $RunFirst == 1 Then
					ShellExecute(@AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", '"' & $exe32bit & '"' & " " & $CmdLineRaw, @ScriptDir, "", @SW_HIDE)
				Else
					ShellExecute($exe32bit, " " & $CmdLineRaw, @ScriptDir)
				EndIf
			Else
				$7z_unpack_line = ' x -y -o' & '"' & @TempDir & '\POP3_WidescreenLauncher' &  '"' & ' ' & '"' & $POP3_Backup & '"' & ' ' & '"' & $POP3_16_by_9_name & '\*' & '"'
				ShellExecuteWait("7za.exe", $7z_unpack_line, @AppDataCommonDir & "\SalFisher47\7za", "", @SW_HIDE)
				FileCopy(@TempDir & '\POP3_WidescreenLauncher\' & $POP3_16_by_9_name & '\POP3.exe', @ScriptDir & '\POP3.exe', 1)
				DirRemove(@TempDir & '\POP3_WidescreenLauncher', 1)

				IniWrite(@AppDataCommonDir & "\SalFisher47\WidescreenLauncher\POP3.ini", "EXE", "patched", " 1")
				IniWrite($widescreen_fix_ini, "EXE", "patched", " 1")
				FileMove(@ScriptDir & "\POP3.exe", @ScriptDir & "\POP3_.exe", 0)
				FileInstall("Blank.exe", @ScriptDir & "\POP3.exe", 0)
				ShellExecuteWait($exe32bit, " " & $CmdLineRaw, @ScriptDir)
				If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", "") <> $HUD_Fix_CanStretchRect Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", $HUD_Fix_CanStretchRect)
				If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", "") <> $Fog_Fix_ForceVSFog Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", $Fog_Fix_ForceVSFog)
				If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", "") <> $Fog_Fix_InvertFogRange Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", $Fog_Fix_InvertFogRange)
				FileMove(@ScriptDir & "\POP3_.exe", @ScriptDir & "\POP3.exe", 1)
				If $RunFirst == 1 Then
					ShellExecute(@AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", '"' & $exe32bit & '"' & " " & $CmdLineRaw, @ScriptDir, "", @SW_HIDE)
				Else
					ShellExecute($exe32bit, " " & $CmdLineRaw, @ScriptDir)
				EndIf
			EndIf
		Else
			$7z_unpack_line = ' x -y -o' & '"' & @TempDir & '\POP3_WidescreenLauncher' &  '"' & ' ' & '"' & $POP3_Backup & '"' & ' ' & '"' & $POP3_16_by_9_name & '\*' & '"'
			ShellExecuteWait("7za.exe", $7z_unpack_line, @AppDataCommonDir & "\SalFisher47\7za", "", @SW_HIDE)
			FileCopy(@TempDir & '\POP3_WidescreenLauncher\' & $POP3_16_by_9_name & '\POP3.exe', @ScriptDir & '\POP3.exe', 1)
			DirRemove(@TempDir & '\POP3_WidescreenLauncher', 1)

			IniWrite(@AppDataCommonDir & "\SalFisher47\WidescreenLauncher\POP3.ini", "EXE", "patched", " 1")
			IniWrite($widescreen_fix_ini, "EXE", "patched", " 1")
			FileMove(@ScriptDir & "\POP3.exe", @ScriptDir & "\POP3_.exe", 0)
			FileInstall("Blank.exe", @ScriptDir & "\POP3.exe", 0)
			ShellExecuteWait($exe32bit, " " & $CmdLineRaw, @ScriptDir)
			If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", "") <> $HUD_Fix_CanStretchRect Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", $HUD_Fix_CanStretchRect)
			If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", "") <> $Fog_Fix_ForceVSFog Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", $Fog_Fix_ForceVSFog)
			If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", "") <> $Fog_Fix_InvertFogRange Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", $Fog_Fix_InvertFogRange)
			FileMove(@ScriptDir & "\POP3_.exe", @ScriptDir & "\POP3.exe", 1)
			If $RunFirst == 1 Then
				ShellExecute(@AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", '"' & $exe32bit & '"' & " " & $CmdLineRaw, @ScriptDir, "", @SW_HIDE)
			Else
				ShellExecute($exe32bit, " " & $CmdLineRaw, @ScriptDir)
			EndIf
		EndIf

	Case 1.78   ; 16:9 aspect ratio, 1366x768
		FileInstall("POP3_Launcher.ini", $widescreen_fix_ini, 0)
		FileInstall("POP3_ProgramData.ini", @AppDataCommonDir & "\SalFisher47\WidescreenLauncher\POP3.ini", 0)
		FileInstall("Hardware.ini", @ScriptDir & "\Hardware.ini", 0)
		If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", "") <> $HUD_Fix_CanStretchRect Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", $HUD_Fix_CanStretchRect)
		If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", "") <> $Fog_Fix_ForceVSFog Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", $Fog_Fix_ForceVSFog)
		If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", "") <> $Fog_Fix_InvertFogRange Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", $Fog_Fix_InvertFogRange)

		$POP3_16_by_9_name = "POP3_1.78 (16 by 9 aspect ratio)"

		If $patched == 1 Then
			If $patched_ProgramData == 1 Then
				If $RunFirst == 1 Then
					ShellExecute(@AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", '"' & $exe32bit & '"' & " " & $CmdLineRaw, @ScriptDir, "", @SW_HIDE)
				Else
					ShellExecute($exe32bit, " " & $CmdLineRaw, @ScriptDir)
				EndIf
			Else
				$7z_unpack_line = ' x -y -o' & '"' & @TempDir & '\POP3_WidescreenLauncher' &  '"' & ' ' & '"' & $POP3_Backup & '"' & ' ' & '"' & $POP3_16_by_9_name & '\*' & '"'
				ShellExecuteWait("7za.exe", $7z_unpack_line, @AppDataCommonDir & "\SalFisher47\7za", "", @SW_HIDE)
				FileCopy(@TempDir & '\POP3_WidescreenLauncher\' & $POP3_16_by_9_name & '\POP3.exe', @ScriptDir & '\POP3.exe', 1)
				DirRemove(@TempDir & '\POP3_WidescreenLauncher', 1)

				IniWrite(@AppDataCommonDir & "\SalFisher47\WidescreenLauncher\POP3.ini", "EXE", "patched", " 1")
				IniWrite($widescreen_fix_ini, "EXE", "patched", " 1")
				FileMove(@ScriptDir & "\POP3.exe", @ScriptDir & "\POP3_.exe", 0)
				FileInstall("Blank.exe", @ScriptDir & "\POP3.exe", 0)
				ShellExecuteWait($exe32bit, " " & $CmdLineRaw, @ScriptDir)
				If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", "") <> $HUD_Fix_CanStretchRect Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", $HUD_Fix_CanStretchRect)
				If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", "") <> $Fog_Fix_ForceVSFog Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", $Fog_Fix_ForceVSFog)
				If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", "") <> $Fog_Fix_InvertFogRange Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", $Fog_Fix_InvertFogRange)
				FileMove(@ScriptDir & "\POP3_.exe", @ScriptDir & "\POP3.exe", 1)
				If $RunFirst == 1 Then
					ShellExecute(@AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", '"' & $exe32bit & '"' & " " & $CmdLineRaw, @ScriptDir, "", @SW_HIDE)
				Else
					ShellExecute($exe32bit, " " & $CmdLineRaw, @ScriptDir)
				EndIf
			EndIf
		Else
			$7z_unpack_line = ' x -y -o' & '"' & @TempDir & '\POP3_WidescreenLauncher' &  '"' & ' ' & '"' & $POP3_Backup & '"' & ' ' & '"' & $POP3_16_by_9_name & '\*' & '"'
			ShellExecuteWait("7za.exe", $7z_unpack_line, @AppDataCommonDir & "\SalFisher47\7za", "", @SW_HIDE)
			FileCopy(@TempDir & '\POP3_WidescreenLauncher\' & $POP3_16_by_9_name & '\POP3.exe', @ScriptDir & '\POP3.exe', 1)
			DirRemove(@TempDir & '\POP3_WidescreenLauncher', 1)

			IniWrite(@AppDataCommonDir & "\SalFisher47\WidescreenLauncher\POP3.ini", "EXE", "patched", " 1")
			IniWrite($widescreen_fix_ini, "EXE", "patched", " 1")
			FileMove(@ScriptDir & "\POP3.exe", @ScriptDir & "\POP3_.exe", 0)
			FileInstall("Blank.exe", @ScriptDir & "\POP3.exe", 0)
			ShellExecuteWait($exe32bit, " " & $CmdLineRaw, @ScriptDir)
			If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", "") <> $HUD_Fix_CanStretchRect Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", $HUD_Fix_CanStretchRect)
			If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", "") <> $Fog_Fix_ForceVSFog Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", $Fog_Fix_ForceVSFog)
			If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", "") <> $Fog_Fix_InvertFogRange Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", $Fog_Fix_InvertFogRange)
			FileMove(@ScriptDir & "\POP3_.exe", @ScriptDir & "\POP3.exe", 1)
			If $RunFirst == 1 Then
				ShellExecute(@AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", '"' & $exe32bit & '"' & " " & $CmdLineRaw, @ScriptDir, "", @SW_HIDE)
			Else
				ShellExecute($exe32bit, " " & $CmdLineRaw, @ScriptDir)
			EndIf
		EndIf

	Case 1.60   ; 16:10 aspect ratio, 1440x900
		FileInstall("POP3_Launcher.ini", $widescreen_fix_ini, 0)
		FileInstall("POP3_ProgramData.ini", @AppDataCommonDir & "\SalFisher47\WidescreenLauncher\POP3.ini", 0)
		FileInstall("Hardware.ini", @ScriptDir & "\Hardware.ini", 0)
		If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", "") <> $HUD_Fix_CanStretchRect Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", $HUD_Fix_CanStretchRect)
		If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", "") <> $Fog_Fix_ForceVSFog Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", $Fog_Fix_ForceVSFog)
		If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", "") <> $Fog_Fix_InvertFogRange Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", $Fog_Fix_InvertFogRange)

		$POP3_16_by_10_name = "POP3_1.60 (16 by 10 aspect ratio)"

		If $patched == 1 Then
			If $patched_ProgramData == 1 Then
				If $RunFirst == 1 Then
					ShellExecute(@AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", '"' & $exe32bit & '"' & " " & $CmdLineRaw, @ScriptDir, "", @SW_HIDE)
				Else
					ShellExecute($exe32bit, " " & $CmdLineRaw, @ScriptDir)
				EndIf
			Else
				$7z_unpack_line = ' x -y -o' & '"' & @TempDir & '\POP3_WidescreenLauncher' &  '"' & ' ' & '"' & $POP3_Backup & '"' & ' ' & '"' & $POP3_16_by_10_name & '\*' & '"'
				ShellExecuteWait("7za.exe", $7z_unpack_line, @AppDataCommonDir & "\SalFisher47\7za", "", @SW_HIDE)
				FileCopy(@TempDir & '\POP3_WidescreenLauncher\' & $POP3_16_by_10_name & '\POP3.exe', @ScriptDir & '\POP3.exe', 1)
				DirRemove(@TempDir & '\POP3_WidescreenLauncher', 1)

				IniWrite(@AppDataCommonDir & "\SalFisher47\WidescreenLauncher\POP3.ini", "EXE", "patched", " 1")
				IniWrite($widescreen_fix_ini, "EXE", "patched", " 1")
				FileMove(@ScriptDir & "\POP3.exe", @ScriptDir & "\POP3_.exe", 0)
				FileInstall("Blank.exe", @ScriptDir & "\POP3.exe", 0)
				ShellExecuteWait($exe32bit, " " & $CmdLineRaw, @ScriptDir)
				If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", "") <> $HUD_Fix_CanStretchRect Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", $HUD_Fix_CanStretchRect)
				If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", "") <> $Fog_Fix_ForceVSFog Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", $Fog_Fix_ForceVSFog)
				If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", "") <> $Fog_Fix_InvertFogRange Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", $Fog_Fix_InvertFogRange)
				FileMove(@ScriptDir & "\POP3_.exe", @ScriptDir & "\POP3.exe", 1)
				If $RunFirst == 1 Then
					ShellExecute(@AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", '"' & $exe32bit & '"' & " " & $CmdLineRaw, @ScriptDir, "", @SW_HIDE)
				Else
					ShellExecute($exe32bit, " " & $CmdLineRaw, @ScriptDir)
				EndIf
			EndIf
		Else
			$7z_unpack_line = ' x -y -o' & '"' & @TempDir & '\POP3_WidescreenLauncher' &  '"' & ' ' & '"' & $POP3_Backup & '"' & ' ' & '"' & $POP3_16_by_10_name & '\*' & '"'
			ShellExecuteWait("7za.exe", $7z_unpack_line, @AppDataCommonDir & "\SalFisher47\7za", "", @SW_HIDE)
			FileCopy(@TempDir & '\POP3_WidescreenLauncher\' & $POP3_16_by_10_name & '\POP3.exe', @ScriptDir & '\POP3.exe', 1)
			DirRemove(@TempDir & '\POP3_WidescreenLauncher', 1)

			IniWrite(@AppDataCommonDir & "\SalFisher47\WidescreenLauncher\POP3.ini", "EXE", "patched", " 1")
			IniWrite($widescreen_fix_ini, "EXE", "patched", " 1")
			FileMove(@ScriptDir & "\POP3.exe", @ScriptDir & "\POP3_.exe", 0)
			FileInstall("Blank.exe", @ScriptDir & "\POP3.exe", 0)
			ShellExecuteWait($exe32bit, " " & $CmdLineRaw, @ScriptDir)
			If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", "") <> $HUD_Fix_CanStretchRect Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", $HUD_Fix_CanStretchRect)
			If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", "") <> $Fog_Fix_ForceVSFog Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", $Fog_Fix_ForceVSFog)
			If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", "") <> $Fog_Fix_InvertFogRange Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", $Fog_Fix_InvertFogRange)
			FileMove(@ScriptDir & "\POP3_.exe", @ScriptDir & "\POP3.exe", 1)
			If $RunFirst == 1 Then
				ShellExecute(@AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", '"' & $exe32bit & '"' & " " & $CmdLineRaw, @ScriptDir, "", @SW_HIDE)
			Else
				ShellExecute($exe32bit, " " & $CmdLineRaw, @ScriptDir)
			EndIf
		EndIf

	Case Else   ; other aspect ratio
		FileInstall("POP3_Launcher.ini", $widescreen_fix_ini, 0)
		FileInstall("POP3_ProgramData.ini", @AppDataCommonDir & "\SalFisher47\WidescreenLauncher\POP3.ini", 0)
		FileInstall("Hardware.ini", @ScriptDir & "\Hardware.ini", 0)
		If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", "") <> $HUD_Fix_CanStretchRect Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", $HUD_Fix_CanStretchRect)
		If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", "") <> $Fog_Fix_ForceVSFog Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", $Fog_Fix_ForceVSFog)
		If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", "") <> $Fog_Fix_InvertFogRange Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", $Fog_Fix_InvertFogRange)

		If $patched_ProgramData == 1 Then
			$7z_unpack_line = ' x -y -o' & '"' & @TempDir & '\POP3_WidescreenLauncher' &  '"' & ' ' & '"' & $POP3_Backup & '"' & ' ' & '"' & "POP3_1.33 (4 by 3 aspect ratio)" & '\*' & '"'
			ShellExecuteWait("7za.exe", $7z_unpack_line, @AppDataCommonDir & "\SalFisher47\7za", "", @SW_HIDE)
			FileCopy(@TempDir & '\POP3_WidescreenLauncher\' & $POP3_16_by_10_name & '\POP3.exe', @ScriptDir & '\POP3.exe', 1)
			DirRemove(@TempDir & '\POP3_WidescreenLauncher', 1)
			If $RunFirst == 1 Then
				ShellExecute(@AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", '"' & $exe32bit & '"' & " " & $CmdLineRaw, @ScriptDir, "", @SW_HIDE)
			Else
				ShellExecute($exe32bit, " " & $CmdLineRaw, @ScriptDir)
			EndIf
		Else
			IniWrite(@AppDataCommonDir & "\SalFisher47\WidescreenLauncher\POP3.ini", "EXE", "patched", " 1")
			IniWrite($widescreen_fix_ini, "EXE", "patched", " 1")
			$7z_unpack_line = ' x -y -o' & '"' & @TempDir & '\POP3_WidescreenLauncher' &  '"' & ' ' & '"' & $POP3_Backup & '"' & ' ' & '"' & "POP3_1.33 (4 by 3 aspect ratio)" & '\*' & '"'
			ShellExecuteWait("7za.exe", $7z_unpack_line, @AppDataCommonDir & "\SalFisher47\7za", "", @SW_HIDE)
			FileCopy(@TempDir & '\POP3_WidescreenLauncher\' & $POP3_16_by_10_name & '\POP3.exe', @ScriptDir & '\POP3.exe', 1)
			DirRemove(@TempDir & '\POP3_WidescreenLauncher', 1)
			FileMove(@ScriptDir & "\POP3.exe", @ScriptDir & "\POP3_.exe", 0)
			FileInstall("Blank.exe", @ScriptDir & "\POP3.exe", 0)
			ShellExecuteWait($exe32bit, " " & $CmdLineRaw, @ScriptDir)
			If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", "") <> $HUD_Fix_CanStretchRect Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", $HUD_Fix_CanStretchRect)
			If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", "") <> $Fog_Fix_ForceVSFog Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", $Fog_Fix_ForceVSFog)
			If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", "") <> $Fog_Fix_InvertFogRange Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", $Fog_Fix_InvertFogRange)
			FileMove(@ScriptDir & "\POP3_.exe", @ScriptDir & "\POP3.exe", 1)
			If $RunFirst == 1 Then
				ShellExecute(@AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", '"' & $exe32bit & '"' & " " & $CmdLineRaw, @ScriptDir, "", @SW_HIDE)
			Else
				ShellExecute($exe32bit, " " & $CmdLineRaw, @ScriptDir)
			EndIf
		EndIf

EndSwitch
