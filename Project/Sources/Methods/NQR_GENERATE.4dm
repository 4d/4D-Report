//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : NQR_GENERATE
  // Database: 4D Report
  // 
  // Created #29-04-2019 by Adrien Cagniant
  // ----------------------------------------------------
  // Description:
  // Method which generate the report inside the quick report
  // ----------------------------------------------------
  // Declarations


  // Make a selection if any
C_LONGINT:C283($Lon_destination;$Lon_table;$Lon_parameters)
C_TEXT:C284($Txt_buffer;$Txt_specific;$Txt_templateName;$Txt_errorHandlingMethod)


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




QR GET DESTINATION:C756(QR_area;$Lon_destination;$Txt_specific)

If ($Lon_destination=qr text file:K14903:2)\
 | ($Lon_destination=qr HTML file:K14903:5)
	
	$Txt_buffer:=Select document:C905($Txt_specific;Choose:C955($Lon_destination=qr text file:K14903:2;".txt";".html");"";File name entry:K24:17+Use sheet window:K24:11)
	
	If (OK=1)
		
		  //$Obj_:=Path to object(DOCUMENT)
		  //$Obj_.extension:=Choose($Lon_destination=qr text file;".txt";".html")
		  //DOCUMENT:=Object to path($Obj_)
		
		  //ACI0099118 : set destination is erasing the html template, so we need to save it and re-set it. 
		$Txt_templateName:=QR Get HTML template:C751(QR_area)
		If (($Txt_templateName="") & Not:C34(ob_dialog.optionHTMLtemplate=Null:C1517))
			$Txt_templateName:=ob_dialog.optionHTMLtemplate
		End if 
		
		
		QR SET DESTINATION:C745(QR_area;$Lon_destination;DOCUMENT)
		
		QR SET HTML TEMPLATE:C750(QR_area;$Txt_templateName)
		
		
	End if 
	
Else 
	
	OK:=1
	
End if 

If (OK=1)
	
	$Lon_table:=QR Get report table:C758(QR_area)
	
	If (Records in selection:C76(Table:C252($Lon_table)->)=0)
		
		ALL RECORDS:C47(Table:C252($Lon_table)->)
		
	End if 
	
	  // Execute the report with the current settings, including the output type
	$Txt_errorHandlingMethod:=report_catchErrors ("on")
	QR RUN:C746(QR_area)
	
	If (error#0)
		
		ALERT:C41(Get localized string:C991("previewIsNotPossible"))
		
	End if 
	
	report_catchErrors ("off";$Txt_errorHandlingMethod)
	
End if 