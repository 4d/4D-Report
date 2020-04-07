  // ----------------------------------------------------
  // Object method : FIELDS.action - (4D Report)
  // ID[1D5C3644052F484EB9A570303541FA8D]
  // Created #11-12-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_BOOLEAN:C305($Boo_expanded;$Boo_nameOrder)
C_LONGINT:C283($Lon_area;$Lon_buffer;$Lon_formEvent;$Lon_ID;$Lon_index;$Lon_parent)
C_LONGINT:C283($Lon_position;$Lon_reference;$Lst_sub)
C_POINTER:C301($Ptr_list;$Ptr_me;$Ptr_report)
C_TEXT:C284($Mnu_pop;$Txt_action;$Txt_Buffer;$Txt_formula;$Txt_me;$Txt_table)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388
$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)
$Ptr_me:=OBJECT Get pointer:C1124(Object current:K67:2)

  // ----------------------------------------------------
Case of 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Clicked:K2:4)
		
		$Boo_nameOrder:=Bool:C1537(ob_dialog.sortByName)
		
		$Mnu_pop:=Create menu:C408
		
		APPEND MENU ITEM:C411($Mnu_pop;":xliff:sortByName")
		SET MENU ITEM PARAMETER:C1004($Mnu_pop;-1;"sortByName")
		
		If ($Boo_nameOrder)
			
			SET MENU ITEM MARK:C208($Mnu_pop;-1;Char:C90(18))
			
		End if 
		
		APPEND MENU ITEM:C411($Mnu_pop;":xliff:defaultSort")
		SET MENU ITEM PARAMETER:C1004($Mnu_pop;-1;"sortByCreation")
		
		If (Not:C34($Boo_nameOrder))
			
			SET MENU ITEM MARK:C208($Mnu_pop;-1;Char:C90(18))
			
		End if 
		
		APPEND MENU ITEM:C411($Mnu_pop;"(-")
		
		$Lon_area:=OB Get:C1224(ob_area;"area";Is longint:K8:6)
		
		If (QR Get report kind:C755($Lon_area)=qr cross report:K14902:2)
			
			GET LIST ITEM:C378(*;"field.list";*;$Lon_reference;$Txt_formula;$Lst_sub;$Boo_expanded)
			
			APPEND MENU ITEM:C411($Mnu_pop;":xliff:assignAsDatasourceForColumns";*)
			SET MENU ITEM PARAMETER:C1004($Mnu_pop;-1;"cross_1")
			
			If (Selected list items:C379(*;"field.list")=0)\
				 | (Is a list:C621($Lst_sub))
				
				DISABLE MENU ITEM:C150($Mnu_pop;-1)
				
			End if 
			
			APPEND MENU ITEM:C411($Mnu_pop;":xliff:assignAsDatasourceForRows";*)
			SET MENU ITEM PARAMETER:C1004($Mnu_pop;-1;"cross_2")
			
			If (Selected list items:C379(*;"field.list")=0)\
				 | (Is a list:C621($Lst_sub))
				
				DISABLE MENU ITEM:C150($Mnu_pop;-1)
				
			End if 
			
			APPEND MENU ITEM:C411($Mnu_pop;":xliff:assignAsDatasourceForCells";*)
			SET MENU ITEM PARAMETER:C1004($Mnu_pop;-1;"cross_3")
			
			If (Selected list items:C379(*;"field.list")=0)\
				 | (Is a list:C621($Lst_sub))
				
				DISABLE MENU ITEM:C150($Mnu_pop;-1)
				
			End if 
			
		Else 
			
			APPEND MENU ITEM:C411($Mnu_pop;":xliff:addSelected";*)
			SET MENU ITEM PARAMETER:C1004($Mnu_pop;-1;"add_selected")
			
			If (Selected list items:C379(*;"field.list")=0)
				
				DISABLE MENU ITEM:C150($Mnu_pop;-1)
				
			End if 
			
			APPEND MENU ITEM:C411($Mnu_pop;":xliff:AddMissing";*)
			SET MENU ITEM PARAMETER:C1004($Mnu_pop;-1;"add_all")
			
		End if 
		
		$Txt_action:=Dynamic pop up menu:C1006($Mnu_pop)
		RELEASE MENU:C978($Mnu_pop)
		
		Case of 
				
				  //______________________________________________________
			: (Length:C16($Txt_action)=0)
				
				  //NOTHING MORE TO DO
				
				  //______________________________________________________
			: ($Txt_action="cross_@")
				
				$Lon_parent:=List item parent:C633(*;"field.list";$Lon_reference)
				
				If ($Lon_parent#0)  //linked table's field
					
					$Lon_position:=List item position:C629(*;"field.list";$Lon_parent)
					GET LIST ITEM:C378(*;"field.list";$Lon_position;$Lon_buffer;$Txt_table)
					
				Else 
					
					$Txt_table:=Table name:C256(C_QR_MASTERTABLE)
					
				End if 
				
				$Txt_formula:="["+$Txt_table+"]"+$Txt_formula
				
				$Lon_index:=Num:C11($Txt_action[[7]])
				
				  //update preview
				SVG SET ATTRIBUTE:C1055(*;"report.cross.picture";"txt_"+$Txt_action[[7]];\
					"4D-text";$Txt_formula;\
					*)
				
				  //update object
				ARRAY OBJECT:C1221($tObj_columns;0x0000)
				OB GET ARRAY:C1229((OBJECT Get pointer:C1124(Object subform container:K67:4))->;"columns";$tObj_columns)
				OB SET:C1220($tObj_columns{$Lon_index};\
					"formula";$Txt_formula)
				
				  //update list (hidden)
				GET LIST ITEM:C378(*;"report.list";$Lon_index;$Lon_ID;$Txt_Buffer)
				SET LIST ITEM:C385(*;"report.list";$Lon_ID;$Txt_formula;$Lon_ID)
				
				$Ptr_report:=OBJECT Get pointer:C1124(Object named:K67:5;"report.list")
				list_ITEM_COPY_METADATA (OBJECT Get pointer:C1124(Object named:K67:5;"field.list")->;$Ptr_report->;$Lon_reference;$Lon_ID)
				
				  //______________________________________________________
			: ($Txt_action="add_@")
				
				NQR_SETTING_HANDLER ($Txt_action)
				
				  //______________________________________________________
			: ($Txt_action="sortBy@")
				
				$Boo_nameOrder:=($Txt_action="sortByName")
				
				If ($Boo_nameOrder#Bool:C1537(ob_dialog.sortByName))
					
					ob_dialog.sortByName:=$Boo_nameOrder
					
					  //refresh the list
					$Ptr_list:=OBJECT Get pointer:C1124(Object named:K67:5;"field.list")
					
					CLEAR LIST:C377($Ptr_list->;*)
					
					$Ptr_list->:=db_Get_field_list (C_QR_MASTERTABLE;\
						(OBJECT Get pointer:C1124(Object named:K67:5;"field.search.box"))->;\
						Bool:C1537(ob_dialog.sortByName))
					
				End if 
				
				  //______________________________________________________
			Else 
				
				ASSERT:C1129(False:C215;"Unknown entry point: \""+$Txt_action+"\"")
				
				  //______________________________________________________
		End case 
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessarily ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 