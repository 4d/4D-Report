//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : report_SELECTION
// Database: sandbox_14
// ID[09AAC562C1E14454AAC5DEBC5980B44F]
// Created #30-1-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations

#DECLARE($action : Text; $index_1 : Integer; $index_2 : Integer)


var \
$is_OK; \
$display : Boolean


var \
$int; \
$area; \
$left; \
$top; \
$right; \
$bottom; \
$width; \
$height; \
$column; \
$line; \
$reportType; \
$columnNumber; \
$rowNumber; \
$count_parameters; \
$count_lockedColumns; \
$lockedRight : Integer


var \
$idx_1; \
$idx_2 : Integer


ARRAY BOOLEAN:C223($_visible; 0)
ARRAY POINTER:C280($_columnVars; 0)
ARRAY POINTER:C280($_headerVars; 0)
ARRAY POINTER:C280($_styles; 0)
ARRAY TEXT:C222($_columnNames; 0)
ARRAY TEXT:C222($_headerNames; 0)

If (False:C215)
	C_TEXT:C284(report_SELECTION; $1)
	C_LONGINT:C283(report_SELECTION; $2)
	C_LONGINT:C283(report_SELECTION; $3)
End if 

// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=1; "Missing parameter"))
	
	//$action:=$1
	
	If ($count_parameters>=2)
		
		$idx_1:=$index_1
		
		If ($count_parameters>=3)
			
			$idx_2:=$index_2
			
		End if 
	End if 
	
	//[ISOFUNCTIONAL = THE MULTISELECTION IS NOT MANAGED]
	//$kBoo_multiSelection:=False
	
	$is_OK:=(OB Is defined:C1231(ob_area))
	
	If ($is_OK)
		
		$area:=OB Get:C1224(ob_area; "area"; Is longint:K8:6)
		$rowNumber:=OB Get:C1224(ob_area; "qrRowNumber"; Is longint:K8:6)
		$columnNumber:=OB Get:C1224(ob_area; "qrColumnNumber"; Is longint:K8:6)
		$reportType:=OB Get:C1224(ob_area; "reportType"; Is longint:K8:6)
		
	End if 
	
	LISTBOX GET ARRAYS:C832(*; Form:C1466.areaObject; \
		$_columnNames; \
		$_headerNames; \
		$_columnVars; \
		$_headerVars; \
		$_visible; \
		$_styles)
	
	$count_lockedColumns:=LISTBOX Get locked columns:C1152(*; Form:C1466.areaObject)
	
Else 
	
	ABORT:C156
	
End if 

//LOG EVENT(Into 4D debug message; "4D report - "+Current method name+" "+$Txt_entrypoint)

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($area=0)
		
		//NOTHING MORE TO DO
		
		//______________________________________________________
	: ($action="display")\
		 | ($action="adjust")
		
		If ($action="adjust")
			
			$column:=OB Get:C1224(ob_area; "selected-column"; Is longint:K8:6)
			$line:=OB Get:C1224(ob_area; "selected-line"; Is longint:K8:6)
			
		Else 
			
			//retrieve the coordinates of the cell that is selected.
			QR GET SELECTION:C793($area; $left; $top; $right; $bottom)
			
			Case of 
					
					//…………………………………………………………………………………………
				: ($left=-1)  //no selection
					
					$column:=0
					$line:=0
					
					//…………………………………………………………………………………………
				: (($left+$top)=0)  //All area
					
					$column:=-1
					$line:=-1
					
					//…………………………………………………………………………………………
				: ($top=0)  //entire column
					
					$column:=$left+$count_lockedColumns
					
					//…………………………………………………………………………………………
				: ($left=0)  //entire row
					
					$line:=$top
					
					//…………………………………………………………………………………………
				Else 
					
					$column:=$left+$count_lockedColumns
					$line:=$top
					
					//…………………………………………………………………………………………
			End case 
			
			OB SET:C1220(ob_area; \
				"selected-column"; $column; \
				"selected-line"; $line)
			
		End if 
		
		Case of 
				
				//…………………………………………………………………………………………
			: (($column=0)\
				 & ($line=0))
				
				//NO SELECTION
				report_SELECTION("select_none")
				
				//…………………………………………………………………………………………
			: (($column=-1)\
				 & ($line=-1))
				
				report_SELECTION("select_all")
				
				//…………………………………………………………………………………………
			: ($line=0)
				
				report_SELECTION("select_column"; $column)
				
				//…………………………………………………………………………………………
			: ($column=0)
				
				report_SELECTION("select_line"; $line)
				
				//…………………………………………………………………………………………
			Else 
				
				report_SELECTION("select_cell"; $column; $line)
				
				//…………………………………………………………………………………………
		End case 
		
		//______________________________________________________
	: ($action="select_none")
		
		OBJECT SET VISIBLE:C603(*; "sel@"; False:C215)
		
		OB SET:C1220(ob_area; \
			"selected-column"; 0; \
			"selected-line"; 0)
		
		//______________________________________________________
	: ($action="select_all")
		
		$display:=True:C214
		
		OBJECT GET COORDINATES:C663(*; $_columnNames{$count_lockedColumns}; $int; $int; $left; $int)
		OBJECT GET COORDINATES:C663(*; $_headerNames{1}; $int; $int; $int; $top)
		OBJECT GET COORDINATES:C663(*; "filler"; $right; $int; $int; $int)
		LISTBOX GET CELL COORDINATES:C1330(*; Form:C1466.areaObject; 1; LISTBOX Get number of rows:C915(*; Form:C1466.areaObject); $int; $int; $int; $bottom)
		
		OB SET:C1220(ob_area; \
			"selected-column"; -1; \
			"selected-line"; -1)
		
		//______________________________________________________
	Else 
		
		$display:=True:C214
		
		Case of 
				
				//…………………………………………………………………………………………
			: ($action="select_column")
				
				If ($idx_1<=Size of array:C274($_columnNames))
					
					OB SET:C1220(ob_area; \
						"selected-column"; $idx_1; \
						"selected-line"; 0)
					
					OBJECT GET COORDINATES:C663(*; $_columnNames{$idx_1}; $left; $top; $right; $bottom)
					
					// MARK:ACI0103784
					If ($bottom<=$top)
						
						$bottom:=$top+($rowNumber*Form:C1466.defaultRowHeight)
						
					End if 
				End if 
				
				//…………………………………………………………………………………………
			: ($action="select_line")
				
				OB SET:C1220(ob_area; \
					"selected-column"; 0; \
					"selected-line"; $idx_1)
				
				OBJECT GET COORDINATES:C663(*; $_columnNames{$count_lockedColumns}; $int; $int; $left; $int)
				LISTBOX GET CELL COORDINATES:C1330(*; Form:C1466.areaObject; 2; $idx_1; $int; $top; $int; $bottom)
				OBJECT GET COORDINATES:C663(*; "filler"; $right; $int; $int; $int)
				
				//…………………………………………………………………………………………
			: ($action="select_cell")
				
				OB SET:C1220(ob_area; \
					"selected-column"; $idx_1; \
					"selected-line"; $idx_2)
				
				LISTBOX GET CELL COORDINATES:C1330(*; Form:C1466.areaObject; $idx_1; $idx_2; $left; $top; $right; $bottom)
				
				//…………………………………………………………………………………………
		End case 
		
		//________________________________________
End case 

If ($action="select_@")
	
	If ($display)
		
		//crop if any
		OBJECT GET COORDINATES:C663(*; $_columnNames{$count_lockedColumns}; $int; $int; $lockedRight; $int)
		$left:=Choose:C955($left<$lockedRight; $lockedRight; $left)
		
		If (OB Get:C1224(ob_area; "reportType"; Is longint:K8:6)=qr list report:K14902:1)
			
			$top:=Choose:C955($top<Form:C1466.headerHeight; Form:C1466.headerHeight; $top)
			
		End if 
		
		OBJECT GET SUBFORM CONTAINER SIZE:C1148($width; $height)
		
		//calculate the corrected area coordinates with the scrollbar widths
		$width:=$width-\
			(LISTBOX Get property:C917(*; Form:C1466.areaObject; lk ver scrollbar width:K53:9)*LISTBOX Get property:C917(*; Form:C1466.areaObject; _o_lk display ver scrollbar:K53:8))
		$right:=Choose:C955($right>$width; $width; $right)
		
		$height:=$height-\
			(LISTBOX Get property:C917(*; Form:C1466.areaObject; lk hor scrollbar height:K53:7)*LISTBOX Get property:C917(*; Form:C1466.areaObject; _o_lk display hor scrollbar:K53:6))
		$bottom:=Choose:C955($bottom>$height; $height+1; $bottom)
		
		$right:=$right-1
		$bottom:=$bottom-1
		
		OBJECT SET COORDINATES:C1248(*; "sel@"; $left; $top; $right; $bottom)
		
		//display if any
		OBJECT SET VISIBLE:C603(*; "sel@"; $right>=$left)
		
	Else 
		
		OBJECT SET VISIBLE:C603(*; "sel@"; False:C215)
		
	End if 
End if 

If ($action#"adjust")  //stop reentrance
	
	var $Ptr_timer : Pointer
	$Ptr_timer:=OBJECT Get pointer:C1124(Object named:K67:5; "timerEvent")
	If ($Ptr_timer->#0)
		//LOG EVENT(Into 4D debug message; "4D report - "+Current method name+" "+$Txt_entrypoint)
		SET TIMER:C645(-1)
	End if 
	
End if 

// ----------------------------------------------------
// End