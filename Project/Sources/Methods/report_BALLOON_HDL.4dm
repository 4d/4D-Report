//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : report_BALLOON_HDL
// Database: 4D Report
// ID[584A5065D22E433C98F7D94F79E000FE]
// Created #25-9-2014 by Vincent de Lachaux
// ----------------------------------------------------
#DECLARE($parameter : Object)

/* CONSTANTS */
var $MARGIN : Integer
$MARGIN:=5

var $SUBFORM_NAME : Text
$SUBFORM_NAME:="balloon.subform"

var $i; $reportKind; $type : Integer
var $area; $mouseX; $mouseY : Integer
var $left; $top; $right; $bottom; $width; $height; $offset : Integer

///*COLUMN*/var $columnData; $columnNumber; $columnType; $repeatedValues; $index : Integer
var $columnData; $columnNumber; $columnType; $repeatedValues; $index : Integer

///*ROW*/var $rowData; $row_number; $subtotal_index : Integer
var $rowData; $rowNumber; $subtotal_index : Integer

///*UI*/var $ui_label_pointer : Pointer
var $ui_label_pointer : Pointer

var $t; $text; $action; $digest; $form; $unit_name : Text
var $caller; $o : Object
var $isSelected : Boolean
var $blob : Blob

/* ARRAYS */
ARRAY LONGINT:C221($columns; 0)
ARRAY LONGINT:C221($orders; 0)

If (Asserted:C1132($parameter#Null:C1517 && $parameter.action#Null:C1517))
	
	$action:=String:C10($parameter.action)
	
End if 

$form:=String:C10($parameter.form)

Case of 
		
		//______________________________________________________
	: (Length:C16($action)=0)
		
		//NOTHING MORE TO DO
		
		//______________________________________________________
	: ($action="update")
		
		// Resize the background
		OBJECT GET SUBFORM CONTAINER SIZE:C1148($height; $width)
		OBJECT SET COORDINATES:C1248(*; "border"; 0; 0; $height; $width)
		
		Obj_CENTER("computations"; "separator"; Horizontally centered:K39:1)
		
		$caller:=OB Copy:C1225(ob_area)
		$area:=Num:C11($caller.area)
		
		If (Asserted:C1132(QR_is_valid_area($area)))
			
			$reportKind:=QR Get report kind:C755($area)
			$area:=report_Get_target($caller; ->$columnNumber; ->$rowNumber)
			
			If (Asserted:C1132($columnNumber>=0))
				
				// Mark:[COMMON]
				
				// Mark:Font name
				$caller.fontName:=QR_Get_font_name($area; $columnNumber; $rowNumber)
				$caller.fontName:=Choose:C955($caller.fontName="-"; Get localized string:C991("disparate"); \
					Choose:C955($caller.fontName=""; "<Default>"; Replace string:C233($caller.fontName; ".Lucida Grande UI"; "Lucida Grande")))
				(OBJECT Get pointer:C1124(Object named:K67:5; "font.family.label"))->:=$caller.fontName
				
				// Mark:Font style
				$caller.fontStyle:=QR_Get_font_style($area; $columnNumber; $rowNumber)
				(OBJECT Get pointer:C1124(Object named:K67:5; "font.style"))->:=$caller.fontStyle
				
				// Mark:Font size
				$caller.fontSize:=QR_Get_font_size($area; $columnNumber; $rowNumber)
				(OBJECT Get pointer:C1124(Object named:K67:5; "font.size.label"))->:=$caller.fontSize=-1 ? "-" : String:C10($caller.fontSize)
				
				// Mark:Justification
				$caller.justification:=QR_Get_justification($area; $columnNumber; $rowNumber)
				(OBJECT Get pointer:C1124(Object named:K67:5; "justification"))->:=$caller.justification
				
				// Mark:Font color
				$caller.frontColor:=QR_Get_color($area; $columnNumber; $rowNumber; qr text color:K14904:6)
				(OBJECT Get pointer:C1124(Object named:K67:5; "font.front.color"))->:=$caller.frontColor
				
				// Mark:Back color
				$caller.backColor:=QR_Get_color($area; $columnNumber; $rowNumber; qr background color:K14904:8)
				(OBJECT Get pointer:C1124(Object named:K67:5; "font.back.color"))->:=$caller.backColor
				
				// Mark:Border properties
				$o:=QR_Get_border_properties($area; $columnNumber; $rowNumber)
				
				If ($o#Null:C1517)
					
					// Border selected
					(OBJECT Get pointer:C1124(Object named:K67:5; "borders.controls"))->:=$o
					
					// Color
					(OBJECT Get pointer:C1124(Object named:K67:5; "border.color1"))->:=Choose:C955($o.sameColor; $o.colorToSet; 0)
					
					// Thickness
					(OBJECT Get pointer:C1124(Object named:K67:5; "border.style"))->:=$o.thicknessToSet
					(OBJECT Get pointer:C1124(Object named:K67:5; "border.style.label"))->:=Get localized string:C991($o.sameThickness ? "menu_thickness"+String:C10($o.thicknessToSet) : "menu_thicknessMultiple")
					
				End if 
				
				// Mark:[SPECIFIC]
				Case of 
						
						//…………………………………………………………………………………………………………
					: (Position:C15("BALLOON_SUBTOTALLINE"; $form)=1)
						
						// Format
						OBJECT SET VISIBLE:C603(*; "format@"; False:C215)
						
						// Computations
						OBJECT SET VISIBLE:C603(*; "computations"; True:C214)
						
						If ($reportKind=qr cross report:K14902:2) & ($columnNumber=3)
							
							$caller.computations:=QR_Get_computation($area; 2; $rowNumber)
							
						Else 
							
							$caller.computations:=QR_Get_computation($area; $columnNumber; $rowNumber)
							
						End if 
						
						(OBJECT Get pointer:C1124(Object named:K67:5; "computations"))->:=$caller.computations
						
						// Subtotal handling
						If (ob_area.sortNumber>0)  // We should be in a subtotal row ... but we never know
							
							$subtotal_index:=ob_area.qrRow
							QR GET TOTALS SPACING:C762($area; $subtotal_index; $i)
							
							If ($i=32000)
								
								$isSelected:=False:C215
								$t:=Get localized string:C991("menu_subtotalSpacingBreak")
								
							Else 
								
								$isSelected:=True:C214
								$t:=Get localized string:C991("menu_subtotalSpacingValue")
								
								If ($i<0)
									
									$unit_name:=Get localized string:C991("menu_subtotalSpacingPercent")
									$i:=-$i
									
								Else 
									
									$unit_name:=Get localized string:C991("menu_subtotalSpacingPoint")
									
								End if 
							End if 
							
							(OBJECT Get pointer:C1124(Object named:K67:5; "subtotalProp.label"))->:=$t
							(OBJECT Get pointer:C1124(Object named:K67:5; "totalSpacing.unit.label"))->:=$unit_name
							(OBJECT Get pointer:C1124(Object named:K67:5; "totalSpacing.label"))->:=$i
							
							OBJECT SET VISIBLE:C603(*; "totalSpacing@"; $isSelected)
							
							If ($isSelected)
								
								OBJECT GET COORDINATES:C663(*; "subtotalProp"; $left; $top; $right; $bottom)
								OBJECT SET COORDINATES:C1248(*; "subtotalProp"; $left; $top; 193; $bottom)
								
								OBJECT GET COORDINATES:C663(*; "subtotalProp.back"; $left; $top; $lon_rightNew; $bottom)
								OBJECT SET COORDINATES:C1248(*; "subtotalProp.back"; $left; $top; 194; $bottom)
								
								OBJECT GET COORDINATES:C663(*; "subtotalProp.label"; $left; $top; $lon_rightNew; $bottom)
								OBJECT SET COORDINATES:C1248(*; "subtotalProp.label"; $left; $top; 190; $bottom)
								
								
							Else 
								
								OBJECT GET COORDINATES:C663(*; "subtotalProp"; $left; $top; $right; $bottom)
								OBJECT SET COORDINATES:C1248(*; "subtotalProp"; $left; $top; 262; $bottom)
								
								OBJECT GET COORDINATES:C663(*; "subtotalProp.back"; $left; $top; $lon_rightNew; $bottom)
								OBJECT SET COORDINATES:C1248(*; "subtotalProp.back"; $left; $top; 263; $bottom)
								
								OBJECT GET COORDINATES:C663(*; "subtotalProp.label"; $left; $top; $lon_rightNew; $bottom)
								OBJECT SET COORDINATES:C1248(*; "subtotalProp.label"; $left; $top; 260; $bottom)
								
							End if 
						End if 
						
						//…………………………………………………………………………………………………………
					: (Position:C15("BALLOON_FONT"; $form)=1)
						
						// <NOTHING MORE TO DO>
						
						//…………………………………………………………………………………………………………
					: (Position:C15("BALLOON_LINE"; $form)=1)
						
						// Format (Detail) & computation (only for Subtotal rows and Grand total)
						Case of 
								
								//______________________________________________________
							: ($rowNumber=qr title:K14906:1)  // Title
								
								OBJECT SET ENABLED:C1123(*; "format@"; False:C215)
								(OBJECT Get pointer:C1124(Object named:K67:5; "format.label"))->:=Get localized string:C991("inapplicable")
								
								//______________________________________________________
							: ($rowNumber=qr detail:K14906:2)  // Detail
								
								// Alternate background color
								OBJECT SET VISIBLE:C603(*; "format@"; True:C214)
								OBJECT SET VISIBLE:C603(*; "computations"; False:C215)
								OBJECT SET VISIBLE:C603(*; "font.alternate.back.color"; True:C214)
								
								$caller.altBackColor:=QR_Get_color($area; $columnNumber; $rowNumber; qr alternate background color:K14904:9)
								(OBJECT Get pointer:C1124(Object named:K67:5; "font.alternate.back.color"))->:=$caller.altBackColor
								
								If (QR_Get_column_type($area; $columnNumber)=-1)  // Mismatch
									
									OBJECT SET ENABLED:C1123(*; "format"; False:C215)
									OBJECT SET VISIBLE:C603(*; "format.back"; False:C215)
									OBJECT SET VISIBLE:C603(*; "format.label"; True:C214)
									(OBJECT Get pointer:C1124(Object named:K67:5; "format.label"))->:=Get localized string:C991("inapplicable")
									
								Else 
									
									OBJECT SET ENABLED:C1123(*; "format"; True:C214)
									OBJECT SET VISIBLE:C603(*; "format.back"; True:C214)
									OBJECT SET VISIBLE:C603(*; "format.label"; True:C214)
									
									$caller.columnFormat:=QR_Get_column_format($area; $columnNumber)
									(OBJECT Get pointer:C1124(Object named:K67:5; "format.label"))->:=Choose:C955(Length:C16($caller.columnFormat)#0; $caller.columnFormat; Get localized string:C991("none"))
									
								End if 
								
								//______________________________________________________
							: ($rowNumber=qr grand total:K14906:3)  //Grand Total
								
								OBJECT SET VISIBLE:C603(*; "format@"; False:C215)
								OBJECT SET VISIBLE:C603(*; "computations"; True:C214)
								
								$caller.computations:=QR_Get_computation($area; $columnNumber; $rowNumber)
								(OBJECT Get pointer:C1124(Object named:K67:5; "computations"))->:=$caller.computations
								
								//______________________________________________________
							: ($rowNumber>0)  //break
								
								OBJECT SET VISIBLE:C603(*; "format@"; False:C215)
								OBJECT SET VISIBLE:C603(*; "computations"; True:C214)
								
								// #ACI0098288<
								If ($reportKind=qr cross report:K14902:2) & ($columnNumber=3)
									
									$caller.computations:=QR_Get_computation($area; 2; $rowNumber)
									
								Else 
									
									$caller.computations:=QR_Get_computation($area; $columnNumber; $rowNumber)
									
								End if 
								
								(OBJECT Get pointer:C1124(Object named:K67:5; "computations"))->:=$caller.computations
								
								//______________________________________________________
							Else 
								
								TRACE:C157
								
								//______________________________________________________
						End case 
						
						//…………………………………………………………………………………………………………
					: (Position:C15("BALLOON_COLUMN"; $form)=1)
						
						If ($reportKind=qr cross report:K14902:2)
							
							$caller.altBackColor:=QR_Get_color($area; $columnNumber; $rowNumber; qr alternate background color:K14904:9)
							(OBJECT Get pointer:C1124(Object named:K67:5; "font.alternate.back.color"))->:=$caller.altBackColor
							
							// #ACI0095708
							$area:=report_Get_target($caller; ->$columnData; ->$rowData; True:C214)
							$columnType:=QR_Get_column_type($area; $columnData)
							
						Else 
							
							$columnType:=QR_Get_column_type($area; $columnNumber)
							
						End if 
						
						If ($columnType=-1)  // Undefined for a formula
							
							// #TO_BE_DONE - change the user interface to allow string entry
							
						End if 
						
						If ($reportKind=qr cross report:K14902:2)
							
							// #ACI0095708
							$caller.columnFormat:=QR_Get_column_format($area; $columnData; $columnType)
							
						Else 
							
							$caller.columnFormat:=QR_Get_column_format($area; $columnNumber; $columnType)
							
						End if 
						
						(OBJECT Get pointer:C1124(Object named:K67:5; "format.label"))->:=Choose:C955(Length:C16($caller.columnFormat)#0; $caller.columnFormat; Get localized string:C991("none"))
						OBJECT SET VISIBLE:C603(*; "format@"; True:C214)
						
						// Sort
						If ($columnType=Is BLOB:K8:12)\
							 | ($columnType=Is picture:K8:10)\
							 | ($columnType=Is subtable:K8:11)
							
							OBJECT SET ENABLED:C1123(*; "sort"; False:C215)
							OBJECT SET VISIBLE:C603(*; "sort.back"; False:C215)
							(OBJECT Get pointer:C1124(Object named:K67:5; "sort.label"))->:=Get localized string:C991("inapplicable")
							
						Else 
							
							OBJECT SET ENABLED:C1123(*; "sort"; True:C214)
							OBJECT SET VISIBLE:C603(*; "sort.back"; True:C214)
							
							QR GET SORTS:C753($area; $columns; $orders)
							$index:=Find in array:C230($columns; $columnNumber)
							
							$ui_label_pointer:=OBJECT Get pointer:C1124(Object named:K67:5; "sort.label")
							
							Case of 
									
									//-----------------------------
								: ($index=-1)  // Not sorted
									
									$ui_label_pointer->:=Get localized string:C991("menu_sort_none")
									
									//-----------------------------
								: ($orders{$index}=0)
									
									$ui_label_pointer->:=Get localized string:C991("menu_sort_none")
									
									//-----------------------------
								: ($orders{$index}=1)
									
									$ui_label_pointer->:=Get localized string:C991(\
										Choose:C955($reportKind=qr cross report:K14902:2; \
										Choose:C955($columnNumber=2; \
										"menu_sort_leftToRight"; \
										"menu_sort_topToBottom"); \
										"menu_sort_ascending"))
									
									//-----------------------------
								: ($orders{$index}=-1)
									
									$ui_label_pointer->:=Get localized string:C991(\
										Choose:C955($reportKind=qr cross report:K14902:2; \
										Choose:C955($columnNumber=2; \
										"menu_sort_rightToLeft"; \
										"menu_sort_bottomToTop"); \
										"menu_sort_descending"))
									
									//-----------------------------
							End case 
							
							REDRAW WINDOW:C456(Current form window:C827)
							
						End if 
						
						// Options
						QR GET INFO COLUMN:C766($area; $columnNumber; $text; $text; $i; $width; $repeatedValues; $text; $text)
						
						(OBJECT Get pointer:C1124(Object named:K67:5; "automaticWidth"))->:=Num:C11($width=-1)
						
						If ($reportKind=qr cross report:K14902:2)
							
							If ($columnNumber=1)
								
								OBJECT SET VISIBLE:C603(*; "font.alternate.back.color"; True:C214)
								
							Else 
								
								OBJECT GET SUBFORM CONTAINER SIZE:C1148($width; $i)
								OBJECT GET COORDINATES:C663(*; "font.alternate.back.color"; $i; $i; $right; $i)
								OBJECT SET VISIBLE:C603(*; "font.alternate.back.color"; $width>=$right)
								
							End if 
							
						Else 
							
							(OBJECT Get pointer:C1124(Object named:K67:5; "repeatedValues"))->:=$repeatedValues
							
						End if 
						
						//…………………………………………………………………………………………………………
					: (Position:C15("BALLOON_CROSS_DATA"; $form)=1)
						
						// Format
						OBJECT SET VISIBLE:C603(*; "format@"; True:C214)
						
						// #ACI0095708
						$area:=report_Get_target($caller; ->$columnData; ->$rowData; True:C214)
						$type:=QR_Get_column_type($area; $columnData)
						
						If ($type=-1)  // Mismatch
							
							OBJECT SET ENABLED:C1123(*; "format"; False:C215)
							OBJECT SET VISIBLE:C603(*; "format.back"; False:C215)
							OBJECT SET VISIBLE:C603(*; "format.label"; True:C214)
							(OBJECT Get pointer:C1124(Object named:K67:5; "format.label"))->:=Get localized string:C991("inapplicable")
							
						Else 
							
							OBJECT SET ENABLED:C1123(*; "format"; True:C214)
							OBJECT SET VISIBLE:C603(*; "format.back"; True:C214)
							OBJECT SET VISIBLE:C603(*; "format.label"; True:C214)
							
							// ACI0100940
							// ACI0100938
							$caller.columnFormat:=QR_Get_column_format($area; $columnData; $columnType)
							(OBJECT Get pointer:C1124(Object named:K67:5; "format.label"))->:=Choose:C955(Length:C16($caller.columnFormat)#0; $caller.columnFormat; Get localized string:C991("none"))
							
						End if 
						
						// Alternate background color
						OBJECT SET VISIBLE:C603(*; "font.alternate.back.color"; True:C214)
						
						If ($columnData=2)\
							 | ($columnData=3)  // Apply to line
							
							$columnData:=$columnData+(3-$columnData)+(2-$columnData)
							
						End if 
						
						$caller.altBackColor:=QR_Get_color($area; $columnData; $rowData; qr alternate background color:K14904:9)
						(OBJECT Get pointer:C1124(Object named:K67:5; "font.alternate.back.color"))->:=$caller.altBackColor
						
						// Computations
						OBJECT SET VISIBLE:C603(*; "computations"; True:C214)
						$caller.computations:=QR_Get_computation($area; $columnNumber; $rowNumber)
						(OBJECT Get pointer:C1124(Object named:K67:5; "computations"))->:=$caller.computations
						
						//…………………………………………………………………………………………………………
					Else 
						
						ASSERT:C1129(False:C215; "Unknown entry point: \""+$form+"\"")
						
						//…………………………………………………………………………………………………………
				End case 
			End if 
		End if 
		
		(OBJECT Get pointer:C1124(Object named:K67:5; "caller"))->:=JSON Stringify:C1217($caller)
		
		
		//______________________________________________________
	: ($action="switch")
		
		$parameter:=$parameter || New object:C1471  //#DD : securise the parameter instance
		
		If (OBJECT Get visible:C1075(*; $SUBFORM_NAME))
			
			$parameter.action:="hide"
			
		Else 
			
			$parameter.action:="show"
			
		End if 
		
		report_BALLOON_HDL($parameter)
		
		//______________________________________________________
	: ($action="show")
		
		// Find coordinates and dimensions
		FORM GET PROPERTIES:C674($form; $width; $height)
		OBJECT GET COORDINATES:C663(*; String:C10($parameter.caller); $left; $i; $i; $bottom)
		
		$top:=$bottom
		$right:=$left+$width+Num:C11($parameter.hOffset)
		$bottom:=$top+$height+Num:C11($parameter.vOffset)
		
		// Move if necessary to remain in the container
		OBJECT GET SUBFORM CONTAINER SIZE:C1148($width; $height)
		
		If ($right>$width)  // Shift left
			
			$offset:=$width-$right
			$left:=$left+$offset-$MARGIN
			$right+=$offset-$MARGIN
			
		End if 
		
		If ($bottom>$height)  // Shift up
			
			$offset:=$height-$bottom
			$top:=$top+$offset-$MARGIN
			$bottom+=$offset-$MARGIN
			
		End if 
		
		// Set the UI subform
		OBJECT SET SUBFORM:C1138(*; $SUBFORM_NAME; $form)
		
		// Positioning balloon
		OBJECT SET COORDINATES:C1248(*; $SUBFORM_NAME; $left; $top; $right; $bottom)
		
		// Positioning mask
		OBJECT GET COORDINATES:C663(*; Form:C1466.areaObject; $left; $top; $right; $bottom)
		OBJECT SET COORDINATES:C1248(*; "balloon.mask"; $left; $top; $right; $bottom)
		
		// Making visible
		OBJECT SET VISIBLE:C603(*; "balloon.@"; True:C214)
		
		// Give the focus to the subform to generate an On activate event
		GOTO OBJECT:C206(*; "balloon.subform")
		
		// Set the balloon's flag
		ob_area.balloon:=True:C214
		
		//______________________________________________________
	: ($action="hide")
		
		// Hide the UI
		OBJECT SET VISIBLE:C603(*; "balloon.@"; False:C215)
		
		// #ACI0095689
		OBJECT SET SUBFORM:C1138(*; $SUBFORM_NAME; "BALLOON_EMPTY")
		
		If (OB Is defined:C1231($parameter; "postClick"))
			
			If (OB Get:C1224($parameter; "postClick"; Is boolean:K8:9))
				
				GET MOUSE:C468($mouseX; $mouseY; $i; *)
				POST CLICK:C466($mouseX; $mouseY; *)
				
			End if 
		End if 
		
		// Release the balloon's flag
		ob_area.balloon:=False:C215
		
		If (QR_is_valid_area(ob_area.area))
			
			QR REPORT TO BLOB:C770(ob_area.area; $blob)
			
			$digest:=Generate digest:C1147($blob; MD5 digest:K66:1)
			
			If (ob_area._digest#$digest)
				
				ob_area.modified:=True:C214
				
			End if 
		End if 
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Unknown entry point: \""+$action+"\"")
		
		//______________________________________________________
End case 

CLEAR VARIABLE:C89($parameter)