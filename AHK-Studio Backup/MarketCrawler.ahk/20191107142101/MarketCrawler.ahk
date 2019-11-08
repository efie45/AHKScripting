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


!`::
;Activate the necessary windows
For key, val in % WindowList {
    If WinExist(val) {
            WinActivate, %val%
    }
}
toggleCoordMode(1) ;Coordmode to Screen
checkRefresh()
var = -1
maxImages = 10
Loop { ; Loop until user escapes using ESC key
    ; For each image in the image file

    Loop, %maxImages% {
        var += 1
        CheckRefresh()

        ToolTip, Searching for image%var%, 0, 25
        ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *100 C:\Users\EthanXPS\Desktop\SCBuild Macros\ImageAssets\storage2x2\image%var%.jpg

        If (ErrorLevel = 0) {
            ;msgbox, Found image
            SoundPlay, C:\Users\EthanXPS\Desktop\SCBuild Macros\SoundAssets\found.wav
            Click, %FoundX%, %FoundY%
            Sleep 100
            Click, %FoundX%,%FoundY%
            ToolTip, Found one! It's image%var%.jpg, 0, 25
            ErrorLevel := -1
            FoundX := ""
            FoundY := ""
            SearchAndPurchase()

        }

        Else If (ErrorLevel) {
            ; code if image NOT found
        } 

        If var >= %maxImages%
            var = -1
    }

    HomewardBound()
}

Return
  
SearchAndPurchase(){
    toggleCoordMode(1) ;set to relative to window
    WaitForLoadingScreen()
    ;msgbox made it here
    var := -1
    ErrorLevel = ""
    Loop, 2 {
        ;msgbox inside first loop
        a := 1
        Loop, 6 {
            ;msgbox inside 2nd loop
            var += 1
            ToolTip, Looking in shop for image%var% , 0, 125
            Sleep 1000
            ImageSearch, FoundXX, FoundYY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *100 C:\Users\EthanXPS\Desktop\SCBuild Macros\ImageAssets\storage2x2\storage2x2Store\image%var%.jpg

            If (ErrorLevel = 0) {
                ;msgbox, Found in the shop!
                Click, %FoundXX%, %FoundYY%
                sleep 100
                Click, %FoundXX%, %FoundYY%
                sleep 10000
                WasPurchaseSuccessful(%FoundXX%, %FoundYY%)            
                SoundPlay, C:\Users\EthanXPS\Desktop\SCBuild Macros\SoundAssets\chaching.wav

                ToolTip, $$$ image%var%.jpg $$$, %FoundX% + 10, %FoundY% + 10
                Sleep 50
                Click, %FoundXX%, %FoundYY%
                FoundX := ""
                FoundY := ""
            }
            If (ErrorLevel) {
                ;msgbox, [ Options, Title, Text, Timeout], Couldn't purchase... 0, 75
            }
            If (var >= 6) {
                var = -1
            }
        }
    }
    HomewardBound()
}
Return ;*[MarketCrawler]
 ;*[MarketCrawler]
HomewardBound() {
    toggleCoordMode(1)
    WinActivate, Hammertown (Hammers)
    WinGetActiveStats, Title, Width, Height, X, Y
    totClicks = 0
    ErrorLevel = 1
    while (ErrorLevel != 0) {
        var = 0
        Loop, 3 {
            var += 1
            x2 := X + 175
            y2 := Y + 175
            msgbox Search @ %X% %Y% %x2% %y2%
            ImageSearch, FoundX, FoundY, %X% ,%Y%, %x2%, %y2%,  *150 C:\Users\EthanXPS\Desktop\SCBuild Macros\ImageAssets\homeBadge%var%.jpg
        } Until (ErrorLevel = 0)
  
        If (ErrorLevel != 0) {
            c1 := X + 65
            c2 := Y + 95
            Click c1, c2 Left, , Down
            Sleep 100
            Click c1, c2 Left, , Up
            Sleep 3000
            MouseMove 100, 100, 0, R
            Sleep 1000
        }
    }
    Click 218, 188 Left,, Down
    Sleep 100
    Click 218, 188 Left,, Up

}

checkRefresh() {
    toggleCoordMode(1)
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

WaitForLoadingScreen() {

    ;Look a couple times for logo
    ToolTip, Searching for logo 1 of 2 ..., 0, 225
    Sleep 500
    Loop, 2  {
        Tooltip x1>>y1, 230, 325
        Sleep 500
        Tooltip x2>>y2, 668, 420
        Sleep 500
        ImageSearch, OutputVarX, OutputVarY, 130, 260, 1810, 1050, *100 C:\Users\EthanXPS\Desktop\SCBuild Macros\ImageAssets\SimCityLogo.jpg
        If (ErrorLevel = 0) {
            ToolTip,  Found the logo for the first time..., 0, 225
            Sleep 1000
        }
        Else If (ErrorLevel = 1) {
            ToolTip, No logo yet, 0, 150
            Sleep 1000
        }
        Sleep 2000
    } Until (ErrorLevel = 0)
    ;Find when loading screen goes away
    ErrorLevel = -1
    While (ErrorLevel != 1) {
        ToolTip, Now Waiting for it to go away..., 0,  250
        ImageSearch, OutputVarX, OutputVarY, 130, 260, 1810, 1050, *100 C:\Users\EthanXPS\Desktop\SCBuild Macros\ImageAssets\SimCityLogo.jpg
        If (ErrorLevel != 0) {
            msgbox Can't find logo anymore
        }
        Else If (ErrorLevel = 0) {
            ToolTip, Still found logo..., 0, 150
        }
        Sleep 1500
    }
    ;msgbox, Store finally loaded! Let's buy some shit!
}

WasPurchaseSuccessful(x,y){
    ;msgbox Was purchase successful
    toggleCoordMode(1)
    ; coordinates in area where click occurred 
    x1 := x - 100
    y1 := y - 100
    x2 := x + 100
    y2 := y + 100

    Sleep 5000

    ImageSearch, FoundX, FoundY,  x1, y1, x2, y2,*50 C:\Users\EthanXPS\Desktop\SCBuild Macros\ImageAssets\greenCheck.jpg
    If (ErrorLevel = 0) {
        wasSuccessful := true
        msgbox We did it!
    }
    Else {
        wasSuccessful := false
        msgbox Ohp! Couldn't make the purchase!
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
        CoordMode, Mouse, Window
        CoordMode, Pixel, Window
        CoordMode, ToolTip, Window
    }
}

PurchaseFromShop() {

    var := -1
    ErrorLevel = ""
    Loop, 2 {
        ;msgbox inside first loop
        Loop, 6 {
            ;msgbox inside 2nd loop
            var += 1
            ToolTip, Looking in shop for image%var% , 0, 125
            Sleep 1000
            ImageSearch, FoundXX, FoundYY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *150 C:\Users\EthanXPS\Desktop\SCBuild Macros\ImageAssets\storage2x2\storage2x2Store\image%var%.jpg

            If (ErrorLevel = 0) {
                ;msgbox, Found in the shop!
                Click, %FoundXX%, %FoundYY%
                WasPurchaseSuccessful(%FoundXX%, %FoundYY%)            
                SoundPlay, C:\Users\EthanXPS\Desktop\SCBuild Macros\SoundAssets\chaching.wav

                ToolTip, $$$ image%var%.jpg $$$, %FoundX% + 10, %FoundY% + 10
                Sleep 50
                Click, %FoundXX%, %FoundYY%
                FoundX := ""
                FoundY := ""
            }
            If (ErrorLevel) {
                ;;msgbox, [ Options, Title, Text, Timeout], Couldn't purchase... 0, 75
            }
            If (var >= 6) {
                var = -1
            }
        }
    }
}


`:: 
Pause
BlockInput MouseMoveOff
Return

Esc:: 
BlockInput MouseMoveOff
ExitApp

^!7::
HomewardBound()

~LButton::
Send {Ctrl}

~LButton UP::
Send {Ctrl}

Return
