//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : NQR_New
  // ID[682F8F4CC23C4E76BA68CEA96FEEA8A8]
  // Created #8-4-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  // Creates a new report in the Quick Report
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($1)

C_LONGINT:C283($Lon_i;$Lon_ii;$Lon_parameters;$Lon_type)

If (False:C215)
	C_LONGINT:C283(NQR_NEW ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	$Lon_type:=qr list report:K14902:1
	
	If ($Lon_parameters>=1)
		
		$Lon_type:=$1  //{default = qr list report}
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------

  //#redmine:25075
  //$File_new:=Select document(8858;".4qr";Get localized string("save_the_new_report_as");File name entry+Use sheet window+Package open)
  //If (OK=1)
  //clear selection
NQR_SET_SELECTION ("none")

  //keep the document path
  //C_QR_INITPATH:=DOCUMENT
CLEAR VARIABLE:C89(C_QR_INITPATH)

  //delete previous area…
QR DELETE OFFSCREEN AREA:C754(QR_area)

  //…& create a new one
QR NEW AREA:C1320(->QR_area)

  //assign the current master table
QR SET REPORT TABLE:C757(QR_area;C_QR_MASTERTABLE)

  //set the wanted type
QR SET REPORT KIND:C738(QR_area;$Lon_type)

If ($Lon_type=qr cross report:K14902:2)
	
	  //initialize the default values
	QR_SET_CELL_TEXT (QR_area;3;1;Get localized string:C991("defaultLastColumnTitle"))
	QR_SET_CELL_TEXT (QR_area;1;3;Get localized string:C991("defaultLastRowTitle"))
	
	QR SET TEXT PROPERTY:C759(QR_area;3;1;qr bold:K14904:3;1)
	QR SET TEXT PROPERTY:C759(QR_area;1;3;qr bold:K14904:3;1)
	
	  //justification {
	For ($Lon_i;1;3;1)
		
		For ($Lon_ii;1;3;1)
			
			QR SET TEXT PROPERTY:C759(QR_area;$Lon_i;$Lon_ii;qr justification:K14904:7;3)  //centered
			
		End for 
	End for 
	  //}
	
Else 
	
	  //
	
End if 

QR REPORT TO BLOB:C770(QR_area;C_QR_INITBLOB)

  //save the file
  //BLOB TO DOCUMENT(C_QR_INITPATH;C_QR_INITBLOB)

  //update the hash
NQR_DIGEST (->C_QR_INITBLOB)

  //update UI
NQR_TOOLBAR ("update")

  // ----------------------------------------------------
  // Return
  //<NONE>
  // ----------------------------------------------------
  // End