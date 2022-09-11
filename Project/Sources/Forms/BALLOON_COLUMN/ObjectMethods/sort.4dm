// ----------------------------------------------------
// Object method : BALLOON_COLUMN.sort - (4D Report)
// ID[F370EEDE38454504A8EB44EFCC0D1056]
// Created #18-9-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Declarations
C_LONGINT:C283($Lon_area; $Lon_column; $Lon_formEvent; $Lon_row; $Lon_sort_index)
C_POINTER:C301($Ptr_me)
C_TEXT:C284($Mnu_main; $Txt_action; $Txt_me)
C_OBJECT:C1216($Obj_caller)

ARRAY LONGINT:C221($tLon_sortedColumns; 0)
ARRAY LONGINT:C221($tLon_sortOrder; 0)

// ----------------------------------------------------
// Initialisations
$Lon_formEvent:=Form event code:C388
$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)
$Ptr_me:=OBJECT Get pointer:C1124(Object current:K67:2)

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($Lon_formEvent=On Clicked:K2:4)
		
		$Obj_caller:=JSON Parse:C1218((OBJECT Get pointer:C1124(Object named:K67:5; "caller"))->)
		$Lon_area:=report_Get_target($Obj_caller; ->$Lon_column; ->$Lon_row)
		CLEAR VARIABLE:C89($Obj_caller)
		QR GET SORTS:C753($Lon_area; $tLon_sortedColumns; $tLon_sortOrder)
		$Lon_sort_index:=Find in array:C230($tLon_sortedColumns; $Lon_column)
		
		If ($Lon_sort_index>0)
			
			$tLon_sortOrder{0}:=$tLon_sortOrder{$Lon_sort_index}
			
		End if 
		
		$Mnu_main:=Create menu:C408
		APPEND MENU ITEM:C411($Mnu_main; ":xliff:menu_sort_none")
		SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "none")
		SET MENU ITEM MARK:C208($Mnu_main; -1; Char:C90(18)*Num:C11($tLon_sortOrder{0}=0))
		APPEND MENU ITEM:C411($Mnu_main; "-")
		
		If (QR Get report kind:C755($Lon_area)=qr cross report:K14902:2)
			
			If ($Lon_column=2)
				
				APPEND MENU ITEM:C411($Mnu_main; ":xliff:menu_sort_leftToRight")
				SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "ascending")
				SET MENU ITEM MARK:C208($Mnu_main; -1; Char:C90(18)*Num:C11($tLon_sortOrder{0}=1))
				APPEND MENU ITEM:C411($Mnu_main; ":xliff:menu_sort_rightToLeft")
				SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "descending")
				SET MENU ITEM MARK:C208($Mnu_main; -1; Char:C90(18)*Num:C11($tLon_sortOrder{0}=-1))
				
			Else 
				
				APPEND MENU ITEM:C411($Mnu_main; ":xliff:menu_sort_topToBottom")
				SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "ascending")
				SET MENU ITEM MARK:C208($Mnu_main; -1; Char:C90(18)*Num:C11($tLon_sortOrder{0}=1))
				APPEND MENU ITEM:C411($Mnu_main; ":xliff:menu_sort_bottomToTop")
				SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "descending")
				SET MENU ITEM MARK:C208($Mnu_main; -1; Char:C90(18)*Num:C11($tLon_sortOrder{0}=-1))
				
			End if 
			
		Else 
			
			APPEND MENU ITEM:C411($Mnu_main; ":xliff:menu_sort_ascending")
			SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "ascending")
			SET MENU ITEM MARK:C208($Mnu_main; -1; Char:C90(18)*Num:C11($tLon_sortOrder{0}=1))
			APPEND MENU ITEM:C411($Mnu_main; ":xliff:menu_sort_descending")
			SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "descending")
			SET MENU ITEM MARK:C208($Mnu_main; -1; Char:C90(18)*Num:C11($tLon_sortOrder{0}=-1))
			
		End if 
		
		$Txt_action:=Dynamic pop up menu:C1006($Mnu_main)
		RELEASE MENU:C978($Mnu_main)
		
		If (Length:C16($Txt_action)>0)
			
			Case of 
					
					//______________________________________________________
				: ($Txt_action="none")
					
					If ($Lon_sort_index>0)
						
						DELETE FROM ARRAY:C228($tLon_sortedColumns; $Lon_sort_index; 1)
						DELETE FROM ARRAY:C228($tLon_sortOrder; $Lon_sort_index; 1)
						
					End if 
					
					$Txt_action:=Get localized string:C991("menu_sort_none")
					
					//------------------------------------
				: ($Txt_action="ascending")
					
					If ($Lon_sort_index>0)
						
						$tLon_sortOrder{$Lon_sort_index}:=1
						
					Else 
						
						APPEND TO ARRAY:C911($tLon_sortedColumns; $Lon_column)
						APPEND TO ARRAY:C911($tLon_sortOrder; 1)
						
					End if 
					
					If (QR Get report kind:C755($Lon_area)=qr cross report:K14902:2)
						
						$Txt_action:=Choose:C955($Lon_column=2; \
							Get localized string:C991("menu_sort_leftToRight"); \
							Get localized string:C991("menu_sort_topToBottom"))
						
					Else 
						
						$Txt_action:=Get localized string:C991("menu_sort_ascending")
						
					End if 
					
					//------------------------------------
				: ($Txt_action="descending")
					
					If ($Lon_sort_index>0)
						
						$tLon_sortOrder{$Lon_sort_index}:=-1
						
					Else 
						
						APPEND TO ARRAY:C911($tLon_sortedColumns; $Lon_column)
						APPEND TO ARRAY:C911($tLon_sortOrder; -1)
						
					End if 
					
					If (QR Get report kind:C755($Lon_area)=qr cross report:K14902:2)
						
						$Txt_action:=Choose:C955($Lon_column=2; \
							Get localized string:C991("menu_sort_rightToLeft"); \
							Get localized string:C991("menu_sort_bottomToTop"))
						
					Else 
						
						$Txt_action:=Get localized string:C991("menu_sort_descending")
						
					End if 
					
					//------------------------------------
			End case 
			
			//update UI
			(OBJECT Get pointer:C1124(Object named:K67:5; $Txt_me+".label"))->:=$Txt_action
			
			//update area
			QR SET SORTS:C752($Lon_area; $tLon_sortedColumns; $tLon_sortOrder)
			
			ob_area.modified:=True:C214
			
		End if 
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		//______________________________________________________
End case 