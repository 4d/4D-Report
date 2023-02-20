//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : QR_SWAP_ROWS
// Database: 4D Report
// ID[76B7A1F6E8FA441EB53C0860E7AC5FA3]
// Created #6-5-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations


#DECLARE($area : Integer; $old_position : Integer; $new_position : Integer)




var \
$count_parameters; \
$count_sorted_columns; \
$i : Integer

If (False:C215)
	C_LONGINT:C283(QR_SWAP_ROWS; $1)
	C_LONGINT:C283(QR_SWAP_ROWS; $2)
	C_LONGINT:C283(QR_SWAP_ROWS; $3)
End if 

// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

//TRACE

If (Asserted:C1132($count_parameters>=3; "Missing parameter"))
	
	//$area:=$1
	//$old_position:=$2
	//$new_position:=$3
	
	ARRAY LONGINT:C221($_sorted_columns; 0x0000)
	ARRAY LONGINT:C221($_sort_order; 0x0000)
	
	//Get the sort order of each column of the quick report
	QR GET SORTS:C753($area; $_sorted_columns; $_sort_order)
	
	$count_sorted_columns:=Size of array:C274($_sorted_columns)
	
	//apply an offset 2 for the two first rows (title and detail)
	$old_position:=$old_position-2
	$new_position:=$new_position-2
	
	//the sort order is inverted !
	ARRAY LONGINT:C221($_new_order; $count_sorted_columns)
	
	For ($i; 1; $count_sorted_columns; 1)
		
		$_new_order{$i}:=$i
		
	End for 
	
	SORT ARRAY:C229($_new_order; $_sort_order; $_sorted_columns; <)
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
//The row can't be moved before the detail's line or after grand total's line
If ($new_position>0)\
 & ($new_position<=$count_sorted_columns)
	
	If ($new_position=$count_sorted_columns)
		
		//append a row at the end
		APPEND TO ARRAY:C911($_sorted_columns; $_sorted_columns{$old_position})
		APPEND TO ARRAY:C911($_sort_order; $_sort_order{$old_position})
		
	Else 
		
		//apply an offset of 1 to the old position if it is greater than the new one
		$old_position:=$old_position+Num:C11($old_position>$new_position)
		
		//apply an offset of 1 to new position if it is greater than the old one
		$new_position:=$new_position+Num:C11($new_position>$old_position)
		
		//insert a row at the new position…
		INSERT IN ARRAY:C227($_sorted_columns; $new_position; 1)
		INSERT IN ARRAY:C227($_sort_order; $new_position; 1)
		
		//…and populate with source's datas
		$_sorted_columns{$new_position}:=$_sorted_columns{$old_position}
		$_sort_order{$new_position}:=$_sort_order{$old_position}
		
	End if 
	
	//finally, delete the old row
	DELETE FROM ARRAY:C228($_sorted_columns; $old_position; 1)
	DELETE FROM ARRAY:C228($_sort_order; $old_position; 1)
	
	//reverse the array order
	ARRAY LONGINT:C221($_new_order; $count_sorted_columns)
	
	For ($i; 1; $count_sorted_columns; 1)
		
		$_new_order{$i}:=$i
		
	End for 
	
	SORT ARRAY:C229($_new_order; $_sort_order; $_sorted_columns; <)
	
	//apply the new sort order
	QR SET SORTS:C752($area; $_sorted_columns; $_sort_order)
	
End if 

// ----------------------------------------------------
// End