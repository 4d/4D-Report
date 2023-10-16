//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : QR_Get_border_properties
  // Database: 4D Report
  // Created #30-8-2019 by Adrien Cagniant
  // ----------------------------------------------------
  // Description:
  //$0:=$obj_border
  //$Lon_area:=$1
  //$Lon_column:=$2
  //$Lon_row:=$3
  // ----------------------------------------------------
  // Declarations

C_LONGINT:C283($Lon_area;$Lon_parameters;$Lon_column;$Lon_row;$lon_border;$lon_affected;$lon_rowCount)
C_LONGINT:C283($lon_thickness;$lon_color;$Lon_i;$lon_thicknessBuffer;$lon_colorBuffer;$lon_lastRow;$lon_columnCount)
C_OBJECT:C1216($Obj_caller;$obj_border;$obj_borderItem)
C_POINTER:C301($Ptr_caller)
C_BOOLEAN:C305($boo_sameThickness;$boo_sameColor;$boo_withGrandTotal)
C_COLLECTION:C1488($col_borders)
C_TEXT:C284($txt_borderBuffer;$Txt_content)

ARRAY REAL:C219($_arrColumns;0)
ARRAY REAL:C219($_arrOrders;0)

If (False:C215)
	C_OBJECT:C1216(QR_Get_border_properties ;$0)
	C_LONGINT:C283(QR_Get_border_properties ;$1)
	C_LONGINT:C283(QR_Get_border_properties ;$2)
	C_LONGINT:C283(QR_Get_border_properties ;$3)
	
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //Required parameters
	$Lon_area:=$1
	
	
	  //Optional parameters
	If ($Lon_parameters>=2)
		
		$Lon_column:=$2
		
		If ($Lon_parameters>=3)
			
			$Lon_row:=$3
			
		End if 
	End if 
	
	
	
	
Else 
	
	ABORT:C156
	
End if 



If ($Lon_area#0)
	
	Case of 
			
		: (($Lon_column#0) & ($Lon_row#0))  // for single cell
			
			  // we are in a line or in a loop
			
/*
$obj_border := 
			
{
"bottom":{"thickness":int;"color":int},
"insideHorizontal":{"thickness":int;"color":int},
"insideVertical":{"thickness":int;"color":int},
"left":{"thickness":int;"color":int},
"right":{"thickness":int;"color":int},
"top":{"thickness":int;"color":int},
“sameColor":bool,
“sameThickness":bool,
"colorToSet":int,
"thicknessToSet":int
}
			
*/
			
			QR GET BORDERS:C798($Lon_area;$Lon_column;$Lon_row;qr bottom border:K14908:4;$lon_thickness;$lon_color)
			$obj_border:=New object:C1471("bottom";New object:C1471("thickness";$lon_thickness;"color";$lon_color))
			
			QR GET BORDERS:C798($Lon_area;$Lon_column;$Lon_row;qr inside horizontal border:K14908:6;$lon_thickness;$lon_color)
			$obj_border.insideHorizontal:=New object:C1471("thickness";$lon_thickness;"color";$lon_color)
			
			QR GET BORDERS:C798($Lon_area;$Lon_column;$Lon_row;qr inside vertical border:K14908:5;$lon_thickness;$lon_color)
			$obj_border.insideVertical:=New object:C1471("thickness";$lon_thickness;"color";$lon_color)
			
			QR GET BORDERS:C798($Lon_area;$Lon_column;$Lon_row;qr left border:K14908:1;$lon_thickness;$lon_color)
			$obj_border.left:=New object:C1471("thickness";$lon_thickness;"color";$lon_color)
			
			QR GET BORDERS:C798($Lon_area;$Lon_column;$Lon_row;qr right border:K14908:3;$lon_thickness;$lon_color)
			$obj_border.right:=New object:C1471("thickness";$lon_thickness;"color";$lon_color)
			
			QR GET BORDERS:C798($Lon_area;$Lon_column;$Lon_row;qr top border:K14908:2;$lon_thickness;$lon_color)
			$obj_border.top:=New object:C1471("thickness";$lon_thickness;"color";$lon_color)
			
			
			  //check whether the thickness is the same
			$boo_sameThickness:=True:C214
			$lon_thicknessBuffer:=5
			
			For each ($txt_borderBuffer;$obj_border)
				
				If (OB Get:C1224($obj_border;$txt_borderBuffer).thickness#0)
					
					$lon_thicknessBuffer:=Choose:C955($lon_thicknessBuffer=5;OB Get:C1224($obj_border;$txt_borderBuffer).thickness;$lon_thicknessBuffer)
					$boo_sameThickness:=(($lon_thicknessBuffer=OB Get:C1224($obj_border;$txt_borderBuffer).thickness) & $boo_sameThickness)
					
				End if 
				
			End for each 
			
			  //check whether the color is the same
			$boo_sameColor:=True:C214
			$lon_colorBuffer:=-2
			
			For each ($txt_borderBuffer;$obj_border)
				
				If (OB Get:C1224($obj_border;$txt_borderBuffer).thickness#0)
					
					$lon_colorBuffer:=Choose:C955($lon_colorBuffer=-2;OB Get:C1224($obj_border;$txt_borderBuffer).color;$lon_colorBuffer)
					$boo_sameColor:=(($lon_colorBuffer=OB Get:C1224($obj_border;$txt_borderBuffer).color) & $boo_sameColor)
					
				End if 
				
			End for each 
			
			  // set the properties
			$obj_border.sameColor:=$boo_sameColor
			$obj_border.sameThickness:=$boo_sameThickness
			
			
			If ($boo_sameThickness)  // if border is the same we take the non null value
				
				ARRAY LONGINT:C221($_Thickness;6)
				$_Thickness{1}:=$obj_border.left.thickness
				$_Thickness{2}:=$obj_border.insideVertical.thickness
				$_Thickness{3}:=$obj_border.insideHorizontal.thickness
				$_Thickness{4}:=$obj_border.bottom.thickness
				$_Thickness{5}:=$obj_border.top.thickness
				$_Thickness{6}:=$obj_border.right.thickness
				
				  //we take the max in order to not take the 0 value
				$obj_border.thicknessToSet:=Choose:C955((Max:C3($_Thickness))=0;1;(Max:C3($_Thickness)))
				
			Else 
				  // default value is hairline (1)
				$obj_border.thicknessToSet:=1
				
			End if 
			
			
			If ($boo_sameColor)  // if border is the same we take the non null value
				
				
				$obj_border.colorToSet:=Choose:C955($lon_colorBuffer#-2;$lon_colorBuffer;0)
				
			Else 
				
				
				  // default value is black (0)
				$obj_border.colorToSet:=0
				
			End if 
			
			
			
		Else 
			
			
			  // setting constants
			$lon_columnCount:=QR Count columns:C764($Lon_area)
			
			  //which line is the last
			$boo_withGrandTotal:=False:C215
			
			If (QR Get report kind:C755($Lon_area)=qr list report:K14902:1)
				For ($Lon_i;1;$lon_columnCount)
					
					$Txt_content:=QR_Get_cell_text ($Lon_area;$Lon_i;qr grand total:K14906:3)
					$boo_withGrandTotal:=($Txt_content#"") | ($boo_withGrandTotal)
					
				End for 
				
				$lon_lastRow:=Choose:C955($boo_withGrandTotal;qr grand total:K14906:3;qr detail:K14906:2)
				  // we are starting from -3 grand total if any or -2 details, or 1 if QR is a cross table report
				
				QR GET SORTS:C753($Lon_area;$_arrColumns;$_arrOrders)
				$lon_rowCount:=Size of array:C274($_arrColumns)
				
			Else 
				$lon_lastRow:=1
				$lon_rowCount:=$lon_columnCount
				
			End if 
			
			Case of 
					
				: (($Lon_column=0) & ($Lon_row=0))  // global cells
					
					$col_borders:=New collection:C1472
					
					For ($Lon_row;$lon_lastRow;$lon_rowCount)
						
						If ($Lon_row#0)
							
							For ($Lon_column;1;$lon_columnCount)
								
								$obj_border:=QR_Get_border_properties ($Lon_area;$Lon_column;$Lon_row)
								$col_borders.push($obj_border)
								
							End for 
							
						End if 
						
					End for 
					
					$obj_border:=QR_returnBorderFromCollection ($col_borders;$obj_border)
					
				: ($Lon_column=0)  //  cells in a row
					
					$col_borders:=New collection:C1472
					
					For ($Lon_column;1;$lon_columnCount)
						
						$obj_border:=QR_Get_border_properties ($Lon_area;$Lon_column;$Lon_row)
						$col_borders.push($obj_border)
						
					End for 
					
					$obj_border:=QR_returnBorderFromCollection ($col_borders;$obj_border)
					
				: ($Lon_row=0)  // cells in a column 
					
					$col_borders:=New collection:C1472
					
					For ($Lon_row;$lon_lastRow;$lon_rowCount)
						
						If ($Lon_row#0)
							
							$obj_border:=QR_Get_border_properties ($Lon_area;$Lon_column;$Lon_row)
							$col_borders.push($obj_border)
							
						End if 
						
					End for 
					
					$obj_border:=QR_returnBorderFromCollection ($col_borders;$obj_border)
					
			End case 
	End case 
	
End if 

$0:=$obj_border
