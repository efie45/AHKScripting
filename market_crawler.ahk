SetWorkingDir %A_ScriptDir%
SetCoordMode(1)
SendMode Input
#SingleInstance Force
SetControlDelay 1
SetWinDelay 0
SetKeyDelay -1
SetMouseDelay -1
SetBatchLines -1
windowList := ["BlueStacks", "Hammertown (Hammers)", "Shove It"]
curToolTipY := 0

^!\::
;Activate the necessary windows
For key, val in % WindowList {
    If WinExist(val) {
            WinActivate, %val%
    }
}
checkRefresh()
mainLoopVar = 0
totalSearchLoops = 0
maxImages = 7
Loop { ; Loop until user escapes using ESC key
    ; For each image in the image file

    Loop, %maxImages% {
        mainLoopVar += 1
        CheckRefresh()
        message := "Searching for storage (" . mainLoopVar . ").jpg"
        NextToolTip(message)
        path := A_ScriptDir . "\image_assets\storage\storage (" . mainLoopVar . ").jpg"
        ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *100 %path%
        If (ErrorLevel = 0) {
            soundPath := A_ScriptDir . "sound_assets\found.wav"
            SoundPlay, %soundPath%
            Click, %FoundX%, %FoundY%
            Sleep 100
            Click, %FoundX%,%FoundY%
			message := "Found storage (" . mainLoopVar . ").jpg"
            ErrorLevel := -1 
            FoundX := ""
            FoundY := ""
            PurchaseFromShop()
			HomewardBound()
        }

        If mainLoopVar >= %maxImages%
            mainLoopVar = 0
    } Until (ErrorLevel = 0)
}
Return
 
HomewardBound() {
    totClicks = 0
    ErrorLevel = 1
	X1 := 0
	Y1 := 40
	X2 := 150
	Y2 := 150
    while (ErrorLevel != 0) {
        var = 0
        Loop, 3 {
            var += 1
            path := A_ScriptDir . "\image_assets\homebadge (" . var . ").jpg"
            ImageSearch, FoundX, FoundY, %X1% ,%Y1%, %X2%, %Y2%,  *150 %path%
        } Until (ErrorLevel = 0)
  
        If (ErrorLevel != 0) {
            c1 := 65
            c2 := 95
            Click, %c1%, %c2% Left, , Down
            Sleep 100
            Click, %c1%, %c2% Left, , Up
            Sleep 3000
            MouseMove 100, 100, 0, R
            Sleep 1000
        }
    }
    Click 305, 170 Left,, Down
    Sleep 100
    Click 305, 170 Left,, Up
	Sleep 4000

}

checkRefresh() {
    var = 0
    ErrorLevel = ""
    while ((var < 3) && (ErrorLevel != 0)) {
        var += 1
        path := A_ScriptDir . "\image_assets\refresh (" . var . ").jpg"
        ImageSearch, FoundX, FoundY,  0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *50 %path%
    }

    If (ErrorLevel = 0) {

        FoundX += 50    
        FoundY += 10
        Click, %Foundx%, %FoundY% 
        

    }

    Else If (ErrorLevel) {
        message := "No refresh found"
        NextToolTip(message)
    FoundX = ""
    FoundY = ""

    }
}

WaitForLoadingScreen() {

    message := "Searching for logo to identify loading screen..."
    Sleep 500
    loopNum := 0
    Loop, 2  {
        loopNum += 1
        Sleep 500
        path := A_ScriptDir . "\image_assets\SimCityLogo.jpg"
        ImageSearch, OutputVarX, OutputVarY, 130, 260, 1810, 1050, *100 %path%
        If (ErrorLevel = 0) {
            message := "Found the logo! Loading screen initiated..."
            NextToolTip(message)
            Sleep 1000
        }
        Else If (ErrorLevel = 1) {
            if (loopNum = 1)
                message := "No logo found...trying again..."
            if loopNum > 1
                message := "Still no logo found..."
            NextToolTip(message)
            Sleep 1000
        }
        Sleep 2000
    } Until (ErrorLevel = 0)
    ;Find when loading screen goes away
    ErrorLevel = -1
    While (ErrorLevel != 1) {
        path := A_ScriptDir . "\image_assets\SimCityLogo.jpg"
        ImageSearch, OutputVarX, OutputVarY, 130, 260, 1810, 1050, *100 %path%
        If (ErrorLevel != 0) {
        }
        Else If (ErrorLevel = 0) {
            message := "Logo still found, waiting for screen to load..."
            NextToolTip(message)
        }
        Sleep 1500
    }
    ;msgbox, Store finally loaded! Let's buy some shit!
}

WasPurchaseSuccessful(x,y){
    x1 := x - 100
    y1 := y - 100
    x2 := x + 100
    y2 := y + 100
	ErrorLevel = """

    Sleep 5000
    path := A_ScriptDir . "\image_assets\greenCheck.jpg"
    ImageSearch, FoundX, FoundY,  %x1%, %y1%, %x2%, %y2%, *50 %path%
    If (ErrorLevel = 0) {
        wasSuccessful := true
    }
    Else {
        wasSuccessful := false
    }
    return WasPurchaseSuccessful
}


SetCoordMode(coordType) { ;*[MarketCrawler]
    if (coordType = 1) {
        CoordMode, Pixel, Screen
        CoordMode, ToolTip, Screen
        CoordMode, Mouse, Screen
    }

    if (coordType = 2) {
        CoordMode, Mouse, Relative
        CoordMode, Pixel, Relative
        CoordMode, ToolTip, Relative
    }
}


PurchaseFromShop() {

    var := 0
    ErrorLevel = ""
    message := "Looking in the shop..."
    NextToolTip(message)
    Loop, 2 {
        Loop, 6 {
            var += 1
            message := "Looking for storage_store (" . var . ").jpg"
            NextToolTip(message)
            Sleep 1000
            path := A_ScriptDir . "\image_assets\storage\storage_store\storage_store (" . var . ").jpg"
            ImageSearch, FoundXX, FoundYY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *150 %path%
            
            If (ErrorLevel = 0) {
                message := "Found the shop item!"
                NextToolTip(message)
                Click, %FoundXX%, %FoundYY%
                WasPurchaseSuccessful(FoundXX, FoundYY)
                if (wasPurchaseSuccessful = true) {
					soundPath := A_ScriptDir . "\sound_asseets\chaching.wav"
					SoundPlay, %soundPath%
                }
                Sleep 50
                Click, %FoundXX%, %FoundYY%
                FoundX := ""
                FoundY := ""
            }
            If (var >= 6) {
                var = 0
            }
        } Until (ErrorLevel = 0)
    }Until (ErrorLevel = 0)
}

NextToolTip(message){
    if (curToolTipY > 1000) {
        curToolTipY = 0
    }
    ToolTip, %message%, 0, %curToolTipY%
    curToolTipY += 25
}


`:: 
Pause
Return

Esc:: 
ExitApp

