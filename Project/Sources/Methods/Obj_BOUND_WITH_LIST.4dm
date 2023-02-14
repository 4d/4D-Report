//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : obj_BOUND_WITH_LIST
// Database: 4D Labels
// ID[44C45B6F34C74894B1124B83E12B6C0C]
// Created #5-12-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_LONGINT:C283($1)
C_TEXT:C284($2)

C_LONGINT:C283($Lon_parameters; $Lst_listReference)
C_TEXT:C284($Txt_objectName)

If (False:C215)
	C_LONGINT:C283(Obj_BOUND_WITH_LIST; $1)
	C_TEXT:C284(Obj_BOUND_WITH_LIST; $2)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1; "Missing parameter"))
	
	//Required parameters
	$Lst_listReference:=$1
	
	//Optional parameters
	If ($Lon_parameters>=2)
		
		$Txt_objectName:=$2  //{form's object to be assign} current object if missing
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
Lon_buffer:=Copy list:C626($Lst_listReference)

If (Length:C16($Txt_objectName)=0)
	
	
	//(OBJECT Get pointer(Object current))->:=Copy list(Lon_buffer)
	EXECUTE FORMULA:C63("(:C1124(:K67:2))->:=:C626(Lon_buffer))")
	
Else 
	
	//(OBJECT Get pointer(Object named;"xxx"))->:=Copy list(Lon_buffer)
	EXECUTE FORMULA:C63("(:C1124(:K67:5;\""+$Txt_objectName+"\"))->:=:C626(Lon_buffer)")
	
End if 

CLEAR LIST:C377($Lst_listReference; *)

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End