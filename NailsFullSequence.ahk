; ######## GENERAL SETTINGS ########
#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
CoordMode, Mouse, Window
SendMode Input
SetTitleMatchMode 2
#WinActivateForce
SetControlDelay 1
SetWinDelay 0
SetKeyDelay -1
SetMouseDelay -1
SetBatchLines -1

; ######## FUNCTIONS ########

^!u:: ; ### MAIN ###

;Main settings

DEFAULT_SLEEP := 1000

;Program execution

ClosePeskyAds(2)
ClickCenterScreen(7)
ClickTradeDepot()
	FillSaleCrates()
	ExitTradeDepot()
ClickCenterScreen(2)
ClickDummyFactory()
	CollectFromFactories(4)
ClickDummyStore()
ClickRightArrow() ;bring back to main store
ClickCenterScreen(5)
StartNewMaterials(1,6)

Return

ClosePeskyAds(numClicks){
	Loop, % numClicks
	{
		Click, 1335, 271 
		Sleep 1000
	}
	Sleep % DEFAULT_SLEEP
}


ClickCenterScreen(numClicks){
	Loop, % numClicks
	{
		Click, 927, 538 Left, , Down
		Sleep, 250
		Click, 927, 538 Left, , Up
		Sleep, 1000
	}
	Sleep % DEFAULT_SLEEP
}

ClickTradeDepot(){

	Click, 420, 705
	Sleep, 250
}

FillSaleCrate(x,y){

	Click, %x%, %y%
	Sleep 1000
	;in case it was recently sold, it needs to be clicked twice
	Click, %x%, %y%
	Sleep 1000
	;select 2nd row items before materials
	Click, 350, 608 
	Sleep 1000
	;Increment sale to put max items(5) up for sale
	Loop, 5 {
		Click, 1530, 425, Left, , Down
		Sleep 250
		Click, 1530, 425, Left, , Up
		Sleep 250
	}
	Sleep 1000
	;Click the (-) button and hold to drop price
	Click, 1218, 588 Left, , Down
	Sleep, 5000
	Click, 1218, 588 Left, , Up
	Sleep, 250
	;Uncheck advertise box to ensure private sale only
	Click, 1517, 794 
 	Sleep 1000
	;Put that shit on sale baby
	Click, 1354, 948 
 	Sleep 1000
 	;Exit in case of unbought crate
 	Click, 1224, 126 
 	Sleep 1000
 	;Exit Create Sale Window
	Click, 1643, 134
	Sleep 1000
}

FillSaleCrates(){

    ;Crate coordinates
	FillSaleCrate(465, 425)
	FillSaleCrate(735, 425)
	FillSaleCrate(1000, 425)
	FillSaleCrate(1280, 425)
	FillSaleCrate(465, 756)
	FillSaleCrate(735, 756)
	FillSaleCrate(1000, 756)
	FillSaleCrate(1280, 756)
}

ExitTradeDepot(){
	Click, 1512, 129
	Sleep, 250
}

ClickDummyFactory(){
	Click, 940, 420 
 	Sleep 2000
}

StartNewMaterials(matPosition, numRefills) {
	if (matPosition = 1) {
		Loop, %numRefills% {
			DragMaterialFromPos1()
		}
	}
	else if (matPosition = 2) {
		MsgBox, "Set up collecting mats for position 2"
	}
		else if (matPosition = 3) {
		MsgBox, "Set up collecting mats for position 3"
	}
	else if (matPosition = 4) {
		MsgBox, "Set up collecting mats for position 4"
	}
	else if (matPosition = 5) {
		MsgBox, "Set up collecting mats for position 5"
	}
}

DragMaterialFromPos1(){
	Click, 604, 329 Left, , Down
Sleep, 5
Click, 607, 330, 0
Sleep, 5
Click, 609, 331, 0
Sleep, 5
Click, 612, 332, 0
Sleep, 5
Click, 615, 333, 0
Sleep, 5
Click, 616, 334, 0
Sleep, 5
Click, 617, 335, 0
Sleep, 5
Click, 619, 336, 0
Sleep, 5
Click, 633, 341, 0
Sleep, 5
Click, 655, 355, 0
Sleep, 5
Click, 688, 369, 0
Sleep, 5
Click, 702, 375, 0
Sleep, 5
Click, 711, 378, 0
Sleep, 5
Click, 726, 385, 0
Sleep, 5
Click, 729, 386, 0
Sleep, 5
Click, 737, 392, 0
Sleep, 5
Click, 748, 398, 0
Sleep, 5
Click, 774, 412, 0
Sleep, 5
Click, 778, 414, 0
Sleep, 5
Click, 790, 421, 0
Sleep, 5
Click, 797, 424, 0
Sleep, 5
Click, 800, 426, 0
Sleep, 5
Click, 803, 430, 0
Sleep, 5
Click, 816, 436, 0
Sleep, 5
Click, 843, 452, 0
Sleep, 5
Click, 859, 460, 0
Sleep, 5
Click, 864, 465, 0
Sleep, 5
Click, 864, 466, 0
Sleep, 5
Click, 865, 467, 0
Sleep, 5
Click, 868, 470, 0
Sleep, 5
Click, 878, 477, 0
Sleep, 5
Click, 887, 485, 0
Sleep, 5
Click, 889, 486, 0
Sleep, 5
Click, 893, 490, 0
Sleep, 5
Click, 898, 494, 0
Sleep, 5
Click, 899, 495, 0
Sleep, 5
Click, 899, 496, 0
Sleep, 5
Click, 899, 497, 0
Sleep, 5
Click, 900, 497, 0
Sleep, 5
Click, 900, 498, 0
Sleep, 5
Click, 900, 499, 0
Sleep, 5
Click, 900, 500, 0
Sleep, 5
Click, 901, 500, 0
Sleep, 5
Click, 901, 502, 0
Sleep, 5
Click, 902, 502, 0
Sleep, 5
Click, 902, 503, 0
Sleep, 5
Click, 902, 505, 0
Sleep, 5
Click, 903, 505, 0
Sleep, 5
Click, 905, 505, 0
Sleep, 5
Click, 906, 505, 0
Sleep, 5
Click, 907, 505, 0
Sleep, 5
Click, 910, 506, 0
Sleep, 5
Click, 910, 507, 0
Sleep, 5
Click, 911, 507, 0
Sleep, 5
Click, 911, 508, 0
Sleep, 5
Click, 911, 509, 0
Sleep, 5
Click, 915, 512, 0
Sleep, 5
Click, 917, 513, 0
Sleep, 5
Click, 917, 513 Left, , Up
Sleep, 5
Click, 917, 514, 0
Sleep, 5
Click, 916, 514, 0
Return
}

ClickFactoryToRight(numClicks){
	Loop, %numClicks% {
		Click, 1062, 522 
	 	Sleep 250	
	 }
}


ClickRightArrow(){
	Click, 1420, 87 
 	Sleep 2000
}

CollectFromFactories(numOfFactories){
	Loop, %numOfFactories% {
	ClickRightArrow()
	Sleep 2000
	ClickCenterScreen(5)
	Sleep 2000
	StartNewMaterials(1,3) ;material position, number of times
	Sleep 2000
	}
}

ClickDummyStore(){
	Click, 1082, 524 
 	Sleep 2000
}

^!y:: ;TESTS

ClickCenterScreen(2)
Sleep 2000
MsgBox, "Dummy Factory Click", 5000
ClickDummyFactory()
Sleep 2000
MsgBox, "Factory Collection", 5000
CollectFromFactories(4)
Sleep 2000
MsgBox, "Dummy Store Click", 5000
ClickDummyStore()
Sleep 2000
MsgBox, "Navigate with right arrow to main store", 5000
ClickRightArrow() ;bring back to main store
Sleep 2000
MsgBox, "Click center store", 5000
ClickCenterScreen(5)
Sleep 2000
MsgBox, "New Materials", 5000
StartNewMaterials(1,6)
Sleep 2000

Esc::ExitApp  ; Exit script with Escape key