//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : QR_SWAP_COLUMNS
  // Database: 4D Report
  // ID[FD8A838D4ACB419380B42E712D55C461]
  // Created #25-3-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)

C_LONGINT:C283($Lon_area;$Lon_columnNumber;$Lon_hide;$Lon_i;$Lon_newPosition;$Lon_oldPosition;$Lon_parameters;$Lon_repeated)
C_LONGINT:C283($Lon_size;$Lon_sortIndex;$Lon_sortNumber)
C_TEXT:C284($Txt_format;$Txt_formula;$Txt_object;$Txt_title)

ARRAY OBJECT:C1221($tObj_rows;0)

If (False:C215)
	C_LONGINT:C283(QR_SWAP_COLUMNS ;$1)
	C_LONGINT:C283(QR_SWAP_COLUMNS ;$2)
	C_LONGINT:C283(QR_SWAP_COLUMNS ;$3)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=2;"Missing parameter"))
	
	$Lon_area:=$1
	
	$Lon_oldPosition:=$2
	$Lon_newPosition:=$3
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
$Lon_columnNumber:=QR Count columns:C764($Lon_area)

If ($Lon_newPosition<=$Lon_columnNumber)
	
	  //Retrieve all properties of the moved column
	QR GET INFO COLUMN:C766($Lon_area;$Lon_oldPosition;\
		$Txt_title;\
		$Txt_object;\
		$Lon_hide;\
		$Lon_size;\
		$Lon_repeated;\
		$Txt_format;\
		$Txt_formula)
	
	OB SET:C1220($tObj_rows{0};\
		"title";$Txt_title;\
		"Object";$Txt_object;\
		"hide";$Lon_hide;\
		"size";$Lon_size;\
		"repeated";$Lon_repeated;\
		"format";$Txt_format;\
		"formula";$Txt_formula)
	
	APPEND TO ARRAY:C911($tObj_rows;QR_Get_cell_object ($Lon_area;$Lon_oldPosition;qr title:K14906:1))
	APPEND TO ARRAY:C911($tObj_rows;QR_Get_cell_object ($Lon_area;$Lon_oldPosition;qr detail:K14906:2))
	
	ARRAY LONGINT:C221($tLon_sortedColumns;0x0000)
	ARRAY LONGINT:C221($tLon_sortOrder;0x0000)
	QR GET SORTS:C753($Lon_area;$tLon_sortedColumns;$tLon_sortOrder)
	$Lon_sortNumber:=Size of array:C274($tLon_sortedColumns)
	
	For ($Lon_i;1;$Lon_sortNumber;1)
		
		APPEND TO ARRAY:C911($tObj_rows;QR_Get_cell_object ($Lon_area;$Lon_oldPosition;$Lon_i))
		
	End for 
	
	APPEND TO ARRAY:C911($tObj_rows;QR_Get_cell_object ($Lon_area;$Lon_oldPosition;qr grand total:K14906:3))
	
	  //Delete the moved column
	QR DELETE COLUMN:C749($Lon_area;$Lon_oldPosition)
	
	  //Create a new column at the drop position
	QR INSERT COLUMN:C748($Lon_area;$Lon_newPosition;$Txt_object)
	QR SET INFO COLUMN:C765($Lon_area;$Lon_newPosition;\
		$Txt_title;\
		Choose:C955(Length:C16($Txt_formula)>0;$Txt_formula;$Txt_object);\
		$Lon_hide;\
		$Lon_size;\
		$Lon_repeated;\
		$Txt_format)
	
	QR SET SELECTION:C794($Lon_area;$Lon_newPosition;0;$Lon_newPosition;0)
	
	  //Don't forget the sort, if any
	$Lon_sortIndex:=Find in array:C230($tLon_sortedColumns;$Lon_oldPosition)
	
	If ($Lon_sortIndex>0)
		
		  //Keep the sort order
		$tLon_sortOrder{0}:=$tLon_sortOrder{$Lon_sortIndex}
		
		  //Shift the following columns, if any
		For ($Lon_i;$Lon_sortIndex;$Lon_sortNumber;1)
			
			$tLon_sortedColumns{$Lon_i}:=$tLon_sortedColumns{$Lon_i}-1
			
		End for 
		
		  //Remove the old entry
		DELETE FROM ARRAY:C228($tLon_sortedColumns;$Lon_sortIndex;1)
		DELETE FROM ARRAY:C228($tLon_sortOrder;$Lon_sortIndex;1)
		
		  //Place the new column at the end of the sort's arrays
		APPEND TO ARRAY:C911($tLon_sortedColumns;$Lon_newPosition)
		APPEND TO ARRAY:C911($tLon_sortOrder;$tLon_sortOrder{0})
		
		QR SET SORTS:C752($Lon_area;$tLon_sortedColumns;$tLon_sortOrder)
		
	End if 
	
	  //Restore the cells' properties
	QR_SET_CELL_OBJECT ($Lon_area;$tObj_rows{1};$Lon_newPosition;qr title:K14906:1)
	QR_SET_CELL_OBJECT ($Lon_area;$tObj_rows{2};$Lon_newPosition;qr detail:K14906:2)
	
	For ($Lon_i;1;$Lon_sortNumber;1)
		
		QR_SET_CELL_OBJECT ($Lon_area;$tObj_rows{$Lon_i+2};$Lon_newPosition;$Lon_i)
		
	End for 
	
	QR_SET_CELL_OBJECT ($Lon_area;$tObj_rows{Size of array:C274($tObj_rows)};$Lon_newPosition;qr grand total:K14906:3)
	
End if 

  // ----------------------------------------------------
  // End