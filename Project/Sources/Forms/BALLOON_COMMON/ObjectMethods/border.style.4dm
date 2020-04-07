  // ----------------------------------------------------
  // Object method : BALLOON_COMMON.border.style - (4D Report)
  // Created #22-8-2019 by Adrien Cagniant
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_area;$Lon_column;$Lon_formEvent;$Lon_row;$Lon_thickness)
C_POINTER:C301($Ptr_borders;$Ptr_me;$Ptr_caller)
C_TEXT:C284($kTxt_key;$Mnu_main;$Txt_action;$Txt_fontName;$Txt_me)
C_OBJECT:C1216($Obj_border;$Obj_caller)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388
$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)
$Ptr_me:=OBJECT Get pointer:C1124(Object current:K67:2)
$Ptr_borders:=OBJECT Get pointer:C1124(Object named:K67:5;"borders.controls")

$Ptr_caller:=OBJECT Get pointer:C1124(Object named:K67:5;"caller")
$Obj_caller:=JSON Parse:C1218($Ptr_caller->)



If (OB Is defined:C1231($Obj_caller))
	
	$Lon_area:=report_Get_target ($Obj_caller;->$Lon_column;->$Lon_row)
	
	  // ----------------------------------------------------
	Case of 
			
		: ($Lon_formEvent=On Load:K2:1)
			
			
			(OBJECT Get pointer:C1124(Object named:K67:5;$Txt_me+".label"))->:=Get localized string:C991("menu_thickness4")
			
			
			
			  //______________________________________________________
		: ($Lon_formEvent=On Clicked:K2:4)
			
			$Mnu_main:=mnu_borderThickness ($Ptr_borders->thicknessToSet)
			
			$Txt_action:=Dynamic pop up menu:C1006($Mnu_main)
			
			RELEASE MENU:C978($Mnu_main)
			
			If ($Txt_action#"")  // if not clicked outside
				
				$Ptr_borders->thicknessToSet:=Num:C11($Txt_action;".")
				
				$Ptr_borders->top.thickness:=Choose:C955($Ptr_borders->top.thickness=0;0;$Ptr_borders->thicknessToSet)
				$Ptr_borders->bottom.thickness:=Choose:C955($Ptr_borders->bottom.thickness=0;0;$Ptr_borders->thicknessToSet)
				$Ptr_borders->insideHorizontal.thickness:=Choose:C955($Ptr_borders->insideHorizontal.thickness=0;0;$Ptr_borders->thicknessToSet)
				$Ptr_borders->insideVertical.thickness:=Choose:C955($Ptr_borders->insideVertical.thickness=0;0;$Ptr_borders->thicknessToSet)
				$Ptr_borders->left.thickness:=Choose:C955($Ptr_borders->left.thickness=0;0;$Ptr_borders->thicknessToSet)
				$Ptr_borders->right.thickness:=Choose:C955($Ptr_borders->right.thickness=0;0;$Ptr_borders->thicknessToSet)
				
				
				  //QR_SET_BORDER_PROPERTIES ($Lon_area;$Ptr_borders->;$Lon_column;$Lon_row)
				  //update UI
				(OBJECT Get pointer:C1124(Object named:K67:5;$Txt_me+".label"))->:=Get localized string:C991("menu_thickness"+String:C10($Txt_action))
				
			End if 
			
			
			  //______________________________________________________
		Else 
			
			ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
			
			  //______________________________________________________
	End case 
End if 

