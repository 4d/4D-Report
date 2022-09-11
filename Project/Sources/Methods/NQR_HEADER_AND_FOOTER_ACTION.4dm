//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : NQR_HEADER_AND_FOOTER_ACTION
// Database: 4D Report
// ID[B0133B60955A41AAAD04581C9D6FD7B1]
// Created #12-6-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_TEXT:C284($1)

C_LONGINT:C283($Lon_; $Lon_action; $Lon_alignment; $Lon_bottom; $Lon_end; $Lon_height)
C_LONGINT:C283($Lon_left; $Lon_offset; $Lon_parameters; $Lon_right; $Lon_right2; $Lon_start)
C_LONGINT:C283($Lon_top; $Lon_unit; $Lon_width)
C_POINTER:C301($Ptr_box; $Ptr_unit)
C_TEXT:C284($Mnu_pop; $Txt_action; $Txt_buffer; $Txt_object)

If (False:C215)
	C_TEXT:C284(NQR_HEADER_AND_FOOTER_ACTION; $1)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1; "Missing parameter"))
	
	//Required parameters
	$Txt_action:=$1
	
	//Optional parameters
	If ($Lon_parameters>=2)
		
		// <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($Txt_action="hide")
		
		OBJECT SET VISIBLE:C603(*; "action"; False:C215)
		
		//______________________________________________________
	: ($Txt_action="show")
		
		$Txt_object:=OBJECT Get name:C1087(Object with focus:K67:3)
		
		//keep the current textbox
		(OBJECT Get pointer:C1124(Object named:K67:5; "current_1"))->:=$Txt_object
		
		OBJECT GET COORDINATES:C663(*; "action"; $Lon_; $Lon_; $Lon_right; $Lon_)
		OBJECT GET COORDINATES:C663(*; $Txt_object; $Lon_left; $Lon_top; $Lon_right2; $Lon_bottom)
		
		OBJECT SET COORDINATES:C1248(*; "textbox"; $Lon_left; $Lon_top; $Lon_right2; $Lon_bottom)
		
		$Lon_offset:=$Lon_right2-$Lon_right
		OBJECT MOVE:C664(*; "action"; $Lon_offset; 0)
		OBJECT SET VISIBLE:C603(*; "action"; True:C214)
		
		//______________________________________________________
	: ($Txt_action="menu.textbox")
		
		$Mnu_pop:=Create menu:C408
		
		APPEND MENU ITEM:C411($Mnu_pop; ":xliff:pageNumber")
		SET MENU ITEM PARAMETER:C1004($Mnu_pop; -1; "#P")
		
		APPEND MENU ITEM:C411($Mnu_pop; ":xliff:executionDate")
		SET MENU ITEM PARAMETER:C1004($Mnu_pop; -1; "#D")
		
		APPEND MENU ITEM:C411($Mnu_pop; ":xliff:executionTime")
		SET MENU ITEM PARAMETER:C1004($Mnu_pop; -1; "#H")
		
		$Txt_action:=Dynamic pop up menu:C1006($Mnu_pop)
		RELEASE MENU:C978($Mnu_pop)
		
		Case of 
				
				//………………………………………………………………
			: (Length:C16($Txt_action)=0)
				
				//NOTHING MORE TO DO
				
				//………………………………………………………………
			: ($Txt_action="#@")  // Add/Insert
				
				$Ptr_box:=OBJECT Get pointer:C1124(Object with focus:K67:3)
				GET HIGHLIGHT:C209($Ptr_box->; $Lon_start; $Lon_end)
				
				$Txt_buffer:=$Ptr_box->
				
				If ($Lon_start>0)
					
					$Ptr_box->:=Substring:C12($Txt_buffer; 1; $Lon_start-1)\
						+$Txt_action\
						+Substring:C12($Txt_buffer; $Lon_end)
					
				End if 
				
				HIGHLIGHT TEXT:C210($Ptr_box->; $Lon_start+2; $Lon_start+2)
				
				ob_area.modified:=True:C214
				
				//………………………………………………………………
			Else 
				
				TRACE:C157
				
				//………………………………………………………………
		End case 
		
		//______________________________________________________
	: ($Txt_action="menu.picture")
		
		$Lon_alignment:=(OBJECT Get pointer:C1124(Object named:K67:5; "alignment"))->
		PICTURE PROPERTIES:C457((OBJECT Get pointer:C1124(Object named:K67:5; "picture"))->; $Lon_width; $Lon_height)
		
		$Mnu_pop:=Create menu:C408
		
		APPEND MENU ITEM:C411($Mnu_pop; ":xliff:load")
		SET MENU ITEM PARAMETER:C1004($Mnu_pop; -1; "-1")
		
		APPEND MENU ITEM:C411($Mnu_pop; ":xliff:clear")
		SET MENU ITEM PARAMETER:C1004($Mnu_pop; -1; "-2")
		
		If ($Lon_height=0)
			
			DISABLE MENU ITEM:C150($Mnu_pop; -1)
			
		End if 
		
		APPEND MENU ITEM:C411($Mnu_pop; "-")
		
		APPEND MENU ITEM:C411($Mnu_pop; ":xliff:alignedToLeft")
		SET MENU ITEM PARAMETER:C1004($Mnu_pop; -1; "1")
		
		If ($Lon_alignment=1)
			
			SET MENU ITEM MARK:C208($Mnu_pop; -1; Char:C90(19))
			
		End if 
		
		APPEND MENU ITEM:C411($Mnu_pop; ":xliff:centered")
		SET MENU ITEM PARAMETER:C1004($Mnu_pop; -1; "2")
		
		If ($Lon_alignment=2)
			
			SET MENU ITEM MARK:C208($Mnu_pop; -1; Char:C90(19))
			
		End if 
		
		APPEND MENU ITEM:C411($Mnu_pop; ":xliff:alignedToRight")
		SET MENU ITEM PARAMETER:C1004($Mnu_pop; -1; "3")
		
		If ($Lon_alignment=3)
			
			SET MENU ITEM MARK:C208($Mnu_pop; -1; Char:C90(19))
			
		End if 
		
		APPEND MENU ITEM:C411($Mnu_pop; "-")
		
		APPEND MENU ITEM:C411($Mnu_pop; ":xliff:affectTheHeightOfThePictureToTheArea")
		SET MENU ITEM PARAMETER:C1004($Mnu_pop; -1; "-3")
		
		If ($Lon_height=0)
			
			DISABLE MENU ITEM:C150($Mnu_pop; -1)
			
		End if 
		
		$Lon_action:=Num:C11(Dynamic pop up menu:C1006($Mnu_pop))
		RELEASE MENU:C978($Mnu_pop)
		
		Case of 
				
				//………………………………………………………………
			: ($Lon_action=0)
				
				//NOTHING MORE TO DO
				
				//………………………………………………………………
			: ($Lon_action=-1)  //import
				
				READ PICTURE FILE:C678(""; (OBJECT Get pointer:C1124(Object named:K67:5; "picture"))->)
				
				ob_area.modified:=True:C214
				
				//………………………………………………………………
			: ($Lon_action=-2)  //clear
				
				CLEAR VARIABLE:C89((OBJECT Get pointer:C1124(Object named:K67:5; "picture"))->)
				
				//reset default height
				(OBJECT Get pointer:C1124(Object named:K67:5; "height"))->:=25
				(OBJECT Get pointer:C1124(Object named:K67:5; "height.points"))->:=25
				
				$Ptr_unit:=OBJECT Get pointer:C1124(Object named:K67:5; "height.unit")
				$Lon_unit:=$Ptr_unit->
				
				If ($Lon_unit#1)
					
					//hide current
					SVG SET ATTRIBUTE:C1055(*; "unit"; String:C10($Lon_unit); \
						"visibility"; "hidden")
					
					//change unit
					$Ptr_unit->:=1
					SVG SET ATTRIBUTE:C1055(*; "unit"; "1"; \
						"visibility"; "visible")
					
				End if 
				
				ob_area.modified:=True:C214
				
				//………………………………………………………………
			: ($Lon_action=-3)  //affect height of the picture to the area
				
				//height is in points
				(OBJECT Get pointer:C1124(Object named:K67:5; "height"))->:=$Lon_height
				(OBJECT Get pointer:C1124(Object named:K67:5; "height.points"))->:=$Lon_height
				
				$Ptr_unit:=OBJECT Get pointer:C1124(Object named:K67:5; "height.unit")
				$Lon_unit:=$Ptr_unit->
				
				If ($Lon_unit#1)
					
					//hide current
					SVG SET ATTRIBUTE:C1055(*; "unit"; String:C10($Lon_unit); \
						"visibility"; "hidden")
					
					//change unit
					$Ptr_unit->:=1
					SVG SET ATTRIBUTE:C1055(*; "unit"; "1"; \
						"visibility"; "visible")
					
				End if 
				
				ob_area.modified:=True:C214
				
				//………………………………………………………………
			Else 
				
				(OBJECT Get pointer:C1124(Object named:K67:5; "alignment"))->:=$Lon_action
				
				//………………………………………………………………
		End case 
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Unknown entry point: \""+$Txt_action+"\"")
		
		//______________________________________________________
End case 

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End