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
WinActivate,  "Hammertown"
ClosePeskyAds(2)
ClickCenterScreen(7)
StartNewMaterials(1,7)
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
		Sleep % DEFAULT_SLEEP
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
	Sleep % DEFAULT_SLEEP
	;in case it was recently sold, it needs to be clicked twice
	Click, %x%, %y%
	Sleep % DEFAULT_SLEEP
	;select 2nd row items before materials
	Click, 350, 608 
	Sleep % DEFAULT_SLEEP
	;Increment sale to put max items(5) up for sale
	Loop, 5 {
		Click, 1530, 425, Left, , Down
		Sleep 250
		Click, 1530, 425, Left, , Up
		Sleep 250
	}
	Sleep % DEFAULT_SLEEP
	;Click the (-) button and hold to drop price
	Click, 1218, 588 Left, , Down
	Sleep, 5000
	Click, 1218, 588 Left, , Up
	Sleep, 250
	;Uncheck advertise box to ensure private sale only
	Click, 1517, 794 
 	Sleep % DEFAULT_SLEEP
	;Put that shit on sale baby
	Click, 1354, 948 
 	Sleep % DEFAULT_SLEEP
 	;Exit in case of unbought crate
 	Click, 1224, 126 
 	Sleep % DEFAULT_SLEEP
 	;Exit Create Sale Window
	Click, 1643, 134
	Sleep % DEFAULT_SLEEP
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
 	Sleep % DEFAULT_SLEEP
}

StartNewMaterials(matPosition, numRefills) {
	Loop, % numRefills{
		if (matPosition = 1) {
			DragMaterialFromPos1()

		} else if (matPosition = 2) {
			DragMaterialFromPos2()

		} else if (matPosition = 3) {
			MsgBox, "Set up collecting mats for position 3"
		} else if (matPosition = 4) {
			MsgBox, "Set up collecting mats for position 4"
		} else if (matPosition = 5) {
			MsgBox, "Set up collecting mats for position 5"
		}
		Click, 656, 856 
 		Sleep 250
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

DragMaterialFromPos2(){
	Click, 627, 529 Left, , Down
	Sleep, 735
	Click, 630, 529, 0
	Sleep 10
	Click, 632, 529, 0
	Sleep 10
	Click, 633, 529, 0
	Sleep 10
	Click, 637, 529, 0
	Sleep 10
	Click, 639, 529, 0
	Sleep 10
	Click, 642, 529, 0
	Sleep 10
	Click, 646, 529, 0
	Sleep 10
	Click, 649, 529, 0
	Sleep 10
	Click, 651, 529, 0
	Sleep 10
	Click, 653, 529, 0
	Sleep 10
	Click, 656, 529, 0
	Sleep 10
	Click, 661, 529, 0
	Sleep 10
	Click, 665, 529, 0
	Sleep 10
	Click, 667, 529, 0
	Sleep 10
	Click, 673, 529, 0
	Sleep 10
	Click, 678, 529, 0
	Sleep 10
	Click, 682, 529, 0
	Sleep 10
	Click, 685, 529, 0
	Sleep 10
	Click, 689, 529, 0
	Sleep 10
	Click, 692, 529, 0
	Sleep 10
	Click, 699, 529, 0
	Sleep 10
	Click, 700, 529, 0
	Sleep 10
	Click, 710, 530, 0
	Sleep 10
	Click, 715, 530, 0
	Sleep 10
	Click, 720, 531, 0
	Sleep 10
	Click, 724, 532, 0
	Sleep 10
	Click, 730, 532, 0
	Sleep 10
	Click, 731, 532, 0
	Sleep 10
	Click, 736, 533, 0
	Sleep 10
	Click, 741, 533, 0
	Sleep 10
	Click, 750, 533, 0
	Sleep 10
	Click, 752, 533, 0
	Sleep 10
	Click, 761, 533, 0
	Sleep 10
	Click, 763, 533, 0
	Sleep 10
	Click, 767, 534, 0
	Sleep 10
	Click, 770, 535, 0
	Sleep 10
	Click, 773, 535, 0
	Sleep 10
	Click, 776, 535, 0
	Sleep 10
	Click, 796, 540, 0
	Sleep 10
	Click, 812, 543, 0
	Sleep 10
	Click, 813, 543, 0
	Sleep 10
	Click, 818, 544, 0
	Sleep 10
	Click, 823, 545, 0
	Sleep 10
	Click, 825, 546, 0
	Sleep 10
	Click, 830, 548, 0
	Sleep 10
	Click, 834, 550, 0
	Sleep 10
	Click, 847, 550, 0
	Sleep 10
	Click, 855, 548, 0
	Sleep 10
	Click, 861, 548, 0
	Sleep 10
	Click, 862, 548, 0
	Sleep 10
	Click, 867, 548, 0
	Sleep 10
	Click, 868, 549, 0
	Sleep 10
	Click, 877, 551, 0
	Sleep 10
	Click, 887, 551, 0
	Sleep 10
	Click, 896, 551, 0
	Sleep 10
	Click, 901, 551, 0
	Sleep 10
	Click, 906, 551, 0
	Sleep 10
	Click, 906, 552, 0
	Sleep 10
	Click, 907, 552, 0
	Sleep 10
	Click, 909, 552, 0
	Sleep 10
	Click, 911, 552, 0
	Sleep 10
	Click, 912, 552, 0
	Sleep 10
	Click, 914, 551, 0
	Sleep 10
	Click, 918, 551, 0
	Sleep 10
	Click, 921, 551, 0
	Sleep, 297
	Click, 921, 551 Left, , Up
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
WinActivate,  ahk_class ThumbnailDeviceHelperWnd
Sleep 2000
WinActivate, BlueStacks ahk_class HwndWrapper[Bluestacks.exe;;5b32fde4-2355-48c5-be51-8927697e9914]

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