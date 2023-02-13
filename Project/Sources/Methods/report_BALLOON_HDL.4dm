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
C_OBJECT:C1216($1)

C_LONGINT:C283($kLon_margin; $Lon_; $Lon_area; $Lon_bottom; $Lon_buffer; $Lon_column; $lon_columnTempo)
C_LONGINT:C283($Lon_columnData; $Lon_columnType; $Lon_height; $Lon_hOffset; $Lon_left; $Lon_mouseX)
C_LONGINT:C283($Lon_mouseY; $Lon_offset; $Lon_parameters; $Lon_repeated; $Lon_reportType; $Lon_right)
C_LONGINT:C283($Lon_row; $Lon_rowData; $Lon_sort_index; $Lon_top; $Lon_type; $Lon_vOffset)
C_LONGINT:C283($Lon_width; $lon_subtotalNumber; $lon_left; $lon_top; $lon_right; $lon_bottom)
C_POINTER:C301($Ptr_label)
C_TEXT:C284($kTxt_subform; $Txt_; $Txt_action; $Txt_buffer; $Txt_caller; $Txt_form; $txt_unit)
C_OBJECT:C1216($Obj_caller; $Obj_param; $obj_buffer)
C_BOOLEAN:C305($boo_propertiesSelected)


ARRAY LONGINT:C221($tLon_sortedColumns; 0)
ARRAY LONGINT:C221($tLon_sortOrder; 0)

If (False:C215)
	C_OBJECT:C1216(report_BALLOON_HDL; $1)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1; "Missing parameter"))
	
	//Required parameters
	$Obj_param:=$1
	
	//Optional parameters
	If ($Lon_parameters>=2)
		
		//NONE
		
	End if 
	
	If (Asserted:C1132(OB Is defined:C1231($Obj_param)))
		
		If (Asserted:C1132(OB Is defined:C1231($Obj_param; "action")))
			
			$Txt_action:=OB Get:C1224($Obj_param; "action"; Is text:K8:3)
			
		End if 
	End if 
	
	//Constants
	$kTxt_subform:="balloon.subform"
	$kLon_margin:=5
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: (Length:C16($Txt_action)=0)
		
		//NOTHING MORE TO DO
		
		//______________________________________________________
	: ($Txt_action="update")
		
		If (OB Is defined:C1231($Obj_param))
			
			ASSERT:C1129(OB Is defined:C1231($Obj_param; "form"))
			$Txt_form:=OB Get:C1224($Obj_param; "form"; Is text:K8:3)
			
			$Obj_caller:=OB Copy:C1225(ob_area)
			
			//4DPop_JSON_LAB_VIEW($Obj_caller)
			
			//resize the background
			OBJECT GET SUBFORM CONTAINER SIZE:C1148($Lon_height; $Lon_width)
			OBJECT SET COORDINATES:C1248(*; "border"; 0; 0; $Lon_height; $Lon_width)
			
			Obj_CENTER("computations"; "separator"; Horizontally centered:K39:1)
			
			ASSERT:C1129(OB Is defined:C1231($Obj_caller; "area"))
			$Lon_area:=OB Get:C1224($Obj_caller; "area"; Is longint:K8:6)
			
			If (Asserted:C1132(QR_is_valid_area($Lon_area)))
				
				$Lon_reportType:=QR Get report kind:C755($Lon_area)
				
				$Lon_area:=report_Get_target($Obj_caller; ->$Lon_column; ->$Lon_row)
				
				If (Asserted:C1132($Lon_column>=0))
					
					//------------------ COMMON ------------------//
					
					If (True:C214)  //font name
						
						$Txt_buffer:=QR_Get_font_name($Lon_area; $Lon_column; $Lon_row)
						
						OB SET:C1220($Obj_caller; \
							"fontName"; $Txt_buffer)
						
						$Txt_buffer:=Choose:C955($Txt_buffer="-"; \
							Get localized string:C991("disparate"); \
							Choose:C955($Txt_buffer=""; \
							"<Default>"; \
							Replace string:C233($Txt_buffer; ".Lucida Grande UI"; "Lucida Grande")))
						(OBJECT Get pointer:C1124(Object named:K67:5; "font.family.label"))->:=$Txt_buffer
						
					End if 
					
					If (True:C214)  //font style
						
						$Lon_buffer:=QR_Get_font_style($Lon_area; $Lon_column; $Lon_row)
						
						OB SET:C1220($Obj_caller; \
							"fontStyle"; $Lon_buffer)
						
						(OBJECT Get pointer:C1124(Object named:K67:5; "font.style"))->:=$Lon_buffer
						
					End if 
					
					If (True:C214)  //font size
						
						$Lon_buffer:=QR_Get_font_size($Lon_area; $Lon_column; $Lon_row)
						
						OB SET:C1220($Obj_caller; \
							"fontSize"; $Lon_buffer)
						
						$Txt_buffer:=Choose:C955($Lon_buffer=-1; \
							"-"; \
							String:C10($Lon_buffer))
						(OBJECT Get pointer:C1124(Object named:K67:5; "font.size.label"))->:=$Txt_buffer
						
					End if 
					
					If (True:C214)  //justification
						
						$Lon_buffer:=QR_Get_justification($Lon_area; $Lon_column; $Lon_row)
						
						OB SET:C1220($Obj_caller; \
							"justification"; $Lon_buffer)
						
						(OBJECT Get pointer:C1124(Object named:K67:5; "justification"))->:=$Lon_buffer
						
					End if 
					
					If (True:C214)  //font color
						
						$Lon_buffer:=QR_Get_color($Lon_area; $Lon_column; $Lon_row; qr text color:K14904:6)
						
						OB SET:C1220($Obj_caller; \
							"frontColor"; $Lon_buffer)
						
						(OBJECT Get pointer:C1124(Object named:K67:5; "font.front.color"))->:=$Lon_buffer
						
					End if 
					
					If (True:C214)  //back color
						
						$Lon_buffer:=QR_Get_color($Lon_area; $Lon_column; $Lon_row; qr background color:K14904:8)
						
						OB SET:C1220($Obj_caller; \
							"backColor"; $Lon_buffer)
						
						(OBJECT Get pointer:C1124(Object named:K67:5; "font.back.color"))->:=$Lon_buffer
						
					End if 
					
					If (True:C214)  //border properties 
						
						$obj_buffer:=QR_Get_border_properties($Lon_area; $Lon_column; $Lon_row)
						
						If ($obj_buffer#Null:C1517)
							
							// border selected
							(OBJECT Get pointer:C1124(Object named:K67:5; "borders.controls"))->:=$obj_buffer
							
							
							// color 
							(OBJECT Get pointer:C1124(Object named:K67:5; "border.color1"))->:=Choose:C955($obj_buffer.sameColor; $obj_buffer.colorToSet; 0)
							
							
							
							// thickness
							(OBJECT Get pointer:C1124(Object named:K67:5; "border.style"))->:=$obj_buffer.thicknessToSet
							$Txt_buffer:=Get localized string:C991(Choose:C955($obj_buffer.sameThickness; "menu_thickness"+String:C10($obj_buffer.thicknessToSet); "menu_thicknessMultiple"))
							(OBJECT Get pointer:C1124(Object named:K67:5; "border.style.label"))->:=$Txt_buffer
							
							
						End if 
						
					End if 
					
					
					//----------------- SPECIFIC -----------------//
					Case of 
							
							//…………………………………………………………………………………………………………
						: (Position:C15("BALLOON_SUBTOTALLINE"; $Txt_form)=1)
							
							//format
							OBJECT SET VISIBLE:C603(*; "format@"; False:C215)
							
							//computations {
							OBJECT SET VISIBLE:C603(*; "computations"; True:C214)
							
							If ($Lon_reportType=qr cross report:K14902:2) & ($Lon_column=3)
								
								// Cross - report
								$Lon_buffer:=QR_Get_computation($Lon_area; 2; $Lon_row)
								
							Else 
								
								$Lon_buffer:=QR_Get_computation($Lon_area; $Lon_column; $Lon_row)
								
							End if 
							
							OB SET:C1220($Obj_caller; \
								"computations"; $Lon_buffer)
							
							(OBJECT Get pointer:C1124(Object named:K67:5; "computations"))->:=$Lon_buffer
							//}
							
							//subtotal handling
							If (ob_area.sortNumber>0)  // We should be in a subtotal row ... but we never know
								
								$lon_subtotalNumber:=ob_area.qrRow
								
								QR GET TOTALS SPACING:C762($Lon_area; $lon_subtotalNumber; $Lon_buffer)
								
								If ($Lon_buffer=32000)
									
									$boo_propertiesSelected:=False:C215
									
									$Txt_buffer:=Get localized string:C991("menu_subtotalSpacingBreak")
									
								Else 
									
									$boo_propertiesSelected:=True:C214
									
									$Txt_buffer:=Get localized string:C991("menu_subtotalSpacingValue")
									
									If ($Lon_buffer<0)
										
										$txt_unit:=Get localized string:C991("menu_subtotalSpacingPercent")
										
										$Lon_buffer:=-$Lon_buffer
										
									Else 
										
										$txt_unit:=Get localized string:C991("menu_subtotalSpacingPoint")
										
									End if 
									
								End if 
								
								(OBJECT Get pointer:C1124(Object named:K67:5; "subtotalProp.label"))->:=$Txt_buffer
								(OBJECT Get pointer:C1124(Object named:K67:5; "totalSpacing.unit.label"))->:=$txt_unit
								(OBJECT Get pointer:C1124(Object named:K67:5; "totalSpacing.label"))->:=$Lon_buffer
								
								OBJECT SET VISIBLE:C603(*; "totalSpacing@"; $boo_propertiesSelected)
								
								If ($boo_propertiesSelected)
									
									OBJECT GET COORDINATES:C663(*; "subtotalProp"; $lon_left; $lon_top; $lon_right; $lon_bottom)
									OBJECT SET COORDINATES:C1248(*; "subtotalProp"; $lon_left; $lon_top; 193; $lon_bottom)
									
									OBJECT GET COORDINATES:C663(*; "subtotalProp.back"; $lon_left; $lon_top; $lon_rightNew; $lon_bottom)
									OBJECT SET COORDINATES:C1248(*; "subtotalProp.back"; $lon_left; $lon_top; 194; $lon_bottom)
									
									OBJECT GET COORDINATES:C663(*; "subtotalProp.label"; $lon_left; $lon_top; $lon_rightNew; $lon_bottom)
									OBJECT SET COORDINATES:C1248(*; "subtotalProp.label"; $lon_left; $lon_top; 190; $lon_bottom)
									
									
								Else 
									
									OBJECT GET COORDINATES:C663(*; "subtotalProp"; $lon_left; $lon_top; $lon_right; $lon_bottom)
									OBJECT SET COORDINATES:C1248(*; "subtotalProp"; $lon_left; $lon_top; 262; $lon_bottom)
									
									OBJECT GET COORDINATES:C663(*; "subtotalProp.back"; $lon_left; $lon_top; $lon_rightNew; $lon_bottom)
									OBJECT SET COORDINATES:C1248(*; "subtotalProp.back"; $lon_left; $lon_top; 263; $lon_bottom)
									
									OBJECT GET COORDINATES:C663(*; "subtotalProp.label"; $lon_left; $lon_top; $lon_rightNew; $lon_bottom)
									OBJECT SET COORDINATES:C1248(*; "subtotalProp.label"; $lon_left; $lon_top; 260; $lon_bottom)
									
								End if 
								
								
								
								
							End if 
							
							//NOTHING MORE TO DO
						: (Position:C15("BALLOON_FONT"; $Txt_form)=1)
							
							//…………………………………………………………………………………………………………
						: (Position:C15("BALLOON_LINE"; $Txt_form)=1)
							
							//format (Detail) & computation (only for Subtotal rows and Grand total)
							Case of 
									
									//______________________________________________________
								: ($Lon_row=qr title:K14906:1)  //Title
									
									//format
									OBJECT SET ENABLED:C1123(*; "format@"; False:C215)
									(OBJECT Get pointer:C1124(Object named:K67:5; "format.label"))->:=Get localized string:C991("inapplicable")
									
									//______________________________________________________
								: ($Lon_row=qr detail:K14906:2)  //Detail
									
									//alternate background color
									If (True:C214)
										//format
										OBJECT SET VISIBLE:C603(*; "format@"; True:C214)
										
										OBJECT SET VISIBLE:C603(*; "computations"; False:C215)
										
										OBJECT SET VISIBLE:C603(*; "font.alternate.back.color"; True:C214)
										
										$Lon_buffer:=QR_Get_color($Lon_area; $Lon_column; $Lon_row; qr alternate background color:K14904:9)
										
										OB SET:C1220($Obj_caller; \
											"altBackColor"; $Lon_buffer)
										
										(OBJECT Get pointer:C1124(Object named:K67:5; "font.alternate.back.color"))->:=$Lon_buffer
										
									End if 
									
									//format
									If (True:C214)
										
										$Lon_type:=QR_Get_column_type($Lon_area; $Lon_column)
										
										If ($Lon_type=-1)  //mismatch
											
											OBJECT SET ENABLED:C1123(*; "format"; False:C215)
											OBJECT SET VISIBLE:C603(*; "format.back"; False:C215)
											OBJECT SET VISIBLE:C603(*; "format.label"; True:C214)
											(OBJECT Get pointer:C1124(Object named:K67:5; "format.label"))->:=Get localized string:C991("inapplicable")
											
										Else 
											
											OBJECT SET ENABLED:C1123(*; "format"; True:C214)
											OBJECT SET VISIBLE:C603(*; "format.back"; True:C214)
											OBJECT SET VISIBLE:C603(*; "format.label"; True:C214)
											
											$Txt_buffer:=QR_Get_column_format($Lon_area; $Lon_column)
											
											OB SET:C1220($Obj_caller; \
												"columnFormat"; $Txt_buffer)
											
											(OBJECT Get pointer:C1124(Object named:K67:5; "format.label"))->:=Choose:C955(Length:C16($Txt_buffer)#0; $Txt_buffer; Get localized string:C991("none"))
											
										End if 
									End if 
									
									//______________________________________________________
								: ($Lon_row=qr grand total:K14906:3)  //Grand Total
									
									//format
									OBJECT SET VISIBLE:C603(*; "format@"; False:C215)
									
									//computations {
									OBJECT SET VISIBLE:C603(*; "computations"; True:C214)
									
									
									$Lon_buffer:=QR_Get_computation($Lon_area; $Lon_column; $Lon_row)
									
									OB SET:C1220($Obj_caller; \
										"computations"; $Lon_buffer)
									
									(OBJECT Get pointer:C1124(Object named:K67:5; "computations"))->:=$Lon_buffer
									//}
									
									//______________________________________________________
								: ($Lon_row>0)  //break
									
									//format
									OBJECT SET VISIBLE:C603(*; "format@"; False:C215)
									
									//computations {
									OBJECT SET VISIBLE:C603(*; "computations"; True:C214)
									
									//#ACI0098288 [
									//$Lon_buffer:=Choose(($Lon_reportType=qr cross report) & ($Lon_column=3);\
																																																																																																																																																																																																																																																																																																																							\
																																																																						\
																																																																																\
																																																																																										\
																																																																																																			Q\
																																																																																																				R_Get_comp\
																																																																																																														utation ($\
																																																																																																																								Lon_area;2\
																																																																																																																																		;$Lon_row)\
																																																																																																																																												;\
																																																																																																																																																																																																																																																																																																																																																														QR_Get_computation ($Lon_area;$Lon_column;$Lon_row))
									If ($Lon_reportType=qr cross report:K14902:2) & ($Lon_column=3)
										
										// Cross - report
										$Lon_buffer:=QR_Get_computation($Lon_area; 2; $Lon_row)
										
									Else 
										
										$Lon_buffer:=QR_Get_computation($Lon_area; $Lon_column; $Lon_row)
										
									End if 
									//]
									
									OB SET:C1220($Obj_caller; \
										"computations"; $Lon_buffer)
									
									(OBJECT Get pointer:C1124(Object named:K67:5; "computations"))->:=$Lon_buffer
									//}
									
									//______________________________________________________
								Else 
									
									TRACE:C157
									
									//______________________________________________________
							End case 
							
							//…………………………………………………………………………………………………………
						: (Position:C15("BALLOON_COLUMN"; $Txt_form)=1)
							
							If ($Lon_reportType=qr cross report:K14902:2)
								
								$Lon_buffer:=QR_Get_color($Lon_area; $Lon_column; $Lon_row; qr alternate background color:K14904:9)
								
								OB SET:C1220($Obj_caller; \
									"altBackColor"; $Lon_buffer)
								
								(OBJECT Get pointer:C1124(Object named:K67:5; "font.alternate.back.color"))->:=$Lon_buffer
								
								//#ACI0095708
								$Lon_area:=report_Get_target($Obj_caller; ->$Lon_columnData; ->$Lon_rowData; True:C214)
								$Lon_columnType:=QR_Get_column_type($Lon_area; $Lon_columnData)
								
							Else 
								
								//format
								$Lon_columnType:=QR_Get_column_type($Lon_area; $Lon_column)
								
							End if 
							
							If ($Lon_columnType=-1)  //undefined for a formula
								
								//#TO_BE_DONE - change the user interface to allow string entry
								
							End if 
							
							If ($Lon_reportType=qr cross report:K14902:2)
								
								//#ACI0095708
								$Txt_buffer:=QR_Get_column_format($Lon_area; $Lon_columnData; $Lon_columnType)
								
							Else 
								
								$Txt_buffer:=QR_Get_column_format($Lon_area; $Lon_column; $Lon_columnType)
								
							End if 
							
							OB SET:C1220($Obj_caller; \
								"columnFormat"; $Txt_buffer)
							
							(OBJECT Get pointer:C1124(Object named:K67:5; "format.label"))->:=Choose:C955(Length:C16($Txt_buffer)#0; $Txt_buffer; Get localized string:C991("none"))
							
							OBJECT SET VISIBLE:C603(*; "format@"; True:C214)
							
							//sort
							If ($Lon_columnType=Is BLOB:K8:12)\
								 | ($Lon_columnType=Is picture:K8:10)\
								 | ($Lon_columnType=Is subtable:K8:11)
								
								OBJECT SET ENABLED:C1123(*; "sort"; False:C215)
								OBJECT SET VISIBLE:C603(*; "sort.back"; False:C215)
								(OBJECT Get pointer:C1124(Object named:K67:5; "sort.label"))->:=Get localized string:C991("inapplicable")
								
							Else 
								
								OBJECT SET ENABLED:C1123(*; "sort"; True:C214)
								OBJECT SET VISIBLE:C603(*; "sort.back"; True:C214)
								
								QR GET SORTS:C753($Lon_area; $tLon_sortedColumns; $tLon_sortOrder)
								$Lon_sort_index:=Find in array:C230($tLon_sortedColumns; $Lon_column)
								
								$Ptr_label:=OBJECT Get pointer:C1124(Object named:K67:5; "sort.label")
								
								Case of 
										
										//-----------------------------
									: ($Lon_sort_index=-1)  //not sorted
										
										$Ptr_label->:=Get localized string:C991("menu_sort_none")
										
										//-----------------------------
									: ($tLon_sortOrder{$Lon_sort_index}=0)
										
										$Ptr_label->:=Get localized string:C991("menu_sort_none")
										
										//-----------------------------
									: ($tLon_sortOrder{$Lon_sort_index}=1)
										
										$Ptr_label->:=Get localized string:C991(\
											Choose:C955($Lon_reportType=qr cross report:K14902:2; \
											Choose:C955($Lon_column=2; \
											"menu_sort_leftToRight"; \
											"menu_sort_topToBottom"); \
											"menu_sort_ascending"))
										
										//-----------------------------
									: ($tLon_sortOrder{$Lon_sort_index}=-1)
										
										$Ptr_label->:=Get localized string:C991(\
											Choose:C955($Lon_reportType=qr cross report:K14902:2; \
											Choose:C955($Lon_column=2; \
											"menu_sort_rightToLeft"; \
											"menu_sort_bottomToTop"); \
											"menu_sort_descending"))
										
										//-----------------------------
								End case 
								
								REDRAW WINDOW:C456(Current form window:C827)
								
							End if 
							
							//options
							QR GET INFO COLUMN:C766($Lon_area; $Lon_column; $Txt_; $Txt_; $Lon_; $Lon_width; $Lon_repeated; $Txt_; $Txt_)
							
							(OBJECT Get pointer:C1124(Object named:K67:5; "automaticWidth"))->:=Num:C11($Lon_width=-1)
							
							If ($Lon_reportType=qr cross report:K14902:2)
								
								If ($Lon_column=1)
									
									OBJECT SET VISIBLE:C603(*; "font.alternate.back.color"; True:C214)
									
								Else 
									
									OBJECT GET SUBFORM CONTAINER SIZE:C1148($Lon_width; $Lon_)
									OBJECT GET COORDINATES:C663(*; "font.alternate.back.color"; $Lon_; $Lon_; $Lon_right; $Lon_)
									OBJECT SET VISIBLE:C603(*; "font.alternate.back.color"; $Lon_width>=$Lon_right)
									
								End if 
								
							Else 
								
								(OBJECT Get pointer:C1124(Object named:K67:5; "repeatedValues"))->:=$Lon_repeated
								
							End if 
							
							//…………………………………………………………………………………………………………
						: (Position:C15("BALLOON_CROSS_DATA"; $Txt_form)=1)
							
							//format
							OBJECT SET VISIBLE:C603(*; "format@"; True:C214)
							
							//#ACI0095708
							//$Lon_type:=QR_Get_column_type ($Lon_area;$Lon_column)
							$Lon_area:=report_Get_target($Obj_caller; ->$Lon_columnData; ->$Lon_rowData; True:C214)
							$Lon_type:=QR_Get_column_type($Lon_area; $Lon_columnData)
							
							If ($Lon_type=-1)  //mismatch
								
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
								
								$Txt_buffer:=QR_Get_column_format($Lon_area; $Lon_columnData; $Lon_columnType)
								OB SET:C1220($Obj_caller; \
									"columnFormat"; $Txt_buffer)
								
								(OBJECT Get pointer:C1124(Object named:K67:5; "format.label"))->:=Choose:C955(Length:C16($Txt_buffer)#0; $Txt_buffer; Get localized string:C991("none"))
								
							End if 
							
							//alternate background color
							If (True:C214)
								
								OBJECT SET VISIBLE:C603(*; "font.alternate.back.color"; True:C214)
								
								If ($Lon_columnData=2)\
									 | ($Lon_columnData=3)  //apply to line
									
									$Lon_columnData:=$Lon_columnData+(3-$Lon_columnData)+(2-$Lon_columnData)
									
								End if 
								
								$Lon_buffer:=QR_Get_color($Lon_area; $Lon_columnData; $Lon_rowData; qr alternate background color:K14904:9)
								
								OB SET:C1220($Obj_caller; \
									"altBackColor"; $Lon_buffer)
								
								(OBJECT Get pointer:C1124(Object named:K67:5; "font.alternate.back.color"))->:=$Lon_buffer
								
							End if 
							
							//computations {
							OBJECT SET VISIBLE:C603(*; "computations"; True:C214)
							
							$Lon_buffer:=QR_Get_computation($Lon_area; $Lon_column; $Lon_row)
							
							OB SET:C1220($Obj_caller; \
								"computations"; $Lon_buffer)
							
							(OBJECT Get pointer:C1124(Object named:K67:5; "computations"))->:=$Lon_buffer
							//}
							
							//…………………………………………………………………………………………………………
						Else 
							
							ASSERT:C1129(False:C215; "Unknown entry point: \""+$Txt_form+"\"")
							
							//…………………………………………………………………………………………………………
					End case 
				End if 
			End if 
			
			(OBJECT Get pointer:C1124(Object named:K67:5; "caller"))->:=JSON Stringify:C1217($Obj_caller)
			
		End if 
		
		//______________________________________________________
	: ($Txt_action="switch")
		
		If (OBJECT Get visible:C1075(*; $kTxt_subform))
			
			OB SET:C1220($Obj_param; \
				"action"; "hide")
			
		Else 
			
			OB SET:C1220($Obj_param; \
				"action"; "show")
			
		End if 
		
		report_BALLOON_HDL($Obj_param)
		
		//______________________________________________________
	: ($Txt_action="show")
		
		ASSERT:C1129(OB Is defined:C1231($Obj_param; "caller"))
		ASSERT:C1129(OB Is defined:C1231($Obj_param; "form"))
		
		$Txt_caller:=OB Get:C1224($Obj_param; "caller"; Is text:K8:3)
		$Txt_form:=OB Get:C1224($Obj_param; "form"; Is text:K8:3)
		$Lon_hOffset:=OB Get:C1224($Obj_param; "hOffset"; Is longint:K8:6)
		$Lon_vOffset:=OB Get:C1224($Obj_param; "vOffset"; Is longint:K8:6)
		
		//find coordinates and dimensions
		FORM GET PROPERTIES:C674($Txt_form; $Lon_width; $Lon_height)
		OBJECT GET COORDINATES:C663(*; $Txt_caller; $Lon_left; $Lon_; $Lon_; $Lon_bottom)
		
		$Lon_top:=$Lon_bottom
		$Lon_right:=$Lon_left+$Lon_width+$Lon_hOffset
		$Lon_bottom:=$Lon_top+$Lon_height+$Lon_vOffset
		
		//move if necessary to remain in the container
		OBJECT GET SUBFORM CONTAINER SIZE:C1148($Lon_width; $Lon_height)
		
		If ($Lon_right>$Lon_width)  //shift left
			
			$Lon_offset:=$Lon_width-$Lon_right
			$Lon_left:=$Lon_left+$Lon_offset-$kLon_margin
			$Lon_right:=$Lon_right+$Lon_offset-$kLon_margin
			
		End if 
		
		If ($Lon_bottom>$Lon_height)  //shift up
			
			$Lon_offset:=$Lon_height-$Lon_bottom
			$Lon_top:=$Lon_top+$Lon_offset-$kLon_margin
			$Lon_bottom:=$Lon_bottom+$Lon_offset-$kLon_margin
			
		End if 
		
		
		//set the UI subform
		OBJECT SET SUBFORM:C1138(*; $kTxt_subform; $Txt_form)
		
		//positioning balloon
		OBJECT SET COORDINATES:C1248(*; $kTxt_subform; $Lon_left; $Lon_top; $Lon_right; $Lon_bottom)
		
		//positioning mask
		OBJECT GET COORDINATES:C663(*; Form:C1466.areaObject; $Lon_left; $Lon_top; $Lon_right; $Lon_bottom)
		OBJECT SET COORDINATES:C1248(*; "balloon.mask"; $Lon_left; $Lon_top; $Lon_right; $Lon_bottom)
		
		//making visible
		OBJECT SET VISIBLE:C603(*; "balloon.@"; True:C214)
		
		//give the focus to the subform to generate an On activate event
		GOTO OBJECT:C206(*; "balloon.subform")
		
		//set the balloon's flag
		OB SET:C1220(ob_area; \
			"balloon"; True:C214)
		
		//______________________________________________________
	: ($Txt_action="hide")
		
		//hide the UI
		OBJECT SET VISIBLE:C603(*; "balloon.@"; False:C215)
		
		//#ACI0095689
		OBJECT SET SUBFORM:C1138(*; $kTxt_subform; "BALLOON_EMPTY")
		
		If (OB Is defined:C1231($Obj_param; "postClick"))
			
			If (OB Get:C1224($Obj_param; "postClick"; Is boolean:K8:9))
				
				GET MOUSE:C468($Lon_mouseX; $Lon_mouseY; $Lon_; *)
				POST CLICK:C466($Lon_mouseX; $Lon_mouseY; *)
				
			End if 
		End if 
		
		//release the balloon's flag
		OB SET:C1220(ob_area; \
			"balloon"; False:C215)
		
		
		If (QR_is_valid_area(ob_area.area))
			
			var $digest : Text
			var $x : Blob
			
			QR REPORT TO BLOB:C770(ob_area.area; $x)
			
			$digest:=Generate digest:C1147($x; MD5 digest:K66:1)
			
			If (ob_area._digest#$digest)
				
				ob_area.modified:=True:C214
				
			End if 
			
		End if 
		
		
		
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Unknown entry point: \""+$Txt_action+"\"")
		
		//______________________________________________________
End case 

CLEAR VARIABLE:C89($Obj_param)

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End