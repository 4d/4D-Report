//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : 4D_SET_OBJECT
  // Database: 4D Report
  // ID[18C439471C27420FA310BA600CF9ED3A]
  // Created #5-12-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_OBJECT:C1216($1)
C_TEXT:C284($2)

C_LONGINT:C283($Lon_parameters)
C_TEXT:C284($Txt_name)

If (False:C215)
	C_OBJECT:C1216(4D_SET_OBJECT ;$1)
	C_TEXT:C284(4D_SET_OBJECT ;$2)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	  //Required parameters
	Obj_buffer:=OB Copy:C1225($1)
	
	  //Optional parameters
	If ($Lon_parameters>=2)
		
		$Txt_name:=$2  //{form's object to be assign} current object if missing
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
If (Length:C16($Txt_name)=0)
	
	  //(OBJECT Get pointer(Object current))->:=OB Copy(Obj_buffer)
	EXECUTE FORMULA:C63("(:C1124(:K67:2))->:=:C1225(Obj_buffer)")
	
Else 
	
	  //(OBJECT Get pointer(Object named;"alert.box"))->:=OB Copy(Obj_buffer)
	EXECUTE FORMULA:C63("(:C1124(:K67:5;\""+$Txt_name+"\"))->:=:C1225(Obj_buffer)")
	
End if 


CLEAR VARIABLE:C89(Obj_buffer)

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End