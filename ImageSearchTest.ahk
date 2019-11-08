; This script was created using Pulover's Macro Creator
; www.macrocreator.com

#NoEnv
SetWorkingDir %A_ScriptDir%
CoordMode, Mouse, Window
SendMode Input
#SingleInstance Force
SetTitleMatchMode 2
#WinActivateForce
SetControlDelay 1
SetWinDelay 0
SetKeyDelay -1
SetMouseDelay -1
SetBatchLines -1


^!s::
Loop {
    CoordMode, Pixel, Window

    ImageSearch, FoundX, FoundY, 102, 95, 1800, 367, *2 C:\Users\EthanXPS\Desktop\SCBuild Macros\ImageAssets\CameraBlue.png
    ImageSearch, FoundX, FoundY, 102, 95, 1800, 367, *2 C:\Users\EthanXPS\Desktop\SCBuild Macros\ImageAssets\GrateBlue.png
    ImageSearch, FoundX, FoundY, 102, 95, 1800, 367, *2 C:\Users\EthanXPS\Desktop\SCBuild Macros\ImageAssets\LockBlue.png

    If ErrorLevel = 0
    	SoundPlay, C:\Users\EthanXPS\Desktop\SCBuild Macros\SoundAssets\found.wav
    	Click, %FoundX%, %FoundY% Left, 1
    	Sleep 5000
    	Loop, 5{
    		CoordMode, Pixel, Window

		    ImageSearch, FoundX, FoundY, 102, 95, 1800, 367, *2 C:\Users\EthanXPS\Desktop\SCBuild Macros\ImageAssets\CameraTan.png
		    ImageSearch, FoundX, FoundY, 102, 95, 1800, 367, *2 C:\Users\EthanXPS\Desktop\SCBuild Macros\ImageAssets\GrateBlue.png
		    ImageSearch, FoundX, FoundY, 102, 95, 1800, 367, *2 C:\Users\EthanXPS\Desktop\SCBuild Macros\ImageAssets\LockBlue.png

        	If ErrorLevel = 0 
        		SoundPlay, C:\Users\EthanXPS\Desktop\SCBuild Macros\SoundAssets\chaching.wav
        		Click, %FoundX%, %FoundY% Left, 1
        	
        	Sleep 1000   
    	}

    	If ErrorLevel 
    		Soundplay, C:\Users\EthanXPS\Desktop\SCBuild Macros\SoundAssets\gameOver.wav

        Sleep 1000

    Sleep 1000
Return
Esc:: ExitApp