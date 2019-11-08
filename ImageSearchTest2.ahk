;TODO// Change to all relative so windows can be resized
;       - Note that ImageSearch will need to be altered as well

SetWorkingDir %A_ScriptDir%
CoordMode, Pixel, Screen
CoordMode, ToolTip, Screen
CoordMode, Mouse, Screen
SendMode Input
#SingleInstance Force
SetControlDelay 1
SetWinDelay 0
SetKeyDelay -1
SetMouseDelay -1
SetBatchLines -1
KeyWait, Control

windowList := ["BlueStacks", "Hammertown (Hammers)", "Shove It"]

minX = 0
maxX = 1919
midX = 960
minY = 0
minY = 530
minY = 1079


^!s::
BlockInput, Mouse
BlockInput, MouseMove
;Activate the necessary windows
For key, val in % WindowList {
    If WinExist(val) {
            WinActivate, %val%
    }
}
toggleCoordMode(1) ;Coordmode to Screen
checkRefresh()
var = 0
maxImages = 10
Loop { ; Loop until user escapes using ESC key

    ; For each image in the image file

    Loop, %maxImages% {
        var += 1

        ; Search for the current image on each open emulator window
        ; This greatly improves efficiency and speed over searching the entire screen

        For key, val in % windowList {
            if WinExist(val) {
                WinActivate, %val%

                ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *100 C:\Users\EthanXPS\Desktop\SCBuild dMacros\ImageAssets\storage2x2\image%var%.jpg

                If (ErrorLevel = 0) {
                    MsgBox, Found image
                    SoundPlay, C:\Users\EthanXPS\Desktop\SCBuild Macros\SoundAssets\found.wav
                    Click, %FoundX%, %FoundY%
                    ToolTip, Found one! It's image%var%.jpg, 0, 25
                    ErrorLevel := -1
                    FoundX := ""
                    FoundY := ""
                    WinGetTitle, curWinTitle
                    SearchAndPurchase(%curWinTitle%)

                }

                Else If (ErrorLevel) {
                    ToolTip, image%var%.jpg, 0, 25
                    ToolTip, %val%, 0, 50
                } 
            }
        }

        If var >= %maxImages%
            var = 0

        CheckRefresh()
    }


}

Return

SearchAndPurchase(curWinTitle){
    toggleCoordMode(2) ;set to relative to window
    WaitForLoadingScreen(%curWinTitle%)
    var = 0 
    Loop, 5 {
        var += 1
        ;TODO: Refine to found window only rather than full screen for better results
        ImageSearch, FoundXX, FoundYY, 146, 148, 745, 472, *100 C:\Users\EthanXPS\Desktop\SCBuild Macros\ImageAssets\storage2x2\storage2x2Store\image%var%.jpg

        If (ErrorLevel = 0) {
            Click, %FoundXX%, %FoundYY%
            WasPurchaseSuccessful(%FoundXX%, %FoundYY%)            
            SoundPlay, C:\Users\EthanXPS\Desktop\SCBuild Macros\SoundAssets\chaching.wav

            ToolTip, $$$ image%var%.jpg $$$, %FoundX% + 10, %FoundY% + 10
            Sleep 50
            Click, %FoundXX%, %FoundYY%
            FoundX := ""
            FoundY := ""
        }
        If (ErrorLevel) 
            ToolTip, Couldn't purchase... 0, 75
        If (var >= 10) 
            var = 0
    }

}

HomewardBound(curWinTitle, windowList) {
    WinActivate, %curWinTitle%
    toggleCoordMode(2) ;relative
    var = 0
    ErrorLevel = 1
    while (ErrorLevel != 0) {
        ImageSearch, FoundX, FoundY, %X1%, %Y1%, %X2%, %Y2%, *50 C:\Users\EthanXPS\Desktop\SCBuild Macros\ImageAssets\homeBadge%var%.jpg
        If (ErrorLevel != 0) {
            Click %posX%, %posY%
            Sleep 5000
        }
    }
    Sleep 10000
    Click %posX%, (%posY% + 220) 
}

checkRefresh() {
    var = 0
    ErrorLevel = ""
    while ((var <= 3) && (ErrorLevel != 0)) {
        var += 1
        ImageSearch, FoundX, FoundY,  0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *50 C:\Users\EthanXPS\Desktop\SCBuild Macros\ImageAssets\refresh%var%.jpg
    }

    If (ErrorLevel = 0) {

        FoundX += 50    
        FoundY += 10
        Click, %Foundx%, %FoundY% 

    }

    Else If (ErrorLevel) {
        ToolTip, Refresh not found..., 0, 125
    FoundX = ""
    FoundY = ""

    }
}

WaitForLoadingScreen(curWinTitle) {

}

WasPurchaseSuccessful(x,y){
    toggleCoordMode(1)
    ; coordinates in area where click occurred 
    x1 := x - 100
    y1 := y - 100
    x2 := x + 100
    y2 := y + 100

    ImageSearch, FoundX, FoundY,  x1, y1, x2, y2,*50 C:\Users\EthanXPS\Desktop\SCBuild Macros\ImageAssets\greenCheck.jpg
    If (ErrorLevel = 0) {
        wasSuccessful := true
        msgBox We did it!
    }
    Else {
        wasSuccessful := false
        msgbox Ohp! They beat us to it!
    }
    toggleCoordMode(2)

    return WasPurchaseSuccessful
}


toggleCoordMode(coordType) {
    if (%coordType% = 1) {
        CoordMode, Pixel, Screen
        CoordMode, ToolTip, Screen
        CoordMode, Mouse, Screen
    }

    if (%coordType% = 2) {
        CoordMode, Mouse, Relative
        CoordMode, Pixel, Relative
        CoordMode, ToolTip, Relative
    }


}

`:: 
Pause
BlockInput MouseMoveOff

Esc:: 
BlockInput MouseMoveOff
ExitApp

~LButton::
Send {Ctrl}

~LButton UP::
Send {Ctrl}

Return

^!7::

toggleCoordMode(2)
WasPurchaseSuccessful(10,10)


For key, val in % WindowList {
    If WinExist(val) {
            WinActivate, %val%
    Sleep 1000

    Click, 80, 100
    ToolTip, Lookitme! , 100, 120
    }
}

toggleCoordMode(1)


Return