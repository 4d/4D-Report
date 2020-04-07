//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : NQR_SAVE
  // Database: 4D Report
  // ID[C553F2953DFD43B586B9E3C8CC16EC1A]
  // Created #2-12-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_BOOLEAN:C305($0)

C_BOOLEAN:C305($Boo_OK)
C_LONGINT:C283($Lon_parameters)
C_TEXT:C284($File_)

If (False:C215)
	C_BOOLEAN:C305(NQR_Save ;$0)
End if 

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

  // #12-9-2014
  // Autosave
OK:=Num:C11((Length:C16(C_QR_INITPATH)>0) & (Test path name:C476(C_QR_INITPATH)=Is a document:K24:1))

If (OK=0)
	
	$File_:=Select document:C905(8858;\
		".4qr";\
		Get localized string:C991("save_the_report_as");\
		File name entry:K24:17+Use sheet window:K24:11+Package open:K24:8)
	
	If (OK=1)
		
		C_QR_INITPATH:=DOCUMENT
		
	End if 
End if 

$Boo_OK:=(OK=1)

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