//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : NQR_SET_SELECTION
  // Database: 4D Report
  // ID[4F2C81B5B4674AB9959BA0C2BEDF546E]
  // Created #9-12-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($1)

C_LONGINT:C283($Lon_parameters)
C_TEXT:C284($Txt_action)

If (False:C215)
	C_TEXT:C284(NQR_SET_SELECTION ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
	$Txt_action:="none"
	
	  //Optional parameters
	If ($Lon_parameters>=1)
		
		$Txt_action:=$1
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
Case of 
		
		  //______________________________________________________
	: ($Txt_action="none")
		
		QR SET SELECTION:C794(QR_area;-1;-1;-1;-1)
		EXECUTE METHOD IN SUBFORM:C1085("myQR";"report_SELECTION";*;"select_none")
		
		  //______________________________________________________
	: (False:C215)
		
		  //______________________________________________________
	Else 
		
		  //______________________________________________________
End case 

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End