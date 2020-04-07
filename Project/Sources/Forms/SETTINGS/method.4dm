  // ----------------------------------------------------
  // Form method : SETTINGS - (4D Report)
  // ID[2AD46D1B0A954652BC21A5841712E778]
  // Created #4-12-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_fieldID;$Lon_formEvent;$Lon_tableID)
C_PICTURE:C286($p)
C_POINTER:C301($Ptr_field;$Ptr_list)
C_OBJECT:C1216($o;$Obj_container)

ARRAY LONGINT:C221($tLon_lengths;0)
ARRAY LONGINT:C221($tLon_positions;0)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388

  // ----------------------------------------------------

Case of 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Load:K2:1)
		
		OBJECT SET RGB COLORS:C628(*;"@.focus";Highlight text background color:K23:5;Background color none:K23:10)
		
		SET TIMER:C645(-1)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Unload:K2:2)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Activate:K2:9)
		
		  // SET TIMER(-1)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Bound Variable Change:K2:52)
		
		  // Update report list
		$Ptr_list:=OBJECT Get pointer:C1124(Object named:K67:5;"report.list")
		
		If (Is a list:C621($Ptr_list->))
			
			CLEAR LIST:C377($Ptr_list->)
			
		End if 
		
		$Ptr_list->:=New list:C375
		
		For each ($o;OBJECT Get pointer:C1124(Object subform container:K67:4)->columns)
			
			If (Length:C16(String:C10($o.variable))#0)
				
				APPEND TO LIST:C376($Ptr_list->;String:C10($o.variable);$o.column)
				READ PICTURE FILE:C678(Get 4D folder:C485(Current resources folder:K5:16)+"Images"+Folder separator:K24:12+"formula.png";$p)
				
			Else 
				
				APPEND TO LIST:C376($Ptr_list->;Parse formula:C1576(String:C10($o.formula);Formula out with virtual structure:K88:2);$o.column)
				
				If (Length:C16(String:C10($o.formula))#0)
					
					If (Match regex:C1019("\\[([^]]+)\\](.+)";$o.formula;1;$tLon_positions;$tLon_lengths))
						
						$Lon_tableID:=Find in array:C230(report_structureDefinition{0};Substring:C12($o.formula;$tLon_positions{1};$tLon_lengths{1}))
						$Lon_fieldID:=Find in array:C230(report_structureDefinition{$Lon_tableID};Substring:C12($o.formula;$tLon_positions{2};$tLon_lengths{2}))
						
						$Ptr_field:=Field:C253($Lon_tableID;$Lon_fieldID)
						
					End if 
					
					$p:=db_Get_field_icon (Type:C295($Ptr_field->))
					
				End if 
			End if 
			
			SET LIST ITEM ICON:C950($Ptr_list->;0;$p)
			
		End for each 
		
		If (Num:C11(ob_area.reportType)=qr list report:K14902:1)
			
			FORM GOTO PAGE:C247(1;*)
			
			NQR_SETTING_HANDLER ("update")
			OBJECT SET ENABLED:C1123(*;"b.add.one";True:C214)
			
		Else 
			
			FORM GOTO PAGE:C247(2;*)
			
			SETTINGS_DRAW_CROSS_REPORT 
			
		End if 
		
		GOTO OBJECT:C206(*;"field.list")
		$Ptr_list:=OBJECT Get pointer:C1124(Object named:K67:5;"field.list")
		SELECT LIST ITEMS BY POSITION:C381($Ptr_list->;1)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Timer:K2:25)
		
		SET TIMER:C645(0)
		
		$Ptr_list:=OBJECT Get pointer:C1124(Object named:K67:5;"field.list")
		
		If (Count list items:C380($Ptr_list->)=0)
			
			  // First use
			CLEAR LIST:C377($Ptr_list->)
			
			$Ptr_list->:=db_Get_field_list (C_QR_MASTERTABLE;"";OB Get:C1224(ob_dialog;"sortByName";Is boolean:K8:9))
			
		End if 
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessarily ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 