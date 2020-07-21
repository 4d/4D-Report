//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : report_DISPLAY_AREA
// Database: 4D Report
// ID[5400289DA9EC40CABDC7BE9D94416705]
// Created #13-3-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
// ----------------------------------------------------
// Declarations
C_LONGINT:C283($1)

C_BLOB:C604($Blb_buffer)
C_LONGINT:C283($Lon_area;$Lon_parameters;$Lon_property;$Lon_reportType)
C_TEXT:C284($kTxt_reportObject;$Txt_buffer)
C_OBJECT:C1216($Obj_params)

If (False:C215)
	C_LONGINT:C283(report_DISPLAY_AREA;$1)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	//required variables
	$Lon_area:=$1
	
	//constants
	$kTxt_reportObject:=OB Get:C1224(<>report_params;"form-object";Is text:K8:3)
	
	OBJECT SET VISIBLE:C603(*;"noTableAlert";$Lon_area=0)
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
If ($Lon_area#0)
	
	If (OB Get:C1224(ob_area;"cellEdition";Is boolean:K8:9))
		
		//NOTHING MORE TO DO
		
	Else 
		
		If (False:C215)  //[NO MENUBAR]
			
			//Area properties
			
			//menu bar
			$Lon_property:=QR Get area property:C795($Lon_area;qr view menubar:K14905:1)
			
			If ($Lon_property#-1)
				
				If (OB Is defined:C1231(ob_area;"display-menu"))
					
					If ($Lon_property#OB Get:C1224(ob_area;"display-menu";Is longint:K8:6))
						
						If ($Lon_property=1)
							
							//show menubar
							OBJECT MOVE:C664(*;$kTxt_reportObject;0;23;0;-23)
							
						Else 
							
							//hide menubar
							OBJECT MOVE:C664(*;$kTxt_reportObject;0;-23;0;23)
							
						End if 
					End if 
				End if 
				
				//store the current state
				OB SET:C1220(ob_area;\
					"display-menu";$Lon_property)
				
			End if 
			
			//toolbars
			
			//#TO_BE_DONE
			
		End if 
		
		QR REPORT TO BLOB:C770($Lon_area;$Blb_buffer)
		
		$Txt_buffer:=Generate digest:C1147($Blb_buffer;MD5 digest:K66:1)
		
		If ($Txt_buffer#OB Get:C1224(ob_area;"_digest";Is text:K8:3))
			
			OB SET:C1220(ob_area;\
				"_digest";$Txt_buffer)
			
			OB SET:C1220(ob_area;\
				"modified";True:C214)
			
		End if 
		
		$Lon_reportType:=QR Get report kind:C755($Lon_area)
		
		OB SET:C1220(ob_area;\
			"area";$Lon_area;\
			"reportType";$Lon_reportType)
		
		If ($Lon_reportType=qr list report:K14902:1)
			
			report_DISPLAY_LIST($Lon_area)
			
		Else 
			
			report_DISPLAY_CROSS($Lon_area)
			
			
		End if 
	End if 
	
Else 
	
	//remove all columns
	OB SET:C1220($Obj_params;\
		"action";"adjustColumnNumber";\
		"object";$kTxt_reportObject;\
		"columnsNumber";0)
	
	report_DISPLAY_COMMON($Obj_params)
	
End if 

// ----------------------------------------------------
// End