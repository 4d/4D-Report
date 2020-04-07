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
C_LONGINT:C283($0)
C_OBJECT:C1216($1)
C_POINTER:C301($2)
C_POINTER:C301($3)
C_BOOLEAN:C305($4)

C_BOOLEAN:C305($Boo_data)
C_LONGINT:C283($Lon_area;$Lon_column;$Lon_parameters;$Lon_row)
C_POINTER:C301($Ptr_column;$Ptr_row)
C_OBJECT:C1216($Obj_caller)

If (False:C215)
	C_LONGINT:C283(report_Get_target ;$0)
	C_OBJECT:C1216(report_Get_target ;$1)
	C_POINTER:C301(report_Get_target ;$2)
	C_POINTER:C301(report_Get_target ;$3)
	C_BOOLEAN:C305(report_Get_target ;$4)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=3;"Missing parameter"))
	
	  //Required parameters
	$Obj_caller:=$1
	$Ptr_column:=$2
	$Ptr_row:=$3
	
	  //Optional parameters
	If ($Lon_parameters>=4)
		
		  // <NONE>
		$Boo_data:=$4
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
$Lon_area:=OB Get:C1224($Obj_caller;"area";Is longint:K8:6)

If (QR Get report kind:C755($Lon_area)=qr cross report:K14902:2)
	
	  //#ACI0095708 {
	If ($Boo_data)
		
		$Lon_column:=OB Get:C1224($Obj_caller;"qrColumn";Is longint:K8:6)
		
		  //#ACI0095813
		If ($Lon_column=0)
			
			$Lon_column:=OB Get:C1224($Obj_caller;"columnIndex";Is longint:K8:6)
			
		End if 
		
		$Lon_row:=OB Get:C1224($Obj_caller;"qrRow";Is longint:K8:6)
		
	Else 
		  //}
		
		$Lon_column:=OB Get:C1224($Obj_caller;"columnIndex";Is longint:K8:6)
		$Lon_row:=OB Get:C1224($Obj_caller;"rowIndex";Is longint:K8:6)
		
		If ($Lon_column=1)\
			 & ($Lon_row=1)
			
			$Lon_column:=0
			$Lon_row:=0
			
		End if 
	End if 
	
Else 
	
	$Lon_column:=OB Get:C1224($Obj_caller;"qrColumn";Is longint:K8:6)
	$Lon_row:=OB Get:C1224($Obj_caller;"qrRow";Is longint:K8:6)
	
End if 

  // ----------------------------------------------------
  // Return
$0:=$Lon_area

$Ptr_column->:=$Lon_column
$Ptr_row->:=$Lon_row

  // ----------------------------------------------------
  // End