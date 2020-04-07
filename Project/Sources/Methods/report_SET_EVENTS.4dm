//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : report_SET_EVENTS
  // Database: 4D Report
  // ID[D32CCF6B30E642F5848C884C33236F58]
  // Created #18-7-2016 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($1)
C_TEXT:C284($2)

C_LONGINT:C283($Lon_area;$Lon_parameters)
C_TEXT:C284($Txt_context;$Txt_me;$Txt_reportObject)

ARRAY LONGINT:C221($tLon_events;0)

If (False:C215)
	C_TEXT:C284(report_SET_EVENTS ;$1)
	C_TEXT:C284(report_SET_EVENTS ;$2)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	  //Required parameters
	$Txt_reportObject:=$1
	
	  //Optional parameters
	If ($Lon_parameters>=2)
		
		$Txt_context:=$2
		
	End if 
	
	$Lon_area:=OB Get:C1224(ob_area;"area";Is longint:K8:6)
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
Case of 
		
		  //______________________________________________________
	: (Length:C16($Txt_context)=0)
		
		APPEND TO ARRAY:C911($tLon_events;On Drag Over:K2:13)
		APPEND TO ARRAY:C911($tLon_events;On Drop:K2:12)
		APPEND TO ARRAY:C911($tLon_events;On Column Moved:K2:30)
		APPEND TO ARRAY:C911($tLon_events;On Scroll:K2:57)
		
		If (QR Get report kind:C755($Lon_area)=qr cross report:K14902:2)
			
			OBJECT SET EVENTS:C1239(*;$Txt_reportObject;$tLon_events;Disable events others unchanged:K42:39)
			
		Else 
			
			OBJECT SET EVENTS:C1239(*;$Txt_reportObject;$tLon_events;Enable events others unchanged:K42:38)
			
		End if 
		
		  //______________________________________________________
	: (Length:C16($Txt_context)=0)\
		 | ($Txt_context="display")
		
		APPEND TO ARRAY:C911($tLon_events;On Drag Over:K2:13)
		APPEND TO ARRAY:C911($tLon_events;On Drop:K2:12)
		APPEND TO ARRAY:C911($tLon_events;On Column Moved:K2:30)
		APPEND TO ARRAY:C911($tLon_events;On Scroll:K2:57)
		
		If (QR Get report kind:C755($Lon_area)=qr cross report:K14902:2)
			
			OBJECT SET EVENTS:C1239(*;$Txt_reportObject;$tLon_events;Disable events others unchanged:K42:39)
			
		Else 
			
			OBJECT SET EVENTS:C1239(*;$Txt_reportObject;$tLon_events;Enable events others unchanged:K42:38)
			
		End if 
		
		  //______________________________________________________
	: ($Txt_context="cell_edit")
		
		APPEND TO ARRAY:C911($tLon_events;On Mouse Move:K2:35)
		APPEND TO ARRAY:C911($tLon_events;On Mouse Leave:K2:34)
		APPEND TO ARRAY:C911($tLon_events;On Double Clicked:K2:5)
		APPEND TO ARRAY:C911($tLon_events;On Header Click:K2:40)
		APPEND TO ARRAY:C911($tLon_events;On Drag Over:K2:13)
		APPEND TO ARRAY:C911($tLon_events;On Drop:K2:12)
		APPEND TO ARRAY:C911($tLon_events;On Column Moved:K2:30)
		APPEND TO ARRAY:C911($tLon_events;On Column Resize:K2:31)
		
		If (OB Get:C1224(ob_area;"cellEdition";Is boolean:K8:9))  //true if a cell is being edited
			
			OBJECT SET EVENTS:C1239(*;$Txt_me;$tLon_events;Disable events others unchanged:K42:39)
			
		Else 
			
			OBJECT SET EVENTS:C1239(*;$Txt_me;$tLon_events;Enable events others unchanged:K42:38)
			
		End if 
		
		  //______________________________________________________
	Else 
		
		  //______________________________________________________
End case 

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End