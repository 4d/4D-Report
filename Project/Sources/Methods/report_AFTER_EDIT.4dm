//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : report_AFTER_EDIT
// Database: 4D Report
// ID[F4C6B3651D3241C3AEE4F317441F08A6]
// Created #7-7-2016 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations

#DECLARE()

var $area; $column; $count_parameters; $row : Integer
var $self : Pointer
var $buffer : Text

// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=0; "Missing parameter"))
	
	//NO PARAMETERS REQUIRED
	
	//Optional parameters
	If ($count_parameters>=1)
		
		// <NONE>
		
	End if 
	
	$self:=OBJECT Get pointer:C1124(Object current:K67:2)
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
OBJECT SET VISIBLE:C603(*; "cell_menu"; False:C215)


If (ob_area#Null:C1517)  //#DD ACI0104452 ob_area is undefined at this level when esc keydown 
	
	//get edited cell
	$area:=ob_area.area
	
	If (Bool:C1537(ob_area.crossReport))
		
		$column:=ob_area.columnIndex
		$row:=ob_area.rowIndex
		
		If ($column=1) & ($row=1)
			
			$column:=0
			$row:=0
			
		End if 
		
	Else 
		
		$column:=ob_area.qrColumn
		$row:=ob_area.qrRow
		
	End if 
	
	//%W-533.3
	$buffer:=ST Get plain text:C1092($self->{$self->})
	//%W+533.3
	
	QR_SET_CELL_TEXT($area; $column; $row; $buffer)
	
	//update data
	ob_area.cellEdition:=False:C215
	
End if 

OBJECT SET ENTERABLE:C238($self->; False:C215)

report_AREA_UPDATE

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End