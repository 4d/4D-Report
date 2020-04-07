//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : QR_SET_BORDER_PROPERTIES
  // Database: 4D Report
  // Created #30-8-2019 by Adrien Cagniant
  // ----------------------------------------------------
  // Description:
  //$Lon_area:=$1
  //$obj_border:=$2
  //$Lon_column:=$3
  //$Lon_row:=$4

  // ----------------------------------------------------
  // Declarations

C_LONGINT:C283($Lon_area;$Lon_parameters;$Lon_column;$Lon_row;$Lon_i;$lon_columnCount;$lon_thickness;$lon_color)
C_LONGINT:C283($lon_lastRow;$lon_rowsCount;$lon_lastColumn)
C_OBJECT:C1216($obj_border;$obj_subBorder)
C_BOOLEAN:C305($boo_withGrandTotal)
ARRAY REAL:C219($_arrColumns;0)
ARRAY REAL:C219($_arrOrders;0)
C_TEXT:C284($Txt_content)

If (False:C215)
	
	C_LONGINT:C283(QR_SET_BORDER_PROPERTIES ;$1)
	C_OBJECT:C1216(QR_SET_BORDER_PROPERTIES ;$2)
	C_LONGINT:C283(QR_SET_BORDER_PROPERTIES ;$3)
	C_LONGINT:C283(QR_SET_BORDER_PROPERTIES ;$4)
	
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=4;"Missing parameter"))
	
	  //Required parameters
	
	$Lon_area:=$1
	$obj_border:=$2
	$Lon_column:=$3
	$Lon_row:=$4
	
Else 
	
	ABORT:C156
	
End if 


Case of 
		  //________________________________________
	: (Not:C34(QR_is_valid_area ($Lon_area)))
		
		  //NOTHING MORE TO DO
		
	Else 
		If (Not:C34($obj_border=Null:C1517))
			
			Case of 
					
				: (($Lon_column#0) & ($Lon_row#0))  // for single cell
					
					If (($obj_border.bottom.thickness#0) | ($obj_border.thicknessToSet=0))
						  //if the border position is set and the popup is # than no bordure
						
						QR GET BORDERS:C798($Lon_area;$Lon_column;$Lon_row;qr bottom border:K14908:4;$lon_thickness;$lon_color)
						
						Case of 
							: ($obj_border.colorToSet=-1) & ($obj_border.thicknessToSet=-1)
								  // both are multiples -> basically we do nothing
								
							: ($obj_border.colorToSet#-1) & ($obj_border.thicknessToSet#-1)
								  //color and thickness are defined (not multiple)
								
								$lon_thickness:=$obj_border.thicknessToSet
								$lon_color:=$obj_border.colorToSet
								
							: ($obj_border.colorToSet=-1)
								  // color is multiple
								
								$lon_thickness:=$obj_border.thicknessToSet
								
							: ($obj_border.thicknessToSet=-1)
								  // thickness is multiple
								
								$lon_color:=$obj_border.colorToSet
								
						End case 
						
						QR SET BORDERS:C797($Lon_area;$Lon_column;$Lon_row;qr bottom border:K14908:4;$lon_thickness;$lon_color)
						
					End if 
					
					  //________________________________________
					If (($obj_border.insideHorizontal.thickness#0) | ($obj_border.thicknessToSet=0))
						
						QR GET BORDERS:C798($Lon_area;$Lon_column;$Lon_row;qr inside horizontal border:K14908:6;$lon_thickness;$lon_color)
						
						Case of 
							: ($obj_border.colorToSet=-1) & ($obj_border.thicknessToSet=-1)
								
								
							: ($obj_border.colorToSet#-1) & ($obj_border.thicknessToSet#-1)
								
								$lon_thickness:=$obj_border.thicknessToSet
								$lon_color:=$obj_border.colorToSet
								
							: ($obj_border.colorToSet=-1)
								
								$lon_thickness:=$obj_border.thicknessToSet
								
							: ($obj_border.thicknessToSet=-1)
								
								$lon_color:=$obj_border.colorToSet
								
						End case 
						
						QR SET BORDERS:C797($Lon_area;$Lon_column;$Lon_row;qr inside horizontal border:K14908:6;$lon_thickness;$lon_color)
						
					End if 
					
					  //________________________________________
					If (($obj_border.insideVertical.thickness#0) | ($obj_border.thicknessToSet=0))
						
						QR GET BORDERS:C798($Lon_area;$Lon_column;$Lon_row;qr inside vertical border:K14908:5;$lon_thickness;$lon_color)
						
						Case of 
							: ($obj_border.colorToSet=-1) & ($obj_border.thicknessToSet=-1)
								
								
							: ($obj_border.colorToSet#-1) & ($obj_border.thicknessToSet#-1)
								
								$lon_thickness:=$obj_border.thicknessToSet
								$lon_color:=$obj_border.colorToSet
								
							: ($obj_border.colorToSet=-1)
								
								$lon_thickness:=$obj_border.thicknessToSet
								
							: ($obj_border.thicknessToSet=-1)
								
								$lon_color:=$obj_border.colorToSet
								
						End case 
						
						QR SET BORDERS:C797($Lon_area;$Lon_column;$Lon_row;qr inside vertical border:K14908:5;$lon_thickness;$lon_color)
						
					End if 
					
					  //________________________________________
					If (($obj_border.left.thickness#0) | ($obj_border.thicknessToSet=0))
						
						QR GET BORDERS:C798($Lon_area;$Lon_column;$Lon_row;qr left border:K14908:1;$lon_thickness;$lon_color)
						
						Case of 
							: ($obj_border.colorToSet=-1) & ($obj_border.thicknessToSet=-1)
								
							: ($obj_border.colorToSet#-1) & ($obj_border.thicknessToSet#-1)
								
								$lon_thickness:=$obj_border.thicknessToSet
								$lon_color:=$obj_border.colorToSet
								
							: ($obj_border.colorToSet=-1)
								
								$lon_thickness:=$obj_border.thicknessToSet
								
							: ($obj_border.thicknessToSet=-1)
								
								$lon_color:=$obj_border.colorToSet
								
						End case 
						
						QR SET BORDERS:C797($Lon_area;$Lon_column;$Lon_row;qr left border:K14908:1;$lon_thickness;$lon_color)
						
					End if 
					
					  //________________________________________
					If (($obj_border.right.thickness#0) | ($obj_border.thicknessToSet=0))
						
						QR GET BORDERS:C798($Lon_area;$Lon_column;$Lon_row;qr right border:K14908:3;$lon_thickness;$lon_color)
						
						Case of 
							: ($obj_border.colorToSet=-1) & ($obj_border.thicknessToSet=-1)
								
							: ($obj_border.colorToSet#-1) & ($obj_border.thicknessToSet#-1)
								
								$lon_thickness:=$obj_border.thicknessToSet
								$lon_color:=$obj_border.colorToSet
								
							: ($obj_border.colorToSet=-1)
								
								$lon_thickness:=$obj_border.thicknessToSet
								
							: ($obj_border.thicknessToSet=-1)
								
								$lon_color:=$obj_border.colorToSet
								
						End case 
						
						QR SET BORDERS:C797($Lon_area;$Lon_column;$Lon_row;qr right border:K14908:3;$lon_thickness;$lon_color)
						
					End if 
					
					  //________________________________________
					If (($obj_border.top.thickness#0) | ($obj_border.thicknessToSet=0))
						
						QR GET BORDERS:C798($Lon_area;$Lon_column;$Lon_row;qr top border:K14908:2;$lon_thickness;$lon_color)
						
						Case of 
							: ($obj_border.colorToSet=-1) & ($obj_border.thicknessToSet=-1)
								
							: ($obj_border.colorToSet#-1) & ($obj_border.thicknessToSet#-1)
								
								$lon_thickness:=$obj_border.thicknessToSet
								$lon_color:=$obj_border.colorToSet
								
							: ($obj_border.colorToSet=-1)
								
								$lon_thickness:=$obj_border.thicknessToSet
								
							: ($obj_border.thicknessToSet=-1)
								
								$lon_color:=$obj_border.colorToSet
								
						End case 
						
						QR SET BORDERS:C797($Lon_area;$Lon_column;$Lon_row;qr top border:K14908:2;$lon_thickness;$lon_color)
						
					End if 
					
				Else 
					
					  // setting variables
					$lon_columnCount:=QR Count columns:C764($Lon_area)
					
					
					If (QR Get report kind:C755($Lon_area)=qr list report:K14902:1)
						  // if QR is list report
						
						QR GET SORTS:C753($Lon_area;$_arrColumns;$_arrOrders)
						$lon_rowsCount:=Size of array:C274($_arrColumns)
						
						  //which line is the last
						$boo_withGrandTotal:=False:C215
						For ($Lon_i;1;$lon_columnCount)
							
							$Txt_content:=QR_Get_cell_text ($Lon_area;$Lon_i;qr grand total:K14906:3)
							$boo_withGrandTotal:=($Txt_content#"") | ($boo_withGrandTotal)
							
						End for 
						
						$lon_lastRow:=Choose:C955($boo_withGrandTotal;qr grand total:K14906:3;qr detail:K14906:2)
						
					Else 
						  // if QR is cross table report
						
						$lon_lastRow:=1
						$lon_rowsCount:=$lon_columnCount
						
					End if 
					
					
					Case of 
							  //________________________________________
						: (($Lon_column=0) & ($Lon_row=0))  // global cells
							
							  // we are start
							
							For ($Lon_row;$lon_lastRow;$lon_rowsCount)
								If ($Lon_row#0)
									
									For ($Lon_column;1;$lon_columnCount)
										
										$obj_subBorder:=OB Copy:C1225($obj_border)
										
										If ($obj_border.insideVertical.thickness=0)  // outside borders
											
											$obj_subBorder.left.thickness:=0
											$obj_subBorder.right.thickness:=0
											
											If ($Lon_column=1)
												
												$obj_subBorder.left.thickness:=$obj_border.left.thickness
												
											End if 
											
											If ($Lon_column=$lon_columnCount)
												
												$obj_subBorder.right.thickness:=$obj_border.right.thickness
												
											End if 
										End if 
										
										If ($obj_border.insideHorizontal.thickness=0)  // outside borders
											
											$obj_subBorder.bottom.thickness:=0
											$obj_subBorder.top.thickness:=0
											
											If (($lon_rowsCount>0) & (Not:C34($boo_withGrandTotal)))
												  //if there is subtotals and no grand total
												If ($Lon_row=$lon_rowsCount)
													
													$obj_subBorder.bottom.thickness:=$obj_border.bottom.thickness
													
												End if 
												
											Else 
												  // grand total or details are at the bottom 
												If ($Lon_row=$lon_lastRow)
													
													$obj_subBorder.bottom.thickness:=$obj_border.bottom.thickness
													
												End if 
											End if 
											
											If ($Lon_row=qr title:K14906:1)
												
												$obj_subBorder.top.thickness:=$obj_border.top.thickness
												
											End if 
											
										End if 
										
										If (($obj_border.left.thickness=0) & ($obj_border.left.thickness=0)\
											 & ($obj_border.left.thickness=0) & ($obj_border.left.thickness=0))  // inside borders
											
											
											If ($Lon_column#1)
												
												$obj_subBorder.left.thickness:=$obj_border.insideVertical.thickness
												
											End if 
											
											If ($Lon_column#$lon_columnCount)
												
												$obj_subBorder.right.thickness:=$obj_border.insideVertical.thickness
												
											End if 
											
											If ($Lon_row#$lon_lastRow)
												
												$obj_subBorder.bottom.thickness:=$obj_border.insideHorizontal.thickness
												
											End if 
											
											If ($Lon_row#qr title:K14906:1)
												
												$obj_subBorder.top.thickness:=$obj_border.insideHorizontal.thickness
												
											End if 
											
										End if 
										
										QR_SET_BORDER_PROPERTIES ($Lon_area;$obj_subBorder;$Lon_column;$Lon_row)
										
									End for 
								End if 
								
							End for 
							
							  //________________________________________
						: ($Lon_column=0)  //  We are in row section
							
							For ($Lon_column;1;$lon_columnCount)
								
								$obj_subBorder:=OB Copy:C1225($obj_border)
								
								If ($obj_subBorder.insideVertical.thickness=0)
									
									$obj_subBorder.left.thickness:=0
									$obj_subBorder.right.thickness:=0
									
									If ($Lon_column=1)
										
										$obj_subBorder.left.thickness:=$obj_border.left.thickness
										
									End if 
									
									If ($Lon_column=$lon_columnCount)
										
										$obj_subBorder.right.thickness:=$obj_border.right.thickness
										
									End if 
									
								End if 
								
								QR_SET_BORDER_PROPERTIES ($Lon_area;$obj_subBorder;$Lon_column;$Lon_row)
								
								
								
							End for 
							
						: ($Lon_row=0)  // we are in a column 
							
							For ($Lon_row;$lon_lastRow;$lon_rowsCount)
								
								If ($Lon_row#0)
									
									
									$obj_subBorder:=OB Copy:C1225($obj_border)
									
									If ($obj_border.insideHorizontal.thickness=0)
										
										$obj_subBorder.bottom.thickness:=0
										$obj_subBorder.top.thickness:=0
										
										
										If (($lon_rowsCount>0) & (Not:C34($boo_withGrandTotal)))
											  //if there is subtotals and no grand total
											If ($Lon_row=$lon_rowsCount)
												
												$obj_subBorder.bottom.thickness:=$obj_border.bottom.thickness
												
											End if 
											
										Else 
											  // grand total or details are at the bottom 
											If ($Lon_row=$lon_lastRow)
												
												$obj_subBorder.bottom.thickness:=$obj_border.bottom.thickness
												
											End if 
										End if 
										
										
										If ($Lon_row=qr title:K14906:1)
											
											$obj_subBorder.top.thickness:=$obj_border.top.thickness
											
										End if 
										
									End if 
									
									
/*
									
									
									
									
If ($obj_border.insideVertical.thickness=0)  // outside borders
									
$obj_subBorder.left.thickness:=0
$obj_subBorder.right.thickness:=0
									
If ($Lon_column=1)
									
$obj_subBorder.left.thickness:=$obj_border.left.thickness
									
End if 
									
If ($Lon_column=$lon_columnCount)
									
$obj_subBorder.right.thickness:=$obj_border.right.thickness
									
End if 
End if 
*/
									
									
									If (($obj_border.left.thickness=0) & ($obj_border.left.thickness=0)\
										 & ($obj_border.left.thickness=0) & ($obj_border.left.thickness=0))  // inside borders
										
										
										If ($Lon_row#$lon_lastRow)
											
											$obj_subBorder.bottom.thickness:=$obj_border.insideHorizontal.thickness
											
										End if 
										
										If ($Lon_row#qr title:K14906:1)
											
											$obj_subBorder.top.thickness:=$obj_border.insideHorizontal.thickness
											
										End if 
										
									End if 
									
									QR_SET_BORDER_PROPERTIES ($Lon_area;$obj_subBorder;$Lon_column;$Lon_row)
									
								End if 
								
							End for 
							
							
							
							  //________________________________________
							
							
					End case 
			End case 
			
		Else 
			  // never goes here
			
			TRACE:C157
			
		End if 
End case 




