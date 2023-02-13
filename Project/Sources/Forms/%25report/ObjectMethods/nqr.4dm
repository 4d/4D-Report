// ----------------------------------------------------
// Object method : %report.nqr - (4D Report)
// ID[6D9EBFF1B14147F8BA6F339B74ECE19F]
// Created #16-4-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Declarations

#DECLARE()->$result : Integer

var \
$t : Text

var \
$row; $column; $column_number; \
$mouse_x; $mouse_y; $mouse_button; \
$left; $top; $right; $bottom : Integer

var \
$data : Blob

var \
$o; \
$e : Object

ARRAY TEXT:C222($_columnNames; 0)
ARRAY TEXT:C222($_headerNames; 0)
ARRAY BOOLEAN:C223($_visibles; 0)
ARRAY POINTER:C280($_columnVars; 0)
ARRAY POINTER:C280($_headerVars; 0)
ARRAY POINTER:C280($_styles; 0)

// ----------------------------------------------------
// Initialisations

$e:=FORM Event:C1606

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($e.code=On Drag Over:K2:13)
		
		$result:=-1
		
		GET MOUSE:C468($mouse_x; $mouse_y; $mouse_button)
		
		// #7-9-2015
		//convert coordinates from global (window) to local (subform)
		CONVERT COORDINATES:C1365($mouse_x; $mouse_y; XY Current window:K27:6; XY Current form:K27:5)
		
		$row:=Drop position:C608($column)
		
		$column_number:=ob_area.qrColumnNumber
		$column:=$column-1
		
		//column = 0 should be accepted else move row is broken
		If ($column>=0)
			
			$result:=0  //accept
			
			GET PASTEBOARD DATA:C401("com.4d.wizard"; $data)
			
			If ($column>0)\
				 & ((Not:C34(Bool:C1537(ob_area["4d-dialog"]))) | (BLOB size:C605($data)>0))
				
				OBJECT SET VISIBLE:C603(*; "drop"; True:C214)
				
				$column:=$column+1
				
				LISTBOX GET ARRAYS:C832(*; Form:C1466.areaObject; \
					$_columnNames; \
					$_headerNames; \
					$_columnVars; \
					$_headerVars; \
					$_visibles; \
					$_styles)
				
				OBJECT GET COORDINATES:C663(*; $_columnNames{$column}; $left; $top; $right; $bottom)
				
				Case of 
						
						//………………………………………………………………………………
					: ($column<=1)  //before the first column
						
						$left:=$right
						
						//………………………………………………………………………………
					: ($column>($column_number+1))  //after the last column
						
						$right:=$left
						
						//………………………………………………………………………………
					Else 
						
						Case of 
								
								//-----------------------------------
							: ($mouse_x<=($left+Form:C1466.addSensitive))  //into the left separator sensitive area
								
								$right:=$left
								
								//-----------------------------------
							: ($mouse_x>=($right-Form:C1466.addSensitive))  //into the right separator sensitive area
								
								$left:=$right
								
								//-----------------------------------
							Else 
								
								//NOTHING MORE TO DO
								
								//-----------------------------------
						End case 
						
						//………………………………………………………………………………
				End case 
				
				//move the drop area
				OBJECT SET COORDINATES:C1248(*; "drop"; $left; $top; $right; $bottom)
				
			Else 
				
				OBJECT SET VISIBLE:C603(*; "drop"; False:C215)
				
			End if 
			
			//generate On Drag Over event
			CALL SUBFORM CONTAINER:C1086(On Drag Over:K2:13)
			
		Else 
			
			OBJECT SET VISIBLE:C603(*; "drop"; False:C215)
			
		End if 
		
		//______________________________________________________
	: ($e.code=On Drop:K2:12)
		
		//if the value is negative, it indicates a column number (i.e., -3 if the the drop
		//was performed on column number 3)
		
		//if the value is positive, it indicates that the drop was performed on a
		//separator preceding the column (i.e., 3 if the drop was performed after column
		//2). Keep in mind that the drop does not have to take place before an existing
		//column.
		
		GET MOUSE:C468($mouse_x; $mouse_y; $mouse_button)
		
		// #7-9-2015
		//convert coordinates from global (window) to local (subform)
		CONVERT COORDINATES:C1365($mouse_x; $mouse_y; XY Current window:K27:6; XY Current form:K27:5)
		
		$row:=Drop position:C608($column)
		
		$column_number:=OB Get:C1224(ob_area; "qrColumnNumber"; Is longint:K8:6)
		
		Case of 
				
				//………………………………………………………………………………
			: ($column<=1)  //before the first column
				
				//NOTHING MORE TO DO
				
				//………………………………………………………………………………
			: ($column>($column_number+1))  //after the last column
				
				$column:=$column_number+1
				
				//………………………………………………………………………………
			Else 
				
				LISTBOX GET ARRAYS:C832(*; Form:C1466.areaObject; \
					$_columnNames; \
					$_headerNames; \
					$_columnVars; \
					$_headerVars; \
					$_visibles; \
					$_styles)
				
				OBJECT GET COORDINATES:C663(*; $_columnNames{$column}; $left; $top; $right; $bottom)
				
				Case of 
						
						//-----------------------------------
					: ($mouse_x<=($left+Form:C1466.addSensitive))  //into the left separator sensitive area
						
						$column:=$column-1
						
						//-----------------------------------
					: ($mouse_x>=($right-Form:C1466.addSensitive))  //into the right separator sensitive area
						
						$column:=$column
						
						//-----------------------------------
					Else 
						
						$column:=-($column-1)
						
						//-----------------------------------
				End case 
				
				//………………………………………………………………………………
		End case 
		
		If ($column#0)
			
			GET PASTEBOARD DATA:C401("com.4d.wizard"; $data)
			
			If (BLOB size:C605($data)>0)
				
				$t:=Convert to text:C1012($data; "utf-8")
				
				$o:=JSON Parse:C1218($t)
				
				OB SET:C1220(ob_dialog; "action"; "insert_field"; \
					"column"; $column; \
					"table"; Num:C11($o.table); \
					"field"; Num:C11($o.field))
				
				ob_dialog.action:="insert_field"
				ob_dialog.column:=$column
				ob_dialog.table:=Num:C11($o.table)
				ob_dialog.field:=Num:C11($o.field)
				
				CALL SUBFORM CONTAINER:C1086(-1)
				
			Else 
				
				QR SET AREA PROPERTY:C796(OB Get:C1224(ob_area; "area"; Is longint:K8:6); -100; $column)
				
				//generate On Drop event
				CALL SUBFORM CONTAINER:C1086(On Drop:K2:12)
				
			End if 
		End if 
		
		OBJECT SET VISIBLE:C603(*; "drop"; False:C215)
		
		//______________________________________________________
	: ($e.code=On Delete Action:K2:56)
		
		//------------------------------------------------------------
		//THIS EVENT IS NOT TRIGGERED IF THE LISTBOX SELECTION MODE IS "NONE" !!!
		//------------------------------------------------------------
		
		//management is done into the button "delete"
		
		//______________________________________________________
	Else 
		
		OBJECT SET VISIBLE:C603(*; "drop"; False:C215)
		
		If ($e.code=On Load:K2:1)
			
			//the area is loaded before the form
			COMPILER_report
			
		End if 
		
		report_AREA_OBJECT_METHOD
		
		//______________________________________________________
End case 