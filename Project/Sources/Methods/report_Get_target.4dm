//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : report_Get_target
// Database: 4D Report
// ID[06CD1699C55D44C68E34F175AE681203]
// Created #13-7-2016 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations

#DECLARE($caller : Object; $column : Pointer; $row : Pointer; $get_data : Boolean)->$area : Integer

var \
$count_parameters; \
$column_number; \
$row_number : Integer



If (False:C215)
	C_LONGINT:C283(report_Get_target; $0)
	C_OBJECT:C1216(report_Get_target; $1)
	C_POINTER:C301(report_Get_target; $2)
	C_POINTER:C301(report_Get_target; $3)
	C_BOOLEAN:C305(report_Get_target; $4)
End if 

// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=3; "Missing parameter"))
	
	//Required parameters
	//$caller:=$1
	//$column:=$2
	//$row:=$3
	
	//Optional parameters
	If ($count_parameters>=4)
		
		// <NONE>
		//$get_data:=$4
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
$area:=OB Get:C1224($caller; "area"; Is longint:K8:6)

If (QR Get report kind:C755($area)=qr cross report:K14902:2)
	
	//#ACI0095708 {
	If ($get_data)
		
		$column_number:=OB Get:C1224($caller; "qrColumn"; Is longint:K8:6)
		
		//#ACI0095813
		If ($column_number=0)
			
			$column_number:=OB Get:C1224($caller; "columnIndex"; Is longint:K8:6)
			
		End if 
		
		$row_number:=OB Get:C1224($caller; "qrRow"; Is longint:K8:6)
		
	Else 
		//}
		
		$column_number:=OB Get:C1224($caller; "columnIndex"; Is longint:K8:6)
		$row_number:=OB Get:C1224($caller; "rowIndex"; Is longint:K8:6)
		
		If ($column_number=1)\
			 & ($row_number=1)
			
			$column_number:=0
			$row_number:=0
			
		End if 
	End if 
	
Else 
	
	$column_number:=OB Get:C1224($caller; "qrColumn"; Is longint:K8:6)
	$row_number:=OB Get:C1224($caller; "qrRow"; Is longint:K8:6)
	
End if 

// ----------------------------------------------------
// Return

$column->:=$column_number
$row->:=$row_number

return $area

// ----------------------------------------------------
// End