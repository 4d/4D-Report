C_LONGINT:C283($Lon_current;$Lon_width)
C_TEXT:C284($Mnu_pop;$Txt_choice)

  //get current color
  //$Lon_current:=Editor_Get_default_stroke_width 

  //  //display menu
  //$Mnu_pop:=Editor_MENU_STROKE_WIDTH 
  //$Txt_choice:=Dynamic pop up menu($Mnu_pop;String($Lon_current))
  //RELEASE MENU($Mnu_pop)

  //If (Length($Txt_choice)>0)

  //  //update selected objects if any
  //$Lon_width:=Num(Replace string($Txt_choice;"stroke-width-";"";*))

  //If ($Lon_width#$Lon_current)

  //Editor_SEL_SET_STROKE_WIDTH ($Lon_width)

  //  //update UI
  //Editor_SET_STROKE_WIDTH ($Lon_width)

  //End if 
  //End if 