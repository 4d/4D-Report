  // ----------------------------------------------------
  // Object method : Table.Fields - (label-editor)
  // ID[5FD518ED72094CF5B8C12F06E151E026]
  // Created #11-12-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_BLOB:C604($Blb_buffer)
C_BOOLEAN:C305($Boo_)
C_LONGINT:C283($Lon_;$Lon_count;$Lon_field;$Lon_formEvent;$Lon_i;$Lon_table)
C_LONGINT:C283($Lst_sub)
C_POINTER:C301($Ptr_container;$Ptr_me)
C_TEXT:C284($Txt_;$Txt_buffer;$Txt_me)
C_OBJECT:C1216($Obj_buffer)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388
$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)
$Ptr_me:=OBJECT Get pointer:C1124(Object current:K67:2)

  // ----------------------------------------------------
Case of 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Load:K2:1)
		
		If (Structure file:C489=Structure file:C489(*))
			
			C_QR_MASTERTABLE:=7
			
		End if 
		
		Obj_BOUND_WITH_LIST (New list:C375)
		
		SET TIMER:C645(-1)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Timer:K2:25)
		
		SET TIMER:C645(0)
		
		  //________________________________________
	: ($Lon_formEvent=On Double Clicked:K2:5)
		
		$Ptr_container:=OBJECT Get pointer:C1124(Object subform container:K67:4)
		
		If (Not:C34(Is nil pointer:C315($Ptr_container)))
			
			GET LIST ITEM PARAMETER:C985(*;$Txt_me;*;"tableId";$Lon_table)
			GET LIST ITEM PARAMETER:C985(*;$Txt_me;*;"fieldId";$Lon_field)
			
			OB SET:C1220($Ptr_container->;\
				"action";"append_field";\
				"table";$Lon_table;\
				"field";$Lon_field)
			
			CALL SUBFORM CONTAINER:C1086(-1)
			
		End if 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Getting Focus:K2:7)
		
		OBJECT SET VISIBLE:C603(*;"field.@.focus";False:C215)
		
		  //________________________________________
	: ($Lon_formEvent=On Losing Focus:K2:8)
		
		  //
		
		  //________________________________________
	: ($Lon_formEvent=On Selection Change:K2:29)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Begin Drag Over:K2:44)
		
		  //create the drag icon
		list_SET_DRAG_ICON ($Ptr_me)
		
		CLEAR PASTEBOARD:C402
		
		ARRAY LONGINT:C221($tLon_selected;0x0000)
		
		$tLon_selected{0}:=Selected list items:C379(*;$Txt_me;$tLon_selected;*)
		
		$Lon_count:=Size of array:C274($tLon_selected)
		
		If ($Lon_count#0)
			
			If ($Lon_count=1)
				
				GET LIST ITEM:C378(*;$Txt_me;List item position:C629(*;$Txt_me;$tLon_selected{1});$Lon_;$Txt_;$Lst_sub;$Boo_)
				
				If (Not:C34(Is a list:C621($Lst_sub)))
					
					GET LIST ITEM PARAMETER:C985(*;$Txt_me;$tLon_selected{1};"tableId";$Lon_table)
					GET LIST ITEM PARAMETER:C985(*;$Txt_me;$tLon_selected{1};"fieldId";$Lon_field)
					
					OB SET:C1220($Obj_buffer;\
						"table";$Lon_table;\
						"field";$Lon_field)
					
				End if 
				
				$Txt_buffer:=JSON Stringify:C1217($Obj_buffer;*)
				
			Else 
				
				ARRAY OBJECT:C1221($tObj_pasteboard;$Lon_count)
				
				For ($Lon_i;1;$Lon_count;1)
					
					GET LIST ITEM:C378(*;$Txt_me;List item position:C629(*;$Txt_me;$tLon_selected{$Lon_i});$Lon_;$Txt_;$Lst_sub;$Boo_)
					
					If (Not:C34(Is a list:C621($Lst_sub)))
						
						GET LIST ITEM PARAMETER:C985(*;$Txt_me;$tLon_selected{$Lon_i};"tableId";$Lon_table)
						GET LIST ITEM PARAMETER:C985(*;$Txt_me;$tLon_selected{$Lon_i};"fieldId";$Lon_field)
						
						OB SET:C1220($tObj_pasteboard{$Lon_i};\
							"table";$Lon_table;\
							"field";$Lon_field)
						
					End if 
				End for 
				
				$Txt_buffer:=JSON Stringify array:C1228($tObj_pasteboard;*)
				
			End if 
			
			CONVERT FROM TEXT:C1011($Txt_buffer;"utf-8";$Blb_buffer)
			APPEND DATA TO PASTEBOARD:C403("com.4d.wizard";$Blb_buffer)
			
		End if 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Unload:K2:2)
		
		CLEAR LIST:C377($Ptr_me->;*)
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 