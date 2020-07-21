//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : NQR_AREA_HANDLE
// Database: 4D Report
// ID[7A4FEBBE877F4162AF12AA052DB564BE]
// Created #4-6-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
// Handle area calls
// ----------------------------------------------------
// Declarations
C_OBJECT:C1216($1)

C_BOOLEAN:C305($Boo_crossReport)
C_LONGINT:C283($Lon_area; $Lon_bottom; $Lon_columnIndex; $Lon_hidden; $Lon_left; $Lon_middle)
C_LONGINT:C283($Lon_parameters; $Lon_qrColumn; $Lon_qrColumnNumber; $Lon_qrRow; $Lon_repeated; $Lon_right)
C_LONGINT:C283($Lon_rowIndex; $Lon_sort_index; $Lon_top; $Lon_width)
C_TEXT:C284($Mnu_pop; $Mnu_sub; $Txt_action; $Txt_format; $Txt_formula; $Txt_object)
C_TEXT:C284($Txt_src; $Txt_title)
C_OBJECT:C1216($Obj_message; $Obj_param)

If (False:C215)
	C_OBJECT:C1216(NQR_AREA_HANDLE; $1)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1; "Missing parameter"))
	
	//Required parameters
	$Obj_param:=$1
	
	ASSERT:C1129(OB Is defined:C1231($Obj_param))
	
	//Optional parameters
	If ($Lon_parameters>=2)
		
		//NONE
		
	Else 
		
		$Txt_object:=OBJECT Get name:C1087(Object current:K67:2)
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
//first get the action…
If (OB Is defined:C1231($Obj_param; "action"))
	
	$Txt_action:=OB Get:C1224($Obj_param; "action"; Is text:K8:3)
	
	//…delete…
	OB REMOVE:C1226($Obj_param; "action")
	
	//…then do it
	
	If ($Txt_action="@_context_menu")
		
		$Mnu_pop:=Create menu:C408
		
		$Lon_area:=OB Get:C1224(ob_area; "area"; Is longint:K8:6)
		$Boo_crossReport:=OB Get:C1224(ob_area; "crossReport"; Is boolean:K8:9)
		$Lon_columnIndex:=OB Get:C1224(ob_area; "columnIndex"; Is longint:K8:6)
		$Lon_rowIndex:=OB Get:C1224(ob_area; "rowIndex"; Is longint:K8:6)
		$Lon_qrRow:=OB Get:C1224(ob_area; "qrRow"; Is longint:K8:6)
		$Lon_qrColumn:=OB Get:C1224(ob_area; "qrColumn"; Is longint:K8:6)
		$Lon_qrColumnNumber:=OB Get:C1224(ob_area; "qrColumnNumber"; Is longint:K8:6)
		
	End if 
	
	//===========================================================================
	
	Case of 
			
			//………………………………………………………………………………………………………………………………………………………
		: ($Txt_action="update")
			
			QR_area:=QR_area  //force update
			
			CLEAR VARIABLE:C89($Txt_action)  //stop
			
			//………………………………………………………………………………………………………………………………………………………
		: ($Txt_action="show_plus")  //show the UI add/insert column
			
			If (OB Get:C1224(ob_area; "reportType"; Is longint:K8:6)=qr list report:K14902:1)
				
				If (Not:C34(OBJECT Get visible:C1075(*; "fieldList")))
					
					$Lon_middle:=OB Get:C1224($Obj_param; "middle"; Is longint:K8:6)-1
					OB REMOVE:C1226($Obj_param; "middle")
					
					If ($Lon_middle#0)
						
						If (OBJECT Get visible:C1075(*; "fieldList"))
							
							OBJECT GET COORDINATES:C663(*; "fieldList"; $Lon_left; $Lon_top; $Lon_right; $Lon_bottom)
							$Lon_middle:=$Lon_middle+$Lon_right
							
						End if 
						
						OBJECT GET COORDINATES:C663(*; $Txt_object; $Lon_left; $Lon_top; $Lon_right; $Lon_bottom)
						
						//place the line
						OBJECT SET COORDINATES:C1248(*; "plus.line"; $Lon_middle; $Lon_top; $Lon_middle; $Lon_bottom)
						
						//place the Add button
						$Lon_left:=$Lon_middle-10
						$Lon_top:=$Lon_top-10
						$Lon_right:=$Lon_middle+10
						$Lon_bottom:=$Lon_top+20
						
						OBJECT SET COORDINATES:C1248(*; "plus.button"; $Lon_left; $Lon_top; $Lon_right; $Lon_bottom)
						
						OBJECT SET VISIBLE:C603(*; "plus.@"; True:C214)
						
					End if 
				End if 
			End if 
			
			CLEAR VARIABLE:C89($Txt_action)  //stop
			
			//………………………………………………………………………………………………………………………………………………………
		: ($Txt_action="hide_plus")  //hide the UI add/insert colum
			
			If (OB Get:C1224(ob_area; "area"; Is longint:K8:6)#0)
				
				//the UI will be not hidden if there is no column
				$Lon_qrColumnNumber:=OB Get:C1224(ob_area; "qrColumnNumber"; Is longint:K8:6)
				OBJECT SET VISIBLE:C603(*; "plus@"; $Lon_qrColumnNumber=0)
				
			End if 
			
			CLEAR VARIABLE:C89($Txt_action)  //stop
			
			//………………………………………………………………………………………………………………………………………………………
		: ($Lon_area=0)
			
			//………………………………………………………………………………………………………………………………………………………
		: ($Txt_action="area_context_menu")  // display contextual menu for the top left header (list only)
			
			$Lon_qrColumnNumber:=OB Get:C1224(ob_area; "qrColumnNumber"; Is longint:K8:6)
			
			If ($Lon_qrColumnNumber=0)
				
				APPEND MENU ITEM:C411($Mnu_pop; ":xliff:menu_add_column")
				SET MENU ITEM PARAMETER:C1004($Mnu_pop; -1; "insert_end")
				
			Else 
				
				$Mnu_sub:=Create menu:C408
				
				APPEND MENU ITEM:C411($Mnu_sub; ":xliff:menu_insert_begin")
				SET MENU ITEM PARAMETER:C1004($Mnu_sub; -1; "insert_begin")
				
				APPEND MENU ITEM:C411($Mnu_sub; ":xliff:menu_insert_end")
				SET MENU ITEM PARAMETER:C1004($Mnu_sub; -1; "insert_end")
				
				APPEND MENU ITEM:C411($Mnu_pop; ":xliff:menu_new_column"; $Mnu_sub)
				RELEASE MENU:C978($Mnu_sub)
				
			End if 
			
			$Txt_action:=Dynamic pop up menu:C1006($Mnu_pop)
			
			//………………………………………………………………………………………………………………………………………………………
		: ($Txt_action="line_context_menu")  // display contextual menu for the line's header (list only)
			
			$Lon_hidden:=QR Get info row:C769($Lon_area; $Lon_qrRow)
			
			APPEND MENU ITEM:C411($Mnu_pop; ":xliff:"+Choose:C955($Lon_qrRow>0; "menu_hide_break_line"; "menu_hide_row"))
			
			SET MENU ITEM PARAMETER:C1004($Mnu_pop; -1; "hide_row")
			
			SET MENU ITEM MARK:C208($Mnu_pop; -1; Char:C90(18)*Num:C11($Lon_hidden=1))
			
			If ($Lon_qrRow>0)
				
				APPEND MENU ITEM:C411($Mnu_pop; "-")
				
				APPEND MENU ITEM:C411($Mnu_pop; ":xliff:menu_delete_break_line")
				SET MENU ITEM PARAMETER:C1004($Mnu_pop; -1; "delete_row")
				
			End if 
			
			If ($Lon_qrRow>0)\
				 | ($Lon_qrRow=qr grand total:K14906:3)
				
				APPEND MENU ITEM:C411($Mnu_pop; "-")
				
				APPEND MENU ITEM:C411($Mnu_pop; ":xliff:menu_clear_content")
				SET MENU ITEM PARAMETER:C1004($Mnu_pop; -1; "clear_content")
				
			End if 
			
			$Txt_action:=Dynamic pop up menu:C1006($Mnu_pop)
			
			//………………………………………………………………………………………………………………………………………………………
		: ($Txt_action="cell_context_menu")  // display contextual menu for a cell
			
			If ($Boo_crossReport)
				
				If ($Lon_qrColumn>0)
					
					QR GET INFO COLUMN:C766($Lon_area; $Lon_qrColumn; $Txt_title; $Txt_object; $Lon_hidden; $Lon_width; $Lon_repeated; $Txt_format; $Txt_formula)
					
					APPEND MENU ITEM:C411($Mnu_pop; ":xliff:menu_edit_formula")
					SET MENU ITEM PARAMETER:C1004($Mnu_pop; -1; "edit_formula")
					
				End if 
				
				If ($Lon_columnIndex>1)\
					 & ($Lon_rowIndex>1)
					
					APPEND MENU ITEM:C411($Mnu_pop; "-")
					
					APPEND MENU ITEM:C411($Mnu_pop; ":xliff:menu_clear_content")
					SET MENU ITEM PARAMETER:C1004($Mnu_pop; -1; "clear_content")
					
				End if 
				
			Else 
				
				APPEND MENU ITEM:C411($Mnu_pop; ":xliff:menu_edit")
				SET MENU ITEM PARAMETER:C1004($Mnu_pop; -1; "edit_cell")
				
				If ($Lon_qrRow>0)\
					 | ($Lon_qrRow=qr grand total:K14906:3)
					
					APPEND MENU ITEM:C411($Mnu_pop; "-")
					
					APPEND MENU ITEM:C411($Mnu_pop; ":xliff:menu_clear_content")
					SET MENU ITEM PARAMETER:C1004($Mnu_pop; -1; "clear_content")
					
				End if 
			End if 
			
			$Txt_action:=Dynamic pop up menu:C1006($Mnu_pop)
			
			//………………………………………………………………………………………………………………………………………………………
		: ($Txt_action="header_context_menu")  // display contextual menu for the column's header (list only)
			
			If ($Lon_qrColumnNumber=0)
				
				APPEND MENU ITEM:C411($Mnu_pop; ":xliff:menu_add_column")
				SET MENU ITEM PARAMETER:C1004($Mnu_pop; -1; "insert_end")
				
			Else 
				
				$Mnu_sub:=Create menu:C408
				
				If ($Lon_columnIndex>1)
					
					APPEND MENU ITEM:C411($Mnu_sub; ":xliff:menu_insert_before")
					SET MENU ITEM PARAMETER:C1004($Mnu_sub; -1; "insert_before")
					
					APPEND MENU ITEM:C411($Mnu_sub; ":xliff:menu_insert_after")
					SET MENU ITEM PARAMETER:C1004($Mnu_sub; -1; "insert_after")
					
					APPEND MENU ITEM:C411($Mnu_sub; "-")
					
					If ($Lon_qrColumn>1)
						
						APPEND MENU ITEM:C411($Mnu_sub; ":xliff:menu_insert_begin")
						SET MENU ITEM PARAMETER:C1004($Mnu_sub; -1; "insert_begin")
						
					End if 
					
					If ($Lon_qrColumn<$Lon_qrColumnNumber)
						
						APPEND MENU ITEM:C411($Mnu_sub; ":xliff:menu_insert_end")
						SET MENU ITEM PARAMETER:C1004($Mnu_sub; -1; "insert_end")
						
					End if 
					
					If (Get menu item:C422($Mnu_sub; -1)="-")
						
						DELETE MENU ITEM:C413($Mnu_sub; -1)
						
					End if 
					
					APPEND MENU ITEM:C411($Mnu_pop; ":xliff:menu_new_column"; $Mnu_sub)
					RELEASE MENU:C978($Mnu_sub)
					
					If ($Lon_qrColumn<=$Lon_qrColumnNumber)
						
						QR GET INFO COLUMN:C766($Lon_area; $Lon_qrColumn; $Txt_title; $Txt_object; $Lon_hidden; $Lon_width; $Lon_repeated; $Txt_format; $Txt_formula)
						
						APPEND MENU ITEM:C411($Mnu_pop; ":xliff:menu_duplicate_column")
						SET MENU ITEM PARAMETER:C1004($Mnu_pop; -1; "duplicate")
						
						APPEND MENU ITEM:C411($Mnu_pop; "-")
						
						APPEND MENU ITEM:C411($Mnu_pop; ":xliff:menu_edit_formula")
						SET MENU ITEM PARAMETER:C1004($Mnu_pop; -1; "edit_formula")
						
						APPEND MENU ITEM:C411($Mnu_pop; "-")
						
						APPEND MENU ITEM:C411($Mnu_pop; ":xliff:menu_hide_column")
						SET MENU ITEM PARAMETER:C1004($Mnu_pop; -1; "hide_column")
						SET MENU ITEM MARK:C208($Mnu_pop; -1; Char:C90(18)*Num:C11($Lon_hidden=1))
						
						APPEND MENU ITEM:C411($Mnu_pop; ":xliff:menu_delete_column")
						SET MENU ITEM PARAMETER:C1004($Mnu_pop; -1; "delete_column")
						
					End if 
					
				Else 
					
					APPEND MENU ITEM:C411($Mnu_sub; ":xliff:menu_insert_begin")
					SET MENU ITEM PARAMETER:C1004($Mnu_sub; -1; "insert_begin")
					
					APPEND MENU ITEM:C411($Mnu_sub; ":xliff:menu_insert_end")
					SET MENU ITEM PARAMETER:C1004($Mnu_sub; -1; "insert_end")
					
					APPEND MENU ITEM:C411($Mnu_pop; ":xliff:menu_new_column"; $Mnu_sub)
					RELEASE MENU:C978($Mnu_sub)
					
				End if 
			End if 
			
			$Txt_action:=Dynamic pop up menu:C1006($Mnu_pop)
			
			//………………………………………………………………………………………………………………………………………………………
	End case 
	
	If (Length:C16($Mnu_pop)>0)
		
		RELEASE MENU:C978($Mnu_pop)
		
	End if 
	
	//===========================================================================
	
	//One more time?
	
	//===========================================================================
	
	Case of 
			
			//______________________________________________________
		: (Length:C16($Txt_action)=0)
			
			//NOTHING MORE TO DO
			
			//______________________________________________________
		: ($Txt_action="edit_cell")
			
			//#TO_BE_DONE
			
			//______________________________________________________
		: ($Txt_action="clear_content")
			
			If ($Boo_crossReport)
				
				QR_CLEAR_CONTENTS($Lon_area; $Lon_columnIndex; $Lon_rowIndex)
				
			Else 
				
				QR_CLEAR_CONTENTS($Lon_area; $Lon_qrColumn; $Lon_qrRow)
				
			End if 
			
			//______________________________________________________
		: ($Txt_action="insert_@")\
			 | ($Txt_action="duplicate")
			
			If ($Txt_action="insert_field")
				
				OBJECT SET VISIBLE:C603(*; "plus.@"; False:C215)
				
				EXECUTE METHOD IN SUBFORM:C1085("myQR"; "report_ADD_COLUMN"; *; $Txt_action; $Obj_param)
				
			Else 
				
				EXECUTE METHOD IN SUBFORM:C1085("myQR"; "report_ADD_COLUMN"; *; $Txt_action)
				
			End if 
			
			//______________________________________________________
		: ($Txt_action="edit_formula")
			
			If (Length:C16($Txt_formula)=0)
				
				$Txt_object:=Parse formula:C1576($Txt_object; Formula out with virtual structure:K88:2)
				
			End if 
			
			EDIT FORMULA:C806(Table:C252(QR Get report table:C758($Lon_area))->; $Txt_object)
			
			If (OK=1)
				
				QR SET INFO COLUMN:C765($Lon_area; $Lon_qrColumn; $Txt_title; $Txt_object; $Lon_hidden; $Lon_width; $Lon_repeated; $Txt_format)
				
			End if 
			
			//______________________________________________________
		: ($Txt_action="hide_column")
			
			QR SET INFO COLUMN:C765($Lon_area; $Lon_qrColumn; $Txt_title; $Txt_object; Abs:C99($Lon_hidden-1); $Lon_width; $Lon_repeated; $Txt_format)
			
			//______________________________________________________
		: ($Txt_action="hide_row")
			
			QR SET INFO ROW:C763($Lon_area; $Lon_qrRow; Abs:C99(1-$Lon_hidden))
			
			//______________________________________________________
		: ($Txt_action="delete_column")
			
			ARRAY LONGINT:C221($tLon_sortedColumns; 0x0000)
			ARRAY LONGINT:C221($tLon_sortOrder; 0x0000)
			
			QR GET SORTS:C753($Lon_area; $tLon_sortedColumns; $tLon_sortOrder)
			$Lon_sort_index:=Find in array:C230($tLon_sortedColumns; $Lon_qrColumn)
			
			QR GET INFO COLUMN:C766($Lon_area; $Lon_qrColumn; $Txt_title; $Txt_object; $Lon_hidden; $Lon_width; $Lon_repeated; $Txt_format)
			
			$Txt_src:="delete-column"
			
			OB SET:C1220($Obj_message; \
				"src"; $Txt_src)
			
			//Development #14741
			OB SET:C1220(ob_area; \
				"message"; True:C214)
			
			If (mess_Preferences($Txt_src))
				
				If ($Lon_sort_index>0)\
					 & ($Lon_hidden=0)
					
					//sorted and not hidden
					OB SET:C1220($Obj_message; \
						"message"; Get localized string:C991("areYouSure"); \
						"comment"; Get localized string:C991("theSubtotalRowAssociatedWillBeRemoved.")+"\r"+Get localized string:C991("youCanHideTheColumnAndKeepTheSortingData"); \
						"doLabel"; Get localized string:C991("remove"); \
						"cancelLabel"; Get localized string:C991("cancel"); \
						"forgetLabel"; Get localized string:C991("menu_hide"); \
						"checkbox"; False:C215)
					
					mess_DISPLAY($Obj_message)
					
				Else 
					
					OB SET:C1220($Obj_message; \
						"action"; "ok")
					
					NQR_DO_IT($Obj_message)
					
				End if 
				
			Else 
				
				OB SET:C1220($Obj_message; \
					"action"; "ok")
				
				NQR_DO_IT($Obj_message)
				
			End if 
			
			//______________________________________________________
		: ($Txt_action="delete_row")  //= sort none
			
			$Txt_src:="delete-breakline"
			
			OB SET:C1220($Obj_message; \
				"src"; $Txt_src)
			
			//Development #14741
			OB SET:C1220(ob_area; \
				"message"; True:C214)
			
			If (mess_Preferences($Txt_src))
				
				If (QR Get info row:C769($Lon_area; $Lon_qrRow)=1)
					
					//hidden row
					OB SET:C1220($Obj_message; \
						"message"; Get localized string:C991("areYouSure"); \
						"comment"; Get localized string:C991("thisColumnWillNoMoreBeSorted"); \
						"doLabel"; Get localized string:C991("remove"); \
						"cancelLabel"; Get localized string:C991("cancel"))
					
				Else 
					
					OB SET:C1220($Obj_message; \
						"message"; Get localized string:C991("areYouSure"); \
						"comment"; Get localized string:C991("thisColumnWillNoMoreBeSorted")+"\r"+Get localized string:C991("youCanHideTheLineAndKeepTheSortingData"); \
						"doLabel"; Get localized string:C991("remove"); \
						"cancelLabel"; Get localized string:C991("cancel"); \
						"forgetLabel"; Get localized string:C991("menu_hide"))
					
				End if 
				
				mess_DISPLAY($Obj_message)
				
			Else 
				
				OB SET:C1220($Obj_message; \
					"action"; "ok")
				
				NQR_DO_IT($Obj_message)
				
			End if 
			
			//______________________________________________________
		Else 
			
			ASSERT:C1129(False:C215; "Unknown entry point: \""+$Txt_action+"\"")
			
			//______________________________________________________
	End case 
	
	//finally clear the message
	CLEAR VARIABLE:C89($Obj_param)
	
End if 

//don't display the UI add/insert colum if field list is displayed
If (OBJECT Get visible:C1075(*; "fieldList"))
	
	OBJECT SET VISIBLE:C603(*; "plus@"; False:C215)
	
End if 

//===========================================================================

// ----------------------------------------------------
// Return

//<NONE>

// ----------------------------------------------------
// End