C_TEXT:C284($ICU_D83D;$ICU_DD22;$Mnu_main;$Txt_choice;$Txt_unicode)

$Mnu_main:=Create menu:C408

APPEND MENU ITEM:C411($Mnu_main;Char:C90(0x2211)+"   Sum")
SET MENU ITEM PARAMETER:C1004($Mnu_main;-1;"sum")

APPEND MENU ITEM:C411($Mnu_main;"n"+Char:C90(0x0305)+"   Average")
SET MENU ITEM PARAMETER:C1004($Mnu_main;-1;"average")

APPEND MENU ITEM:C411($Mnu_main;"<   Minimum")
SET MENU ITEM PARAMETER:C1004($Mnu_main;-1;"min")

APPEND MENU ITEM:C411($Mnu_main;">   Maximum")
SET MENU ITEM PARAMETER:C1004($Mnu_main;-1;"max")

APPEND MENU ITEM:C411($Mnu_main;"N   Count")
SET MENU ITEM PARAMETER:C1004($Mnu_main;-1;"count")

APPEND MENU ITEM:C411($Mnu_main;Char:C90(0x03C3)+"   Standard deviation")
SET MENU ITEM PARAMETER:C1004($Mnu_main;-1;"standard-deviation")

APPEND MENU ITEM:C411($Mnu_main;"-")

$ICU_D83D:=Char:C90(0xD83D)
$ICU_DD22:=Char:C90(0xDD22)
$Txt_unicode:=$ICU_D83D+$ICU_DD22

APPEND MENU ITEM:C411($Mnu_main;$Txt_unicode+" Test")
SET MENU ITEM PARAMETER:C1004($Mnu_main;-1;"test")

$Txt_choice:=Dynamic pop up menu:C1006($Mnu_main)
RELEASE MENU:C978($Mnu_main)

Case of 
		
		  //………………………………………………………………………………………
	: (Length:C16($Txt_choice)=0)
		
		  // nothing selected
		
		  //………………………………………………………………………………………
	: (Length:C16($Txt_choice)=0)
		
		  //………………………………………………………………………………………
	Else 
		
		ASSERT:C1129(False:C215;"Unknown menu action ("+$Txt_choice+")")
		
		  //………………………………………………………………………………………
End case 