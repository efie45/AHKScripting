;#############################################################
;################## GENERAL SETTINGS / SETUP #################
;#############################################################

fileLocation := A_ScriptDir . "\sell_for_profit_log.txt"
FileDelete, %fileLocation%
global SetWorkingDir %A_ScriptDir%
SetCoordMode(1)
#SingleInstance Force
SetControlDelay 1s
SetWinDelay 0
SetKeyDelay -1
SetMouseDelay -1
SetBatchLines -1
toggleMouseMove = 0
; Creaate gui
windowList := ["Hammertown", "Diggs", "BlueStacks"]
activeWindowList := []
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
;DEFAULT_SLEEP := 1000
;SHORT_SLEEP := (DEFAULT_SLEEP / 4)
;MID_SLEEP := (DEFAULT_SLEEP * 3)
;LONG_SLEEP := (DEFAULT_SLEEP * 5)

;#############################################################
;################## GUI SETTINGS GO HERE #####################
;#############################################################
; Hard code values that will change from program to program
; here and then add GUI later to control them

global sellItems := true ;will only create items if false
global advertise := true ;advertises in global market and sells for profit
global numFactories := 5
global storeList := ["Furniture Store",  "Farmer's Market", "Hardware Store", "Building Supplies Store"]
global storeCount := storeList.MaxIndex()
	
;#############################################################
;###################### MAIN PROGRAM #########################
;#############################################################

BlockInput, MouseMove
Loop {
	For key, val in % windowList {
		if WinExist(val) {
			WinActivate, % val
			ExecuteRoutine()
		}
	}
}

;#############################################################
;############### MAIN PROGRAM HELPER FUNCTIONS ###############
;#############################################################

ExecuteRoutine(){
	ClosePeskyAds(2)
	ClickCenterScreen(7) ;TODO Change back to 7
	StartNewMaterials(1,2, "Building Supplies Store")
	if (sellItems) {
		ClickTradeDepot()
		ImageSearchFillAllSaleCrates(10,advertise)
		ExitTradeDepot()	
	}
	Sleep 3000
	ClickCenterScreen(4)

	;1st Factory (Dummy factory)
	Loop, 4 {
		ClickDummyFactory()
		ClickCenterScreen(1)
	}
	StartNewMaterials("Metal", 3, "Factory")
	ClickRightArrow(1)

	;2nd Factory
	ClickCenterScreen(4)
	StartNewMaterials("Metal", 3, "Factory")
	ClickRightArrow(1)
	
	;3rd factory
	ClickCenterScreen(4)
	StartNewMaterials("Metal", 3, "Factory")
	ClickRightArrow(1)
	;

	;4th factory
	ClickCenterScreen(4)
	StartNewMaterials("Metal", 3, "Factory")
	ClickRightArrow(1)

	;5th factory
	ClickCenterScreen(4)
	StartNewMaterials("Wood", 3, "Factory")	ClickRightArrow(1) ;bring us back to the first factory
	
	;moving back to main store to avoid ads in factories
	click 441 345
	Sleep 1000
	ClickCenterScreen(1)
	Click 441 345
	Sleep 1000
	ClickCenterScreen(1)
	ClickRightArrow(1)
	
	;2nd store
	ClickCenterScreen(4)
	StartNewMaterials(1, 3, "Hardware Store")
	ClickRightArrow(1)
	
	;3rd Store
	ClickCenterScreen(1)
	ClickRightArrow(1)
	
	;4th store if applicable
	WinGetActiveTitle curWinTitle
	if(curWinTitle = "Hammertown") {
		ClickCenterScreen(2)
		StartNewMaterials(1, 1, "Furniture Store")
		ClickRightArrow(1)
	}
	
	;Main store
	ClickCenterScreen(3)
	Return
}
	

;#############################################################
;###################### FUNCTIONS ############################
;#############################################################

ClosePeskyAds(numClicks){
	DebugAppend("Attempting to close annoying ads")
	Loop, % numClicks
	{
		Click, 582, 106
		Sleep 1000
	}
	Return
}


ClickCenterScreen(numClicks){
	Loop, %numClicks%
	{
		DebugAppend("Clicking center screen ")
		Click, 446, 285 Left Down
		Sleep, 150
		Click, 446, 285 Left Up
		Sleep, 750
	}
	Return
}

ClickTradeDepot(){
	DebugAppend("Clicking trade depot")
	Click, 203, 369
	Sleep 2000
	Return
}

ClickCrate(cratePos){
	DebugAppend("Clicking crate at position " . cratePos)
	if (cratePos = 1) {
		Click, Left, 211, 228
	}
	else if (cratePos = 2) {
		Click, Left, 353, 231
	}
	else if (cratePos = 3) {
		Click, Left, 498, 244
	}
	else if (cratePos = 4) {
		Click, Left, 626, 227
	}
	else if (cratePos = 5) {
		Click, Left, 208, 389
	}
	else if (cratePos = 6) {
		Click, Left, 356, 385
	}
	else if (cratePos = 7) {
		Click, Left, 499, 400
	}
	else if (cratePos = 8) {
		Click, Left, 622, 398
	}
	Sleep 1000
	Return
}

ImageSearchFillSaleCrate(x,y,advertise){
	DebugAppend("Filling sale crate: " . x . ", " . y)
	MouseMove, %x%, %y%, 0
	Sleep 1000
	Click, %x%, %y%
	Sleep 1500
	Click, %x%, %y%
	Sleep 1500
	Click, %x%, %y%
	Sleep 1500
	DebugAppend("    Select 2nd row to avoid some plain materials if possible")
	Click, 158, 325 ;select 2nd row items before materials
	Sleep 1000
	if (!advertise) {
		DebugAppend("    Reducing Price...")
		Click, 593, 328 Left, Down ;Click the (-) button and hold to drop price
		Sleep, 5000
		Click, 593, 328 Left, Up
		Sleep 1000
	} else {
		DebugAppend("    Increasing Price...")
		Click, 750, 333 Left, Down ;Click the (+) button and hold to increase price
		Sleep, 5000
		Click, 750, 333 Left, Up
		Sleep 1000
	}
	;Increment sale to put max items(5) up for sale
	DebugAppend("    Incrementing num of items to max available ")
	Click, 750, 229, Left, Down
	Sleep 2500
	Click, 750, 229, Left, Up
	Sleep, 1000
	if (!advertise) {
		DebugAppend("    Unchecking advertisement box")
		Click, 729, 418 ;Uncheck advertise box to ensure private sale only
		Sleep 1000
	}
	DebugAppend("    Clicking the sale button")
	Click, 667, 492 ;Put that shit on sale baby
 	Sleep 1000
	DebugAppend("    Exit in case of non-purchased crate")
 	Click, 612, 63 ;Exit in case of unbought crate
 	Sleep 1000
	DebugAppend("    Exiting crate sale window")
	Click, 821, 67 ;Exit Create Sale Window
	Sleep 1500
	Return
}

ImageSearchFillAllSaleCrates(searches, advertise) {
	img := A_ScriptDir . "\image_assets\create_new_sale.png"
	img2 := A_ScriptDir . "\image_assets\sale_crate_bought.png"
	Loop, %searches% {
		found := false
		DebugAppend("Searching for open sale crate")
		ImageSearch, FoundX, FoundY, 134, 136, 777, 462, *75 %img%
		if (ErrorLevel = 0) {
			found = true
		}
		else {
			ImageSearch, FoundX, FoundY, 134, 136, 777, 462, *75 %img2%
			if (ErrorLevel = 0) {
				found = true
			}
		}
		if (found) {
			ImageSearchFillSaleCrate(FoundX, FoundY, advertise)
		}
		ErrorLevel = ""
		FoundX = ""
		FoundY = ""
	}
}

ExitTradeDepot(){
	Click, 5,46
	Sleep, 1500
	Return
}

ClickDummyFactory(){
	Click, 450, 221 
 	Sleep 1000
	Return
}

StartNewMaterials(matPosition, numRefills, bldg) {
	Loop, %numRefills% {
		DragMaterialFromPos(matPosition, bldg)
	}
	Sleep 1000
	Return
}

DragMaterialFromPos(fromPos, bldg){
	DebugAppend("Starting " . MaterialLookup(fromPos,bldg) . " production at " bldg)
	if(fromPos = 1 || fromPos = "Metal" || fromPos = "Nails" || fromPos = "Vegetables" || fromPos = "Hammers") {
		Click, Left, Down, 285, 181
	}
	if(fromPos = 2 || fromPos = "Wood") {
		Click, Left, Down, 229, 267
	}
	if(fromPos = 3 || fromPos = "Plastic") {
		Click, Left, Down, 285, 358
	}
	if(fromPos = 4 || fromPos = "Seeds") {
		Click, Left, Down, 608, 181
	}
	if(fromPos = 5) {
		Click, Left, Down, 665, 271
	}
	if(fromPos = 6) {
		Click, Left, Down, 610, 362
	}
	Sleep 1000
	MouseMove, 446, 285, 99
	Sleep 500
	Click, Left, Up, 446, 285 
	Sleep 2000
	if(!(inStr(bldg, "Factory"))) {
		Click, Left, Down, 6, 48
		Sleep 150
		Click, Left, Up, 6, 48
		Sleep 1500
		ClickCenterScreen(1)
	}
	Return
}

ClickBldgToRight(numClicks){
	Loop, %numClicks% {
		Click, 515, 285
	 	Sleep 2000
	}
	Return
}


ClickRightArrow(loops){
	Loop, %loops% {
		Click, 694, 68
		Sleep 2000
		Return
	}
}

ClickDummyStore(){
	Click, 1082, 524 
 	Sleep 2000
	Return
}

MaterialLookup(matPos, bldg) {
	matName := matPos
	if (matpos is integer) {
		if (inStr(bldg, "Factory")) {
			if (matPos = 1) { 
				matName := "Metal"
			}
			else if (matPos = 2) { 
				matName := "Wood" 
			}
			else if (matPos = 3) { 
				matName := "Plastic" 
			}
			else if (matPos = 4) { 
				matName := "Seeds" 
			}
			else if (matPos = 5) { 
				matName := "Minerals" 
			}
			else { 
				matName = "**Unavailabe slot**" 
			}
		}
		else if (bldg = "Building Supplies Store") {
			if (matPos = 1) { 
				matName := "Nails" 
			}
			else if (matPos = 2) { 
				matName := "Planks" 
			}
			else if (matPos = 3) { 
				matName := "Bricks" 
			}
			else { 
				matName = "**Unavailabe slot**" 
			}
		}
		else if (bldg = "Farmer's Market") {
			if (matPos = 1) {
				matName := "Vegetables" 
			}
			else if (matPos = 2) { 
				matName := "Flour Bag" 
			}
			else { 
				matName = "**Unavailabe slot**" 
			}
		}
		else if (bldg = "Hardware Store") {
		if (matPos = 1) { 
			matName := "Hammer" 
			}
			else if (matPos = 2) { 
				matName := "Measuring Tape" 
			}
			else if (matPos = 3) { 
				matName := "Shovel" 
			}
			else 
				{ 
				matName = "**Unavailabe slot**" 
			}
		}
		else {
			matName := "Mat unknown: Check MaterialLookup() function"
		}
		
	}
	return matName
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
	GuiControl,, Debug, %Data%`r`n %Debug%
	fileLocation := A_ScriptDir . "\market_crawler_log.txt"
	FileAppend, %Data% `r`n, %fileLocation% 
	Return
}

^!b::
WinActivate, "BlueStacks"
ClickTradeDepot()
ImageSearchFillAllSaleCrates(8, advertise)
ExitTradeDepot()
Return

^!h::
WinActivate, "Hammertown"
ClickTradeDepot()
ImageSearchFillAllSaleCrates(8, advertise)
ExitTradeDepot()
Return

Esc:: 
	ExitApp  ; Exit script with Escape key