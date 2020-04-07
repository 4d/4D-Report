//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : report_catchErrors
  // Database: 4D Report
  // ID[74749F6B547F4A08A87081D16677FEAC]
  // Created #13-3-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($0)
C_TEXT:C284($1)
C_TEXT:C284($2)

C_LONGINT:C283($Lon_parameters)
C_TEXT:C284($Txt_entrypoint;$Txt_errorHandlingMethod)

If (False:C215)
	C_TEXT:C284(report_catchErrors ;$0)
	C_TEXT:C284(report_catchErrors ;$1)
	C_TEXT:C284(report_catchErrors ;$2)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	If ($Lon_parameters>=1)
		
		$Txt_entrypoint:=$1
		
		If ($Lon_parameters>=2)
			
			$Txt_errorHandlingMethod:=$2
			
		End if 
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
Case of 
		
		  //______________________________________________________
	: ($Lon_parameters=0)  //errer-handling method
		
		  //noError
		IDLE:C311
		
		  //______________________________________________________
	: ($Txt_entrypoint="on")
		
		  //return the previous method isntalled
		$Txt_errorHandlingMethod:=Method called on error:C704
		ERROR:=0
		
		ON ERR CALL:C155(Current method name:C684)
		
		$0:=$Txt_errorHandlingMethod
		
		  //______________________________________________________
	: ($Txt_entrypoint="off")
		
		  //restaure the previous method
		ON ERR CALL:C155($Txt_errorHandlingMethod)
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Unknown entry point: \""+$Txt_entrypoint+"\"")
		
		  //______________________________________________________
End case 

  // ----------------------------------------------------
  // End