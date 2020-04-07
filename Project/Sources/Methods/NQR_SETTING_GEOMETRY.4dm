//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : NQR_SETTING_RESIZE
  // Database: 4D Report
  // ID[34D68895E7E24FDABCD1F748B8235FF3]
  // Created #9-3-2016 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  // Proportional resizing
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($kLon_buttonWidth;$kLon_margin;$Lon_bottom;$Lon_left;$Lon_listWidth;$Lon_offset)
C_LONGINT:C283($Lon_parameters;$Lon_right;$Lon_top;$Lon_totalWidth)

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
	  //Optional parameters
	If ($Lon_parameters>=1)
		
		  // <NONE>
		
	End if 
	
	$kLon_margin:=10
	$kLon_buttonWidth:=24
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
OBJECT GET COORDINATES:C663(*;"background";$Lon_left;$Lon_top;$Lon_right;$Lon_bottom)

$Lon_totalWidth:=$Lon_right-$Lon_left
$Lon_listWidth:=Round:C94(($Lon_totalWidth-($kLon_margin*4)-$kLon_buttonWidth)/2;0)

OBJECT GET COORDINATES:C663(*;"report.field.border";$Lon_left;$Lon_top;$Lon_right;$Lon_bottom)

$Lon_offset:=$Lon_listWidth-($Lon_right-$Lon_left)

  //grow
OBJECT MOVE:C664(*;"field.list";0;0;$Lon_offset;0)
OBJECT MOVE:C664(*;"report.field.border";0;0;$Lon_offset;0)
OBJECT MOVE:C664(*;"field.search.focus";0;0;$Lon_offset;0)
OBJECT MOVE:C664(*;"field.search.box";0;0;$Lon_offset;0)
OBJECT MOVE:C664(*;"field.search.frame";0;0;$Lon_offset;0)

  //move
OBJECT MOVE:C664(*;"action";$Lon_offset;0)
OBJECT MOVE:C664(*;"b.@";$Lon_offset;0)
OBJECT MOVE:C664(*;"ok";$Lon_offset*2;0)
OBJECT MOVE:C664(*;"cancel";$Lon_offset*2;0)

  //move and grow
OBJECT MOVE:C664(*;"report.list@";$Lon_offset;0;$Lon_offset;0)
OBJECT MOVE:C664(*;"report.cross@";$Lon_offset;0;$Lon_offset;0)

If (FORM Get current page:C276(*)=2)
	
	SETTINGS_DRAW_CROSS_REPORT 
	
End if 

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End