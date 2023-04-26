//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : report_BALLOON_HDL
// Database: 4D Report
// ID[584A5065D22E433C98F7D94F79E000FE]
// Created #25-9-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
// ----------------------------------------------------
// Declarations

#DECLARE($parameter : Object)

/* 
  ----------------------------------------------------

  CONSTANTS

  ----------------------------------------------------   
*/

var \
$MARGIN : Integer

var \
$SUBFORM_NAME : Text

//MARK: uppercase namming mean : it's a constant
$SUBFORM_NAME:="balloon.subform"
$MARGIN:=5


/* 
  ----------------------------------------------------

  VARIABLES

  ----------------------------------------------------   
*/

var \
$buffer_integer; \
$count_parameters; \; \
$int; \
$report_type; \
$type : Integer

var \
$area_reference; \
$mouse_x; \
$mouse_y : Integer

var \
$left; \
$top; \
$right; \
$bottom; \
$width; \
$height; \
$offset; \
$h_offset; \
$v_offset : Integer

//COLUMN
var \
$column_data; \
$column_number; \
$column_type; \
$repeated_values; \
$sort_column_index : Integer

//ROW
var \
$row_data; \
$row_number; \
$subtotal_index : Integer

//UI
var \
$ui_label_pointer : Pointer


var \
$text; \
$action; \
$digest; \
$buffer_text; \
$caller_name; \
$form_name; \
$unit_name : Text


var \
$caller_object; \
$buffer_object : Object


var \
$properties_selected : Boolean

var \
$blob : Blob


var $Lon_column; $Lon_row; $Lon_lastColumn; $Lon_lastRow : Integer

//ARRAYS

ARRAY LONGINT:C221($_sorted_columns; 0)
ARRAY LONGINT:C221($_sort_order; 0)



// ----------------------------------------------------

If (False:C215)
	C_OBJECT:C1216(report_BALLOON_HDL; $1)
End if 

// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=1; "Missing parameter"))
	
	//Required parameters
	//$parameter:=$1
	
	//Optional parameters
	If ($count_parameters>=2)
		
		//NONE
		
	End if 
	
	If (Asserted:C1132(OB Is defined:C1231($parameter)))
		
		If (Asserted:C1132(OB Is defined:C1231($parameter; "action")))
			
			$action:=OB Get:C1224($parameter; "action"; Is text:K8:3)
			
		End if 
		
	End if 
	
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: (Length:C16($action)=0)
		
		//NOTHING MORE TO DO
		
		//______________________________________________________
	: ($action="update")
		
		If (OB Is defined:C1231($parameter))
			
			ASSERT:C1129(OB Is defined:C1231($parameter; "form"))
			
			$form_name:=OB Get:C1224($parameter; "form"; Is text:K8:3)
			
			$caller_object:=OB Copy:C1225(ob_area)
			
			//4DPop_JSON_LAB_VIEW($Obj_caller)
			
			//resize the background
			OBJECT GET SUBFORM CONTAINER SIZE:C1148($height; $width)
			OBJECT SET COORDINATES:C1248(*; "border"; 0; 0; $height; $width)
			
			Obj_CENTER("computations"; "separator"; Horizontally centered:K39:1)
			
			ASSERT:C1129(OB Is defined:C1231($caller_object; "area"))
			$area_reference:=OB Get:C1224($caller_object; "area"; Is longint:K8:6)
			
			If (Asserted:C1132(QR_is_valid_area($area_reference)))
				
				$report_type:=QR Get report kind:C755($area_reference)
				
				$area_reference:=report_Get_target($caller_object; ->$column_number; ->$row_number)
				
				If (Asserted:C1132($column_number>=0))
					
					//------------------ COMMON ------------------//
					
					If (True:C214)  //font name
						
						$buffer_text:=QR_Get_font_name($area_reference; $column_number; $row_number)
						
						//OB SET($caller_object; \
																					"fontName"; $buffer_text)
						
						$caller_object.fontName:=$buffer_text
						
						$buffer_text:=Choose:C955($buffer_text="-"; \
							Get localized string:C991("disparate"); \
							Choose:C955($buffer_text=""; \
							"<Default>"; \
							Replace string:C233($buffer_text; ".Lucida Grande UI"; "Lucida Grande")))
						(OBJECT Get pointer:C1124(Object named:K67:5; "font.family.label"))->:=$buffer_text
						
					End if 
					
					If (True:C214)  //font style
						
						$buffer_integer:=QR_Get_font_style($area_reference; $column_number; $row_number)
						
						//OB SET($caller_object; \
																					"fontStyle"; $buffer_integer)
						
						$caller_object.fontStyle:=$buffer_integer
						
						(OBJECT Get pointer:C1124(Object named:K67:5; "font.style"))->:=$buffer_integer
						
					End if 
					
					If (True:C214)  //font size
						
						$buffer_integer:=QR_Get_font_size($area_reference; $column_number; $row_number)
						
						//OB SET($caller_object; \
																					"fontSize"; $buffer_integer)
						
						$caller_object.fontSize:=$buffer_integer
						
						$buffer_text:=Choose:C955($buffer_integer=-1; \
							"-"; \
							String:C10($buffer_integer))
						(OBJECT Get pointer:C1124(Object named:K67:5; "font.size.label"))->:=$buffer_text
						
					End if 
					
					If (True:C214)  //justification
						
						$buffer_integer:=QR_Get_justification($area_reference; $column_number; $row_number)
						
						//OB SET($caller_object; \
																					"justification"; $buffer_integer)
						
						$caller_object.justification:=$buffer_integer
						
						
						(OBJECT Get pointer:C1124(Object named:K67:5; "justification"))->:=$buffer_integer
						
					End if 
					
					If (True:C214)  //font color
						
						$buffer_integer:=QR_Get_color($area_reference; $column_number; $row_number; qr text color:K14904:6)
						
						//OB SET($caller_object; \
																					"frontColor"; $buffer_integer)
						
						$caller_object.frontColor:=$buffer_integer
						
						(OBJECT Get pointer:C1124(Object named:K67:5; "font.front.color"))->:=$buffer_integer
						
					End if 
					
					If (True:C214)  //back color
						
						$buffer_integer:=QR_Get_color($area_reference; $column_number; $row_number; qr background color:K14904:8)
						
						OB SET:C1220($caller_object; \
							"backColor"; $buffer_integer)
						
						(OBJECT Get pointer:C1124(Object named:K67:5; "font.back.color"))->:=$buffer_integer
						
					End if 
					
					If (True:C214)  //border properties 
						
						$buffer_object:=QR_Get_border_properties($area_reference; $column_number; $row_number)
						
						If ($buffer_object#Null:C1517)
							
							// border selected
							(OBJECT Get pointer:C1124(Object named:K67:5; "borders.controls"))->:=$buffer_object
							
							
							// color 
							(OBJECT Get pointer:C1124(Object named:K67:5; "border.color1"))->:=Choose:C955($buffer_object.sameColor; $buffer_object.colorToSet; 0)
							
							
							
							// thickness
							(OBJECT Get pointer:C1124(Object named:K67:5; "border.style"))->:=$buffer_object.thicknessToSet
							$buffer_text:=Get localized string:C991(Choose:C955($buffer_object.sameThickness; "menu_thickness"+String:C10($buffer_object.thicknessToSet); "menu_thicknessMultiple"))
							(OBJECT Get pointer:C1124(Object named:K67:5; "border.style.label"))->:=$buffer_text
							
							
						End if 
						
					End if 
					
					
					//----------------- SPECIFIC -----------------//
					Case of 
							
							//…………………………………………………………………………………………………………
						: (Position:C15("BALLOON_SUBTOTALLINE"; $form_name)=1)
							
							//format
							OBJECT SET VISIBLE:C603(*; "format@"; False:C215)
							
							//computations {
							OBJECT SET VISIBLE:C603(*; "computations"; True:C214)
							
							If ($report_type=qr cross report:K14902:2) & ($column_number=3)
								
								// Cross - report
								$buffer_integer:=QR_Get_computation($area_reference; 2; $row_number)
								
							Else 
								
								$buffer_integer:=QR_Get_computation($area_reference; $column_number; $row_number)
								
							End if 
							
							//OB SET($caller_object; \
																								"computations"; $buffer_integer)
							
							$caller_object.computations:=$buffer_integer
							
							(OBJECT Get pointer:C1124(Object named:K67:5; "computations"))->:=$buffer_integer
							//}
							
							//subtotal handling
							If (ob_area.sortNumber>0)  // We should be in a subtotal row ... but we never know
								
								$subtotal_index:=ob_area.qrRow
								
								QR GET TOTALS SPACING:C762($area_reference; $subtotal_index; $buffer_integer)
								
								If ($buffer_integer=32000)
									
									$properties_selected:=False:C215
									
									$buffer_text:=Get localized string:C991("menu_subtotalSpacingBreak")
									
								Else 
									
									$properties_selected:=True:C214
									
									$buffer_text:=Get localized string:C991("menu_subtotalSpacingValue")
									
									If ($buffer_integer<0)
										
										$unit_name:=Get localized string:C991("menu_subtotalSpacingPercent")
										
										$buffer_integer:=-$buffer_integer
										
									Else 
										
										$unit_name:=Get localized string:C991("menu_subtotalSpacingPoint")
										
									End if 
									
								End if 
								
								(OBJECT Get pointer:C1124(Object named:K67:5; "subtotalProp.label"))->:=$buffer_text
								(OBJECT Get pointer:C1124(Object named:K67:5; "totalSpacing.unit.label"))->:=$unit_name
								(OBJECT Get pointer:C1124(Object named:K67:5; "totalSpacing.label"))->:=$buffer_integer
								
								OBJECT SET VISIBLE:C603(*; "totalSpacing@"; $properties_selected)
								
								If ($properties_selected)
									
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
							
							//NOTHING MORE TO DO
						: (Position:C15("BALLOON_FONT"; $form_name)=1)
							
							//…………………………………………………………………………………………………………
						: (Position:C15("BALLOON_LINE"; $form_name)=1)
							
							//format (Detail) & computation (only for Subtotal rows and Grand total)
							Case of 
									
									//______________________________________________________
								: ($row_number=qr title:K14906:1)  //Title
									
									//format
									OBJECT SET ENABLED:C1123(*; "format@"; False:C215)
									(OBJECT Get pointer:C1124(Object named:K67:5; "format.label"))->:=Get localized string:C991("inapplicable")
									
									//______________________________________________________
								: ($row_number=qr detail:K14906:2)  //Detail
									
									//alternate background color
									If (True:C214)
										//format
										OBJECT SET VISIBLE:C603(*; "format@"; True:C214)
										
										OBJECT SET VISIBLE:C603(*; "computations"; False:C215)
										
										OBJECT SET VISIBLE:C603(*; "font.alternate.back.color"; True:C214)
										
										$buffer_integer:=QR_Get_color($area_reference; $column_number; $row_number; qr alternate background color:K14904:9)
										
										//OB SET($caller_object; \
																																	"altBackColor"; $buffer_integer)
										
										$caller_object.altBackColor:=$buffer_integer
										
										
										(OBJECT Get pointer:C1124(Object named:K67:5; "font.alternate.back.color"))->:=$buffer_integer
										
									End if 
									
									//format
									If (True:C214)
										
										$type:=QR_Get_column_type($area_reference; $column_number)
										
										If ($type=-1)  //mismatch
											
											OBJECT SET ENABLED:C1123(*; "format"; False:C215)
											OBJECT SET VISIBLE:C603(*; "format.back"; False:C215)
											OBJECT SET VISIBLE:C603(*; "format.label"; True:C214)
											(OBJECT Get pointer:C1124(Object named:K67:5; "format.label"))->:=Get localized string:C991("inapplicable")
											
										Else 
											
											OBJECT SET ENABLED:C1123(*; "format"; True:C214)
											OBJECT SET VISIBLE:C603(*; "format.back"; True:C214)
											OBJECT SET VISIBLE:C603(*; "format.label"; True:C214)
											
											$buffer_text:=QR_Get_column_format($area_reference; $column_number)
											
											//OB SET($caller_object; \
																																				"columnFormat"; $buffer_text)
											
											$caller_object.columnFormat:=$buffer_text
											
											(OBJECT Get pointer:C1124(Object named:K67:5; "format.label"))->:=Choose:C955(Length:C16($buffer_text)#0; $buffer_text; Get localized string:C991("none"))
											
										End if 
									End if 
									
									//______________________________________________________
								: ($row_number=qr grand total:K14906:3)  //Grand Total
									
									//format
									OBJECT SET VISIBLE:C603(*; "format@"; False:C215)
									
									//computations {
									OBJECT SET VISIBLE:C603(*; "computations"; True:C214)
									
									
									$buffer_integer:=QR_Get_computation($area_reference; $column_number; $row_number)
									
									//OB SET($caller_object; \
																														"computations"; $buffer_integer)
									
									$caller_object.computations:=$buffer_integer
									
									(OBJECT Get pointer:C1124(Object named:K67:5; "computations"))->:=$buffer_integer
									//}
									
									//______________________________________________________
								: ($row_number>0)  //break
									
									//format
									OBJECT SET VISIBLE:C603(*; "format@"; False:C215)
									
									//computations {
									OBJECT SET VISIBLE:C603(*; "computations"; True:C214)
									
									//#ACI0098288 [
									//$Lon_buffer:=Choose(($Lon_reportType=qr cross report) & ($Lon_column=3);\
																																																												\
																																																																																																																																																																																																																																																																																																																																																																																																																QR_Get_computation ($area_reference;$column_number;$row_number))
									If ($report_type=qr cross report:K14902:2) & ($column_number=3)
										
										// Cross - report
										$buffer_integer:=QR_Get_computation($area_reference; 2; $row_number)
										
									Else 
										
										$buffer_integer:=QR_Get_computation($area_reference; $column_number; $row_number)
										
									End if 
									//]
									
									//OB SET($caller_object; \
																														"computations"; $buffer_integer)
									
									$caller_object.computations:=$buffer_integer
									
									(OBJECT Get pointer:C1124(Object named:K67:5; "computations"))->:=$buffer_integer
									//}
									
									//______________________________________________________
								Else 
									
									TRACE:C157
									
									//______________________________________________________
							End case 
							
							//…………………………………………………………………………………………………………
						: (Position:C15("BALLOON_COLUMN"; $form_name)=1)
							
							If ($report_type=qr cross report:K14902:2)
								
								$buffer_integer:=QR_Get_color($area_reference; $column_number; $row_number; qr alternate background color:K14904:9)
								
								//OB SET($caller_object; \
																											"altBackColor"; $buffer_integer)
								
								$caller_object.altBackColor:=$buffer_integer
								
								(OBJECT Get pointer:C1124(Object named:K67:5; "font.alternate.back.color"))->:=$buffer_integer
								
								//#ACI0095708
								$area_reference:=report_Get_target($caller_object; ->$column_data; ->$row_data; True:C214)
								$column_type:=QR_Get_column_type($area_reference; $column_data)
								
							Else 
								
								//format
								$column_type:=QR_Get_column_type($area_reference; $column_number)
								
							End if 
							
							If ($column_type=-1)  //undefined for a formula
								
								//#TO_BE_DONE - change the user interface to allow string entry
								
							End if 
							
							If ($report_type=qr cross report:K14902:2)
								
								//#ACI0095708
								$buffer_text:=QR_Get_column_format($area_reference; $column_data; $column_type)
								
							Else 
								
								$buffer_text:=QR_Get_column_format($area_reference; $column_number; $column_type)
								
							End if 
							
							//OB SET($caller_object; \
																								"columnFormat"; $buffer_text)
							
							$caller_object.columnFormat:=$buffer_text
							
							(OBJECT Get pointer:C1124(Object named:K67:5; "format.label"))->:=Choose:C955(Length:C16($buffer_text)#0; $buffer_text; Get localized string:C991("none"))
							
							OBJECT SET VISIBLE:C603(*; "format@"; True:C214)
							
							//sort
							If ($column_type=Is BLOB:K8:12)\
								 | ($column_type=Is picture:K8:10)\
								 | ($column_type=Is subtable:K8:11)
								
								OBJECT SET ENABLED:C1123(*; "sort"; False:C215)
								OBJECT SET VISIBLE:C603(*; "sort.back"; False:C215)
								(OBJECT Get pointer:C1124(Object named:K67:5; "sort.label"))->:=Get localized string:C991("inapplicable")
								
							Else 
								
								OBJECT SET ENABLED:C1123(*; "sort"; True:C214)
								OBJECT SET VISIBLE:C603(*; "sort.back"; True:C214)
								
								QR GET SORTS:C753($area_reference; $_sorted_columns; $_sort_order)
								$sort_column_index:=Find in array:C230($_sorted_columns; $column_number)
								
								$ui_label_pointer:=OBJECT Get pointer:C1124(Object named:K67:5; "sort.label")
								
								Case of 
										
										//-----------------------------
									: ($sort_column_index=-1)  //not sorted
										
										$ui_label_pointer->:=Get localized string:C991("menu_sort_none")
										
										//-----------------------------
									: ($_sort_order{$sort_column_index}=0)
										
										$ui_label_pointer->:=Get localized string:C991("menu_sort_none")
										
										//-----------------------------
									: ($_sort_order{$sort_column_index}=1)
										
										$ui_label_pointer->:=Get localized string:C991(\
											Choose:C955($report_type=qr cross report:K14902:2; \
											Choose:C955($column_number=2; \
											"menu_sort_leftToRight"; \
											"menu_sort_topToBottom"); \
											"menu_sort_ascending"))
										
										//-----------------------------
									: ($_sort_order{$sort_column_index}=-1)
										
										$ui_label_pointer->:=Get localized string:C991(\
											Choose:C955($report_type=qr cross report:K14902:2; \
											Choose:C955($column_number=2; \
											"menu_sort_rightToLeft"; \
											"menu_sort_bottomToTop"); \
											"menu_sort_descending"))
										
										//-----------------------------
								End case 
								
								REDRAW WINDOW:C456(Current form window:C827)
								
							End if 
							
							//options
							QR GET INFO COLUMN:C766($area_reference; $column_number; $text; $text; $int; $width; $repeated_values; $text; $text)
							
							(OBJECT Get pointer:C1124(Object named:K67:5; "automaticWidth"))->:=Num:C11($width=-1)
							
							If ($report_type=qr cross report:K14902:2)
								
								If ($column_number=1)
									
									OBJECT SET VISIBLE:C603(*; "font.alternate.back.color"; True:C214)
									
								Else 
									
									OBJECT GET SUBFORM CONTAINER SIZE:C1148($width; $int)
									OBJECT GET COORDINATES:C663(*; "font.alternate.back.color"; $int; $int; $right; $int)
									OBJECT SET VISIBLE:C603(*; "font.alternate.back.color"; $width>=$right)
									
								End if 
								
							Else 
								
								(OBJECT Get pointer:C1124(Object named:K67:5; "repeatedValues"))->:=$repeated_values
								
							End if 
							
							//…………………………………………………………………………………………………………
						: (Position:C15("BALLOON_CROSS_DATA"; $form_name)=1)
							
							//format
							OBJECT SET VISIBLE:C603(*; "format@"; True:C214)
							
							//#ACI0095708
							//$Lon_type:=QR_Get_column_type ($Lon_area;$Lon_column)
							$area_reference:=report_Get_target($caller_object; ->$column_data; ->$row_data; True:C214)
							$type:=QR_Get_column_type($area_reference; $column_data)
							
							If ($type=-1)  //mismatch
								
								OBJECT SET ENABLED:C1123(*; "format"; False:C215)
								OBJECT SET VISIBLE:C603(*; "format.back"; False:C215)
								OBJECT SET VISIBLE:C603(*; "format.label"; True:C214)
								(OBJECT Get pointer:C1124(Object named:K67:5; "format.label"))->:=Get localized string:C991("inapplicable")
								
							Else 
								
								OBJECT SET ENABLED:C1123(*; "format"; True:C214)
								OBJECT SET VISIBLE:C603(*; "format.back"; True:C214)
								OBJECT SET VISIBLE:C603(*; "format.label"; True:C214)
								
								//ACI0100940{ACI0100938
/*
																																																																																								If ($Lon_columnData=2)\
																																																																																																			 | ($Lon_columnData=3)  //apply to line
								
$lon_columnTempo:=$Lon_columnData+(3-$Lon_columnData)+(2-$Lon_columnData)
Else 
$lon_columnTempo:=$Lon_columnData
End if 
//}*/
								
								$buffer_text:=QR_Get_column_format($area_reference; $column_data; $column_type)
								
								//OB SET($caller_object; \
																											"columnFormat"; $buffer_text)
								
								$caller_object.columnFormat:=$buffer_text
								
								(OBJECT Get pointer:C1124(Object named:K67:5; "format.label"))->:=Choose:C955(Length:C16($buffer_text)#0; $buffer_text; Get localized string:C991("none"))
								
							End if 
							
							//alternate background color
							If (True:C214)
								
								OBJECT SET VISIBLE:C603(*; "font.alternate.back.color"; True:C214)
								
								If ($column_data=2)\
									 | ($column_data=3)  //apply to line
									
									$column_data:=$column_data+(3-$column_data)+(2-$column_data)
									
								End if 
								
								$buffer_integer:=QR_Get_color($area_reference; $column_data; $row_data; qr alternate background color:K14904:9)
								
								//OB SET($caller_object; \
																											"altBackColor"; $buffer_integer)
								
								$caller_object.altBackColor:=$buffer_integer
								
								
								(OBJECT Get pointer:C1124(Object named:K67:5; "font.alternate.back.color"))->:=$buffer_integer
								
							End if 
							
							//computations {
							OBJECT SET VISIBLE:C603(*; "computations"; True:C214)
							
							$buffer_integer:=QR_Get_computation($area_reference; $column_number; $row_number)
							
							//OB SET($caller_object; \
																								"computations"; $buffer_integer)
							
							$caller_object.computations:=$buffer_integer
							
							(OBJECT Get pointer:C1124(Object named:K67:5; "computations"))->:=$buffer_integer
							//}
							
							//…………………………………………………………………………………………………………
						Else 
							
							ASSERT:C1129(False:C215; "Unknown entry point: \""+$form_name+"\"")
							
							//…………………………………………………………………………………………………………
					End case 
				End if 
			End if 
			
			(OBJECT Get pointer:C1124(Object named:K67:5; "caller"))->:=JSON Stringify:C1217($caller_object)
			
		End if 
		
		//______________________________________________________
	: ($action="switch")
		
		$parameter:=$parameter || New object:C1471  //#DD : securise the parameter instance
		
		If (OBJECT Get visible:C1075(*; $SUBFORM_NAME))
			
			//OB SET($parameter; \
												"action"; "hide")
			
			$parameter.action:="hide"
			
		Else 
			
			//OB SET($parameter; \
												"action"; "show")
			
			$parameter.action:="show"
			
		End if 
		
		report_BALLOON_HDL($parameter)
		
		//______________________________________________________
	: ($action="show")
		
		ASSERT:C1129(OB Is defined:C1231($parameter; "caller"))
		ASSERT:C1129(OB Is defined:C1231($parameter; "form"))
		
		$caller_name:=OB Get:C1224($parameter; "caller"; Is text:K8:3)
		$form_name:=OB Get:C1224($parameter; "form"; Is text:K8:3)
		$h_offset:=OB Get:C1224($parameter; "hOffset"; Is longint:K8:6)
		$v_offset:=OB Get:C1224($parameter; "vOffset"; Is longint:K8:6)
		
		//find coordinates and dimensions
		FORM GET PROPERTIES:C674($form_name; $width; $height)
		OBJECT GET COORDINATES:C663(*; $caller_name; $left; $int; $int; $bottom)
		
		$top:=$bottom
		$right:=$left+$width+$h_offset
		$bottom:=$top+$height+$v_offset
		
		//move if necessary to remain in the container
		OBJECT GET SUBFORM CONTAINER SIZE:C1148($width; $height)
		
		If ($right>$width)  //shift left
			
			$offset:=$width-$right
			$left:=$left+$offset-$MARGIN
			$right:=$right+$offset-$MARGIN
			
		End if 
		
		If ($bottom>$height)  //shift up
			
			$offset:=$height-$bottom
			$top:=$top+$offset-$MARGIN
			$bottom:=$bottom+$offset-$MARGIN
			
		End if 
		
		
		//set the UI subform
		OBJECT SET SUBFORM:C1138(*; $SUBFORM_NAME; $form_name)
		
		//positioning balloon
		OBJECT SET COORDINATES:C1248(*; $SUBFORM_NAME; $left; $top; $right; $bottom)
		
		//positioning mask
		OBJECT GET COORDINATES:C663(*; Form:C1466.areaObject; $left; $top; $right; $bottom)
		OBJECT SET COORDINATES:C1248(*; "balloon.mask"; $left; $top; $right; $bottom)
		
		//making visible
		OBJECT SET VISIBLE:C603(*; "balloon.@"; True:C214)
		
		//give the focus to the subform to generate an On activate event
		GOTO OBJECT:C206(*; "balloon.subform")
		
		//set the balloon's flag
		//OB SET(ob_area; \
									"balloon"; True)
		
		ob_area.balloon:=True:C214
		//______________________________________________________
	: ($action="hide")
		
		//hide the UI
		OBJECT SET VISIBLE:C603(*; "balloon.@"; False:C215)
		
		//#ACI0095689
		OBJECT SET SUBFORM:C1138(*; $SUBFORM_NAME; "BALLOON_EMPTY")
		
		If (OB Is defined:C1231($parameter; "postClick"))
			
			If (OB Get:C1224($parameter; "postClick"; Is boolean:K8:9))
				
				GET MOUSE:C468($mouse_x; $mouse_y; $int; *)
				POST CLICK:C466($mouse_x; $mouse_y; *)
				
			End if 
			
		End if 
		
		//release the balloon's flag
		
		//OB SET(ob_area; \
									"balloon"; False)
		
		ob_area.balloon:=False:C215
		
		
		If (QR_is_valid_area(ob_area.area))
			
			
			
			QR REPORT TO BLOB:C770(ob_area.area; $blob)
			
			$digest:=Generate digest:C1147($blob; MD5 digest:K66:1)
			QR GET SELECTION:C793(ob_area.area; $Lon_column; $Lon_row; $Lon_lastColumn; $Lon_lastRow)
			$digest+=String:C10($Lon_column)+"_"+String:C10($Lon_row)+"_"+String:C10($Lon_lastColumn)+"_"+String:C10($Lon_lastRow)
			
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

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End