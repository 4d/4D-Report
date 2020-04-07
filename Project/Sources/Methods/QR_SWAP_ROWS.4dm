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
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)

C_LONGINT:C283($Lon_area;$Lon_i;$Lon_newPosition;$Lon_oldPosition;$Lon_parameters;$Lon_sortNumber)

If (False:C215)
	C_LONGINT:C283(QR_SWAP_ROWS ;$1)
	C_LONGINT:C283(QR_SWAP_ROWS ;$2)
	C_LONGINT:C283(QR_SWAP_ROWS ;$3)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

  //TRACE

If (Asserted:C1132($Lon_parameters>=3;"Missing parameter"))
	
	$Lon_area:=$1
	$Lon_oldPosition:=$2
	$Lon_newPosition:=$3
	
	ARRAY LONGINT:C221($tLon_sortedColumns;0x0000)
	ARRAY LONGINT:C221($tLon_sortOrder;0x0000)
	
	  //Get the sort order of each column of the quick report
	QR GET SORTS:C753($Lon_area;$tLon_sortedColumns;$tLon_sortOrder)
	
	$Lon_sortNumber:=Size of array:C274($tLon_sortedColumns)
	
	  //apply an offset 2 for the two first rows (title and detail)
	$Lon_oldPosition:=$Lon_oldPosition-2
	$Lon_newPosition:=$Lon_newPosition-2
	
	  //the sort order is inverted !
	ARRAY LONGINT:C221($tLon_order;$Lon_sortNumber)
	
	For ($Lon_i;1;$Lon_sortNumber;1)
		
		$tLon_order{$Lon_i}:=$Lon_i
		
	End for 
	
	SORT ARRAY:C229($tLon_order;$tLon_sortOrder;$tLon_sortedColumns;<)
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
  //The row can't be moved before the detail's line or after grand total's line
If ($Lon_newPosition>0)\
 & ($Lon_newPosition<=$Lon_sortNumber)
	
	If ($Lon_newPosition=$Lon_sortNumber)
		
		  //append a row at the end
		APPEND TO ARRAY:C911($tLon_sortedColumns;$tLon_sortedColumns{$Lon_oldPosition})
		APPEND TO ARRAY:C911($tLon_sortOrder;$tLon_sortOrder{$Lon_oldPosition})
		
	Else 
		
		  //apply an offset of 1 to the old position if it is greater than the new one
		$Lon_oldPosition:=$Lon_oldPosition+Num:C11($Lon_oldPosition>$Lon_newPosition)
		
		  //apply an offset of 1 to new position if it is greater than the old one
		$Lon_newPosition:=$Lon_newPosition+Num:C11($Lon_newPosition>$Lon_oldPosition)
		
		  //insert a row at the new position…
		INSERT IN ARRAY:C227($tLon_sortedColumns;$Lon_newPosition;1)
		INSERT IN ARRAY:C227($tLon_sortOrder;$Lon_newPosition;1)
		
		  //…and populate with source's datas
		$tLon_sortedColumns{$Lon_newPosition}:=$tLon_sortedColumns{$Lon_oldPosition}
		$tLon_sortOrder{$Lon_newPosition}:=$tLon_sortOrder{$Lon_oldPosition}
		
	End if 
	
	  //finally, delete the old row
	DELETE FROM ARRAY:C228($tLon_sortedColumns;$Lon_oldPosition;1)
	DELETE FROM ARRAY:C228($tLon_sortOrder;$Lon_oldPosition;1)
	
	  //reverse the array order
	ARRAY LONGINT:C221($tLon_order;$Lon_sortNumber)
	
	For ($Lon_i;1;$Lon_sortNumber;1)
		
		$tLon_order{$Lon_i}:=$Lon_i
		
	End for 
	
	SORT ARRAY:C229($tLon_order;$tLon_sortOrder;$tLon_sortedColumns;<)
	
	  //apply the new sort order
	QR SET SORTS:C752($Lon_area;$tLon_sortedColumns;$tLon_sortOrder)
	
End if 

  // ----------------------------------------------------
  // End