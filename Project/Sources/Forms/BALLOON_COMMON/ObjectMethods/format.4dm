// ----------------------------------------------------
// Object method : BALLOON_COMMON.font.family - (4D Report)
// ID[F370EEDE38454504A8EB44EFCC0D1056]
// Created #18-9-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Declarations
var $action; $current; $format; $KEY; $me; $menumain : Text
var $area; $column; $formEvent; $row : Integer
var $callerPtr : Pointer
var $caller : Object

$formEvent:=Form event code:C388
$me:=OBJECT Get name:C1087(Object current:K67:2)
$callerPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "caller")

$KEY:="columnFormat"

$caller:=JSON Parse:C1218($callerPtr->)

Case of 
		
		//______________________________________________________
	: (Not:C34(OB Is defined:C1231($caller)))
		
		return 
		
		//______________________________________________________
	: ($formEvent=On Clicked:K2:4)
		
		//#ACI0095708
		//$area:=report_Get_target ($Obj_caller;->$column;->$row)
		$area:=report_Get_target($caller; ->$column; ->$row; True:C214)
		
		$current:=String:C10($caller[$KEY])
		
		$menumain:=menu_format(QR_Get_column_type($area; $column); $current)
		
		$action:=Dynamic pop up menu:C1006($menumain)
		RELEASE MENU:C978($menumain)
		
		Case of 
				
				//______________________________________________________
			: (Length:C16($action)=0)
				
				// Nothing selected
				
				//______________________________________________________
			: ($action="format_@")
				
				$format:=Delete string:C232($action; 1; 7)
				
				// Update UI
				(OBJECT Get pointer:C1124(Object named:K67:5; $me+".label"))->:=Choose:C955(Length:C16($format)#0; $format; Get localized string:C991("none"))
				
				If ($format#$current)
					
					// Keep value
					$caller[$KEY]:=$format
					$callerPtr->:=JSON Stringify:C1217($caller)
					
					// Update selection
					QR_SET_COLUMN_FORMAT($area; $column; $format)
					
/* ACI0100938
If (QR Get report kind($area)=qr cross report)
If ($column=2)\
| ($column=3)  //apply to line
$column:=$column+(3-$column)+(2-$column)
QR_SET_COLUMN_FORMAT($area; $column; $format)
End if
End if
*/
					
				End if 
				
				ob_area.modified:=True:C214
				
				//______________________________________________________
			Else 
				
				ASSERT:C1129(False:C215; "Unknown menu action ("+$action+")")
				
				//______________________________________________________
		End case 
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Form event activated unnecessary ("+String:C10($formEvent)+")")
		
		//______________________________________________________
End case 