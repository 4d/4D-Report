  // ----------------------------------------------------
  // Object method : NQR.message - (4D Report)
  // ID[BD24E8DCC7684EB9A0A642A958F325B6]
  // Created #4-12-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_formEvent)
C_POINTER:C301($Ptr_me)
C_TEXT:C284($kTxt_hostMethod;$Txt_me)

ARRAY TEXT:C222($tTxt_actions;0)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388
$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)
$Ptr_me:=OBJECT Get pointer:C1124(Object current:K67:2)

$kTxt_hostMethod:="NQR_DO_IT"  //host method to execute

  // ----------------------------------------------------
Case of 
		
		  //______________________________________________________
	: ($Lon_formEvent<0)
		
		OBJECT SET VISIBLE:C603(*;"alert.@";False:C215)
		
		EXECUTE METHOD:C1007($kTxt_hostMethod;*;$Ptr_me->)
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 