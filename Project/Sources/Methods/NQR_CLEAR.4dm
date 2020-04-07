//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : NQR_CLEAR
  // ID[ABCCE1FA4C5541CB9237D1DDF6137443]
  // Created #23-6-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  // Clear the report in the Quick Report area passed in area
  // ----------------------------------------------------
  // Declarations
C_BLOB:C604($Blb_)
C_LONGINT:C283($Lon_parameters)

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
	  //Optional parameters
	If ($Lon_parameters>=1)
		
		  //<NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
  //clear selection
NQR_SET_SELECTION ("none")

QR DELETE OFFSCREEN AREA:C754(QR_area)

QR NEW AREA:C1320(->QR_area)

  //set the master table
If (C_QR_MASTERTABLE#0)
	
	QR SET REPORT TABLE:C757(QR_area;C_QR_MASTERTABLE)
	
End if 

  //update the hash
NQR_DIGEST (->$Blb_;True:C214)

  // ----------------------------------------------------
  // End