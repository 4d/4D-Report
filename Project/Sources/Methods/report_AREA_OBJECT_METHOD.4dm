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
C_BOOLEAN:C305($Boo_balloon; $Boo_cellEditing; $Boo_contextual; $Boo_crossReport; $Boo_inCell; $Boo_inHeaderColumn)
C_BOOLEAN:C305($Boo_inHeaderLine; $Boo_inScroolbar; $Boo_inTopLeftHeader; $Boo_mouseDown; $Boo_outside; $Boo_quickReport)
C_BOOLEAN:C305($Boo_skip)
C_LONGINT:C283($headerHeight; $Lon_; $Lon_area)
C_LONGINT:C283($Lon_bottom; $Lon_cellBottom; $Lon_cellTop; $Lon_colIndex; $Lon_column; $Lon_columnLeft)
C_LONGINT:C283($Lon_columnPosition; $Lon_columnRight; $Lon_formEvent; $Lon_hScrollOffset; $Lon_i; $Lon_left)
C_LONGINT:C283($Lon_lockedColumns; $Lon_lockedRight; $Lon_meBottom; $Lon_meColumnNumber; $Lon_meLeft; $Lon_meRight)
C_LONGINT:C283($Lon_meRowNumber; $Lon_meTop; $Lon_mouseButton; $Lon_newPosition; $Lon_oldPosition; $Lon_parameters)
C_LONGINT:C283($Lon_posBottom; $Lon_posLeft; $Lon_posRight; $Lon_posTop; $Lon_qrColumn; $Lon_qrColumnNumber)
C_LONGINT:C283($Lon_qrDestination; $Lon_qrRow; $Lon_qrRowNumber; $Lon_reportType; $Lon_right; $Lon_rowIndex)
C_LONGINT:C283($Lon_rowPosition; $Lon_sz; $Lon_top; $Lon_vScrollOffset; $Lon_width; $Lon_x)
C_LONGINT:C283($Lon_y)
C_POINTER:C301($Ptr_me)
C_TEXT:C284($Txt_helpTip; $Txt_me)

ARRAY BOOLEAN:C223($tBoo_visible; 0)
ARRAY POINTER:C280($tPtr_columnVars; 0)
ARRAY POINTER:C280($tPtr_headerVars; 0)
ARRAY POINTER:C280($tPtr_styles; 0)
ARRAY REAL:C219($aColumns; 0)
ARRAY REAL:C219($aOrders; 0)
ARRAY TEXT:C222($tTxt_columnNames; 0)
ARRAY TEXT:C222($tTxt_headerNames; 0)

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259



If (Asserted:C1132($Lon_parameters>=0; "Missing parameter"))
	
	$Lon_formEvent:=Form event code:C388
	
	//mouse state
	GET MOUSE:C468($Lon_x; $Lon_y; $Lon_mouseButton)
	
	$Boo_contextual:=(($Lon_formEvent=On Clicked:K2:4) | ($Lon_formEvent=On Header Click:K2:40)) & (Contextual click:C713 | ($Lon_mouseButton=2))
	$Boo_mouseDown:=($Lon_mouseButton=1)
	
	//me
	$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)
	$Ptr_me:=OBJECT Get pointer:C1124(Object current:K67:2)
	
	//%W-518.7
	If (Not:C34(Undefined:C82(ob_area)))
		
		If (OB Is defined:C1231(ob_area))
			
			//QR properties
			$Lon_area:=OB Get:C1224(ob_area; "area"; Is longint:K8:6)
			$Lon_qrColumnNumber:=OB Get:C1224(ob_area; "qrColumnNumber"; Is longint:K8:6)
			$Lon_qrRowNumber:=OB Get:C1224(ob_area; "qrRowNumber"; Is longint:K8:6)
			$Lon_qrDestination:=OB Get:C1224(ob_area; "destination"; Is longint:K8:6)
			
			$Lon_reportType:=OB Get:C1224(ob_area; "reportType"; Is longint:K8:6)
			$Boo_crossReport:=($Lon_reportType=qr cross report:K14902:2)
			
			$Boo_cellEditing:=OB Get:C1224(ob_area; "cellEdition"; Is boolean:K8:9)  //true if a cell is being edited
			
			$Boo_skip:=OB Get:C1224(ob_area; "stop"; Is boolean:K8:9)\
				 | OB Get:C1224(ob_area; "message"; Is boolean:K8:9)  //true if an additional panel is opened or if message is displayed
			
			$Boo_quickReport:=OB Get:C1224(ob_area; "4d-dialog"; Is boolean:K8:9)  //true if Quick Report
			
			$headerHeight:=Choose:C955($Boo_crossReport; 0; Form:C1466.headerHeight)
			
		End if 
	End if 
	//%W+518.7
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
If (Not:C34($Boo_skip)\
 & Not:C34($Boo_cellEditing))
	
	//listbox specifications
	OBJECT GET COORDINATES:C663(*; $Txt_me; $Lon_meLeft; $Lon_meTop; $Lon_meRight; $Lon_meBottom)
	LISTBOX GET ARRAYS:C832(*; $Txt_me; $tTxt_columnNames; $tTxt_headerNames; $tPtr_columnVars; $tPtr_headerVars; $tBoo_visible; $tPtr_styles)
	
	$Lon_vScrollOffset:=LISTBOX Get property:C917(*; $Txt_me; lk ver scrollbar width:K53:9)*LISTBOX Get property:C917(*; $Txt_me; _o_lk display ver scrollbar:K53:8)
	$Lon_hScrollOffset:=LISTBOX Get property:C917(*; $Txt_me; lk hor scrollbar height:K53:7)*LISTBOX Get property:C917(*; $Txt_me; _o_lk display hor scrollbar:K53:6)
	
	//column & row numbers
	$Lon_meRowNumber:=LISTBOX Get number of rows:C915(*; $Txt_me)
	$Lon_meColumnNumber:=Size of array:C274($tTxt_columnNames)
	
	//limit of the locked columns
	$Lon_lockedColumns:=LISTBOX Get locked columns:C1152(*; $Txt_me)
	OBJECT GET COORDINATES:C663(*; $tTxt_columnNames{$Lon_lockedColumns}; $Lon_; $Lon_; $Lon_lockedRight; $Lon_)
	
	// #7-9-2015
	//convert coordinates from global (window) to local (subform)
	CONVERT COORDINATES:C1365($Lon_x; $Lon_y; XY Current window:K27:6; XY Current form:K27:5)
	
	If ($Boo_quickReport)
		
		//no longer necessary with CONVERT COORDINATES
		//$Lon_y:=$Lon_y-OB Get(ob_area;"top-offset";Is longint)
		
		OB SET:C1220(ob_dialog; \
			"action"; "hide_plus")
		
	End if 
	
	//balloon is it opened ?
	$Boo_balloon:=OBJECT Get visible:C1075(*; "balloon.subform")
	OBJECT SET VISIBLE:C603(*; "header_action"; $Boo_balloon)  //force display if any
	
	//out of the area ?
	OBJECT GET COORDINATES:C663(*; "filler"; $Lon_left; $Lon_; $Lon_; $Lon_)
	LISTBOX GET CELL COORDINATES:C1330(*; $Txt_me; 1; $Lon_meRowNumber; $Lon_; $Lon_; $Lon_; $Lon_bottom)
	$Boo_outside:=($Lon_y>$Lon_bottom) | ($Lon_x>$Lon_left)
	
	If ($Boo_outside)  //outside the area
		
		$Lon_colIndex:=-1
		$Lon_rowIndex:=-1
		
		$Boo_inScroolbar:=(($Lon_y>=($Lon_meBottom-$Lon_hScrollOffset))\
			 & ($Lon_y<=$Lon_meBottom)) | (($Lon_x>=($Lon_meRight-$Lon_vScrollOffset))\
			 & ($Lon_x<=$Lon_meRight))
		
	Else 
		
		If ($Lon_x<($Lon_meRight-$Lon_vScrollOffset))\
			 & ($Lon_x>$Lon_meLeft)\
			 & ($Lon_y<($Lon_meBottom-$Lon_hScrollOffset))\
			 & ($Lon_y>$Lon_meTop)
			
			$Lon_rowIndex:=-1
			
			//get the row index of the listbox
			If ($Lon_y>($headerHeight+$Lon_meTop))
				
				For ($Lon_i; 1; $Lon_meRowNumber; 1)
					
					LISTBOX GET CELL COORDINATES:C1330(*; $Txt_me; 1; $Lon_i; $Lon_; $Lon_cellTop; $Lon_; $Lon_cellBottom)
					
					If ($Lon_y>=$Lon_cellTop)\
						 & ($Lon_y<=$Lon_cellBottom)
						
						$Lon_rowIndex:=$Lon_i
						$Lon_i:=MAXLONG:K35:2-1
						
					End if 
				End for 
			End if 
			
			$Lon_colIndex:=-1
			
			//get the column index of the listbox
			For ($Lon_i; 1; Size of array:C274($tTxt_columnNames)-2; 1)
				
				OBJECT GET COORDINATES:C663(*; $tTxt_columnNames{$Lon_i}; $Lon_columnLeft; $Lon_; $Lon_columnRight; $Lon_)
				
				If ($Lon_x>$Lon_columnLeft)\
					 & ($Lon_x<=$Lon_columnRight)
					
					$Lon_colIndex:=$Lon_i
					$Lon_i:=MAXLONG:K35:2-1
					
				End if 
			End for 
			
			$Lon_rowIndex:=Choose:C955($Lon_colIndex=-1; -1; $Lon_rowIndex)
			
		End if 
	End if 
	
	If ($Lon_area#0)
		
		//Get QR column & row
		If ($Boo_crossReport)
			
			$Lon_qrRow:=$Lon_rowIndex
			
			Case of 
					
					//…………………………………………………………………
				: ($Lon_colIndex=2)\
					 & ($Lon_rowIndex=1)
					
					$Lon_qrColumn:=1
					
					//…………………………………………………………………
				: ($Lon_colIndex=1)\
					 & ($Lon_rowIndex=2)
					
					$Lon_qrColumn:=2
					
					//…………………………………………………………………
				: ($Lon_colIndex=2)\
					 & ($Lon_rowIndex=2)
					
					$Lon_qrColumn:=3
					
					//…………………………………………………………………
				Else 
					
					$Lon_qrColumn:=0
					
					//…………………………………………………………………
			End case 
			
		Else 
			
			$Lon_qrColumn:=Choose:C955($Lon_colIndex>0; $Lon_colIndex-1; 0)
			
			$Lon_qrRow:=Choose:C955($Lon_rowIndex<=0; 0; \
				Choose:C955($Lon_rowIndex=1; qr title:K14906:1; \
				Choose:C955($Lon_rowIndex=2; qr detail:K14906:2; \
				Choose:C955($Lon_rowIndex=$Lon_qrRowNumber; qr grand total:K14906:3; \
				Choose:C955($Lon_rowIndex<=$Lon_qrRowNumber; $Lon_rowIndex-2; 0)))))
			
		End if 
	End if 
	
	If ($Boo_crossReport)
		
		$Boo_inTopLeftHeader:=($Lon_colIndex=1) & ($Lon_rowIndex=1)
		$Boo_inHeaderLine:=($Lon_colIndex=1) & ($Lon_rowIndex<=$Lon_meRowNumber) & ($Lon_rowIndex>0)
		$Boo_inHeaderColumn:=($Lon_rowIndex=1) & ($Lon_colIndex>1) & ($Lon_colIndex<=($Lon_qrColumnNumber+1))
		$Boo_inCell:=($Lon_colIndex>0) & ($Lon_rowIndex>0)
		
	Else 
		
		$Boo_inTopLeftHeader:=($Lon_colIndex=$Lon_lockedColumns) & ($Lon_rowIndex=-1)
		$Boo_inHeaderLine:=($Lon_colIndex=$Lon_lockedColumns) & ($Lon_rowIndex<=$Lon_meRowNumber) & ($Lon_rowIndex>0)
		$Boo_inHeaderColumn:=($Lon_rowIndex=-1) & ($Lon_colIndex>$Lon_lockedColumns) & ($Lon_colIndex<=($Lon_qrColumnNumber+1))
		$Boo_inCell:=($Lon_colIndex>$Lon_lockedColumns) & ($Lon_rowIndex>0)
		
	End if 
	
	
	
	Case of 
			
			//______________________________________________________
		: ($Lon_area=0)
			
			//______________________________________________________
		: ($Lon_formEvent=On Mouse Enter:K2:33)
			
			If (<>withFeature105739)
				
				ob_area.tipsDelay:=Get database parameter:C643(Tips delay:K37:80)
				SET DATABASE PARAMETER:C642(Tips delay:K37:80; 0)
				
			End if 
			//______________________________________________________
		: ($Lon_formEvent=On Mouse Leave:K2:34)
			
			If (<>withFeature105739)
				
				SET DATABASE PARAMETER:C642(Tips delay:K37:80; Num:C11(ob_area.tipsDelay))
				
			End if 
			
			//______________________________________________________
		: ($Lon_formEvent=On Header Click:K2:40)
			
			Case of 
					
					//………………………………………………………………………………
				: ($Boo_crossReport)
					
					//NOTHING MORE TO DO
					
					//………………………………………………………………………………
				: ($Boo_contextual)
					
					OB SET:C1220(ob_dialog; \
						"action"; "header_context_menu")
					
					//………………………………………………………………………………
				: ($Boo_inHeaderColumn)
					
					//select the column
					QR SET SELECTION:C794($Lon_area; $Lon_qrColumn; 0; $Lon_qrColumn; 0)
					report_SELECTION("select_column"; $Lon_colIndex)
					
					If (Clickcount:C1332=2)  //double click => Edit formula
						
						report_EDIT_COLUMN_FORMULA($Lon_area; $Lon_qrColumn)
						
					End if 
					
					//………………………………………………………………………………
				: ($Boo_inTopLeftHeader)
					
					//select the area
					QR SET SELECTION:C794($Lon_area; 0; 0)
					report_SELECTION("select_all")
					
					//………………………………………………………………………………
				Else 
					
					//unselect all
					QR SET SELECTION:C794($Lon_area; -1; -1; -1; -1)
					report_SELECTION("select_none")
					
					//………………………………………………………………………………
			End case 
			
			//______________________________________________________
		: ($Lon_formEvent=On Losing Focus:K2:8)
			
			OB SET:C1220(ob_dialog; \
				"action"; "update")
			
			//______________________________________________________
		: ($Lon_formEvent=On Double Clicked:K2:5)
			
			If ($Boo_inCell)
				
				If ($Boo_crossReport\
					 & (($Lon_colIndex<3) & ($Lon_rowIndex<3)))
					
					If ($Lon_colIndex=1)\
						 & ($Lon_rowIndex=1)
						
						//NOTHING MORE TO DO
						
					Else 
						
						report_EDIT_COLUMN_FORMULA($Lon_area; $Lon_qrColumn)
						
					End if 
					
				Else 
					
					If (Not:C34($Boo_crossReport))\
						 | ($Boo_crossReport & (($Lon_colIndex<3)\
						 | ($Lon_rowIndex#3)))
						
						If ($Boo_crossReport)
							
							//work with column index
							$Ptr_me->{$Lon_rowIndex}:=QR_Get_cell_text($Lon_area; $Lon_colIndex; $Lon_rowIndex)
							
						Else 
							
							$Ptr_me->{$Lon_rowIndex}:=QR_Get_cell_text($Lon_area; $Lon_qrColumn; $Lon_qrRow)
							
						End if 
						
						//make column enterable
						OBJECT SET ENTERABLE:C238($Ptr_me->; True:C214)
						
						//restore black color for text if any
						//%W-533.3
						LISTBOX SET ROW COLOR:C1270($Ptr_me->{$Ptr_me->}; $Lon_rowIndex; Foreground color:K23:1; lk font color:K53:24)
						//%W+533.3
						
						//set the edit flag
						OB SET:C1220(ob_area; \
							"cellEdition"; True:C214)
						
						$Boo_cellEditing:=True:C214
						
						If ($Lon_rowIndex>2) | $Boo_crossReport
							
							//display action button
							LISTBOX GET CELL COORDINATES:C1330(*; $Txt_me; $Lon_colIndex; $Lon_rowIndex; $Lon_left; $Lon_top; $Lon_right; $Lon_bottom)
							
							$Lon_top:=$Lon_top-16
							$Lon_right:=$Lon_left+23
							$Lon_bottom:=$Lon_top+16
							
							OBJECT SET COORDINATES:C1248(*; "cell_menu"; $Lon_left; $Lon_top; $Lon_right; $Lon_bottom)
							
							If (Not:C34($Boo_crossReport))
								
								OBJECT SET VISIBLE:C603(*; "cell_menu"; True:C214)
								
							Else 
								
								If ($Lon_colIndex>1)\
									 & ($Lon_rowIndex>1)
									
									OBJECT SET VISIBLE:C603(*; "cell_menu"; True:C214)
									
								End if 
							End if 
						End if 
						
						EDIT ITEM:C870($Ptr_me->)
						
					End if 
				End if 
			End if 
			
			//______________________________________________________
		: ($Lon_formEvent=On Clicked:K2:4)
			
			Case of 
					
					//…………………………………………………
				: ($Boo_inScroolbar)
					
					//…………………………………………………
				: ($Boo_cellEditing)
					
					//!!!! On clicked isn't generated during editing a cell !!!!
					
					//…………………………………………………
				: ($Boo_inHeaderLine)
					
					If ($Boo_contextual)
						
						If ($Boo_crossReport)
							
							OB SET:C1220(ob_dialog; \
								"action"; "cell_context_menu")
							
						Else 
							
							OB SET:C1220(ob_dialog; \
								"action"; "line_context_menu")
							
						End if 
						
					Else 
						
						If ($Boo_crossReport)
							
							If ($Lon_colIndex=1)\
								 & ($Lon_rowIndex=1)
								
								QR SET SELECTION:C794($Lon_area; 0; 0; 0; 0)
								report_SELECTION("select_all")
								
							Else 
								
								QR SET SELECTION:C794($Lon_area; $Lon_colIndex; $Lon_rowIndex; $Lon_colIndex; $Lon_rowIndex)
								report_SELECTION("select_cell"; $Lon_colIndex; $Lon_rowIndex)
								
							End if 
							
						Else 
							
							//select line
							QR SET SELECTION:C794($Lon_area; 0; $Lon_rowIndex; 0; $Lon_rowIndex)
							report_SELECTION("select_line"; $Lon_rowIndex)
							
						End if 
					End if 
					
					//…………………………………………………
				: ($Boo_inCell)
					
					If ($Boo_contextual)
						
						If ($Boo_crossReport)\
							 & ($Lon_colIndex=3)\
							 & ($Lon_rowIndex=3)
							
							//NOTHING MORE TO DO
							
						Else 
							
							OB SET:C1220(ob_dialog; \
								"action"; "cell_context_menu")
							
						End if 
						
					Else 
						
						If ($Boo_crossReport)\
							 & ($Lon_colIndex=3)\
							 & ($Lon_rowIndex=3)
							
							//deselect
							QR SET SELECTION:C794($Lon_area; -1; -1; -1; -1)
							report_SELECTION("select_none")
							
						Else 
							
							//select cell
							QR SET SELECTION:C794($Lon_area; $Lon_colIndex-$Lon_lockedColumns; $Lon_rowIndex; $Lon_colIndex-$Lon_lockedColumns; $Lon_rowIndex)
							report_SELECTION("select_cell"; $Lon_colIndex; $Lon_rowIndex)
							
						End if 
					End if 
					
					//…………………………………………………
				: ($Boo_outside)
					
					If ($Boo_contextual)
						
						If (Not:C34($Boo_crossReport))
							
							OB SET:C1220(ob_dialog; \
								"action"; "area_context_menu")
							
						End if 
						
					Else 
						
						//deselect
						QR SET SELECTION:C794($Lon_area; -1; -1; -1; -1)
						report_SELECTION("select_none")
						
					End if 
					
					//…………………………………………………
				Else 
					
					//deselect
					QR SET SELECTION:C794($Lon_area; -1; -1; -1; -1)
					report_SELECTION("select_none")
					
					//…………………………………………………
			End case 
			
			//______________________________________________________
			//#ACI0097243
			//: ($Lon_formEvent=On Column Moved)
		: ($Lon_formEvent=On Column Moved:K2:30)\
			 & (Not:C34($Boo_balloon))
			
			//Get the previous position and the new position of the column moved in the list box
			LISTBOX MOVED COLUMN NUMBER:C844(*; $Txt_me; $Lon_oldPosition; $Lon_newPosition)
			
			
			If ($Lon_newPosition#$Lon_oldPosition)
				
				//#ACI0095333 [
				//first restore the listbox column position !!!
				
				If ($Boo_quickReport)  // ACI0100359{ not for the report area only for the QR as it will be re-adjusted after. 
					LISTBOX MOVE COLUMN:C1274(*; $tTxt_columnNames{$Lon_newPosition}; $Lon_oldPosition)
				End if 
				//]
				//Is it an authorized moving?
				If ((($Lon_newPosition-1)<=$Lon_qrColumnNumber) & (($Lon_oldPosition-1)<=$Lon_qrColumnNumber))
					
					
					// #21-8-2014 - use the new command QR MOVE COLUMN
					//QR_SWAP_COLUMNS ($Lon_area;$Lon_oldPosition-1;$Lon_newPosition-1)
					QR MOVE COLUMN:C1325($Lon_area; $Lon_oldPosition-1; $Lon_newPosition-1)
					QR SET SELECTION:C794($Lon_area; $Lon_newPosition-1; 0; $Lon_newPosition-1; 0)
					
					
				Else 
					
					//#ACI0095333 [
					//LISTBOX MOVE COLUMN(*;$tTxt_columnNames{$Lon_newPosition};$Lon_qrColumnNumber+1)
					//]
					// move in last position
					LISTBOX MOVE COLUMN:C1274(*; $tTxt_columnNames{$Lon_newPosition}; $Lon_oldPosition)
					
					If (ob_area.qrColumn<0)  // if no column no movement
						
						QR MOVE COLUMN:C1325($Lon_area; $Lon_oldPosition-1; $Lon_qrColumnNumber-1)
						
					End if 
					
				End if 
			End if 
			
			OB SET:C1220(ob_dialog; \
				"action"; "update")
			
			//______________________________________________________
		: ($Boo_cellEditing)
			
			//do nothing until editing is complete
			
			//______________________________________________________
		: ($Boo_mouseDown) & False:C215
			
			//do nothing until the mouse button is down
			
			//______________________________________________________
		: ($Boo_outside)
			
			
			OBJECT SET HELP TIP:C1181(*; $Txt_me; $Txt_helpTip)
			
			//______________________________________________________
		: ($Lon_formEvent=On Mouse Move:K2:35)
			
			//get target coordinates
			
			
			Case of 
					
					//----------------------------------------
				: (OB Get:C1224(ob_area; "on-drop"; Is boolean:K8:9))
					
					//BEEP
					
					//…………………………………………………
				: ($Boo_inTopLeftHeader)
					
					If ($Boo_crossReport)
						
						LISTBOX GET CELL COORDINATES:C1330(*; $Txt_me; 1; $Lon_rowIndex; $Lon_left; $Lon_top; $Lon_right; $Lon_bottom)
						
					Else 
						
						OBJECT GET COORDINATES:C663(*; $tTxt_headerNames{1}; $Lon_left; $Lon_top; $Lon_right; $Lon_bottom)
						
					End if 
					
					//…………………………………………………
				: ($Boo_inHeaderLine)
					
					LISTBOX GET CELL COORDINATES:C1330(*; $Txt_me; 1; $Lon_rowIndex; $Lon_left; $Lon_top; $Lon_right; $Lon_bottom)
					
					If (<>withFeature105739)
						
						If (ob_area.sortNumber>0)  // The report is sorted
							
							QR GET SORTS:C753(ob_area.area; $aColumns; $aOrders)
							
							// Reorder the array
							$Lon_sz:=Size of array:C274($aOrders)
							ARRAY INTEGER:C220($aColumnsReordered; $Lon_sz)
							ARRAY INTEGER:C220($aOrdersReordered; $Lon_sz)
							
							For ($Lon_i; 1; $Lon_sz; 1)
								
								$aColumnsReordered{($Lon_sz-$Lon_i)+1}:=$aColumns{$Lon_i}
								$aOrdersReordered{($Lon_sz-$Lon_i)+1}:=$aOrders{$Lon_i}
								
							End for 
							
							If ((ob_area.rowIndex>2)\
								 & (ob_area.rowIndex<(3+ob_area.sortNumber)))  // In a subtotal row header
								
								//%W-533.3
								$Txt_helpTip:=Get localized string:C991(Choose:C955($aOrdersReordered{(ob_area.rowIndex-2)}=1; "ascendingSortOrder"; "descendingSortOrder"))
								//%W+533.3
								
							End if 
						End if 
					End if 
					
					//…………………………………………………
				: ($Boo_inHeaderColumn)
					
					If ($Boo_crossReport)
						
						LISTBOX GET CELL COORDINATES:C1330(*; $Txt_me; $Lon_colIndex; 1; $Lon_left; $Lon_top; $Lon_right; $Lon_bottom)
						
					Else 
						
						OBJECT GET COORDINATES:C663(*; $tTxt_headerNames{$Lon_colIndex}; $Lon_left; $Lon_top; $Lon_right; $Lon_bottom)
						
					End if 
					
					
					//…………………………………………………
				: ($Boo_inCell)
					
					LISTBOX GET CELL COORDINATES:C1330(*; $Txt_me; $Lon_colIndex; $Lon_rowIndex; $Lon_left; $Lon_top; $Lon_right; $Lon_bottom)
					
					//…………………………………………………
				Else 
					
					//ASSERT(False)
					
					//…………………………………………………
			End case 
			
			OBJECT SET HELP TIP:C1181(*; $Txt_me; $Txt_helpTip)
			
			
			//crop if any
			$Lon_left:=Choose:C955(($Lon_left<$Lon_lockedRight) & ($Lon_colIndex>1); $Lon_lockedRight; $Lon_left)
			$Lon_top:=Choose:C955(($Lon_top<($headerHeight+$Lon_meTop)) & ($Lon_rowIndex>0); $headerHeight+$Lon_meTop; $Lon_top)
			$Lon_right:=Choose:C955($Lon_right>($Lon_meRight-$Lon_vScrollOffset); $Lon_meRight-$Lon_vScrollOffset; $Lon_right)
			$Lon_bottom:=Choose:C955($Lon_bottom>($Lon_meBottom-$Lon_hScrollOffset); $Lon_meBottom-$Lon_hScrollOffset; $Lon_bottom)
			
			Case of 
					
					//………………………………………………………………………………………………………………
				: (Not:C34($Boo_quickReport))
					
					//NOTHING MORE TO DO
					
					//………………………………………………………………………………………………………………
				: ($Boo_balloon)
					
					//NOTHING MORE TO DO
					
					//………………………………………………………………………………………………………………
				: ($Boo_inTopLeftHeader)
					
					Case of 
							
							//-----------------------------------
						: ($Boo_crossReport)
							
							$Lon_posLeft:=$Lon_right-Form:C1466.headerButtonWidth
							$Lon_posTop:=$Lon_top+Form:C1466.headerButtonOffset
							$Lon_posRight:=$Lon_posLeft+Form:C1466.headerButtonWidth
							$Lon_posBottom:=$Lon_posTop+Form:C1466.headerButtonWidth
							
							OBJECT SET COORDINATES:C1248(*; "header_action"; $Lon_posLeft; $Lon_posTop; $Lon_posRight; $Lon_posBottom)
							OBJECT SET VISIBLE:C603(*; "header_action"; True:C214)
							
							//-----------------------------------
						: ($Lon_x>=($Lon_right-Form:C1466.addSensitive))  //into the right separator sensitive area
							
							If (LISTBOX Get property:C917(*; $Txt_me; _o_lk hor scrollbar position:K53:10)=0)
								
								OB SET:C1220(ob_dialog; \
									"action"; "show_plus"; \
									"middle"; $Lon_right)
								
							End if 
							
							//-----------------------------------
						: (($Lon_right-$Lon_left)>(Form:C1466.headerButtonWidth+(Form:C1466.headerButtonOffset*2)))
							
							//don't display arrow when the QR is empty
							If ($Lon_qrColumnNumber>0)
								
								$Lon_posLeft:=$Lon_right-Form:C1466.headerButtonWidth
								$Lon_posTop:=$Lon_top+Form:C1466.headerButtonOffset
								$Lon_posRight:=$Lon_posLeft+Form:C1466.headerButtonWidth
								$Lon_posBottom:=$Lon_posTop+Form:C1466.headerButtonWidth
								
								OBJECT SET COORDINATES:C1248(*; "header_action"; $Lon_posLeft; $Lon_posTop; $Lon_posRight; $Lon_posBottom)
								OBJECT SET VISIBLE:C603(*; "header_action"; True:C214)
								
							End if 
							
							//-------------------------------------
					End case 
					
					//………………………………………………………………………………………………………………
				: ($Boo_inHeaderColumn)
					
					If ($Lon_qrColumn<=$Lon_qrColumnNumber)
						
						Case of 
								
								//-----------------------------------
							: ($Boo_crossReport)
								
								$Lon_posLeft:=$Lon_right-Form:C1466.headerButtonWidth
								$Lon_posTop:=$Lon_top+Form:C1466.headerButtonOffset
								$Lon_posRight:=$Lon_posLeft+Form:C1466.headerButtonWidth
								$Lon_posBottom:=$Lon_posTop+Form:C1466.headerButtonWidth
								
								OBJECT SET COORDINATES:C1248(*; "header_action"; $Lon_posLeft; $Lon_posTop; $Lon_posRight; $Lon_posBottom)
								OBJECT SET VISIBLE:C603(*; "header_action"; True:C214)
								
								//-----------------------------------
							: ($Lon_x>=($Lon_right-Form:C1466.addSensitive))  //into the right separator sensitive area
								
								OBJECT SET VISIBLE:C603(*; "header_action"; False:C215)
								
								OB SET:C1220(ob_dialog; \
									"action"; "show_plus"; \
									"middle"; $Lon_right)
								
								//-----------------------------------
							: ($Lon_x<=($Lon_left+Form:C1466.addSensitive))  //into the left separator sensitive area
								
								OBJECT SET VISIBLE:C603(*; "header_action"; False:C215)
								
								OB SET:C1220(ob_dialog; \
									"action"; "show_plus"; \
									"middle"; $Lon_left)
								
								//-----------------------------------
							Else 
								
								If (($Lon_right-$Lon_left)>(Form:C1466.headerButtonWidth+(Form:C1466.headerButtonOffset*2)))
									
									$Lon_posLeft:=$Lon_right-Form:C1466.headerButtonWidth
									$Lon_posTop:=$Lon_top+Form:C1466.headerButtonOffset
									$Lon_posRight:=$Lon_posLeft+Form:C1466.headerButtonWidth
									$Lon_posBottom:=$Lon_posTop+Form:C1466.headerButtonWidth
									
									OBJECT SET COORDINATES:C1248(*; "header_action"; $Lon_posLeft; $Lon_posTop; $Lon_posRight; $Lon_posBottom)
									OBJECT SET VISIBLE:C603(*; "header_action"; True:C214)
									
								End if 
								
								//-------------------------------------
						End case 
					End if 
					
					//………………………………………………………………………………………………………………
				: ($Boo_inHeaderLine)
					
					If ($Lon_x>=($Lon_right-Form:C1466.addSensitive))  //into the right separator sensitive area
						
						OBJECT SET VISIBLE:C603(*; "header_action"; False:C215)
						
						OB SET:C1220(ob_dialog; \
							"action"; "show_plus"; \
							"middle"; $Lon_right)
						
					Else 
						
						If (($Lon_right-$Lon_left)>(Form:C1466.headerButtonWidth+(Form:C1466.headerButtonOffset*2)))
							
							//don't display arrow when the QR is empty
							If ($Lon_qrColumnNumber>0)
								
								$Lon_posLeft:=$Lon_right-Form:C1466.headerButtonWidth
								$Lon_posTop:=$Lon_top+Form:C1466.headerButtonOffset
								$Lon_posRight:=$Lon_posLeft+Form:C1466.headerButtonWidth
								$Lon_posBottom:=$Lon_posTop+Form:C1466.headerButtonWidth
								
								OBJECT SET COORDINATES:C1248(*; "header_action"; $Lon_posLeft; $Lon_posTop; $Lon_posRight; $Lon_posBottom)
								OBJECT SET VISIBLE:C603(*; "header_action"; True:C214)
								
							End if 
						End if 
					End if 
					
					//………………………………………………………………………………………………………………
				: ($Boo_inCell)
					
					Case of 
							
							//-----------------------------------
						: ($Boo_crossReport)
							
							$Lon_posLeft:=$Lon_right-Form:C1466.headerButtonWidth
							$Lon_posTop:=$Lon_top+Form:C1466.headerButtonOffset
							$Lon_posRight:=$Lon_posLeft+Form:C1466.headerButtonWidth
							$Lon_posBottom:=$Lon_posTop+Form:C1466.headerButtonWidth
							
							OBJECT SET COORDINATES:C1248(*; "header_action"; $Lon_posLeft; $Lon_posTop; $Lon_posRight; $Lon_posBottom)
							OBJECT SET VISIBLE:C603(*; "header_action"; True:C214)
							
							//-----------------------------------
						: ($Lon_qrColumn>$Lon_qrColumnNumber)
							
							//NOTHING MORE TO DO
							
							//-----------------------------------
						: ($Lon_x>=($Lon_right-Form:C1466.addSensitive))  //into the right separator sensitive area
							
							OB SET:C1220(ob_dialog; \
								"action"; "show_plus"; \
								"middle"; $Lon_right)
							
							//-----------------------------------
						: ($Lon_x<=($Lon_left+Form:C1466.addSensitive))  //into the left separator sensitive area
							
							OB SET:C1220(ob_dialog; \
								"action"; "show_plus"; \
								"middle"; $Lon_left)
							
							//-----------------------------------
						Else 
							
							If (($Lon_right-$Lon_left)>(Form:C1466.headerButtonWidth+(Form:C1466.headerButtonOffset*2)))
								
								$Lon_posLeft:=$Lon_right-Form:C1466.headerButtonWidth
								$Lon_posTop:=$Lon_top+Form:C1466.headerButtonOffset
								$Lon_posRight:=$Lon_posLeft+Form:C1466.headerButtonWidth
								$Lon_posBottom:=$Lon_posTop+Form:C1466.headerButtonWidth
								
								OBJECT SET COORDINATES:C1248(*; "header_action"; $Lon_posLeft; $Lon_posTop; $Lon_posRight; $Lon_posBottom)
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
		: ($Lon_formEvent=On Row Moved:K2:32)
			
			If ($Boo_crossReport)
				
				//restore
				If ($Boo_quickReport)
					
					OB SET:C1220(ob_dialog; \
						"action"; "update")
					
				Else 
					
					report_DISPLAY_AREA($Lon_area)
					
				End if 
				
			Else 
				
				//Get the previous position and the new position of the row moved
				LISTBOX MOVED ROW NUMBER:C837(*; $Txt_me; $Lon_oldPosition; $Lon_newPosition)
				
				If ($Lon_newPosition#$Lon_oldPosition)
					
					//Only the break's lines can be moved
					If ($Lon_oldPosition>2)\
						 & ($Lon_oldPosition<$Lon_meRowNumber)\
						 & ($Lon_newPosition>2)\
						 & ($Lon_newPosition<$Lon_meRowNumber)
						
						QR_SWAP_ROWS($Lon_area; $Lon_oldPosition; $Lon_newPosition)
						
					Else 
						
						//restore
						OB SET:C1220(ob_dialog; \
							"action"; "update")
						
					End if 
				End if 
			End if 
			
			//______________________________________________________
		: ($Lon_formEvent=On Column Resize:K2:31)
			
			If ($Boo_crossReport)
				
				If ($Lon_colIndex>0)
					
					//deselect
					QR SET SELECTION:C794($Lon_area; -1; -1; -1; -1)
					report_SELECTION("select_none")
					
					$Lon_width:=LISTBOX Get column width:C834(*; $tTxt_columnNames{$Lon_colIndex})
					QR_SET_COLUMN_WIDTH($Lon_area; $Lon_colIndex; $Lon_width)
					
				End if 
				
			Else 
				
				$Lon_column:=Find in array:C230($tPtr_columnVars; $Ptr_me)
				
				If ($Lon_column>1)\
					 & ($Lon_column<=($Lon_qrColumnNumber+1))
					
					$Lon_width:=LISTBOX Get column width:C834(*; $tTxt_columnNames{$Lon_column})
					
					QR_SET_COLUMN_WIDTH($Lon_area; $Lon_column-1; $Lon_width)
					
				End if 
			End if 
			
			If ($Lon_mouseButton=0)  //Button up
				
				OB SET:C1220(ob_dialog; \
					"action"; "update")
				
			End if 
			
			//________________________________________
	End case 
	
	
	
	If ($Lon_area#0)
		
		Case of 
				
				//______________________________________________________
			: ($Boo_balloon)
				
				//NOTHING MORE TO DO
				
				//______________________________________________________
			: ($Boo_cellEditing)
				
				OB SET:C1220(ob_area; \
					"columnIndex"; $Lon_colIndex; \
					"rowIndex"; $Lon_rowIndex; \
					"qrColumn"; $Lon_qrColumn; \
					"qrRow"; $Lon_qrRow)
				
				//______________________________________________________
			Else 
				
				area_ADJUST
				
				If ($Lon_qrDestination=qr printer:K14903:1)\
					 & Not:C34($Boo_crossReport)
					
					//move page break if any
					OBJECT GET COORDINATES:C663(*; $tTxt_columnNames{$Lon_lockedColumns+1}; $Lon_left; $Lon_; $Lon_; $Lon_)
					$Lon_left:=($Lon_lockedRight+OB Get:C1224(ob_area; "pageBreak"; Is longint:K8:6))-($Lon_lockedRight-$Lon_left)
					OBJECT GET COORDINATES:C663(*; "page.break"; $Lon_; $Lon_top; $Lon_; $Lon_bottom)
					OBJECT SET COORDINATES:C1248(*; "page.break"; $Lon_left; $Lon_top; $Lon_left; $Lon_bottom)
					OBJECT SET VISIBLE:C603(*; "page.break"; $Lon_left>$Lon_lockedRight)
					
				End if 
				
				//keep the position of the scroll bars
				OBJECT GET SCROLL POSITION:C1114(*; $Txt_me; $Lon_rowPosition; $Lon_columnPosition)
				
				OB SET:C1220(ob_area; \
					"columnIndex"; $Lon_colIndex; \
					"rowIndex"; $Lon_rowIndex; \
					"qrColumn"; $Lon_qrColumn; \
					"qrRow"; $Lon_qrRow; \
					"inTopLeftHeader"; $Boo_inTopLeftHeader; \
					"inHeaderColumn"; $Boo_inHeaderColumn; \
					"inHeaderLine"; $Boo_inHeaderLine; \
					"inCell"; $Boo_inCell; \
					"scrollRow"; $Lon_rowPosition; \
					"scrollColumn"; $Lon_columnPosition; \
					"crossReport"; $Boo_crossReport)
				
				//______________________________________________________
		End case 
		
		If ($Boo_quickReport)
			
			If (Not:C34($Boo_cellEditing))
				
				CALL SUBFORM CONTAINER:C1086(-1)
				
			End if 
			
		Else 
			
			If ($Boo_contextual)\
				 & ($Lon_area#0)
				
				If (QR Get area property:C795($Lon_area; qr view contextual menus:K14905:7)#0)
					
					If ($Boo_crossReport)
						
						If ($Lon_colIndex=3)\
							 & ($Lon_rowIndex=3)
							
						Else 
							
							report_CONTEXTUAL_MENUS($Lon_area; $Lon_colIndex; $Lon_rowIndex)
							
						End if 
						
					Else 
						
						report_CONTEXTUAL_MENUS($Lon_area; $Lon_qrColumn; $Lon_qrRow)
						
					End if 
				End if 
			End if 
		End if 
	End if 
End if 

// ----------------------------------------------------
// End