// ----------------------------------------------------
// Object method : SETTINGS.report.cross.picture - (4D Report)
// ID[3BD42CF5158A452AAEAF4067261A8DF5]
// Created #29-6-2016 by Vincent de Lachaux
// ----------------------------------------------------
// Declarations
C_LONGINT:C283($0)

C_BOOLEAN:C305($Boo_expanded)
C_LONGINT:C283($Lon_bottom; $Lon_buffer; $Lon_button; $Lon_formEvent; $Lon_i; $Lon_ID; $lon_Found)
C_LONGINT:C283($Lon_index; $Lon_left; $Lon_mouseX; $Lon_mouseY; $Lon_parent; $Lon_position)
C_LONGINT:C283($Lon_reference; $Lon_right; $Lon_top; $Lst_sub)
C_POINTER:C301($Ptr_me; $Ptr_report)
C_TEXT:C284($Txt_Buffer; $Txt_formula; $Txt_id; $Txt_me; $Txt_table)

// ----------------------------------------------------
// Initialisations
$Lon_formEvent:=Form event code:C388
$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)
$Ptr_me:=OBJECT Get pointer:C1124(Object current:K67:2)

$0:=-1

GET MOUSE:C468($Lon_mouseX; $Lon_mouseY; $Lon_button)
CONVERT COORDINATES:C1365($Lon_mouseX; $Lon_mouseY; XY Current window:K27:6; XY Current form:K27:5)

OBJECT GET COORDINATES:C663(*; "report.cross.picture"; $Lon_left; $Lon_top; $Lon_right; $Lon_bottom)
$Lon_mouseX:=$Lon_mouseX-$Lon_left
$Lon_mouseY:=$Lon_mouseY-$Lon_top

$Txt_id:=SVG Find element ID by coordinates:C1054(*; $Txt_me; $Lon_mouseX; $Lon_mouseY)

//hide selection
For ($Lon_i; 1; 3; 1)
	
	SVG SET ATTRIBUTE:C1055(*; $Txt_me; "sel_"+String:C10($Lon_i); \
		"visibility"; "hidden")
	
End for 

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($Lon_formEvent=On Drag Over:K2:13)
		
		If (Length:C16($Txt_id)#0)
			
			SVG SET ATTRIBUTE:C1055(*; $Txt_me; "sel_"+$Txt_id[[5]]; \
				"visibility"; "visible")
			
			$0:=0
			
		End if 
		
		//______________________________________________________
	: ($Lon_formEvent=On Drop:K2:12)
		
		If (Length:C16($Txt_id)#0)
			
			GET LIST ITEM:C378(*; "field.list"; *; $Lon_reference; $Txt_formula)
			$Lon_position:=List item position:C629(*; "field.list"; $Lon_reference)
			
			//get current item description
			GET LIST ITEM:C378(*; "field.list"; $Lon_position; $Lon_reference; $Txt_formula; $Lst_sub; $Boo_expanded)
			
			If (Is a list:C621($Lst_sub))
				
				BEEP:C151
				
			Else 
				
				$Lon_parent:=List item parent:C633(*; "field.list"; $Lon_reference)
				
				If ($Lon_parent#0)  //linked table's field
					
					//#redmine:29952 {
					//$Lon_position:=List item position(*;"field.list";$Lon_parent)
					//GET LIST ITEM(*;"field.list";$Lon_position;$Lon_buffer;$Txt_table)
					GET LIST ITEM PARAMETER:C985(*; "field.list"; $Lon_reference; "tableId"; $Lon_buffer)
					$Txt_table:=db_virtualTableName($Lon_buffer)
					//}
					
				Else 
					
					//If (<>withFeature111172)
					
					$Txt_table:=db_virtualTableName(C_QR_MASTERTABLE)
					
					//Else 
					
					//$Txt_table:=Table name(C_QR_MASTERTABLE)
					
					//End if 
				End if 
				
				$Txt_formula:="["+$Txt_table+"]"+$Txt_formula
				
				
				$Lon_index:=Num:C11($Txt_id[[5]])
				
				//update preview
				SVG SET ATTRIBUTE:C1055($Ptr_me->; "txt_"+$Txt_id[[5]]; \
					"4D-text"; $Txt_formula; \
					*)
				
				//update object
				ARRAY OBJECT:C1221($tObj_columns; 0x0000)
				OB GET ARRAY:C1229((OBJECT Get pointer:C1124(Object subform container:K67:4))->; "columns"; $tObj_columns)
				OB SET:C1220($tObj_columns{$Lon_index}; \
					"formula"; $Txt_formula)
				
				//update list (hidden)
				GET LIST ITEM:C378(*; "report.list"; $Lon_index; $Lon_ID; $Txt_Buffer)
				SET LIST ITEM:C385(*; "report.list"; $Lon_ID; $Txt_formula; $Lon_ID)
				
				$Ptr_report:=OBJECT Get pointer:C1124(Object named:K67:5; "report.list")
				list_ITEM_COPY_METADATA(OBJECT Get pointer:C1124(Object named:K67:5; "field.list")->; $Ptr_report->; $Lon_reference; $Lon_ID)
				
			End if 
		End if 
		
		//______________________________________________________
	: ($Lon_formEvent=On Mouse Move:K2:35)\
		 | ($Lon_formEvent=On Mouse Leave:K2:34)
		
		//NOTHING MORE TO DO
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Form event activated unnecessarily ("+String:C10($Lon_formEvent)+")")
		
		//______________________________________________________
End case 