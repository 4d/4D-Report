//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : QR_Get_computation
  // Database: 4D Report
  // ID[6DD9FECFD0CC44ABA2DEB38A68BB585C]
  // Created #18-11-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)

C_BOOLEAN:C305($Boo_average;$Boo_count;$Boo_deviation;$Boo_max;$Boo_min;$Boo_sum)
C_LONGINT:C283($Lon_area;$Lon_column;$Lon_columnNumber;$Lon_computation;$Lon_parameters;$Lon_row)
C_TEXT:C284($Txt_data)

If (False:C215)
	C_LONGINT:C283(QR_Get_computation ;$0)
	C_LONGINT:C283(QR_Get_computation ;$1)
	C_LONGINT:C283(QR_Get_computation ;$2)
	C_LONGINT:C283(QR_Get_computation ;$3)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	$Lon_area:=$1
	
	If ($Lon_parameters>=2)
		
		$Lon_column:=$2
		
		If ($Lon_parameters>=3)
			
			$Lon_row:=$3
			
		End if 
	End if 
	
	$Lon_computation:=-1  //disparate
	
	$Boo_sum:=True:C214
	$Boo_average:=True:C214
	$Boo_min:=True:C214
	$Boo_max:=True:C214
	$Boo_count:=True:C214
	$Boo_deviation:=True:C214
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
Case of 
		
		  //________________________________________
	: ($Lon_column=0)\
		 & ($Lon_row=0)  //compute the area to find a common value
		
		  //NOT USED
		
		  //________________________________________
	: ($Lon_column=0)  //compute the line to find a common value
		
		$Lon_columnNumber:=QR Count columns:C764($Lon_area)
		
		If ($Lon_columnNumber>0)
			
			  //TRACE
			
			For ($Lon_column;1;$Lon_columnNumber;1)
				
				QR GET TOTALS DATA:C768($Lon_area;$Lon_column;$Lon_row;$Lon_computation;$Txt_data)
				
				$Boo_sum:=$Boo_sum & ($Lon_computation ?? 0)  //1
				$Boo_average:=$Boo_average & ($Lon_computation ?? 1)  //2
				$Boo_min:=$Boo_min & ($Lon_computation ?? 2)  //4
				$Boo_max:=$Boo_max & ($Lon_computation ?? 3)  //8
				$Boo_count:=$Boo_count & ($Lon_computation ?? 4)  //16
				$Boo_deviation:=$Boo_deviation & ($Lon_computation ?? 5)  //32
				
			End for 
			
			$Lon_computation:=Num:C11($Boo_sum)\
				+(Num:C11($Boo_average)*2)\
				+(Num:C11($Boo_min)*4)\
				+(Num:C11($Boo_max)*8)\
				+(Num:C11($Boo_count)*16)\
				+(Num:C11($Boo_deviation)*32)
			
		End if 
		
		  //________________________________________
	: ($Lon_row=0)  //compute the column to find a common style value
		
		  //NOT USED
		
		  //________________________________________
	Else   //get the cell value
		
		QR GET TOTALS DATA:C768($Lon_area;$Lon_column;$Lon_row;$Lon_computation;$Txt_data)
		
		  //________________________________________
End case 

$0:=$Lon_computation

  // ----------------------------------------------------
  // End