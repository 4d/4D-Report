C_LONGINT:C283($Lon_color;$Lon_current)
C_TEXT:C284($Mnu_pop;$Txt_choice)

  //get current color
  //$Lon_current:=Editor_Get_color ("stroke")

  //display menu
$Mnu_pop:=mnu_Color ($Lon_current;"front")
$Txt_choice:=Dynamic pop up menu:C1006($Mnu_pop;String:C10($Lon_current))
RELEASE MENU:C978($Mnu_pop)

If (Length:C16($Txt_choice)>0)
	
	  //update selected objects if any
	  //$Lon_color:=mnu_Get_color ($Txt_choice)
	
	  //Editor_SEL_SET_COLOR ("stroke";$Lon_color)
	
	  //update UI
	  //Editor_SET_STROKE ($Lon_color)
	
End if 