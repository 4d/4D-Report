  // ----------------------------------------------------
  // Object method : BALLOON_COLUMN.repeatedValues - (4D Report)
  // ID[380D6699454346F2AFD443DB41975C57]
  // Created #16-10-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_;$Lon_area;$Lon_column;$Lon_formEvent;$Lon_hidden;$Lon_width)
C_POINTER:C301($Ptr_me)
C_TEXT:C284($Txt_format;$Txt_me;$Txt_object;$Txt_title)
C_OBJECT:C1216($Obj_caller)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388
$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)
$Ptr_me:=OBJECT Get pointer:C1124(Object current:K67:2)

  // ----------------------------------------------------
Case of 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Clicked:K2:4)
		
		$Obj_caller:=JSON Parse:C1218((OBJECT Get pointer:C1124(Object named:K67:5;"caller"))->)
		$Lon_area:=OB Get:C1224($Obj_caller;"area";Is longint:K8:6)
		$Lon_column:=OB Get:C1224($Obj_caller;"qrColumn";Is longint:K8:6)
		CLEAR VARIABLE:C89($Obj_caller)
		
		QR GET INFO COLUMN:C766($Lon_area;$Lon_column;\
			$Txt_title;\
			$Txt_object;\
			$Lon_hidden;\
			$Lon_width;\
			$Lon_;\
			$Txt_format)
		
		QR SET INFO COLUMN:C765($Lon_area;$Lon_column;\
			$Txt_title;\
			$Txt_object;\
			$Lon_hidden;\
			$Lon_width;\
			$Ptr_me->;\
			$Txt_format)
		
		CLEAR VARIABLE:C89($Obj_caller)
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 