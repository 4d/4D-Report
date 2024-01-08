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
C_LONGINT:C283($Lon_area; $Lon_column; $Lon_parameters; $Lon_row)
C_POINTER:C301($Ptr_me)
C_TEXT:C284($Txt_buffer)

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0; "Missing parameter"))
	
	//NO PARAMETERS REQUIRED
	
	//Optional parameters
	If ($Lon_parameters>=1)
		
		// <NONE>
		
	End if 
	
	$Ptr_me:=OBJECT Get pointer:C1124(Object current:K67:2)
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
OBJECT SET VISIBLE:C603(*; "cell_menu"; False:C215)


If (ob_area#Null:C1517)  //#DD ACI0104452 ob_area is undefined at this level when esc keydown 
	
	//get edited cell
	$Lon_area:=OB Get:C1224(ob_area; "area"; Is longint:K8:6)
	
	If (OB Get:C1224(ob_area; "crossReport"; Is boolean:K8:9))
		
		$Lon_column:=OB Get:C1224(ob_area; "columnIndex"; Is longint:K8:6)
		$Lon_row:=OB Get:C1224(ob_area; "rowIndex"; Is longint:K8:6)
		
		If ($Lon_column=1)\
			 & ($Lon_row=1)
			
			$Lon_column:=0
			$Lon_row:=0
			
		End if 
		
	Else 
		
		$Lon_column:=OB Get:C1224(ob_area; "qrColumn"; Is longint:K8:6)
		$Lon_row:=OB Get:C1224(ob_area; "qrRow"; Is longint:K8:6)
		
	End if 
	
	//%W-533.3
	$Txt_buffer:=ST Get plain text:C1092($Ptr_me->{$Ptr_me->})
	//%W+533.3
	
	QR_SET_CELL_TEXT($Lon_area; $Lon_column; $Lon_row; $Txt_buffer)
	
	//update data
	OB SET:C1220(ob_area; \
		"cellEdition"; False:C215)
	
End if 

OBJECT SET ENTERABLE:C238($Ptr_me->; False:C215)

report_AREA_UPDATE

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End