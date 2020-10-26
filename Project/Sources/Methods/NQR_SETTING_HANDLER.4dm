//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : NQR_SETTING_HANDLER
// Database: 4D Report
// ID[7E22CBAE04F84D55ADDB9195702986DD]
// Created #7-12-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_TEXT:C284($1)
C_LONGINT:C283($2)

C_BOOLEAN:C305($Boo_allowDuplicateField; $Boo_expanded)
C_LONGINT:C283($Lon_buffer; $Lon_count; $Lon_destination; $Lon_destRef; $Lon_field; $Lon_i)
C_LONGINT:C283($Lon_ID; $Lon_parameters; $Lon_parent; $Lon_position; $Lon_process; $Lon_reference)
C_LONGINT:C283($Lon_source; $Lon_table; $Lst_sub; $lon_Found)
C_PICTURE:C286($Pic_icon)
C_POINTER:C301($Ptr_report; $Ptr_source)
C_TEXT:C284($Txt_; $Txt_action; $Txt_Buffer; $Txt_formula; $Txt_label; $Txt_table)

ARRAY LONGINT:C221($tLon_selected; 0)

If (False:C215)
	C_TEXT:C284(NQR_SETTING_HANDLER; $1)
	C_LONGINT:C283(NQR_SETTING_HANDLER; $2)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1; "Missing parameter"))
	
	//Required parameters
	$Txt_action:=$1
	
	//Optional parameters
	If ($Lon_parameters>=2)
		
		$Lon_reference:=$2
		
	End if 
	
	$Ptr_report:=OBJECT Get pointer:C1124(Object named:K67:5; "report.list")
	
	//allow or not multiple occurrences of field into the report
	$Boo_allowDuplicateField:=False:C215
	
Else 
	
	ABORT:C156
	
End if 

ASSERT:C1129(Not:C34(Shift down:C543) & Not:C34(Is compiled mode:C492))
// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($Txt_action="update")
		
		//NOTHING MORE TO DO
		
		//______________________________________________________
	: ($Txt_action="add")
		
		//get an available negative ID
		$Lon_ID:=-1
		
		While (List item position:C629($Ptr_report->; $Lon_ID)>0)
			
			$Lon_ID:=$Lon_ID-1
			
		End while 
		
		$Lon_position:=List item position:C629(*; "field.list"; $Lon_reference)
		
		//get current item description
		GET LIST ITEM:C378(*; "field.list"; $Lon_position; $Lon_reference; $Txt_formula; $Lst_sub; $Boo_expanded)
		
		If (Is a list:C621($Lst_sub)) & False:C215
			
			//add all fields of the linked table
			$Txt_table:="["+$Txt_formula+"]"
			
			For ($Lon_i; 1; Count list items:C380($Lst_sub; *); 1)
				
				//get subitem description
				GET LIST ITEM:C378($Lst_sub; $Lon_i; $Lon_reference; $Txt_formula)
				
				$Txt_formula:=$Txt_table+$Txt_formula
				
				//add the field if not in the list
				If (Find in list:C952($Ptr_report->; $Txt_formula; 0)=0)\
					 | $Boo_allowDuplicateField
					
					//append
					$Lon_ID:=$Lon_ID-Num:C11($Lon_i>1)
					APPEND TO LIST:C376($Ptr_report->; $Txt_formula; $Lon_ID)
					
					list_ITEM_COPY_METADATA($Lst_sub; $Ptr_report->; $Lon_reference)
					
				Else 
					
					$Lon_ID:=Find in list:C952($Ptr_report->; $Txt_formula; 0; *)
					
				End if 
				
				SELECT LIST ITEMS BY REFERENCE:C630($Ptr_report->; $Lon_ID)
				
			End for 
			
		Else 
			
			$Lon_parent:=List item parent:C633(*; "field.list"; $Lon_reference)
			
			If ($Lon_parent#0)  //linked table's field
				
				$Lon_position:=List item position:C629(*; "field.list"; $Lon_parent)
				GET LIST ITEM:C378(*; "field.list"; $Lon_position; $Lon_buffer; $Txt_table)
				
			Else 
				If (<>withFeature111172)
					
					$Txt_table:=db_virtualTableName(C_QR_MASTERTABLE)
					
				Else 
					
					$Txt_table:=Table name:C256(C_QR_MASTERTABLE)
					
				End if 
			End if 
			
			$Txt_formula:="["+$Txt_table+"]"+$Txt_formula
			
			If (Find in list:C952($Ptr_report->; $Txt_formula; 0)=0)\
				 | $Boo_allowDuplicateField
				
				//append
				APPEND TO LIST:C376($Ptr_report->; $Txt_formula; $Lon_ID)
				list_ITEM_COPY_METADATA(OBJECT Get pointer:C1124(Object named:K67:5; "field.list")->; $Ptr_report->; $Lon_reference; $Lon_ID)
				
			Else 
				
				$Lon_ID:=Find in list:C952($Ptr_report->; $Txt_formula; 0; *)
				
			End if 
			
			SELECT LIST ITEMS BY REFERENCE:C630($Ptr_report->; $Lon_ID)
			
		End if 
		
		//______________________________________________________
	: ($Txt_action="move")
		
		//get the information about the drag and drop source object
		_O_DRAG AND DROP PROPERTIES:C607($Ptr_source; $Lon_source; $Lon_process)
		
		//get the destination element number
		$Lon_destination:=Drop position:C608
		
		//if the element was not dropped over itself
		If ($Lon_destination#$Lon_source)
			
			//get source object properties
			GET LIST ITEM:C378($Ptr_source->; $Lon_source; $Lon_reference; $Txt_label)
			
			GET LIST ITEM ICON:C951($Ptr_source->; $Lon_reference; $Pic_icon)
			GET LIST ITEM PARAMETER:C985($Ptr_source->; $Lon_ID; "tableId"; $Lon_table)
			GET LIST ITEM PARAMETER:C985($Ptr_source->; $Lon_ID; "fieldId"; $Lon_field)
			
			//delete the dragged element
			DELETE FROM LIST:C624($Ptr_source->; $Lon_reference)
			
			If ($Lon_destination=-1)
				
				APPEND TO LIST:C376($Ptr_source->; $Txt_label; $Lon_reference)
				$Lon_destination:=Count list items:C380($Ptr_report->)
				
			Else 
				
				If ($Lon_destination>$Lon_source)
					
					$Lon_destination:=$Lon_destination-1
					
				End if 
				
				GET LIST ITEM:C378($Ptr_source->; $Lon_destination; $Lon_destRef; $Txt_)
				INSERT IN LIST:C625($Ptr_source->; $Lon_destRef; $Txt_label; $Lon_reference)
				
			End if 
			
			SET LIST ITEM ICON:C950($Ptr_report->; 0; $Pic_icon)
			SET LIST ITEM PARAMETER:C986($Ptr_report->; 0; "tableId"; $Lon_table)
			SET LIST ITEM PARAMETER:C986($Ptr_report->; 0; "fieldId"; $Lon_field)
			
			//update the indexes
			$Lon_count:=Count list items:C380($Ptr_report->)
			
		End if 
		
		//______________________________________________________
	: ($Txt_action="add_selected")
		
		//get the references of the selected items
		$tLon_selected{0}:=Selected list items:C379(*; "field.list"; $tLon_selected; *)
		$Lon_count:=Size of array:C274($tLon_selected)
		
		For ($Lon_i; 1; $Lon_count; 1)
			
			NQR_SETTING_HANDLER("add"; $tLon_selected{$Lon_i})
			
		End for 
		
		If ($Lon_count=1)
			
			//select next one
			$Lon_position:=List item position:C629(*; "field.list"; $tLon_selected{0})
			SELECT LIST ITEMS BY POSITION:C381(*; "field.list"; $Lon_position+1)
			
		Else 
			
			//select none
			SELECT LIST ITEMS BY POSITION:C381(*; "field.list"; MAXLONG:K35:2)
			
		End if 
		
		//______________________________________________________
	: ($Txt_action="add_one")
		
		//get the reference of the current item
		GET LIST ITEM:C378(*; "field.list"; *; $Lon_reference; $Txt_formula)
		NQR_SETTING_HANDLER("add"; $Lon_reference)
		
		//______________________________________________________
	: ($Txt_action="add_cross")
		
		//get the reference of the current item
		GET LIST ITEM:C378(*; "field.list"; *; $Lon_reference; $Txt_formula)
		$Lon_position:=List item position:C629(*; "field.list"; $Lon_reference)
		
		//get current item description
		GET LIST ITEM:C378(*; "field.list"; $Lon_position; $Lon_reference; $Txt_formula; $Lst_sub; $Boo_expanded)
		
		If (Is a list:C621($Lst_sub))
			
			BEEP:C151
			
		Else 
			
			$Lon_parent:=List item parent:C633(*; "field.list"; $Lon_reference)
			
			If ($Lon_parent#0)  //linked table's field
				
				GET LIST ITEM PARAMETER:C985(*; "field.list"; $Lon_reference; "tableId"; $Lon_buffer)
				$Txt_table:=db_virtualTableName($Lon_buffer)
				
			Else 
				
				If (<>withFeature111172)
					
					$Txt_table:=db_virtualTableName(C_QR_MASTERTABLE)
					
				Else 
					
					$Txt_table:=Table name:C256(C_QR_MASTERTABLE)
					
				End if 
				
			End if 
			
			$Txt_formula:="["+$Txt_table+"]"+$Txt_formula
			
			For ($Lon_i; 1; 3; 1)
				
				GET LIST ITEM:C378(*; "report.list"; $Lon_i; $Lon_ID; $Txt_Buffer)
				
				If (Length:C16($Txt_Buffer)=0)
					
					//update object
					ARRAY OBJECT:C1221($tObj_columns; 0x0000)
					OB GET ARRAY:C1229((OBJECT Get pointer:C1124(Object subform container:K67:4))->; "columns"; $tObj_columns)
					OB SET:C1220($tObj_columns{$Lon_i}; \
						"formula"; $Txt_formula)
					
					//update list (hidden)
					SET LIST ITEM:C385(*; "report.list"; $Lon_ID; $Txt_formula; $Lon_ID)
					
					$Ptr_report:=OBJECT Get pointer:C1124(Object named:K67:5; "report.list")
					list_ITEM_COPY_METADATA(OBJECT Get pointer:C1124(Object named:K67:5; "field.list")->; $Ptr_report->; $Lon_reference; $Lon_ID)
					
					//update preview
					SVG SET ATTRIBUTE:C1055(*; "report.cross.picture"; "txt_"+String:C10($Lon_i); \
						"4D-text"; $Txt_formula; \
						*)
					
					$Lon_i:=MAXLONG:K35:2-1
					
				End if 
			End for 
		End if 
		
		//______________________________________________________
	: ($Txt_action="add_all")
		
		For ($Lon_i; 1; Count list items:C380(*; "field.list"; *); 1)
			
			GET LIST ITEM:C378(*; "field.list"; $Lon_i; $Lon_reference; $Txt_formula)
			NQR_SETTING_HANDLER("add"; $Lon_reference)
			
		End for 
		
		//select none
		SELECT LIST ITEMS BY POSITION:C381(*; "field.list"; MAXLONG:K35:2)
		
		//______________________________________________________
	: ($Txt_action="remove_selected")
		
		//get the references of the selected items
		$tLon_selected{0}:=Selected list items:C379($Ptr_report->; $tLon_selected; *)
		
		//positon of the first item selected
		$Lon_position:=List item position:C629($Ptr_report->; $tLon_selected{0})
		
		For ($Lon_i; 1; Size of array:C274($tLon_selected); 1)
			
			DELETE FROM LIST:C624($Ptr_report->; $tLon_selected{$Lon_i})
			
		End for 
		
		$Lon_count:=Count list items:C380($Ptr_report->)
		
		If ($Lon_position<=$Lon_count)
			
			SELECT LIST ITEMS BY POSITION:C381($Ptr_report->; $Lon_position)
			
		Else 
			
			SELECT LIST ITEMS BY POSITION:C381($Ptr_report->; $Lon_count)
			
		End if 
		
		//______________________________________________________
	: ($Txt_action="remove_all")
		
		For ($Lon_i; Count list items:C380($Ptr_report->); 1; -1)
			
			GET LIST ITEM:C378($Ptr_report->; $Lon_i; $Lon_ID; $Txt_formula)
			
			DELETE FROM LIST:C624($Ptr_report->; $Lon_ID)
			
		End for 
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Unknown entry point: \""+$Txt_action+"\"")
		
		//______________________________________________________
End case 

//update UI
OBJECT SET ENABLED:C1123(*; "b.remove.all"; Count list items:C380($Ptr_report->)>0)
OBJECT SET ENABLED:C1123(*; "b.remove.one"; Selected list items:C379($Ptr_report->)>0)
OBJECT SET ENABLED:C1123(*; "b.add.one"; Selected list items:C379(*; "field.list")>0)

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End