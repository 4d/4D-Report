//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : NQR_MENU_COLUMN
  // Database: 4D Report
  // ID[96956AF43B0E42458D9C2E8275916E2E]
  // Created #27-5-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_POINTER:C301($1)

C_BOOLEAN:C305($Boo_oneColumn)
C_LONGINT:C283($Lon_;$Lon_area;$Lon_bottom;$Lon_column;$Lon_hidden;$Lon_lastColumn)
C_LONGINT:C283($Lon_lastRow;$Lon_left;$Lon_parameters;$Lon_repeated;$Lon_row;$Lon_width)
C_POINTER:C301($Ptr_area)
C_TEXT:C284($Mnu_pop;$Txt_action;$Txt_format;$Txt_formula;$Txt_object;$Txt_title)

If (False:C215)
	C_POINTER:C301(NQR_MENU_COLUMN ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	  //Required parameters
	$Ptr_area:=$1  //target area pointer
	$Lon_area:=$Ptr_area->
	
	  //Optional parameters
	If ($Lon_parameters>=2)
		
		  //
		
	End if 
	
	  //get the coordinates of the cell that is selected.
	QR GET SELECTION:C793($Lon_area;$Lon_column;$Lon_row;$Lon_lastColumn;$Lon_lastRow)
	
	$Boo_oneColumn:=($Lon_row=0) & ($Lon_column>0)
	
	If ($Boo_oneColumn)
		
		QR GET INFO COLUMN:C766($Lon_area;$Lon_column;$Txt_title;$Txt_object;$Lon_hidden;$Lon_width;$Lon_repeated;$Txt_format;$Txt_formula)
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
$Mnu_pop:=Create menu:C408

APPEND MENU ITEM:C411($Mnu_pop;".Add…")
SET MENU ITEM PARAMETER:C1004($Mnu_pop;-1;"add")

APPEND MENU ITEM:C411($Mnu_pop;".Insert…")
SET MENU ITEM PARAMETER:C1004($Mnu_pop;-1;"insert")

If (Not:C34($Boo_oneColumn))
	
	DISABLE MENU ITEM:C150($Mnu_pop;-1)
	
End if 

APPEND MENU ITEM:C411($Mnu_pop;".Edit…")
SET MENU ITEM PARAMETER:C1004($Mnu_pop;-1;"edit")

If (Not:C34($Boo_oneColumn))
	
	DISABLE MENU ITEM:C150($Mnu_pop;-1)
	
End if 

APPEND MENU ITEM:C411($Mnu_pop;".Delete")
SET MENU ITEM PARAMETER:C1004($Mnu_pop;-1;"delete")

If (Not:C34($Boo_oneColumn))
	
	DISABLE MENU ITEM:C150($Mnu_pop;-1)
	
End if 

APPEND MENU ITEM:C411($Mnu_pop;".Hide")
SET MENU ITEM PARAMETER:C1004($Mnu_pop;-1;"hide")

If ($Boo_oneColumn)
	
	SET MENU ITEM MARK:C208($Mnu_pop;-1;Char:C90(19)*$Lon_hidden)
	
Else 
	
	DISABLE MENU ITEM:C150($Mnu_pop;-1)
	
End if 

  //APPEND MENU ITEM($Mnu_pop;"-")

  //APPEND MENU ITEM($Mnu_pop;".Move Left")
  //SET MENU ITEM PARAMETER($Mnu_pop;-1;"move_left")

  //If (Not($Boo_oneColumn))
  //DISABLE MENU ITEM($Mnu_pop;-1)

  //End if

  //APPEND MENU ITEM($Mnu_pop;".Move Right")
  //SET MENU ITEM PARAMETER($Mnu_pop;-1;"move_right")

  //If (Not($Boo_oneColumn))
  //DISABLE MENU ITEM($Mnu_pop;-1)

  //End if

APPEND MENU ITEM:C411($Mnu_pop;"-")

APPEND MENU ITEM:C411($Mnu_pop;".Automatic Width")
SET MENU ITEM PARAMETER:C1004($Mnu_pop;-1;"automatic_width")

If ($Boo_oneColumn)
	
	SET MENU ITEM MARK:C208($Mnu_pop;-1;Char:C90(19)*Num:C11($Lon_width=-1))
	
Else 
	
	DISABLE MENU ITEM:C150($Mnu_pop;-1)
	
End if 

APPEND MENU ITEM:C411($Mnu_pop;".Repeated Values")
SET MENU ITEM PARAMETER:C1004($Mnu_pop;-1;"repeated_values")

If ($Boo_oneColumn)
	
	SET MENU ITEM MARK:C208($Mnu_pop;-1;Char:C90(19)*$Lon_repeated)
	
Else 
	
	DISABLE MENU ITEM:C150($Mnu_pop;-1)
	
End if 

OBJECT GET COORDINATES:C663(*;OBJECT Get name:C1087(Object current:K67:2);$Lon_left;$Lon_;$Lon_;$Lon_bottom)
$Txt_action:=Dynamic pop up menu:C1006($Mnu_pop;"";$Lon_left;$Lon_bottom-2)

RELEASE MENU:C978($Mnu_pop)

Case of 
		
		  //______________________________________________________
	: (Length:C16($Txt_action)=0)
		
		  //NOTHING MORE TO DO
		
		  //______________________________________________________
	: ($Txt_action="add")
		
		EDIT FORMULA:C806(Table:C252(QR Get report table:C758($Lon_area))->;$Txt_formula)
		
		If (OK=1)
			
			$Lon_column:=QR Count columns:C764($Lon_area)+1
			QR INSERT COLUMN:C748($Lon_area;$Lon_column;$Txt_formula)
			QR SET INFO COLUMN:C765($Lon_area;$Lon_column;"";$Txt_formula;0;-1;1;"")
			
		End if 
		
		  //______________________________________________________
	: ($Txt_action="edit")
		
		$Txt_formula:=Choose:C955(Length:C16($Txt_formula)=0;$Txt_object;$Txt_formula)
		EDIT FORMULA:C806(Table:C252(QR Get report table:C758($Lon_area))->;$Txt_formula)
		
		If (OK=1)
			
			QR SET INFO COLUMN:C765($Lon_area;$Lon_column;$Txt_title;$Txt_formula;$Lon_hidden;$Lon_width;$Lon_repeated;$Txt_format)
			report_AREA_UPDATE 
			
		End if 
		
		  //______________________________________________________
	: ($Txt_action="delete")
		
		QR DELETE COLUMN:C749($Lon_area;$Lon_column)
		report_AREA_UPDATE 
		
		  //______________________________________________________
	: ($Txt_action="hide")
		
		If ($Lon_column=0)
			
			  //hide the row
			QR SET INFO ROW:C763($Lon_area;$Lon_row;Abs:C99(1-$Lon_hidden))
			
		Else 
			
			  //hide the column
			QR SET INFO COLUMN:C765($Lon_area;$Lon_column;$Txt_title;$Txt_formula;Abs:C99(1-$Lon_hidden);$Lon_width;$Lon_repeated;$Txt_format)
			
		End if 
		
		report_AREA_UPDATE 
		
		  //______________________________________________________
	: ($Txt_action="repeted_values")
		
		QR SET INFO COLUMN:C765($Lon_area;$Lon_column;$Txt_title;$Txt_formula;$Lon_hidden;$Lon_width;Abs:C99(1-$Lon_repeated);$Txt_format)
		
		  //______________________________________________________
	: ($Txt_action="automatic_width")
		
		QR_SET_COLUMN_WIDTH ($Lon_area;$Lon_column;Choose:C955($Lon_width=-1;128;-1))
		report_AREA_UPDATE 
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Unknown entry point: \""+$Txt_action+"\"")
		
		  //______________________________________________________
End case 

  // ----------------------------------------------------
  // Return

  // ----------------------------------------------------
  // End