//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : QR_MENU_CELLS
  // ID[CD716DA47F8141328007EBD2ACDBC79A]
  // Created #8-4-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_POINTER:C301($1)

C_BOOLEAN:C305($Boo_disable;$Boo_entireArea;$Boo_entireColumn;$Boo_entireRow;$Boo_noSelection;$Boo_oneCell)
C_LONGINT:C283($Lon_;$Lon_area;$Lon_bit;$Lon_column;$Lon_first_row;$Lon_firstColumn)
C_LONGINT:C283($Lon_lastColumn;$Lon_lastRow;$Lon_operator;$Lon_parameters;$Lon_qrRow;$Lon_row)
C_LONGINT:C283($Lon_x;$Lon_y)
C_POINTER:C301($Ptr_area)
C_TEXT:C284($Mnu_pop;$Txt_action;$Txt_data)

If (False:C215)
	C_POINTER:C301(NQR_MENU_CELLS ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	$Ptr_area:=$1  //target area pointer
	$Lon_area:=$Ptr_area->
	
	  //get the coordinates of the cell that is selected.
	QR GET SELECTION:C793($Lon_area;$Lon_firstColumn;$Lon_first_row;$Lon_lastColumn;$Lon_lastRow)
	
	$Boo_noSelection:=($Lon_firstColumn=-1)
	
	If (Not:C34($Boo_noSelection))
		
		ARRAY LONGINT:C221($tLon_sortedColumns;0x0000)
		ARRAY LONGINT:C221($tLon_sortOrder;0x0000)
		QR GET SORTS:C753($Lon_area;$tLon_sortedColumns;$tLon_sortOrder)
		
		$Boo_entireArea:=(($Lon_firstColumn+$Lon_first_row)=0)
		
		If (Not:C34($Boo_entireArea))
			
			$Boo_entireColumn:=($Lon_first_row=0)
			$Boo_entireRow:=($Lon_firstColumn=0)
			
			If (Not:C34($Boo_entireColumn))
				
				$Boo_oneCell:=($Lon_first_row=$Lon_lastRow)
				
			End if 
		End if 
	End if 
	
	$Boo_disable:=($Lon_first_row<3)  // not for Title & detail
	
	If (Not:C34($Boo_disable))
		
		If ($Boo_oneCell)
			
			If (Not:C34($Boo_entireRow))
				
				If ($Lon_first_row>2)
					
					  //Warning: the row reference returned by GET SELECTION is not the same as used by GET/SET TOTALS DATA
					$Lon_qrRow:=Choose:C955($Lon_first_row=(Size of array:C274($tLon_sortedColumns)+3);qr grand total:K14906:3;$Lon_first_row-2)
					QR GET TOTALS DATA:C768($Lon_area;$Lon_firstColumn;$Lon_qrRow;$Lon_operator;$Txt_data)
					
				End if 
			End if 
			
		Else 
			
			$Boo_disable:=$Boo_entireArea | $Boo_entireColumn | $Boo_entireRow
			
		End if 
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
If (True:C214)  //menu definition
	
	$Mnu_pop:=Create menu:C408
	
	APPEND MENU ITEM:C411($Mnu_pop;Choose:C955($Boo_disable;"(";"")+Get localized string:C991("menu_sum"))
	SET MENU ITEM PARAMETER:C1004($Mnu_pop;-1;"0")
	SET MENU ITEM MARK:C208($Mnu_pop;-1;Char:C90(18)*Num:C11($Lon_operator ?? 0))
	
	APPEND MENU ITEM:C411($Mnu_pop;Choose:C955($Boo_disable;"(";"")+Get localized string:C991("menu_average"))
	SET MENU ITEM PARAMETER:C1004($Mnu_pop;-1;"1")
	SET MENU ITEM MARK:C208($Mnu_pop;-1;Char:C90(18)*Num:C11($Lon_operator ?? 1))
	
	APPEND MENU ITEM:C411($Mnu_pop;Choose:C955($Boo_disable;"(";"")+Get localized string:C991("menu_min"))
	SET MENU ITEM PARAMETER:C1004($Mnu_pop;-1;"2")
	SET MENU ITEM MARK:C208($Mnu_pop;-1;Char:C90(18)*Num:C11($Lon_operator ?? 2))
	
	APPEND MENU ITEM:C411($Mnu_pop;Choose:C955($Boo_disable;"(";"")+Get localized string:C991("menu_max"))
	SET MENU ITEM PARAMETER:C1004($Mnu_pop;-1;"3")
	SET MENU ITEM MARK:C208($Mnu_pop;-1;Char:C90(18)*Num:C11($Lon_operator ?? 3))
	
	APPEND MENU ITEM:C411($Mnu_pop;Choose:C955($Boo_disable;"(";"")+Get localized string:C991("menu_count"))
	SET MENU ITEM PARAMETER:C1004($Mnu_pop;-1;"4")
	SET MENU ITEM MARK:C208($Mnu_pop;-1;Char:C90(18)*Num:C11($Lon_operator ?? 4))
	
	APPEND MENU ITEM:C411($Mnu_pop;Choose:C955($Boo_disable;"(";"")+Get localized string:C991("menu_standard_deviation"))
	SET MENU ITEM PARAMETER:C1004($Mnu_pop;-1;"5")
	SET MENU ITEM MARK:C208($Mnu_pop;-1;Char:C90(18)*Num:C11($Lon_operator ?? 5))
	
End if 

OBJECT GET COORDINATES:C663(*;OBJECT Get name:C1087(Object current:K67:2);$Lon_x;$Lon_;$Lon_;$Lon_y)
$Txt_action:=Dynamic pop up menu:C1006($Mnu_pop;"";$Lon_x;$Lon_y-2)

RELEASE MENU:C978($Mnu_pop)

Case of 
		
		  //______________________________________________________
	: (Length:C16($Txt_action)=0)
		
		  //NOTHING MORE TO DO
		
		  //______________________________________________________
	Else 
		
		$Lon_bit:=Num:C11($Txt_action)
		
		Case of 
				
				  //______________________________________________________
			: ($Boo_entireArea)
				
				For ($Lon_column;1;QR Count columns:C764($Lon_area);1)
					
					For ($Lon_row;1;Size of array:C274($tLon_sortedColumns);1)
						
						QR GET TOTALS DATA:C768($Lon_area;$Lon_column;$Lon_row;$Lon_operator;$Txt_data)
						QR SET TOTALS DATA:C767($Lon_area;$Lon_column;$Lon_row;$Lon_operator ?+ $Lon_bit)
						
					End for 
					
					QR GET TOTALS DATA:C768($Lon_area;$Lon_column;qr grand total:K14906:3;$Lon_operator;$Txt_data)
					QR SET TOTALS DATA:C767($Lon_area;$Lon_column;qr grand total:K14906:3;$Lon_operator ?+ $Lon_bit)
					
				End for 
				
				  //______________________________________________________
			: ($Boo_entireColumn)
				
				$Lon_column:=$Lon_firstColumn
				
				For ($Lon_row;1;Size of array:C274($tLon_sortedColumns);1)
					
					QR GET TOTALS DATA:C768($Lon_area;$Lon_column;$Lon_row;$Lon_operator;$Txt_data)
					QR SET TOTALS DATA:C767($Lon_area;$Lon_column;$Lon_row;$Lon_operator ?+ $Lon_bit)
					
				End for 
				
				QR GET TOTALS DATA:C768($Lon_area;$Lon_column;qr grand total:K14906:3;$Lon_operator;$Txt_data)
				QR SET TOTALS DATA:C767($Lon_area;$Lon_column;qr grand total:K14906:3;$Lon_operator ?+ $Lon_bit)
				
				  //______________________________________________________
			: ($Boo_entireRow)
				
				$Lon_row:=$Lon_first_row-2
				
				For ($Lon_column;1;QR Count columns:C764($Lon_area);1)
					
					QR GET TOTALS DATA:C768($Lon_area;$Lon_column;$Lon_row;$Lon_operator;$Txt_data)
					QR SET TOTALS DATA:C767($Lon_area;$Lon_column;$Lon_row;$Lon_operator ?+ $Lon_bit)
					
				End for 
				
				  //______________________________________________________
			Else 
				
				$Lon_column:=$Lon_firstColumn
				$Lon_row:=$Lon_qrRow
				
				QR SET TOTALS DATA:C767($Lon_area;$Lon_column;$Lon_row;Choose:C955($Lon_operator ?? $Lon_bit;$Lon_operator ?- $Lon_bit;$Lon_operator ?+ $Lon_bit))
				
				  //______________________________________________________
		End case 
		
		  //______________________________________________________
End case 

  // ----------------------------------------------------
  // End