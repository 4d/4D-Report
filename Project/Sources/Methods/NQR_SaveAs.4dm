//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : NQR_SAVEAS
  // Database: 4D Report
  // 
  // Created #18-03-2019 by Adrien Cagniant
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations

C_BOOLEAN:C305($Boo_OK)
C_LONGINT:C283($Lon_parameters)
C_TEXT:C284($File_)

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
	  //Optional parameters
	If ($Lon_parameters>=1)
		
		  // <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 


  // ----------------------------------------------------

QR REPORT TO BLOB:C770(QR_area;C_QR_INITBLOB)


$File_:=Select document:C905(8858;\
".4qr";\
Get localized string:C991("save_the_report_as");\
File name entry:K24:17+Use sheet window:K24:11+Package open:K24:8)
$Boo_OK:=(OK=1)

If ($Boo_OK)
	
	C_QR_INITPATH:=DOCUMENT
	
End if 


If ($Boo_OK)
	
	BLOB TO DOCUMENT:C526(C_QR_INITPATH;C_QR_INITBLOB)
	
	$Boo_OK:=(OK=1)
	
End if 

If ($Boo_OK)
	ob_area.modified:=False:C215
End if 


  // ----------------------------------------------------
  // Return
$0:=$Boo_OK

  // ----------------------------------------------------
  // End