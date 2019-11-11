;#############################################################
;################## GENERAL SETTINGS #########################
;#############################################################
fileLocation := A_ScriptDir . "\market_crawler_log.txt"
FileDelete, %fileLocation%
global SetWorkingDir %A_ScriptDir%
SetCoordMode(2)
SendMode Input
#SingleInstance Force
SetControlDelay 1
SetWinDelay 0
SetKeyDelay -1
SetMouseDelay -1
SetBatchLines -1
; Creaate gui
windowList := ["BlueStacks", "Hammertown", "Shove It"]
activeWindowList := []
curToolTipY := 0
; Count images in storage item folder
storageFiles := A_ScriptDir . "\image_assets\storage\*.*"
loop, %storageFiles%
    storageFileCount := A_Index	
storageStoreFiles := A_ScriptDir . "image_assets\storage\storage_store\*.*"
; Activate the necessary windows
Gui, Add, Edit, Readonly x10 y10 w750 h470 vDebug
Gui, Show, w750 h470 x0 y548, Debug Window
DebugAppend("Starting program")
For key, val in % WindowList {
    If WinExist(val) {
			DebugAppend("Activating window: " . val)
			DebugAppend("Adding to activeWindowList[]")
			activeWindowList.Push(val)
            WinActivate, %val%
			WinGetActiveStats, %val%, winMaxHeight, winMaxWidth, winX, winY
			DebugAppend("H: " . winMaxHeight)
			DebugAppend("W: " . winMaxWidth)
			DebugAppend("X: " . winX)
			DebugAppend("Y: " . winY)
    }
	Else {
		DebugAppend("Couldn't activate window: " . val)
	}
}
DebugAppend("Active window list:")
For key, val in % activeWindowList {
	DebugAppend(val)
}
;#############################################################
;###################### MAIN PROGRAM #########################
;#############################################################

^!\::
checkRefresh()
mainLoopVar = 0
totalSearchLoops = 0
while (true) ; Loop until user escapes using ESC key
{ 
	DebugAppend(windowList)
	For key, winName in %windowList% ; for each window 
	{
		DebugAppend("Activating window " . winName . " in main loop...")
		WinActivate, %winName%
		WinGetActiveStats, %val%, wx1, wy1, wx2, wy2
		MouseMove, %wx1%, %wy1%, 100
		Pause
		MouseMove, %wx2%, %wy2%, 100
		Pause
		Loop Files, %storageFiles% ; For each image in file
		{
			mainLoopVar += 1
			CheckRefresh()
			path := A_LoopFileFullPath
			ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *100 %path%
			If (ErrorLevel = 0) {
				soundPath := A_ScriptDir . "sound_assets\found.wav"
				SoundPlay, %soundPath%
				Click, %FoundX%, %FoundY%
				Sleep 250
				Click, %FoundX%,%FoundY%
				Sleep 1000
				DebugAppend("Clicking twice at " . FoundX . ", " . FoundY)
				DebugAppend("Found storage (" . mainLoopVar . ").jpg")
				ErrorLevel := -1 
				FoundX := ""
				FoundY := ""
				PurchaseFromShop()
				HomewardBound()
			}
		} Until (ErrorLevel = 0)
	
	} 

} Return
 
HomewardBound() {
	DebugAppend("Homeward bound...")
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
			DebugAppend("	Looking for homebadge (" . var . ").jpg @ *125")
			DebugAppend("	Searching at X1: " . X1 . " Y1: " . Y1 . " X2: " . X2 . " Y2: " . Y2)
            ImageSearch, FoundX, FoundY, %X1% ,%Y1%, %X2%, %Y2%,  *125 %path%
        } Until (ErrorLevel = 0)
  
        If (ErrorLevel != 0) {
			DebugAppend("	Found homebadge(" . var . ") @ " )
            c1 := 65
            c2 := 95
            Click, %c1%, %c2% Left, , Down
            Sleep 100
            Click, %c1%, %c2% Left, , Up
            Sleep 3000
            MouseMove 0, 0, 0, R
            Sleep 1000
        }
    }
	click 305, 170 left,, down
    sleep 100
    click 305, 170 left,, up
	sleep 4000
	errorlevel := ""
	FoundX := ""
	FoundY := ""

	;path := a_scriptdir . "\image_assets\global_trade_hq.jpg"
	;while (errorlevel != 0) {
	;	imagesearch, foundx, foundy, 90, 40, 790, 140, *75 %path%
	;	if (errorlevel = 0) {
	;		debugappend("back in the global trade hq. okay to proceed...")
	;	}
	;}
} Return

checkRefresh() {
    var = 0
    ErrorLevel = ""
    while ((var < 3) && (ErrorLevel != 0)) {
        var += 1
        path := A_ScriptDir . "\image_assets\refresh (" . var . ").jpg"
		MouseMove, 0, 0, 0
		MouseMove, %A_ScreenWidth%, %A_ScreenHeight%, 50
		Sleep 5000
        ImageSearch, FoundX, FoundY,  0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *75 %path%
    }

    If (ErrorLevel = 0) {
		DebugAppend("Refreshing Global Trade HQ...")
        FoundX += 50    
        FoundY += 10
        Click, %Foundx%, %FoundY% 
        

    }

    Else If (ErrorLevel) {
    FoundX = ""
    FoundY = ""

    }
} Return

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
            DebugAppend(message)
            Sleep 1000
        }
        Else If (ErrorLevel = 1) {
            if (loopNum = 1)
                message := "No logo found...trying again..."
            if loopNum > 1
                message := "Still no logo found..."
            DebugAppend(message)
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
			DebugAppend("Logo not found, loading screen complete.")
			DebugAppend("Starting search for item to purchase...")
        }
        Else If (ErrorLevel = 0) {
            message := "Logo still found, waiting for screen to load..."
            DebugAppend(message)
        }
        Sleep 1500
    }
    ;msgbox, Store finally loaded! Let's buy some shit!
} Return

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
		DebugAppend("Purchase was successful")
    }
    Else {
        wasSuccessful := false
		DebugAppend("No check mark found to indicate successful purchase.")
		
    }
    return WasPurchaseSuccessful
}


SetCoordMode(coordType) { ;*[MarketCrawler]
    if (coordType = 1) {
		DebugAppend("Changing CoordMode for all input to pixel/screen")
        CoordMode, Pixel, Screen
        CoordMode, ToolTip, Screen
        CoordMode, Mouse, Screen
    }

    if (coordType = 2) {
		DebugAppend("Changing CoordMode for all input to relative")
        CoordMode, Mouse, Relative
        CoordMode, Pixel, Relative
        CoordMode, ToolTip, Relative
    }
} Return


PurchaseFromShop() {
    ErrorLevel = ""
    message := "Looking in the shop..."
    DebugAppend(message)
    Loop, 2 {
        Loop File, %StorageStoreFiles%  
		{
            message := "Looking for " . A_LoopFileFullPAth 
            DebugAppend(message)
            Sleep 1000
            path := A_LoopFileFullPath
            ImageSearch, FoundXX, FoundYY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *75 %path%
            
            If (ErrorLevel = 0) {
                message := "Found the shop item!"
                DebugAppend(message)
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
        } Until (ErrorLevel = 0)
    }Until (ErrorLevel = 0)
}
Return

DebugAppend(Data)
{
GuiControlGet, Debug
GuiControl,, Debug, %Data%`r`n%Debug%
fileLocation := A_ScriptDir . "\market_crawler_log.txt"
FileAppend, %Data% `r`n, %fileLocation% 
}

GuiClose:
Gui, Destroy
Return


`:: 
Pause
Return

Esc:: 

ExitApp

