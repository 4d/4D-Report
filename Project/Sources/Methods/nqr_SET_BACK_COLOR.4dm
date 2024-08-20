//%attributes = {"invisible":true}
#DECLARE($target : Integer)

var $PROPERTY : Text
$PROPERTY:=$target=qr background color:K14904:8 ? "backColor" : "altBackColor"

var $isCrossReport : Boolean
var $area; $color; $column; $row : Integer
var $callerPtr : Pointer
var $caller : Object

$callerPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "caller")
$caller:=JSON Parse:C1218($callerPtr->)

If ($caller=Null:C1517)\
 || ($caller.area=Null:C1517)
	
	return 
	
End if 

$isCrossReport:=Num:C11($caller.reportType)=qr cross report:K14902:2
$area:=report_Get_target($caller; ->$column; ->$row; $isCrossReport)

$color:=Self:C308->

If ($color#-1)  // Disparate
	
	$color:=$color=0 ? 0x00FFFFFF : $color
	
	If ($color#Num:C11($caller[$PROPERTY]))
		
		// Keep value
		$caller[$PROPERTY]:=$color
		$callerPtr->:=JSON Stringify:C1217($caller)
		
		// Update selection
		QR_SET_TEXT_PROPERTY($area; $target; String:C10($color); $column; $row)
		
		If ($isCrossReport)
			
			If ($column=2)\
				 | ($column=3)  // Apply to line
				
				$column:=$column+(3-$column)+(2-$column)
				QR_SET_TEXT_PROPERTY($area; $target; String:C10($color); $column; $row)
				
			End if 
		End if 
	End if 
End if 

ob_area.modified:=True:C214
