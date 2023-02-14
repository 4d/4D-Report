//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : report_CONTEXTUAL_MENUS
// Database: 4D Report
// ID[BC611413B32340529067731443FBED5A]
// Created #24-3-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)

C_BOOLEAN:C305($Boo_crossReport; $Boo_data; $Boo_notBinary; $Boo_text)
C_LONGINT:C283($Lon_altBackColor; $Lon_area; $Lon_backColor; $Lon_color; $Lon_column; $Lon_columnNumber)
C_LONGINT:C283($Lon_columnType; $Lon_destination; $Lon_fontColor; $Lon_fontSize; $Lon_fontStyle; $Lon_hidden)
C_LONGINT:C283($Lon_justification; $Lon_lineNumber; $Lon_operator; $Lon_parameters; $Lon_repeated; $Lon_row)
C_LONGINT:C283($Lon_sort_index; $Lon_type; $Lon_width; $lon_value; $Lon_SubBreakSpacing)
C_TEXT:C284($File_path; $Mnu_main; $Mnu_submenu; $Txt_action; $Txt_buffer; $Txt_columnFormat)
C_TEXT:C284($Txt_data; $Txt_format; $Txt_formula; $Txt_object; $Txt_title; $Txt_templateName; $txt_value)

If (False:C215)
	C_LONGINT:C283(report_CONTEXTUAL_MENUS; $1)
	C_LONGINT:C283(report_CONTEXTUAL_MENUS; $2)
	C_LONGINT:C283(report_CONTEXTUAL_MENUS; $3)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1; "Missing parameter"))
	
	$Lon_area:=$1
	
	If ($Lon_parameters>=2)
		
		$Lon_column:=$2
		
		If ($Lon_parameters>=3)
			
			$Lon_row:=$3
			
		End if 
	End if 
	
	$Boo_crossReport:=(OB Get:C1224(ob_area; "reportType"; Is longint:K8:6)=qr cross report:K14902:2)
	
	If ($Boo_crossReport)
		
		If ($Lon_column=1)\
			 & ($Lon_row=1)
			
			$Lon_column:=0
			$Lon_row:=0
			
		End if 
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
//Get columns that have a sort order
ARRAY LONGINT:C221($tLon_sortedColumns; 0x0000)
ARRAY LONGINT:C221($tLon_sortOrder; 0x0000)
QR GET SORTS:C753($Lon_area; $tLon_sortedColumns; $tLon_sortOrder)

//Number of columns & rows of the QR
$Lon_lineNumber:=Size of array:C274($tLon_sortedColumns)+3
$Lon_columnNumber:=QR Count columns:C764($Lon_area)

$Lon_columnType:=Is undefined:K8:13

//Retrieve column properties and common values
If (($Lon_column>0)\
 & ($Lon_column<=$Lon_columnNumber))\
 | $Boo_crossReport
	
	If (Not:C34($Boo_crossReport))
		
		QR GET INFO COLUMN:C766($Lon_area; $Lon_column; $Txt_title; $Txt_object; $Lon_hidden; $Lon_width; $Lon_repeated; $Txt_format; $Txt_formula)
		
	End if 
	
	If ($Lon_column#-1)
		
		$Lon_fontStyle:=QR_Get_font_style($Lon_area; $Lon_column; $Lon_row)
		$Lon_fontSize:=QR_Get_font_size($Lon_area; $Lon_column; $Lon_row)
		$Lon_justification:=QR_Get_justification($Lon_area; $Lon_column; $Lon_row)
		$Lon_fontColor:=QR_Get_color($Lon_area; $Lon_column; $Lon_row)
		
		//************************************************
		//*                   #TO_BE_DONE                *
		//************************************************
		$Lon_backColor:=QR_Get_color($Lon_area; $Lon_column; $Lon_row; qr background color:K14904:8)
		$Lon_altBackColor:=QR_Get_color($Lon_area; $Lon_column; $Lon_row; qr alternate background color:K14904:9)
		
		$Lon_columnType:=QR_Get_column_type($Lon_area; $Lon_column)
		$Boo_notBinary:=($Lon_columnType#Is BLOB:K8:12) & ($Lon_columnType#Is picture:K8:10) & ($Lon_columnType#Is subtable:K8:11)
		
		$Txt_columnFormat:=QR_Get_column_format($Lon_area; $Lon_column; $Lon_columnType)
		
	End if 
	
	If ($Lon_column>0)\
		 & (($Lon_row>0)\
		 | ($Lon_row=qr grand total:K14906:3))
		
		QR GET TOTALS DATA:C768($Lon_area; $Lon_column; $Lon_row; $Lon_operator; $Txt_data)
		
	End if 
	
Else 
	
	If ($Lon_column=0)\
		 & ($Lon_row#0)
		
		$Lon_hidden:=QR Get info row:C769($Lon_area; $Lon_row)
		
	End if 
End if 

// retrieve subtotal spacing if any
If (Not:C34($Boo_crossReport)\
 & ($Lon_row>0))
	
	$Lon_SubBreakSpacing:=QR_get_TotalsSpacing($Lon_area; $Lon_row)
	
End if 

$Mnu_main:=Create menu:C408

If ($Boo_crossReport)
	
	Case of 
			
			//______________________________________________________
		: (($Lon_column=1)\
			 & ($Lon_row=2))\
			 | (($Lon_column=2) & ($Lon_row<3))
			
			APPEND MENU ITEM:C411($Mnu_main; ":xliff:menu_edit_formula")
			SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "header_edit")
			
			APPEND MENU ITEM:C411($Mnu_main; "-")
			
			//______________________________________________________
		: (($Lon_column=1)\
			 & ($Lon_row=3))\
			 | (($Lon_column=3) & ($Lon_row=1))
			
			APPEND MENU ITEM:C411($Mnu_main; ":xliff:menu_edit")
			SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "edit")
			
			APPEND MENU ITEM:C411($Mnu_main; "-")
			
			//______________________________________________________
	End case 
End if 

Case of 
		
		//______________________________________________________
	: ($Lon_column>$Lon_columnNumber)\
		 | ($Lon_row>$Lon_lineNumber)
		
		//{n+1,x} | {x, n+1} = external
		
		APPEND MENU ITEM:C411($Mnu_main; ":xliff:menu_add_column")
		SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "add")
		
		//______________________________________________________
	: ($Lon_column=0)\
		 & ($Lon_row=0)
		
		//{0,0} = All
		
		$Mnu_submenu:=Create menu:C408
		
		QR GET DESTINATION:C756($Lon_area; $Lon_type; $File_path)
		
		If (Not:C34($Boo_crossReport))
			
			APPEND MENU ITEM:C411($Mnu_main; ":xliff:menu_add_column")
			SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "add")
			
			APPEND MENU ITEM:C411($Mnu_main; "-")
			
		End if 
		
		APPEND MENU ITEM:C411($Mnu_submenu; ":xliff:menu_printer")
		SET MENU ITEM PARAMETER:C1004($Mnu_submenu; -1; "dest_"+String:C10(qr printer:K14903:1))
		SET MENU ITEM MARK:C208($Mnu_submenu; -1; Char:C90(18)*Num:C11($Lon_type=qr printer:K14903:1))
		
		APPEND MENU ITEM:C411($Mnu_submenu; ":xliff:menu_text_file")
		SET MENU ITEM PARAMETER:C1004($Mnu_submenu; -1; "dest_"+String:C10(qr text file:K14903:2))
		SET MENU ITEM MARK:C208($Mnu_submenu; -1; Char:C90(18)*Num:C11($Lon_type=qr text file:K14903:2))
		
		APPEND MENU ITEM:C411($Mnu_submenu; ":xliff:menu_html_file")
		SET MENU ITEM PARAMETER:C1004($Mnu_submenu; -1; "dest_"+String:C10(qr HTML file:K14903:5))
		SET MENU ITEM MARK:C208($Mnu_submenu; -1; Char:C90(18)*Num:C11($Lon_type=qr HTML file:K14903:5))
		
		APPEND MENU ITEM:C411($Mnu_main; ":xliff:menu_destination"; $Mnu_submenu)
		RELEASE MENU:C978($Mnu_submenu)
		
		If (<>withFeature110931)
			
			APPEND MENU ITEM:C411($Mnu_main; "-")
			
			//$Mnu_submenu:=Create menu
			
			$Mnu_submenu:=mnu_border
			APPEND MENU ITEM:C411($Mnu_main; ":xliff:menu_borders"; $Mnu_submenu)
			SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "")
			RELEASE MENU:C978($Mnu_submenu)
			
		End if 
		
		If (Form:C1466.debug)
			
			APPEND MENU ITEM:C411($Mnu_main; "-")
			
			APPEND MENU ITEM:C411($Mnu_main; ":xliff:menu_header_and_footers")
			SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "header&footer")
			
		End if 
		
		$Boo_text:=($Lon_columnNumber>0)
		
		//______________________________________________________
	: ($Lon_row=0)
		
		//{n,0} = header
		
		$Lon_sort_index:=Find in array:C230($tLon_sortedColumns; $Lon_column)
		
		If ($Lon_sort_index>0)
			
			$tLon_sortOrder{0}:=$tLon_sortOrder{$Lon_sort_index}
			
		End if 
		
		If ($Lon_column=$Lon_columnNumber)
			
			APPEND MENU ITEM:C411($Mnu_main; ":xliff:menu_add_column")
			SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "add")
			
		End if 
		
		APPEND MENU ITEM:C411($Mnu_main; ":xliff:menu_insert_column")
		SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "insert")
		
		APPEND MENU ITEM:C411($Mnu_main; "-")
		
		APPEND MENU ITEM:C411($Mnu_main; ":xliff:menu_edit_formula")
		SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "header_edit")
		
		APPEND MENU ITEM:C411($Mnu_main; "-")
		
		APPEND MENU ITEM:C411($Mnu_main; ":xliff:menu_hide_column")
		SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "hide")
		SET MENU ITEM MARK:C208($Mnu_main; -1; Char:C90(18)*Num:C11($Lon_hidden=1))
		
		APPEND MENU ITEM:C411($Mnu_main; ":xliff:menu_delete_column")
		SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "delete")
		
		APPEND MENU ITEM:C411($Mnu_main; "-")
		
		APPEND MENU ITEM:C411($Mnu_main; ":xliff:menu_repeated_values")
		SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "repeted_values")
		SET MENU ITEM MARK:C208($Mnu_main; -1; Char:C90(18)*Num:C11($Lon_repeated=1))
		
		APPEND MENU ITEM:C411($Mnu_main; ":xliff:menu_automatic_width")
		SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "automatic_width")
		SET MENU ITEM MARK:C208($Mnu_main; -1; Char:C90(18)*Num:C11($Lon_width=-1))
		
		If (<>withFeature110931)
			
			APPEND MENU ITEM:C411($Mnu_main; "-")
			
			$Mnu_submenu:=Create menu:C408
			
			$Mnu_submenu:=mnu_border
			APPEND MENU ITEM:C411($Mnu_main; ":xliff:menu_borders"; $Mnu_submenu)
			SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "")
			RELEASE MENU:C978($Mnu_submenu)
			
		End if 
		
		If (($Boo_notBinary) & (Not:C34($Boo_crossReport)))
			
			APPEND MENU ITEM:C411($Mnu_main; "-")
			
			$Mnu_submenu:=Create menu:C408
			
			APPEND MENU ITEM:C411($Mnu_submenu; ":xliff:menu_sort_none")
			SET MENU ITEM PARAMETER:C1004($Mnu_submenu; -1; "sort_none")
			SET MENU ITEM MARK:C208($Mnu_submenu; -1; Char:C90(18)*Num:C11($tLon_sortOrder{0}=0))
			
			APPEND MENU ITEM:C411($Mnu_submenu; "-")
			
			APPEND MENU ITEM:C411($Mnu_submenu; ":xliff:menu_sort_ascending")
			SET MENU ITEM PARAMETER:C1004($Mnu_submenu; -1; "sort_ascending")
			SET MENU ITEM MARK:C208($Mnu_submenu; -1; Char:C90(18)*Num:C11($tLon_sortOrder{0}=1))
			
			APPEND MENU ITEM:C411($Mnu_submenu; ":xliff:menu_sort_descending")
			SET MENU ITEM PARAMETER:C1004($Mnu_submenu; -1; "sort_descending")
			SET MENU ITEM MARK:C208($Mnu_submenu; -1; Char:C90(18)*Num:C11($tLon_sortOrder{0}=-1))
			
			APPEND MENU ITEM:C411($Mnu_main; ":xliff:menu_sort_order"; $Mnu_submenu)
			SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "sort")
			
			RELEASE MENU:C978($Mnu_submenu)
			
		End if 
		
		$Boo_text:=True:C214
		
		//______________________________________________________
	: ($Lon_column=0)
		
		//{1,n} = line header
		
		$Boo_text:=($Lon_columnNumber>0)
		$Boo_data:=(($Lon_row>0) | ($Lon_row=qr grand total:K14906:3)) & ($Lon_columnNumber>0)
		
		If ($Lon_row#0)
			
			APPEND MENU ITEM:C411($Mnu_main; ":xliff:menu_hide_row")
			SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "hide")
			SET MENU ITEM MARK:C208($Mnu_main; -1; Char:C90(18)*Num:C11($Lon_hidden=1))
			
			
			If (<>withFeature110931)
				
				//$Mnu_submenu:=Create menu
				
				$Mnu_submenu:=mnu_border
				APPEND MENU ITEM:C411($Mnu_main; ":xliff:menu_borders"; $Mnu_submenu)
				SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "")
				RELEASE MENU:C978($Mnu_submenu)
				
			End if 
		End if 
		
		//______________________________________________________
	Else 
		
		//{n,n} - Cell
		
		If ($Lon_column#-1)
			
			$Boo_text:=True:C214
			$Boo_data:=($Lon_row>0) | ($Lon_row=qr grand total:K14906:3)
			
			If (<>withFeature110931)
				
				
				//$Mnu_submenu:=Create menu
				
				$Mnu_submenu:=mnu_border
				APPEND MENU ITEM:C411($Mnu_main; ":xliff:menu_borders"; $Mnu_submenu)
				SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "")
				RELEASE MENU:C978($Mnu_submenu)
				
			End if 
		End if 
		
		//______________________________________________________
End case 

If ($Boo_data)\
 & ($Boo_notBinary | ($Lon_column=0))
	
	If ($Boo_crossReport)\
		 & (($Lon_row=1)\
		 | ($Lon_column=1))
		
	Else 
		
		If (Count menu items:C405($Mnu_main)>0)
			
			APPEND MENU ITEM:C411($Mnu_main; "-")
			
		End if 
		
		APPEND MENU ITEM:C411($Mnu_main; ":xliff:menu_sum")
		SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "data_0")
		SET MENU ITEM MARK:C208($Mnu_main; -1; Char:C90(18)*Num:C11($Lon_operator ?? 0))
		
		APPEND MENU ITEM:C411($Mnu_main; ":xliff:menu_average")
		SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "data_1")
		SET MENU ITEM MARK:C208($Mnu_main; -1; Char:C90(18)*Num:C11($Lon_operator ?? 1))
		
		APPEND MENU ITEM:C411($Mnu_main; ":xliff:menu_min")
		SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "data_2")
		SET MENU ITEM MARK:C208($Mnu_main; -1; Char:C90(18)*Num:C11($Lon_operator ?? 2))
		
		APPEND MENU ITEM:C411($Mnu_main; ":xliff:menu_max")
		SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "data_3")
		SET MENU ITEM MARK:C208($Mnu_main; -1; Char:C90(18)*Num:C11($Lon_operator ?? 3))
		
		APPEND MENU ITEM:C411($Mnu_main; ":xliff:menu_count")
		SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "data_4")
		SET MENU ITEM MARK:C208($Mnu_main; -1; Char:C90(18)*Num:C11($Lon_operator ?? 4))
		
		APPEND MENU ITEM:C411($Mnu_main; ":xliff:menu_standard_deviation")
		SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "data_5")
		SET MENU ITEM MARK:C208($Mnu_main; -1; Char:C90(18)*Num:C11($Lon_operator ?? 5))
		
	End if 
End if 

If ($Boo_text)
	
	If ($Boo_notBinary | ($Lon_column=0))
		
		If (Count menu items:C405($Mnu_main)>0)
			
			APPEND MENU ITEM:C411($Mnu_main; "-")
			
		End if 
		
		$Mnu_submenu:=mnu_Font
		APPEND MENU ITEM:C411($Mnu_main; ":xliff:menu_font"; $Mnu_submenu)
		SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "")
		RELEASE MENU:C978($Mnu_submenu)
		
		$Mnu_submenu:=mnu_FontSize($Lon_fontSize)
		APPEND MENU ITEM:C411($Mnu_main; ":xliff:menu_size"; $Mnu_submenu)
		SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "")
		RELEASE MENU:C978($Mnu_submenu)
		
		$Mnu_submenu:=mnu_FontSyle($Lon_fontStyle)
		APPEND MENU ITEM:C411($Mnu_main; ":xliff:menu_style"; $Mnu_submenu)
		SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "")
		RELEASE MENU:C978($Mnu_submenu)
		
		$Mnu_submenu:=mnu_Justification($Lon_justification)
		APPEND MENU ITEM:C411($Mnu_main; ":xliff:menu_justification"; $Mnu_submenu)
		SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "")
		RELEASE MENU:C978($Mnu_submenu)
		
		$Mnu_submenu:=mnu_Color($Lon_fontColor)
		APPEND MENU ITEM:C411($Mnu_main; ":xliff:menu_font_color"; $Mnu_submenu)
		SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "")
		RELEASE MENU:C978($Mnu_submenu)
		
	End if 
	
	$Mnu_submenu:=mnu_Color($Lon_backColor; "back")
	APPEND MENU ITEM:C411($Mnu_main; ":xliff:menu_background_color"; $Mnu_submenu)
	SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "")
	RELEASE MENU:C978($Mnu_submenu)
	
	If ($Lon_row=qr detail:K14906:2)
		
		$Mnu_submenu:=mnu_Color($Lon_altBackColor; "backAlt")
		APPEND MENU ITEM:C411($Mnu_main; ":xliff:menu_alternate_background_color"; $Mnu_submenu)
		SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "")
		RELEASE MENU:C978($Mnu_submenu)
		
	End if 
	
	// #ACI0101161 
	//If ($Lon_row>0)
	If ($Lon_row>0) & Not:C34($Boo_crossReport)
		
		$Mnu_submenu:=mnu_breakSpacing($Lon_SubBreakSpacing)
		
		APPEND MENU ITEM:C411($Mnu_main; "-")
		APPEND MENU ITEM:C411($Mnu_main; ":xliff:menu_subtotalSpacingItem"; $Mnu_submenu)
		SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "")
		RELEASE MENU:C978($Mnu_submenu)
		
	End if 
	//ACI0101179
	//If ($Lon_row>0)
	If (($Lon_row=0) & (Not:C34($Boo_crossReport)))  //The format is global for a column
		
		$Mnu_submenu:=menu_format($Lon_columnType; $Txt_columnFormat)
		
		If (Count menu items:C405($Mnu_submenu)>0)
			
			APPEND MENU ITEM:C411($Mnu_main; "-")
			
			APPEND MENU ITEM:C411($Mnu_main; ":xliff:menu_format"; $Mnu_submenu)
			RELEASE MENU:C978($Mnu_submenu)
			
		End if 
	End if 
End if 

$Txt_action:=Dynamic pop up menu:C1006($Mnu_main)
RELEASE MENU:C978($Mnu_main)

If (Length:C16($Txt_action)#0)
	
	Case of 
			
			//______________________________________________________
		: ($Txt_action="dest_@")
			
			$Lon_destination:=Num:C11(Replace string:C233($Txt_action; "dest_"; ""))
			
			// #ACI0099118 : set destination is erasing the html template, so we need to save it and re-set it. 
			$Txt_templateName:=QR Get HTML template:C751($Lon_area)
			If (($Txt_templateName="") & Not:C34(ob_dialog.optionHTMLtemplate=Null:C1517))
				$Txt_templateName:=ob_dialog.optionHTMLtemplate
			End if 
			
			QR SET DESTINATION:C745($Lon_area; $Lon_destination)
			QR SET HTML TEMPLATE:C750($Lon_area; $Txt_templateName)
			
			//______________________________________________________
		: ($Txt_action="add")\
			 | ($Txt_action="insert")
			
			CLEAR VARIABLE:C89($Txt_formula)
			EDIT FORMULA:C806(Table:C252(QR Get report table:C758($Lon_area))->; $Txt_formula)
			
			
			Case of 
					
				: (OK=0)
					
				: (Length:C16($Txt_formula)=0)
					//mark:ACI0103550 empty formula is not accepted
					
				Else 
					
					$Lon_column:=Choose:C955($Txt_action="add"; $Lon_columnNumber+1; $Lon_column)
					
					QR INSERT COLUMN:C748($Lon_area; $Lon_column; $Txt_formula)
					QR SET INFO COLUMN:C765($Lon_area; $Lon_column; ""; $Txt_formula; 0; -1; 1; "")
					
					QR_SET_TITLE($Lon_area; $Lon_column)
					
			End case 
			
			//______________________________________________________
		: ($Txt_action="edit")
			
			$Txt_buffer:=Choose:C955($Lon_column=1; "headers"; "QR_column_2")
			OBJECT SET ENTERABLE:C238(*; $Txt_buffer; True:C214)
			EDIT ITEM:C870(*; $Txt_buffer; $Lon_row)
			
			// #ACI0101165
			ob_area.cellEdition:=True:C214
			
			//______________________________________________________
		: ($Txt_action="header_edit")
			
			If ($Boo_crossReport)
				
				report_EDIT_COLUMN_FORMULA($Lon_area; 1+Choose:C955($Lon_row>1; $Lon_column; 0))
				
			Else 
				
				report_EDIT_COLUMN_FORMULA($Lon_area; $Lon_column)
				
			End if 
			
			//______________________________________________________
		: ($Txt_action="delete")
			
			QR DELETE COLUMN:C749($Lon_area; $Lon_column)
			
			//______________________________________________________
		: ($Txt_action="hide")
			
			If ($Lon_column=0)
				
				//hide/show the row
				QR SET INFO ROW:C763($Lon_area; $Lon_row; Abs:C99(1-$Lon_hidden))
				
			Else 
				//hide/show the column
				QR SET INFO COLUMN:C765($Lon_area; $Lon_column; $Txt_title; $Txt_object; Abs:C99(1-$Lon_hidden); $Lon_width; $Lon_repeated; $Txt_format)
				
			End if 
			
			//______________________________________________________
		: ($Txt_action="border@")
			
			C_BOOLEAN:C305($boo_isColor)
			C_LONGINT:C283($lon_border; $Lon_thickness; $lon_columnCount)
			ARRAY LONGINT:C221($_arrColumns; 0)
			ARRAY LONGINT:C221($_arrOrders; 0)
			
			$Txt_action:=Substring:C12($Txt_action; 7)
			$boo_isColor:=Choose:C955($Txt_action="@color@"; True:C214; False:C215)
			
			Case of 
					
					//________________________________________
				: ($Txt_action="All@")
					
					$lon_border:=(qr bottom border:K14908:4+qr top border:K14908:2+qr left border:K14908:1+\
						qr right border:K14908:3+qr inside horizontal border:K14908:6+qr inside vertical border:K14908:5)
					
					//________________________________________
				: ($Txt_action="Out@")
					
					$lon_border:=(qr bottom border:K14908:4+qr top border:K14908:2+qr left border:K14908:1+qr right border:K14908:3)
					
					//________________________________________
				: ($Txt_action="Ins@")
					
					$lon_border:=qr inside vertical border:K14908:5
					
					//________________________________________
				: ($Txt_action="Ver@")
					
					$lon_border:=qr inside vertical border:K14908:5
					
					//________________________________________
				: ($Txt_action="Hor@")
					
					$lon_border:=qr inside horizontal border:K14908:6
					
					//________________________________________
				: ($Txt_action="Lef@")
					
					$lon_border:=qr left border:K14908:1
					
					//________________________________________
				: ($Txt_action="Rig@")
					
					$lon_border:=qr right border:K14908:3
					
					//________________________________________
				: ($Txt_action="Top@")
					
					$lon_border:=qr top border:K14908:2
					
					//________________________________________
				: ($Txt_action="Bot@")
					
					$lon_border:=qr bottom border:K14908:4
					
					//________________________________________
			End case 
			
			If (Not:C34(($lon_border=15) | ($lon_border=63)))
				
				// if not mixed we get the previous value
				QR GET BORDERS:C798($Lon_area; $Lon_column; $Lon_row; $lon_border; $Lon_thickness; $Lon_color)
				
			Else 
				
				// if mixed we set the default value
				$Lon_thickness:=1
				$Lon_color:=1
				
			End if 
			
			$lon_value:=Num:C11($Txt_action)
			
			If ($boo_isColor)
				
				$Lon_color:=$lon_value
				
			Else 
				
				$Lon_thickness:=$lon_value
				
			End if 
			
			Case of 
					//________________________________________
				: (($Lon_column=0) & ($Lon_row=0))  // global cells
					
					$lon_columnCount:=QR Count columns:C764($Lon_area)
					QR GET SORTS:C753($Lon_area; $_arrColumns; $_arrOrders)
					
					For ($Lon_row; qr grand total:K14906:3; Size of array:C274($_arrColumns); 1)
						
						If ($Lon_row#0)
							
							For ($Lon_column; 1; $lon_columnCount; 1)
								
								QR SET BORDERS:C797($Lon_area; $Lon_column; $Lon_row; $lon_border; $Lon_thickness; $Lon_color)
								
							End for 
						End if 
					End for 
					
					//________________________________________
				: ($Lon_column=0)  //  We are in row section
					
					For ($Lon_column; 1; QR Count columns:C764($Lon_area))
						
						QR SET BORDERS:C797($Lon_area; $Lon_column; $Lon_row; $lon_border; $Lon_thickness; $Lon_color)
						
					End for 
					
					//________________________________________
				: ($Lon_row=0)  // we are in a column 
					
					QR GET SORTS:C753($Lon_area; $_arrColumns; $_arrOrders)
					
					For ($Lon_row; qr grand total:K14906:3; Size of array:C274($_arrColumns); 1)
						
						If ($Lon_row#0)
							
							QR SET BORDERS:C797($Lon_area; $Lon_column; $Lon_row; $lon_border; $Lon_thickness; $Lon_color)
							
						End if 
					End for 
					
					//________________________________________
				Else   // we are in a cell
					
					QR SET BORDERS:C797($Lon_area; $Lon_column; $Lon_row; $lon_border; $Lon_thickness; $Lon_color)
					
			End case 
			
			//______________________________________________________
		: ($Txt_action="header&footer")
			
			QR EXECUTE COMMAND:C791($Lon_area; qr cmd header and footer:K14900:23)
			
			//______________________________________________________
		: ($Txt_action="repeted_values")
			
			QR SET INFO COLUMN:C765($Lon_area; $Lon_column; $Txt_title; $Txt_formula; $Lon_hidden; $Lon_width; Abs:C99(1-$Lon_repeated); $Txt_format)
			
			//______________________________________________________
		: ($Txt_action="automatic_width")
			
			QR_SET_COLUMN_WIDTH($Lon_area; $Lon_column; Choose:C955($Lon_width=-1; 128; -1))
			
			//______________________________________________________
		: ($Txt_action="sort_@")
			
			$Txt_action:=Replace string:C233($Txt_action; "sort_"; "")
			
			Case of 
					
					//------------------------------------
				: ($Txt_action="none")
					
					If ($Lon_sort_index>0)
						
						DELETE FROM ARRAY:C228($tLon_sortedColumns; $Lon_sort_index; 1)
						DELETE FROM ARRAY:C228($tLon_sortOrder; $Lon_sort_index; 1)
						
					End if 
					
					//------------------------------------
				: ($Txt_action="ascending")
					
					If ($Lon_sort_index>0)
						
						$tLon_sortOrder{$Lon_sort_index}:=1
						
					Else 
						
						APPEND TO ARRAY:C911($tLon_sortedColumns; $Lon_column)
						APPEND TO ARRAY:C911($tLon_sortOrder; 1)
						
					End if 
					
					//------------------------------------
				: ($Txt_action="descending")
					
					If ($Lon_sort_index>0)
						
						$tLon_sortOrder{$Lon_sort_index}:=-1
						
					Else 
						
						APPEND TO ARRAY:C911($tLon_sortedColumns; $Lon_column)
						APPEND TO ARRAY:C911($tLon_sortOrder; -1)
						
					End if 
					
					//------------------------------------
				Else 
					
					TRACE:C157
					
					//------------------------------------
			End case 
			
			QR SET SORTS:C752($Lon_area; $tLon_sortedColumns; $tLon_sortOrder)
			
			//______________________________________________________
		: ($Txt_action="font_picker")
			
			GOTO OBJECT:C206(*; "font_picker")
			OPEN FONT PICKER:C1303(1)
			
			//______________________________________________________
		: ($Txt_action="font_@")
			
			QR_SET_TEXT_PROPERTY($Lon_area; qr font name:K14904:10; Replace string:C233($Txt_action; "font_"; ""); $Lon_column; $Lon_row)
			
			//______________________________________________________
		: ($Txt_action="fontSize_@")
			
			$Txt_buffer:=Replace string:C233($Txt_action; "fontSize_"; "")
			QR_SET_TEXT_PROPERTY($Lon_area; qr font size:K14904:2; $Txt_buffer; $Lon_column; $Lon_row)
			
			//______________________________________________________
		: ($Txt_action="fontStyle_@")
			
			$Txt_action:=Replace string:C233($Txt_action; "fontStyle_"; "")
			
			Case of 
					
					//------------------------------
				: ($Txt_action="plain")
					
					QR_SET_TEXT_PROPERTY($Lon_area; qr bold:K14904:3; "0"; $Lon_column; $Lon_row)
					QR_SET_TEXT_PROPERTY($Lon_area; qr italic:K14904:4; "0"; $Lon_column; $Lon_row)
					QR_SET_TEXT_PROPERTY($Lon_area; qr underline:K14904:5; "0"; $Lon_column; $Lon_row)
					
					//------------------------------
				: ($Txt_action="bold")
					
					QR_SET_TEXT_PROPERTY($Lon_area; qr bold:K14904:3; String:C10(1-Num:C11($Lon_fontStyle ?? 0)); $Lon_column; $Lon_row)
					
					//------------------------------
				: ($Txt_action="italic")
					
					QR_SET_TEXT_PROPERTY($Lon_area; qr italic:K14904:4; String:C10(1-Num:C11($Lon_fontStyle ?? 1)); $Lon_column; $Lon_row)
					
					//------------------------------
				: ($Txt_action="underline")
					
					QR_SET_TEXT_PROPERTY($Lon_area; qr underline:K14904:5; String:C10(1-Num:C11($Lon_fontStyle ?? 2)); $Lon_column; $Lon_row)
					
					//------------------------------
				Else 
					
					TRACE:C157
					
					//------------------------------
			End case 
			
			//______________________________________________________
		: ($Txt_action="justification_@")
			
			//WARNING
			//There is an offset of -1 between 4D justification and QR justification
			$Txt_action:=Replace string:C233($Txt_action; "justification_"; "")
			$Txt_action:=String:C10(Num:C11($Txt_action)-1)
			
			QR_SET_TEXT_PROPERTY($Lon_area; qr justification:K14904:7; $Txt_action; $Lon_column; $Lon_row)
			
			//______________________________________________________
		: ($Txt_action="@Color_@")
			
			$Txt_buffer:=Delete string:C232($Txt_action; 1; Position:C15("_"; $Txt_action))
			$Lon_color:=_hexToDec($Txt_buffer)
			
			Case of 
					
					//------------------------------------
				: ($Lon_color=1)  //automatic
					
					$Lon_color:=Choose:C955($Txt_action="back@"; Background color none:K23:10; Foreground color:K23:1)
					
					//------------------------------------
				: ($Lon_color=0)  //personalized
					
					//displays the system color selection window and returns the RGB value of the color selected by the user
					$Lon_color:=Select RGB color:C956($Lon_color)
					
					//------------------------------------
				Else 
					
					//NOTHING MORE TO DO
					
					//------------------------------------
			End case 
			
			QR_SET_TEXT_PROPERTY($Lon_area; \
				Choose:C955($Txt_action="front@"; qr text color:K14904:6; \
				Choose:C955($Txt_action="backAlt@"; qr alternate background color:K14904:9; qr background color:K14904:8)); \
				String:C10($Lon_color); \
				$Lon_column; $Lon_row)
			
			//______________________________________________________
		: ($Txt_action="data_@")
			
			$Txt_action:=Replace string:C233($Txt_action; "data_"; "")
			
			QR_SET_CELL_DATA($Lon_area; $Lon_column; $Lon_row; Num:C11($Txt_action))
			
			//______________________________________________________
		: ($Txt_action="format_@")
			
			$Txt_action:=Replace string:C233($Txt_action; "format_"; "")
			
			QR_SET_COLUMN_FORMAT($Lon_area; $Lon_column; $Txt_action)
			
			//______________________________________________________
		: ($Txt_action="spacing@")
			
			QR GET TOTALS SPACING:C762($Lon_area; $Lon_row; $lon_value)
			
			Case of 
					
				: ($Txt_action="spacingPoint")
					
					$lon_value:=Choose:C955($lon_value=32000; 0; $lon_value)
					$txt_value:=Request:C163(Get localized string:C991("menu_subtotalSpacingMnuInPoint"); String:C10(Abs:C99($lon_value)))
					
					If (OK=1)
						
						$lon_value:=(Abs:C99(Num:C11($txt_value)))
						
					End if 
					
					//______________________________________________________
				: ($Txt_action="spacingPercent")
					
					$lon_value:=Choose:C955($lon_value=32000; 0; $lon_value)
					$txt_value:=Request:C163(Get localized string:C991("menu_subtotalSpacingMnuInPercent"); String:C10(Abs:C99($lon_value)))
					
					If (OK=1)
						
						$lon_value:=(-Abs:C99(Num:C11($txt_value)))
						
					End if 
					
					//______________________________________________________
				: ($Txt_action="spacingPageBreak")
					
					$lon_value:=Choose:C955($lon_value=32000; 0; 32000)
					
			End case 
			
			If (OK=1)
				
				QR SET TOTALS SPACING:C761($Lon_area; $Lon_row; $lon_value)
				
			End if 
			
		Else 
			
			ASSERT:C1129(False:C215; "Action not yet available: \""+$Txt_action+"\"")
			
			//______________________________________________________
	End case 
	
	If ($Txt_action#"font_picker")
		
		report_AREA_UPDATE
		
	End if 
End if 

// ----------------------------------------------------
// End