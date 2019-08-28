#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;; Emacs 向け設定
#IfWinActive ahk_class Emacs || ahk_class X410_XAppWin
LWin::LAlt

;; LAlt Key を Superキーとして扱う
LAlt::
SendInput ^x@s
KeyWait, LAlt
Return
;; 押しっぱなしのときに連続入力しない
LAlt Up::Return
;; LAlt+Tab は Windows の機能を呼び出す
Tab::!Tab
Return

#IfWinActive
