  // ----------------------------------------------------
  // Object method : %report.popup - (4D Report)
  // ID[A0D45E3318634E26853B3566F4F53D9A]
  // Created #25-9-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_formEvent)
C_POINTER:C301($Ptr_;$Ptr_me)
C_TEXT:C284($Txt_detailSubform;$Txt_me)
C_OBJECT:C1216($Obj_param)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388
$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)
$Ptr_me:=OBJECT Get pointer:C1124(Object current:K67:2)

  // ----------------------------------------------------
Case of 
		
		  //______________________________________________________
	: ($Lon_formEvent=-1)  //??
		
		  //OBJECT SET VISIBLE(*;"balloon.@";True)
		
		  //______________________________________________________
	: ($Lon_formEvent=-2)  //close
		
		OB SET:C1220($Obj_param;\
			"action";"hide")
		
		report_BALLOON_HDL ($Obj_param)
		
		CLEAR VARIABLE:C89($Obj_param)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Getting Focus:K2:7)
		
		OBJECT GET SUBFORM:C1139(*;$Txt_me;$Ptr_;$Txt_detailSubform)
		
		OB SET:C1220($Obj_param;\
			"action";"update";\
			"form";$Txt_detailSubform)
		
		EXECUTE METHOD IN SUBFORM:C1085($Txt_me;"report_BALLOON_HDL";*;$Obj_param)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Losing Focus:K2:8)
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 