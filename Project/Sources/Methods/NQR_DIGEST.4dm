//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : NQR_DIGEST
  // Database: 4D Report
  // ID[83A6C2DCC65A4AE88D6D1E1F74FFE2AA]
  // Created #8-12-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_POINTER:C301($1)
C_BOOLEAN:C305($2)

C_BLOB:C604($Blb_buffer)
C_BOOLEAN:C305($Boo_modified)
C_LONGINT:C283($Lon_parameters)
C_POINTER:C301($Ptr_blob)

If (False:C215)
	C_POINTER:C301(NQR_DIGEST ;$1)
	C_BOOLEAN:C305(NQR_DIGEST ;$2)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
	  //Optional parameters
	If ($Lon_parameters>=1)
		
		$Ptr_blob:=$1
		
		If ($Lon_parameters>=2)
			
			$Boo_modified:=$2
			
		End if 
	End if 
	
	If (Is nil pointer:C315($Ptr_blob))
		
		QR REPORT TO BLOB:C770(QR_area;$Blb_buffer)
		$Ptr_blob:=->$Blb_buffer
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
OB SET:C1220(ob_area;\
"_digest";Generate digest:C1147($Ptr_blob->;MD5 digest:K66:1);\
"modified";$Boo_modified)

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End