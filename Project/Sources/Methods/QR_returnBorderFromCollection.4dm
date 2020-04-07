//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : QR_returnBorderFromCollection
  // Database: 4D Report
  // Created #15-10-2019 by Adrien Cagniant
  // ----------------------------------------------------
  // Description:
  //$col_border:=$1
  //$obj_border:=$0
  //
  // ----------------------------------------------------
  // Declarations
C_COLLECTION:C1488($col_borders)
C_LONGINT:C283($Lon_parameters)
C_OBJECT:C1216($obj_borderItem;$obj_border)


If (False:C215)
	C_OBJECT:C1216(QR_returnBorderFromCollection ;$0)
	C_COLLECTION:C1488(QR_returnBorderFromCollection ;$1)
	C_OBJECT:C1216(QR_returnBorderFromCollection ;$2)
	
End if 
  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //Required parameters
	$col_borders:=$1
	$obj_border:=$2
	
	
Else 
	
	ABORT:C156
	
End if 



  //check if same thickness/color in each border
For each ($obj_borderItem;$col_borders)
	
	If ($obj_borderItem.thicknessToSet#$obj_border.thicknessToSet)
		
		$obj_border.sameThickness:=False:C215
		$obj_border.thicknessToSet:=1
		
	End if 
	
	If ($obj_borderItem.colorToSet#$obj_border.colorToSet)
		
		$obj_border.sameColor:=False:C215
		$obj_border.colorToSet:=0
		
	End if 
	
	
	If ($obj_borderItem.left.thickness#0)
		$obj_border.left.thickness:=$obj_borderItem.left.thickness
	End if 
	
	If ($obj_borderItem.right.thickness#0)
		$obj_border.right.thickness:=$obj_borderItem.right.thickness
	End if 
	
	If ($obj_borderItem.top.thickness#0)
		$obj_border.top.thickness:=$obj_borderItem.top.thickness
	End if 
	
	If ($obj_borderItem.bottom.thickness#0)
		$obj_border.bottom.thickness:=$obj_borderItem.bottom.thickness
	End if 
	
	
End for each 


$0:=$obj_border