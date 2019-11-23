;#############################################################
;################## GENERAL SETTINGS / SETUP #################
;#############################################################
BlockInput, MouseMove
fileLocation := A_ScriptDir . "\market_crawler_log.txt"
fileLocation2 := A_ScriptDir . "\market_crawler_purchase_history.txt"
FileDelete, %fileLocation%
global SetWorkingDir %A_ScriptDir%
SetCoordMode(2)
SendMode Input
#SingleInstance Force
SetControlDelay 1s
SetWinDelay 0
SetKeyDelay -1
SetMouseDelay -1
SetBatchLines -1
toggleMouseMove = 0
; Creaate gui
windowList := ["BlueStacks", "Hammertown", "Diggs"]
activeWindowList := []
curToolTipY := 0
; Count images in storage item folder
storageFiles := A_ScriptDir . "\image_assets\storage\*.*"
loop, %storageFiles%
    storageFileCount := A_Index	
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
			WinMove,%val%,,0,0,898,546
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
mainLoopVar = 0
totalSearchLoops = 0
while (true) ; Loop until user escapes using ESC key
{ 
	For key, winName in % activeWindowList ; for each window 
	{
		DebugAppend("Activating window " . winName . " in main loop...")
		WinActivate, %winName%
		Sleep 250
		WinGetActiveStats, %val%, wx1, wy1, wx2, wy2
		CheckRefresh()
			Loop, Files, %storageFiles% ; For each image in file
			{
				mainLoopVar += 1
				path := A_LoopFileFullPath
				MouseMove, 0, 0, 0
				DebugAppend("Searching for " . A_LoopFileName)
				ImageSearch, FoundX, FoundY, 171, 161, 725, 465, *100 %path%
				mainFound := ErrorLevel
				ErrorLevel := ""
				If (mainFound = 0) {
					soundPath := "C:\Users\EthanXPS\Desktop\SimCity_Buildit_AHK\sound_assets\found.wav"
					SoundPlay, %soundPath%
					Sleep 50
					Click, %FoundX%, %FoundY%
					Sleep 250
					Click, %FoundX%,%FoundY%
					Sleep 1000
					message := "Found storage item " . path . "`r`n"
					DebugAppend(message)
					FileAppend, %message%, %fileLocation2%
					DebugAppend("Clicking twice at " . FoundX . ", " . FoundY)
					FoundX := ""
					FoundY := ""
					WaitForLoadingScreen()
					PurchaseFromShop()
					HomewardBound()
				}
			} Until (mainFound = 0)
	
	} 

} Return
 
HomewardBound() {
	DebugAppend("Homeward bound...")
    Loop {
		path := A_ScriptDir . "\image_assets\global_trade_id.png"
		DebugAppend("	Looking for Global Market sign")
		MouseMove, 0, 0, 0
		Sleep 100
		ImageSearch, FoundX, FoundY, 95 , 23, 242, 155, *130 %path%
		found := ErrorLevel
		ErrorLevel := ""
		Sleep 1000
        If (found != 0) {
			c1 := 65
			c2 := 80
			Click, %c1%, %c2% Left, , Down
			Sleep 100
			Click, %c1%, %c2% Left, , Up
			Sleep 3000
			click 293, 80 left, , down
			sleep 100
			click 293, 80 left, , up
			sleep 2000
			click 293, 80 left, , down
			sleep 100
			click 293, 80 left, , up
			sleep 2000
        }
    } Until (found = 0)
	DebugAppend("	Found Global Market sign, should be back in market")
	FoundX := ""
	FoundY := ""
} Return

checkRefresh() {
	DebugAppend("Check Refresh...")
    var = 0
    while ((var < 3) && (found != 0)) {
        var += 1
        path := A_ScriptDir . "\image_assets\refresh (" . var . ").jpg"
		MouseMove, 0, 0, 0
        ImageSearch, FoundX, FoundY,  330, 450, 564, 517, *100 %path%
		found := ErrorLevel
		ErrorLevel := ""S
    }

    If (found = 0) {
		DebugAppend("Refreshing Global Trade HQ...")
        FoundX += 50    
        FoundY += 10
		DebugAppend("Clicking on ")
        Click, %Foundx%, %FoundY% 
		Sleep 1500
    }

    Else If (found != 0) {
    FoundX = ""
    FoundY = ""

    }
} Return

PurchaseFromShop() {
    DebugAppend("Looking in the shop...")
	storageStoreFiles := A_ScriptDir . "\image_assets\storage\storage_store\*.*"
	DebugAppend("    Looping over storage store files...")
	notFounds = 0
	Loop 
	{
		found = false
		Loop, Files, %storageStoreFiles%
		{
			DebugAppend("    Looking for " . A_LoopFileName . "in the shop")
			path := A_LoopFileFullPath
			MouseMove, 0,0,0
			ImageSearch, FoundXX, FoundYY, 175, 170, 735, 465, *125 %path%
			If (ErrorLevel = 0 )
			{
				found = true
				DebugAppend("    Found " . A_LoopFileName)
				Click, %FoundXX%, %FoundYY%
				Sleep 250
				Click, %FoundXX%, %FoundYY%
				Sleep 1000
				FoundX := ""
				FoundY := ""
			}
			ErrorLevel = ""
		}
		If (found != true){
			notFounds += 1
			DebugAppend ("    Couldn't find any of the images in the shop")
		}
	} until (notFounds >= 2)
	Return
}


WaitForLoadingScreen() {
	found := ""
	DebugAppend("Waiting for loading screen")
    ;Find when loading screen goes away
    found = -1
	loopVar = 0
    Loop, 25 {
		loopVar += 1
        path := A_ScriptDir . "\image_assets\market_logo.png"
		MouseMove,0,0,0
        ImageSearch, OutputVarX, OutputVarY, 120, 45, 205, 119, *100 %path%
		found := ErrorLevel
        If (found = 0) {
			DebugAppend("    Found market logo, market loaded...")
        }
        Else {
            DebugAppend("    Unable to find market logo, attempt " . loopVar . " of 25")
        }
        Sleep 1500
    } Until (found = 0)
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
    ImageSearch, FoundX, FoundY,  %x1%, %y1%, %x2%, %y2%, *100 %path%
	found := ErrorLevel
    If (found = 0) {
        wasSuccessful := true
		DebugAppend("Purchase was successful")
		fileLocation2 := A_ScriptDir . "\market_crawler_purchase_history.txt"
		message := "    Purchase of " . A_LoopFileName . " successful `r`n"
		FileAppend, %message%, %fileLocation2% 
    }
    Else {
        wasSuccessful := false
		DebugAppend("No check mark found to indicate successful purchase.")
		fileLocation2 := A_ScriptDir . "\market_crawler_purchase_history.txt"
		message := "    Unable to verify purchase of " . A_LoopFileName . "`r`n"
		FileAppend, %message%, %fileLocation2% 
		
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

DebugAppend(Data)
{
	GuiControlGet, Debug
	GuiControl,, Debug, %Data%`r`n%Debug%
	fileLocation := A_ScriptDir . "\market_crawler_log.txt"
	FileAppend, %Data% `r`n, %fileLocation% 
}
Return

GuiClose:
	Gui, Destroy
Return


`:: 
Pause
toggleMouseMove := !toggleMouseMove
if (toggleMouseMove) {
	BlockInput, MouseMoveOff
}
else {
	BlockInput, MouseMove
}
Return

Esc:: 
BlockInput, MouseMoveOff
ExitApp

