//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : report_AREA_OBJECT_METHOD
// Database: 4D report
// ID[C928873A1E9D4DB78554B764D2A9C983]
// Created #20-3-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations


var \
$self : Pointer

var \
$help_tip_text; \
$my_name : Text

var \
$contextual_click; \
$mouse_down; \
$is_quickReport; \
$is_crossReport; \
$is_in_cell; \
$is_outside; \
$is_in_scroll_bar; \
$is_cell_editing; \
$is_in_header_column; \
$is_in_header_line; \
$is_in_top_left_header; \
$is_balloon_visible; \
$skip : Boolean

var \
$i; $size; $L; \
$area; \
$event_code; \
$mouse_x; \
$mouse_y; \
$mouse_button; \
$count_parameters; \
$left; $top; $right; $bottom; \
$my_left; $my_top; $my_right; $my_bottom; \
$my_row_number; $my_column_number; \
$new_position; $old_position; \
$left_position; $top_position; $right_position; $bottom_position; \
$column_number; $column_index; $column_position; \
$column_left; $column_right; \
$locked_columns; $locked_column_right; \
$header_height; \
$row_position; $row_index; \
$cell_top; $cell_bottom; \
$h_scroll_offset; $v_scroll_offset; \
$width; \
$report_type; \
$qr_destination; $qr_row; $qr_row_number; $qr_column; $qr_column_number : Integer

ARRAY BOOLEAN:C223($_visible; 0)
ARRAY POINTER:C280($_columnVarPointer; 0)
ARRAY POINTER:C280($_headerVarPointer; 0)
ARRAY POINTER:C280($_styles; 0)

ARRAY TEXT:C222($_column_names; 0)
ARRAY TEXT:C222($_header_names; 0)
ARRAY REAL:C219($_columns; 0)
ARRAY REAL:C219($_orders; 0)

// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=0; "Missing parameter"))
	
	$event_code:=Form event code:C388
	
	//mouse state
	MOUSE POSITION:C468($mouse_x; $mouse_y; $mouse_button)
	
	$contextual_click:=(($event_code=On Clicked:K2:4) | ($event_code=On Header Click:K2:40)) & (Contextual click:C713 | ($mouse_button=2))
	$mouse_down:=($mouse_button=1)
	
	//my
	$my_name:=OBJECT Get name:C1087(Object current:K67:2)
	$self:=OBJECT Get pointer:C1124(Object current:K67:2)
	
	//%W-518.7
	If (Not:C34(Undefined:C82(ob_area)))
		
		If (OB Is defined:C1231(ob_area))
			
			//QR properties
			$area:=OB Get:C1224(ob_area; "area"; Is longint:K8:6)
			$qr_column_number:=OB Get:C1224(ob_area; "qrColumnNumber"; Is longint:K8:6)
			$qr_row_number:=OB Get:C1224(ob_area; "qrRowNumber"; Is longint:K8:6)
			$qr_destination:=OB Get:C1224(ob_area; "destination"; Is longint:K8:6)
			
			$report_type:=OB Get:C1224(ob_area; "reportType"; Is longint:K8:6)
			$is_crossReport:=($report_type=qr cross report:K14902:2)
			
			$is_cell_editing:=OB Get:C1224(ob_area; "cellEdition"; Is boolean:K8:9)  //true if a cell is being edited
			
			$skip:=OB Get:C1224(ob_area; "stop"; Is boolean:K8:9)\
				 | OB Get:C1224(ob_area; "message"; Is boolean:K8:9)  //true if an additional panel is opened or if message is displayed
			
			$is_quickReport:=OB Get:C1224(ob_area; "4d-dialog"; Is boolean:K8:9)  //true if Quick Report
			
			$header_height:=Choose:C955($is_crossReport; 0; Form:C1466.headerHeight)
			
		End if 
	End if 
	//%W+518.7
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
If (Not:C34($skip)\
 & Not:C34($is_cell_editing))
	
	//listbox specifications
	OBJECT GET COORDINATES:C663(*; $my_name; $my_left; $my_top; $my_right; $my_bottom)
	LISTBOX GET ARRAYS:C832(*; $my_name; $_column_names; $_header_names; $_columnVarPointer; $_headerVarPointer; $_visible; $_styles)
	
	$v_scroll_offset:=LISTBOX Get property:C917(*; $my_name; lk ver scrollbar width:K53:9)*LISTBOX Get property:C917(*; $my_name; _o_lk display ver scrollbar:K53:8)
	$h_scroll_offset:=LISTBOX Get property:C917(*; $my_name; lk hor scrollbar height:K53:7)*LISTBOX Get property:C917(*; $my_name; _o_lk display hor scrollbar:K53:6)
	
	//column & row numbers
	$my_row_number:=LISTBOX Get number of rows:C915(*; $my_name)
	$my_column_number:=Size of array:C274($_column_names)
	
	//limit of the locked columns
	$locked_columns:=LISTBOX Get locked columns:C1152(*; $my_name)
	OBJECT GET COORDINATES:C663(*; $_column_names{$locked_columns}; $L; $L; $locked_column_right; $L)
	
	// #7-9-2015
	//convert coordinates from global (window) to local (subform)
	CONVERT COORDINATES:C1365($mouse_x; $mouse_y; XY Current window:K27:6; XY Current form:K27:5)
	
	If ($is_quickReport)
		
		//no longer necessary with CONVERT COORDINATES
		//$Lon_y:=$Lon_y-OB Get(ob_area;"top-offset";Is longint)
		
		OB SET:C1220(ob_dialog; \
			"action"; "hide_plus")
		
	End if 
	
	//balloon is it opened ?
	$is_balloon_visible:=OBJECT Get visible:C1075(*; "balloon.subform")
	OBJECT SET VISIBLE:C603(*; "header_action"; $is_balloon_visible)  //force display if any
	
	//out of the area ?
	OBJECT GET COORDINATES:C663(*; "filler"; $left; $L; $L; $L)
	LISTBOX GET CELL COORDINATES:C1330(*; $my_name; 1; $my_row_number; $L; $L; $L; $bottom)
	$is_outside:=($mouse_y>$bottom) | ($mouse_x>$left)
	
	If ($is_outside)  //outside the area
		
		$column_index:=-1
		$row_index:=-1
		
		$is_in_scroll_bar:=(($mouse_y>=($my_bottom-$h_scroll_offset))\
			 & ($mouse_y<=$my_bottom)) | (($mouse_x>=($my_right-$v_scroll_offset))\
			 & ($mouse_x<=$my_right))
		
	Else 
		
		If ($mouse_x<($my_right-$v_scroll_offset))\
			 & ($mouse_x>$my_left)\
			 & ($mouse_y<($my_bottom-$h_scroll_offset))\
			 & ($mouse_y>$my_top)
			
			$row_index:=-1
			
			//get the row index of the listbox
			If ($mouse_y>($header_height+$my_top))
				
				For ($i; 1; $my_row_number; 1)
					
					LISTBOX GET CELL COORDINATES:C1330(*; $my_name; 1; $i; $L; $cell_top; $L; $cell_bottom)
					
					If ($mouse_y>=$cell_top)\
						 & ($mouse_y<=$cell_bottom)
						
						$row_index:=$i
						$i:=MAXLONG:K35:2-1
						
					End if 
				End for 
			End if 
			
			$column_index:=-1
			
			//get the column index of the listbox
			For ($i; 1; Size of array:C274($_column_names)-2; 1)
				
				OBJECT GET COORDINATES:C663(*; $_column_names{$i}; $column_left; $L; $column_right; $L)
				
				If ($mouse_x>$column_left)\
					 & ($mouse_x<=$column_right)
					
					$column_index:=$i
					$i:=MAXLONG:K35:2-1
					
				End if 
			End for 
			
			$row_index:=Choose:C955($column_index=-1; -1; $row_index)
			
		End if 
	End if 
	
	If ($area#0)
		
		//Get QR column & row
		If ($is_crossReport)
			
			$qr_row:=$row_index
			
			Case of 
					
					//…………………………………………………………………
				: ($column_index=2)\
					 & ($row_index=1)
					
					$qr_column:=1
					
					//…………………………………………………………………
				: ($column_index=1)\
					 & ($row_index=2)
					
					$qr_column:=2
					
					//…………………………………………………………………
				: ($column_index=2)\
					 & ($row_index=2)
					
					$qr_column:=3
					
					//…………………………………………………………………
				Else 
					
					$qr_column:=0
					
					//…………………………………………………………………
			End case 
			
		Else 
			
			$qr_column:=Choose:C955($column_index>0; $column_index-1; 0)
			
			$qr_row:=Choose:C955($row_index<=0; 0; \
				Choose:C955($row_index=1; qr title:K14906:1; \
				Choose:C955($row_index=2; qr detail:K14906:2; \
				Choose:C955($row_index=$qr_row_number; qr grand total:K14906:3; \
				Choose:C955($row_index<=$qr_row_number; $row_index-2; 0)))))
			
		End if 
	End if 
	
	If ($is_crossReport)
		
		$is_in_top_left_header:=($column_index=1) & ($row_index=1)
		$is_in_header_line:=($column_index=1) & ($row_index<=$my_row_number) & ($row_index>0)
		$is_in_header_column:=($row_index=1) & ($column_index>1) & ($column_index<=($qr_column_number+1))
		$is_in_cell:=($column_index>0) & ($row_index>0)
		
	Else 
		
		$is_in_top_left_header:=($column_index=$locked_columns) & ($row_index=-1)
		$is_in_header_line:=($column_index=$locked_columns) & ($row_index<=$my_row_number) & ($row_index>0)
		$is_in_header_column:=($row_index=-1) & ($column_index>$locked_columns) & ($column_index<=($qr_column_number+1))
		$is_in_cell:=($column_index>$locked_columns) & ($row_index>0)
		
	End if 
	
	
	
	Case of 
			
			//______________________________________________________
		: ($area=0)
			
			//______________________________________________________
		: ($event_code=On Mouse Enter:K2:33)
			
			
			
			ob_area.tipsDelay:=Get database parameter:C643(Tips delay:K37:80)
			SET DATABASE PARAMETER:C642(Tips delay:K37:80; 0)
			
			
			//______________________________________________________
		: ($event_code=On Mouse Leave:K2:34)
			
			
			
			SET DATABASE PARAMETER:C642(Tips delay:K37:80; Num:C11(ob_area.tipsDelay))
			
			
			
			//______________________________________________________
		: ($event_code=On Header Click:K2:40)
			
			Case of 
					
					//………………………………………………………………………………
				: ($is_crossReport)
					
					//NOTHING MORE TO DO
					
					//………………………………………………………………………………
				: ($contextual_click)
					
					OB SET:C1220(ob_dialog; \
						"action"; "header_context_menu")
					
					//………………………………………………………………………………
				: ($is_in_header_column)
					
					//select the column
					QR SET SELECTION:C794($area; $qr_column; 0; $qr_column; 0)
					report_SELECTION("select_column"; $column_index)
					
					If (Clickcount:C1332=2)  //double click => Edit formula
						
						report_EDIT_COLUMN_FORMULA($area; $qr_column)
						
					End if 
					
					//………………………………………………………………………………
				: ($is_in_top_left_header)
					
					//select the area
					QR SET SELECTION:C794($area; 0; 0)
					report_SELECTION("select_all")
					
					//………………………………………………………………………………
				Else 
					
					//unselect all
					QR SET SELECTION:C794($area; -1; -1; -1; -1)
					report_SELECTION("select_none")
					
					//………………………………………………………………………………
			End case 
			
			//______________________________________________________
		: ($event_code=On Losing Focus:K2:8)
			
			OB SET:C1220(ob_dialog; \
				"action"; "update")
			
			//______________________________________________________
		: ($event_code=On Double Clicked:K2:5)
			
			If ($is_in_cell)
				
				If ($is_crossReport\
					 & (($column_index<3) & ($row_index<3)))
					
					If ($column_index=1)\
						 & ($row_index=1)
						
						//NOTHING MORE TO DO
						
					Else 
						
						report_EDIT_COLUMN_FORMULA($area; $qr_column)
						
					End if 
					
				Else 
					
					If (Not:C34($is_crossReport))\
						 | ($is_crossReport & (($column_index<3)\
						 | ($row_index#3)))
						
						If ($is_crossReport)
							
							//work with column index
							$self->{$row_index}:=QR_Get_cell_text($area; $column_index; $row_index)
							
						Else 
							
							$self->{$row_index}:=QR_Get_cell_text($area; $qr_column; $qr_row)
							
						End if 
						
						//make column enterable
						OBJECT SET ENTERABLE:C238($self->; True:C214)
						
						//restore black color for text if any
						//%W-533.3
						LISTBOX SET ROW COLOR:C1270($self->{$self->}; $row_index; Foreground color:K23:1; lk font color:K53:24)
						//%W+533.3
						
						//set the edit flag
						OB SET:C1220(ob_area; \
							"cellEdition"; True:C214)
						
						$is_cell_editing:=True:C214
						
						If ($row_index>2) | $is_crossReport
							
							//display action button
							LISTBOX GET CELL COORDINATES:C1330(*; $my_name; $column_index; $row_index; $left; $top; $right; $bottom)
							
							$top:=$top-16
							$right:=$left+23
							$bottom:=$top+16
							
							OBJECT SET COORDINATES:C1248(*; "cell_menu"; $left; $top; $right; $bottom)
							
							If (Not:C34($is_crossReport))
								
								OBJECT SET VISIBLE:C603(*; "cell_menu"; True:C214)
								
							Else 
								
								If ($column_index>1)\
									 & ($row_index>1)
									
									OBJECT SET VISIBLE:C603(*; "cell_menu"; True:C214)
									
								End if 
							End if 
						End if 
						
						EDIT ITEM:C870($self->)
						
					End if 
				End if 
			End if 
			
			//______________________________________________________
		: ($event_code=On Clicked:K2:4)
			
			Case of 
					
					//…………………………………………………
				: ($is_in_scroll_bar)
					
					//…………………………………………………
				: ($is_cell_editing)
					
					//!!!! On clicked isn't generated during editing a cell !!!!
					
					//…………………………………………………
				: ($is_in_header_line)
					
					If ($contextual_click)
						
						If ($is_crossReport)
							
							OB SET:C1220(ob_dialog; \
								"action"; "cell_context_menu")
							
						Else 
							
							OB SET:C1220(ob_dialog; \
								"action"; "line_context_menu")
							
						End if 
						
					Else 
						
						If ($is_crossReport)
							
							If ($column_index=1)\
								 & ($row_index=1)
								
								QR SET SELECTION:C794($area; 0; 0; 0; 0)
								report_SELECTION("select_all")
								
							Else 
								
								QR SET SELECTION:C794($area; $column_index; $row_index; $column_index; $row_index)
								report_SELECTION("select_cell"; $column_index; $row_index)
								
							End if 
							
						Else 
							
							//select line
							QR SET SELECTION:C794($area; 0; $row_index; 0; $row_index)
							report_SELECTION("select_line"; $row_index)
							
						End if 
					End if 
					
					//…………………………………………………
				: ($is_in_cell)
					
					If ($contextual_click)
						
						If ($is_crossReport)\
							 & ($column_index=3)\
							 & ($row_index=3)
							
							//NOTHING MORE TO DO
							
						Else 
							
							OB SET:C1220(ob_dialog; \
								"action"; "cell_context_menu")
							
						End if 
						
					Else 
						
						If ($is_crossReport)\
							 & ($column_index=3)\
							 & ($row_index=3)
							
							//deselect
							QR SET SELECTION:C794($area; -1; -1; -1; -1)
							report_SELECTION("select_none")
							
						Else 
							
							//select cell
							QR SET SELECTION:C794($area; $column_index-$locked_columns; $row_index; $column_index-$locked_columns; $row_index)
							report_SELECTION("select_cell"; $column_index; $row_index)
							
						End if 
					End if 
					
					//…………………………………………………
				: ($is_outside)
					
					If ($contextual_click)
						
						If (Not:C34($is_crossReport))
							
							OB SET:C1220(ob_dialog; \
								"action"; "area_context_menu")
							
						End if 
						
					Else 
						
						//deselect
						QR SET SELECTION:C794($area; -1; -1; -1; -1)
						report_SELECTION("select_none")
						
					End if 
					
					//…………………………………………………
				Else 
					
					//deselect
					QR SET SELECTION:C794($area; -1; -1; -1; -1)
					report_SELECTION("select_none")
					
					//…………………………………………………
			End case 
			
			//______________________________________________________
			//#ACI0097243
			//: ($Lon_formEvent=On Column Moved)
		: ($event_code=On Column Moved:K2:30)\
			 & (Not:C34($is_balloon_visible))
			
			//Get the previous position and the new position of the column moved in the list box
			LISTBOX MOVED COLUMN NUMBER:C844(*; $my_name; $old_position; $new_position)
			
			
			If ($new_position#$old_position)
				
				//#ACI0095333 [
				//first restore the listbox column position !!!
				
				If ($is_quickReport)  // ACI0100359{ not for the report area only for the QR as it will be re-adjusted after. 
					LISTBOX MOVE COLUMN:C1274(*; $_column_names{$new_position}; $old_position)
				End if 
				//]
				
				
				//Is it an authorized moving?
				If ((($new_position-1)<=$qr_column_number) & (($old_position-1)<=$qr_column_number))
					
					
					// #21-8-2014 - use the new command QR MOVE COLUMN
					//QR_SWAP_COLUMNS($Lon_area; $Lon_oldPosition-1; $Lon_newPosition-1)
					
					//mark: QR MOVE COLUMN also move the sort order
					QR MOVE COLUMN:C1325($area; $old_position-1; $new_position-1)
					QR SET SELECTION:C794($area; $new_position-1; 0; $new_position-1; 0)
					
					
					
				Else 
					
					//#ACI0095333 [
					//LISTBOX MOVE COLUMN(*;$tTxt_columnNames{$Lon_newPosition};$Lon_qrColumnNumber+1)
					//]
					// move in last position
					LISTBOX MOVE COLUMN:C1274(*; $_column_names{$new_position}; $old_position)
					
					If (ob_area.qrColumn<0)  // if no column no movement
						
						QR MOVE COLUMN:C1325($area; $old_position-1; $qr_column_number-1)
						
					End if 
					
				End if 
			End if 
			
			OB SET:C1220(ob_dialog; \
				"action"; "update")
			
			//______________________________________________________
			
		: ($is_cell_editing)
			
			//do nothing until editing is complete
			
			//______________________________________________________
		: ($mouse_down) & False:C215
			
			//do nothing until the mouse button is down
			
			//______________________________________________________
		: ($is_outside)
			
			
			OBJECT SET HELP TIP:C1181(*; $my_name; $help_tip_text)
			
			//______________________________________________________
		: ($event_code=On Mouse Move:K2:35)
			
			//get target coordinates
			
			
			Case of 
					
					//----------------------------------------
				: (OB Get:C1224(ob_area; "on-drop"; Is boolean:K8:9))
					
					//BEEP
					
					//…………………………………………………
				: ($is_in_top_left_header)
					
					If ($is_crossReport)
						
						LISTBOX GET CELL COORDINATES:C1330(*; $my_name; 1; $row_index; $left; $top; $right; $bottom)
						
					Else 
						
						OBJECT GET COORDINATES:C663(*; $_header_names{1}; $left; $top; $right; $bottom)
						
					End if 
					
					//…………………………………………………
				: ($is_in_header_line)
					
					LISTBOX GET CELL COORDINATES:C1330(*; $my_name; 1; $row_index; $left; $top; $right; $bottom)
					
					
					
					If (ob_area.sortNumber>0)  // The report is sorted
						
						QR GET SORTS:C753(ob_area.area; $_columns; $_orders)
						
						// Reorder the array
						$size:=Size of array:C274($_orders)
						ARRAY INTEGER:C220($aColumnsReordered; $size)
						ARRAY INTEGER:C220($aOrdersReordered; $size)
						
						For ($i; 1; $size; 1)
							
							$aColumnsReordered{($size-$i)+1}:=$_columns{$i}
							$aOrdersReordered{($size-$i)+1}:=$_orders{$i}
							
						End for 
						
						If ((ob_area.rowIndex>2)\
							 & (ob_area.rowIndex<(3+ob_area.sortNumber)))  // In a subtotal row header
							
							//%W-533.3
							$help_tip_text:=Localized string:C991(Choose:C955($aOrdersReordered{(ob_area.rowIndex-2)}=1; "ascendingSortOrder"; "descendingSortOrder"))
							//%W+533.3
							
						End if 
					End if 
					
					
					//…………………………………………………
				: ($is_in_header_column)
					
					If ($is_crossReport)
						
						LISTBOX GET CELL COORDINATES:C1330(*; $my_name; $column_index; 1; $left; $top; $right; $bottom)
						
					Else 
						
						OBJECT GET COORDINATES:C663(*; $_header_names{$column_index}; $left; $top; $right; $bottom)
						
					End if 
					
					
					//…………………………………………………
				: ($is_in_cell)
					
					LISTBOX GET CELL COORDINATES:C1330(*; $my_name; $column_index; $row_index; $left; $top; $right; $bottom)
					
					//…………………………………………………
				Else 
					
					//ASSERT(False)
					
					//…………………………………………………
			End case 
			
			OBJECT SET HELP TIP:C1181(*; $my_name; $help_tip_text)
			
			
			//crop if any
			$left:=Choose:C955(($left<$locked_column_right) & ($column_index>1); $locked_column_right; $left)
			$top:=Choose:C955(($top<($header_height+$my_top)) & ($row_index>0); $header_height+$my_top; $top)
			$right:=Choose:C955($right>($my_right-$v_scroll_offset); $my_right-$v_scroll_offset; $right)
			$bottom:=Choose:C955($bottom>($my_bottom-$h_scroll_offset); $my_bottom-$h_scroll_offset; $bottom)
			
			Case of 
					
					//………………………………………………………………………………………………………………
				: (Not:C34($is_quickReport))
					
					//NOTHING MORE TO DO
					
					//………………………………………………………………………………………………………………
				: ($is_balloon_visible)
					
					//NOTHING MORE TO DO
					
					//………………………………………………………………………………………………………………
				: ($is_in_top_left_header)
					
					Case of 
							
							//-----------------------------------
						: ($is_crossReport)
							
							$left_position:=$right-Form:C1466.headerButtonWidth
							$top_position:=$top+Form:C1466.headerButtonOffset
							$right_position:=$left_position+Form:C1466.headerButtonWidth
							$bottom_position:=$top_position+Form:C1466.headerButtonWidth
							
							OBJECT SET COORDINATES:C1248(*; "header_action"; $left_position; $top_position; $right_position; $bottom_position)
							OBJECT SET VISIBLE:C603(*; "header_action"; True:C214)
							
							//-----------------------------------
						: ($mouse_x>=($right-Form:C1466.addSensitive))  //into the right separator sensitive area
							
							If (LISTBOX Get property:C917(*; $my_name; _o_lk hor scrollbar position:K53:10)=0)
								
								OB SET:C1220(ob_dialog; \
									"action"; "show_plus"; \
									"middle"; $right)
								
							End if 
							
							//-----------------------------------
						: (($right-$left)>(Form:C1466.headerButtonWidth+(Form:C1466.headerButtonOffset*2)))
							
							//don't display arrow when the QR is empty
							If ($qr_column_number>0)
								
								$left_position:=$right-Form:C1466.headerButtonWidth
								$top_position:=$top+Form:C1466.headerButtonOffset
								$right_position:=$left_position+Form:C1466.headerButtonWidth
								$bottom_position:=$top_position+Form:C1466.headerButtonWidth
								
								OBJECT SET COORDINATES:C1248(*; "header_action"; $left_position; $top_position; $right_position; $bottom_position)
								OBJECT SET VISIBLE:C603(*; "header_action"; True:C214)
								
							End if 
							
							//-------------------------------------
					End case 
					
					//………………………………………………………………………………………………………………
				: ($is_in_header_column)
					
					If ($qr_column<=$qr_column_number)
						
						Case of 
								
								//-----------------------------------
							: ($is_crossReport)
								
								$left_position:=$right-Form:C1466.headerButtonWidth
								$top_position:=$top+Form:C1466.headerButtonOffset
								$right_position:=$left_position+Form:C1466.headerButtonWidth
								$bottom_position:=$top_position+Form:C1466.headerButtonWidth
								
								OBJECT SET COORDINATES:C1248(*; "header_action"; $left_position; $top_position; $right_position; $bottom_position)
								OBJECT SET VISIBLE:C603(*; "header_action"; True:C214)
								
								//-----------------------------------
							: ($mouse_x>=($right-Form:C1466.addSensitive))  //into the right separator sensitive area
								
								OBJECT SET VISIBLE:C603(*; "header_action"; False:C215)
								
								OB SET:C1220(ob_dialog; \
									"action"; "show_plus"; \
									"middle"; $right)
								
								//-----------------------------------
							: ($mouse_x<=($left+Form:C1466.addSensitive))  //into the left separator sensitive area
								
								OBJECT SET VISIBLE:C603(*; "header_action"; False:C215)
								
								OB SET:C1220(ob_dialog; \
									"action"; "show_plus"; \
									"middle"; $left)
								
								//-----------------------------------
							Else 
								
								If (($right-$left)>(Form:C1466.headerButtonWidth+(Form:C1466.headerButtonOffset*2)))
									
									$left_position:=$right-Form:C1466.headerButtonWidth
									$top_position:=$top+Form:C1466.headerButtonOffset
									$right_position:=$left_position+Form:C1466.headerButtonWidth
									$bottom_position:=$top_position+Form:C1466.headerButtonWidth
									
									OBJECT SET COORDINATES:C1248(*; "header_action"; $left_position; $top_position; $right_position; $bottom_position)
									OBJECT SET VISIBLE:C603(*; "header_action"; True:C214)
									
								End if 
								
								//-------------------------------------
						End case 
					End if 
					
					//………………………………………………………………………………………………………………
				: ($is_in_header_line)
					
					If ($mouse_x>=($right-Form:C1466.addSensitive))  //into the right separator sensitive area
						
						OBJECT SET VISIBLE:C603(*; "header_action"; False:C215)
						
						OB SET:C1220(ob_dialog; \
							"action"; "show_plus"; \
							"middle"; $right)
						
					Else 
						
						If (($right-$left)>(Form:C1466.headerButtonWidth+(Form:C1466.headerButtonOffset*2)))
							
							//don't display arrow when the QR is empty
							If ($qr_column_number>0)
								
								$left_position:=$right-Form:C1466.headerButtonWidth
								$top_position:=$top+Form:C1466.headerButtonOffset
								$right_position:=$left_position+Form:C1466.headerButtonWidth
								$bottom_position:=$top_position+Form:C1466.headerButtonWidth
								
								OBJECT SET COORDINATES:C1248(*; "header_action"; $left_position; $top_position; $right_position; $bottom_position)
								OBJECT SET VISIBLE:C603(*; "header_action"; True:C214)
								
							End if 
						End if 
					End if 
					
					//………………………………………………………………………………………………………………
				: ($is_in_cell)
					
					Case of 
							
							//-----------------------------------
						: ($is_crossReport)
							
							$left_position:=$right-Form:C1466.headerButtonWidth
							$top_position:=$top+Form:C1466.headerButtonOffset
							$right_position:=$left_position+Form:C1466.headerButtonWidth
							$bottom_position:=$top_position+Form:C1466.headerButtonWidth
							
							OBJECT SET COORDINATES:C1248(*; "header_action"; $left_position; $top_position; $right_position; $bottom_position)
							OBJECT SET VISIBLE:C603(*; "header_action"; True:C214)
							
							//-----------------------------------
						: ($qr_column>$qr_column_number)
							
							//NOTHING MORE TO DO
							
							//-----------------------------------
						: ($mouse_x>=($right-Form:C1466.addSensitive))  //into the right separator sensitive area
							
							OB SET:C1220(ob_dialog; \
								"action"; "show_plus"; \
								"middle"; $right)
							
							//-----------------------------------
						: ($mouse_x<=($left+Form:C1466.addSensitive))  //into the left separator sensitive area
							
							OB SET:C1220(ob_dialog; \
								"action"; "show_plus"; \
								"middle"; $left)
							
							//-----------------------------------
						Else 
							
							If (($right-$left)>(Form:C1466.headerButtonWidth+(Form:C1466.headerButtonOffset*2)))
								
								$left_position:=$right-Form:C1466.headerButtonWidth
								$top_position:=$top+Form:C1466.headerButtonOffset
								$right_position:=$left_position+Form:C1466.headerButtonWidth
								$bottom_position:=$top_position+Form:C1466.headerButtonWidth
								
								OBJECT SET COORDINATES:C1248(*; "header_action"; $left_position; $top_position; $right_position; $bottom_position)
								OBJECT SET VISIBLE:C603(*; "header_action"; True:C214)
								
							End if 
							
							//-------------------------------------
					End case 
					
					//----------------------------------------
				Else 
					
					//BEEP
					
					//………………………………………………………………………………………………………………
			End case 
			
			//______________________________________________________
		: ($event_code=On Row Moved:K2:32)
			
			If ($is_crossReport)
				
				//restore
				If ($is_quickReport)
					
					OB SET:C1220(ob_dialog; \
						"action"; "update")
					
				Else 
					
					report_DISPLAY_AREA($area)
					
				End if 
				
			Else 
				
				//Get the previous position and the new position of the row moved
				LISTBOX MOVED ROW NUMBER:C837(*; $my_name; $old_position; $new_position)
				
				If ($new_position#$old_position)
					
					//Only the break's lines can be moved
					If ($old_position>2)\
						 & ($old_position<$my_row_number)\
						 & ($new_position>2)\
						 & ($new_position<$my_row_number)
						
						QR_SWAP_ROWS($area; $old_position; $new_position)
						
					Else 
						
						//restore
						OB SET:C1220(ob_dialog; \
							"action"; "update")
						
					End if 
				End if 
			End if 
			
			//______________________________________________________
		: ($event_code=On Column Resize:K2:31)
			
			If ($is_crossReport)
				
				If ($column_index>0)
					
					//deselect
					QR SET SELECTION:C794($area; -1; -1; -1; -1)
					report_SELECTION("select_none")
					
					$width:=LISTBOX Get column width:C834(*; $_column_names{$column_index})
					QR_SET_COLUMN_WIDTH($area; $column_index; $width)
					
				End if 
				
			Else 
				
				$column_number:=Find in array:C230($_columnVarPointer; $self)
				
				If ($column_number>1)\
					 & ($column_number<=($qr_column_number+1))
					
					$width:=LISTBOX Get column width:C834(*; $_column_names{$column_number})
					
					QR_SET_COLUMN_WIDTH($area; $column_number-1; $width)
					
				End if 
			End if 
			
			If ($mouse_button=0)  //Button up
				
				OB SET:C1220(ob_dialog; \
					"action"; "update")
				
			End if 
			
			//________________________________________
	End case 
	
	
	
	If ($area#0)
		
		Case of 
				
				//______________________________________________________
			: ($is_balloon_visible)
				
				//NOTHING MORE TO DO
				
				//______________________________________________________
			: ($is_cell_editing)
				
				OB SET:C1220(ob_area; \
					"columnIndex"; $column_index; \
					"rowIndex"; $row_index; \
					"qrColumn"; $qr_column; \
					"qrRow"; $qr_row)
				
				//______________________________________________________
			Else 
				
				area_ADJUST
				
				If ($qr_destination=qr printer:K14903:1)\
					 & Not:C34($is_crossReport)
					
					//move page break if any
					OBJECT GET COORDINATES:C663(*; $_column_names{$locked_columns+1}; $left; $L; $L; $L)
					$left:=($locked_column_right+OB Get:C1224(ob_area; "pageBreak"; Is longint:K8:6))-($locked_column_right-$left)
					OBJECT GET COORDINATES:C663(*; "page.break"; $L; $top; $L; $bottom)
					OBJECT SET COORDINATES:C1248(*; "page.break"; $left; $top; $left; $bottom)
					OBJECT SET VISIBLE:C603(*; "page.break"; $left>$locked_column_right)
					
				End if 
				
				//keep the position of the scroll bars
				OBJECT GET SCROLL POSITION:C1114(*; $my_name; $row_position; $column_position)
				
				OB SET:C1220(ob_area; \
					"columnIndex"; $column_index; \
					"rowIndex"; $row_index; \
					"qrColumn"; $qr_column; \
					"qrRow"; $qr_row; \
					"inTopLeftHeader"; $is_in_top_left_header; \
					"inHeaderColumn"; $is_in_header_column; \
					"inHeaderLine"; $is_in_header_line; \
					"inCell"; $is_in_cell; \
					"scrollRow"; $row_position; \
					"scrollColumn"; $column_position; \
					"crossReport"; $is_crossReport)
				
				//______________________________________________________
		End case 
		
		If ($is_quickReport)
			
			If (Not:C34($is_cell_editing))
				
				CALL SUBFORM CONTAINER:C1086(-1)
				
			End if 
			
		Else 
			
			If ($contextual_click)\
				 & ($area#0)
				
				If (QR Get area property:C795($area; qr view contextual menus:K14905:7)#0)
					
					If ($is_crossReport)
						
						If ($column_index=3)\
							 & ($row_index=3)
							
						Else 
							
							report_CONTEXTUAL_MENUS($area; $column_index; $row_index)
							
						End if 
						
					Else 
						
						report_CONTEXTUAL_MENUS($area; $qr_column; $qr_row)
						
					End if 
				End if 
			End if 
		End if 
	End if 
End if 

// ----------------------------------------------------
// End