; ER QuickSave HK – Version 1.0.0.1
; Author: mdotstrange (Nexusmods)
; Description:
;   F5 – Create timestamped backup + PreDeath save (with retry + logging)
;   F9 – Restore PreDeath save immediately, close game + relaunch via Steam
;@Ahk2Exe-SetVersion 1.0.0.1
;@Ahk2Exe-SetProductName ER QuickSave HK
;@Ahk2Exe-SetCompanyName mdotstrange
;@Ahk2Exe-SetDescription Save backup utility for Elden Ring (offline only)
;@Ahk2Exe-SetCompression 0

#NoEnv
#SingleInstance, Force
SendMode Input
SetWorkingDir %A_ScriptDir%
SetTitleMatchMode, 2
SetBatchLines, -1

; --- Config ---
backupDir := A_ScriptDir . "\EldenRingBackups"
gameProcess := "eldenring.exe"
steamLaunch := "steam://rungameid/1245620"
launchDelay := 2000

; Auto-detect save path
Loop, %A_AppData%\EldenRing\*.*, 2
{
    savePath := A_AppData . "\EldenRing\" . A_LoopFileName . "\ER0000.sl2"
    break
}

; Fallback in case savePath detection fails
if !FileExist(savePath) {
    MsgBox, 16, Save File Not Found, No Elden Ring save file detected.`nPlease verify your Steam ID folder.
    ExitApp
}

; --- TrayTip: Confirm script startup ---
TrayTip, ER QuickSave HK v1.0, Script is active. Ready for F5 and F9., 3

; --- F5: Create Backup ---
F5::
    if !FileExist(savePath) {
        MsgBox, 16, Save File Not Found, Could not locate Elden Ring save file.`nPlease verify your Steam ID folder.
        return
    }

    FileCreateDir, %backupDir%
    FormatTime, timestamp,, yyyy-MM-dd_HH-mm-ss
    backupFile := backupDir . "\ER_Save_" . timestamp . ".sl2"
    preDeathFile := backupDir . "\ER_Save_PreDeath.sl2"

    ; Retry stability check
    attempts := 0
    Loop {
        FileGetSize, size1, %savePath%
        Sleep, 300
        FileGetSize, size2, %savePath%
        attempts++
        if (size1 = size2 || attempts >= 5)
            break
    }

    if (size1 != size2) {
        TrayTip, Backup Skipped, Save file kept changing., 3
        SoundBeep, 500, 200
        FileAppend, [%A_Now%] Backup skipped after %attempts% retries.`n, %backupDir%\backup_log.txt
        return
    }

    ; Copy both save files
    FileCopy, %savePath%, %backupFile%
    FileCopy, %savePath%, %preDeathFile%, 1

    if FileExist(backupFile) and FileExist(preDeathFile) {
        ; Cleanup old backups
        Loop, %backupDir%\ER_Save_*.sl2
            allFiles := ""
        Loop, %backupDir%\ER_Save_*.sl2
            allFiles .= A_LoopFileFullPath "`n"
        Sort, allFiles, D R
        saves := StrSplit(allFiles, "`n")
        Loop, % saves.Length()
        {
            if (A_Index > 1 && InStr(saves[A_Index], "PreDeath") = 0)
                FileDelete, % saves[A_Index]
        }

        TrayTip, Backup Created, Save stored successfully., 3
        SoundBeep, 750, 150
        FileAppend, [%A_Now%] Backup created: %backupFile% + PreDeath saved.`n, %backupDir%\backup_log.txt
    } else {
        TrayTip, Backup Failed, File copy failed., 3
        SoundBeep, 400, 300
        FileAppend, [%A_Now%] Backup failed: copy error.`n, %backupDir%\backup_log.txt
    }
return

; --- F9: Restore + Relaunch ---
F9::
    if !FileExist(preDeathFile) {
        MsgBox, 48, Restore Failed, PreDeath save not found.`nUse F5 before dying.
        TrayTip, Restore Failed, PreDeath file not found., 3
        SoundBeep, 400, 300
        FileAppend, [%A_Now%] Restore failed: PreDeath missing.`n, %backupDir%\backup_log.txt
        return
    }

    ; Kill game if running
    Process, Exist, %gameProcess%
    if (ErrorLevel) {
        Process, Close, %gameProcess%
        TrayTip, Game Closed, Preparing restore..., 3
        Sleep, 1000
    }

    ; Restore save
    FileCopy, %preDeathFile%, %savePath%, 1
    if FileExist(savePath) {
        TrayTip, Restore Done, Save restored successfully., 3
        SoundBeep, 800, 150
        FileAppend, [%A_Now%] Restore complete: PreDeath injected.`n, %backupDir%\backup_log.txt
    } else {
        TrayTip, Restore Failed, Could not overwrite save., 3
        SoundBeep, 400, 300
        FileAppend, [%A_Now%] Restore failed: overwrite error.`n, %backupDir%\backup_log.txt
        return
    }

    Sleep, %launchDelay%
    Run, %steamLaunch%
    FileAppend, [%A_Now%] Game relaunched via Steam URI.`n, %backupDir%\backup_log.txt
