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

#DECLARE($area : Integer; $column : Integer; $row : Integer)



var $is_crossReport; $is_data; $is_not_binary; $is_text : Boolean
var $is_color : Boolean

var $border; $thickness; $column_count : Integer
var $columnNumber; $back_color; $alt_back_color; $color : Integer
var $columnType; $destination; $font_color; $font_size; $font_style : Integer
var $hidden : Integer
var $justification : Integer
var $line_number; $operator; $count_parameters; $repeated : Integer
var $type; $width; $sub_break_spacing; $sort_index; $numeric_value : Integer

var $file_path; $main_menu; $sub_menu; $action; $buffer; $column_format : Text
var $data; $format; $formula; $object_name; $title; $template_name; $text_value : Text



// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=1; "Missing parameter"))
	
	//$area:=$1
	
	If ($count_parameters>=2)
		
		//$column:=$2
		
		If ($count_parameters>=3)
			
			//$row:=$3
			
		End if 
	End if 
	
	$is_crossReport:=(OB Get:C1224(ob_area; "reportType"; Is longint:K8:6)=qr cross report:K14902:2)
	
	If ($is_crossReport)
		
		If ($column=1)\
			 & ($row=1)
			
			$column:=0
			$row:=0
			
		End if 
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
//Get columns that have a sort order
ARRAY LONGINT:C221($_sorted_columns; 0x0000)
ARRAY LONGINT:C221($_sort_order; 0x0000)

QR GET SORTS:C753($area; $_sorted_columns; $_sort_order)

//Number of columns & rows of the QR
$line_number:=Size of array:C274($_sorted_columns)+3
$columnNumber:=QR Count columns:C764($area)

$columnType:=Is undefined:K8:13

//Retrieve column properties and common values
If (($column>0)\
 & ($column<=$columnNumber))\
 | $is_crossReport
	
	If (Not:C34($is_crossReport))
		
		QR GET INFO COLUMN:C766($area; $column; $title; $object_name; $hidden; $width; $repeated; $format; $formula)
		
	End if 
	
	If ($column#-1)
		
		$font_style:=QR_Get_font_style($area; $column; $row)
		$font_size:=QR_Get_font_size($area; $column; $row)
		$justification:=QR_Get_justification($area; $column; $row)
		$font_color:=QR_Get_color($area; $column; $row)
		
		//************************************************
		//*                   #TO_BE_DONE                *
		//************************************************
		$back_color:=QR_Get_color($area; $column; $row; qr background color:K14904:8)
		$alt_back_color:=QR_Get_color($area; $column; $row; qr alternate background color:K14904:9)
		
		$columnType:=QR_Get_column_type($area; $column)
		$is_not_binary:=($columnType#Is BLOB:K8:12) & ($columnType#Is picture:K8:10) & ($columnType#Is subtable:K8:11)
		
		$column_format:=QR_Get_column_format($area; $column; $columnType)
		
	End if 
	
	If ($column>0)\
		 & (($row>0)\
		 | ($row=qr grand total:K14906:3))
		
		QR GET TOTALS DATA:C768($area; $column; $row; $operator; $data)
		
	End if 
	
Else 
	
	If ($column=0)\
		 & ($row#0)
		
		$hidden:=QR Get info row:C769($area; $row)
		
	End if 
End if 

// retrieve subtotal spacing if any
If (Not:C34($is_crossReport)\
 & ($row>0))
	
	$sub_break_spacing:=QR_get_TotalsSpacing($area; $row)
	
End if 

$main_menu:=Create menu:C408

If ($is_crossReport)
	
	Case of 
			
			//______________________________________________________
		: (($column=1)\
			 & ($row=2))\
			 | (($column=2) & ($row<3))
			
			APPEND MENU ITEM:C411($main_menu; ":xliff:menu_edit_formula")
			SET MENU ITEM PARAMETER:C1004($main_menu; -1; "header_edit")
			
			APPEND MENU ITEM:C411($main_menu; "-")
			
			//______________________________________________________
		: (($column=1)\
			 & ($row=3))\
			 | (($column=3) & ($row=1))
			
			APPEND MENU ITEM:C411($main_menu; ":xliff:menu_edit")
			SET MENU ITEM PARAMETER:C1004($main_menu; -1; "edit")
			
			APPEND MENU ITEM:C411($main_menu; "-")
			
			//______________________________________________________
	End case 
End if 

Case of 
		
		//______________________________________________________
	: ($column>$columnNumber)\
		 | ($row>$line_number)
		
		//{n+1,x} | {x, n+1} = external
		
		APPEND MENU ITEM:C411($main_menu; ":xliff:menu_add_column")
		SET MENU ITEM PARAMETER:C1004($main_menu; -1; "add")
		
		//______________________________________________________
	: ($column=0)\
		 & ($row=0)
		
		//{0,0} = All
		
		$sub_menu:=Create menu:C408
		
		QR GET DESTINATION:C756($area; $type; $file_path)
		
		If (Not:C34($is_crossReport))
			
			APPEND MENU ITEM:C411($main_menu; ":xliff:menu_add_column")
			SET MENU ITEM PARAMETER:C1004($main_menu; -1; "add")
			
			APPEND MENU ITEM:C411($main_menu; "-")
			
		End if 
		
		APPEND MENU ITEM:C411($sub_menu; ":xliff:menu_printer")
		SET MENU ITEM PARAMETER:C1004($sub_menu; -1; "dest_"+String:C10(qr printer:K14903:1))
		SET MENU ITEM MARK:C208($sub_menu; -1; Char:C90(18)*Num:C11($type=qr printer:K14903:1))
		
		APPEND MENU ITEM:C411($sub_menu; ":xliff:menu_text_file")
		SET MENU ITEM PARAMETER:C1004($sub_menu; -1; "dest_"+String:C10(qr text file:K14903:2))
		SET MENU ITEM MARK:C208($sub_menu; -1; Char:C90(18)*Num:C11($type=qr text file:K14903:2))
		
		APPEND MENU ITEM:C411($sub_menu; ":xliff:menu_html_file")
		SET MENU ITEM PARAMETER:C1004($sub_menu; -1; "dest_"+String:C10(qr HTML file:K14903:5))
		SET MENU ITEM MARK:C208($sub_menu; -1; Char:C90(18)*Num:C11($type=qr HTML file:K14903:5))
		
		APPEND MENU ITEM:C411($main_menu; ":xliff:menu_destination"; $sub_menu)
		RELEASE MENU:C978($sub_menu)
		
		If (<>withFeature110931)
			
			APPEND MENU ITEM:C411($main_menu; "-")
			
			//$sub_menu:=Create menu
			
			$sub_menu:=mnu_border
			APPEND MENU ITEM:C411($main_menu; ":xliff:menu_borders"; $sub_menu)
			SET MENU ITEM PARAMETER:C1004($main_menu; -1; "")
			RELEASE MENU:C978($sub_menu)
			
		End if 
		
		If (Form:C1466.debug)
			
			APPEND MENU ITEM:C411($main_menu; "-")
			
			APPEND MENU ITEM:C411($main_menu; ":xliff:menu_header_and_footers")
			SET MENU ITEM PARAMETER:C1004($main_menu; -1; "header&footer")
			
		End if 
		
		$is_text:=($columnNumber>0)
		
		//______________________________________________________
	: ($row=0)
		
		//{n,0} = header
		
		$sort_index:=Find in array:C230($_sorted_columns; $column)
		
		If ($sort_index>0)
			
			$_sort_order{0}:=$_sort_order{$sort_index}
			
		End if 
		
		If ($column=$columnNumber)
			
			APPEND MENU ITEM:C411($main_menu; ":xliff:menu_add_column")
			SET MENU ITEM PARAMETER:C1004($main_menu; -1; "add")
			
		End if 
		
		APPEND MENU ITEM:C411($main_menu; ":xliff:menu_insert_column")
		SET MENU ITEM PARAMETER:C1004($main_menu; -1; "insert")
		
		APPEND MENU ITEM:C411($main_menu; "-")
		
		APPEND MENU ITEM:C411($main_menu; ":xliff:menu_edit_formula")
		SET MENU ITEM PARAMETER:C1004($main_menu; -1; "header_edit")
		
		APPEND MENU ITEM:C411($main_menu; "-")
		
		APPEND MENU ITEM:C411($main_menu; ":xliff:menu_hide_column")
		SET MENU ITEM PARAMETER:C1004($main_menu; -1; "hide")
		SET MENU ITEM MARK:C208($main_menu; -1; Char:C90(18)*Num:C11($hidden=1))
		
		APPEND MENU ITEM:C411($main_menu; ":xliff:menu_delete_column")
		SET MENU ITEM PARAMETER:C1004($main_menu; -1; "delete")
		
		APPEND MENU ITEM:C411($main_menu; "-")
		
		APPEND MENU ITEM:C411($main_menu; ":xliff:menu_repeated_values")
		SET MENU ITEM PARAMETER:C1004($main_menu; -1; "repeted_values")
		SET MENU ITEM MARK:C208($main_menu; -1; Char:C90(18)*Num:C11($repeated=1))
		
		APPEND MENU ITEM:C411($main_menu; ":xliff:menu_automatic_width")
		SET MENU ITEM PARAMETER:C1004($main_menu; -1; "automatic_width")
		SET MENU ITEM MARK:C208($main_menu; -1; Char:C90(18)*Num:C11($width=-1))
		
		If (<>withFeature110931)
			
			APPEND MENU ITEM:C411($main_menu; "-")
			
			$sub_menu:=Create menu:C408
			
			$sub_menu:=mnu_border
			APPEND MENU ITEM:C411($main_menu; ":xliff:menu_borders"; $sub_menu)
			SET MENU ITEM PARAMETER:C1004($main_menu; -1; "")
			RELEASE MENU:C978($sub_menu)
			
		End if 
		
		If (($is_not_binary) & (Not:C34($is_crossReport)))
			
			APPEND MENU ITEM:C411($main_menu; "-")
			
			$sub_menu:=Create menu:C408
			
			APPEND MENU ITEM:C411($sub_menu; ":xliff:menu_sort_none")
			SET MENU ITEM PARAMETER:C1004($sub_menu; -1; "sort_none")
			SET MENU ITEM MARK:C208($sub_menu; -1; Char:C90(18)*Num:C11($_sort_order{0}=0))
			
			APPEND MENU ITEM:C411($sub_menu; "-")
			
			APPEND MENU ITEM:C411($sub_menu; ":xliff:menu_sort_ascending")
			SET MENU ITEM PARAMETER:C1004($sub_menu; -1; "sort_ascending")
			SET MENU ITEM MARK:C208($sub_menu; -1; Char:C90(18)*Num:C11($_sort_order{0}=1))
			
			APPEND MENU ITEM:C411($sub_menu; ":xliff:menu_sort_descending")
			SET MENU ITEM PARAMETER:C1004($sub_menu; -1; "sort_descending")
			SET MENU ITEM MARK:C208($sub_menu; -1; Char:C90(18)*Num:C11($_sort_order{0}=-1))
			
			APPEND MENU ITEM:C411($main_menu; ":xliff:menu_sort_order"; $sub_menu)
			SET MENU ITEM PARAMETER:C1004($main_menu; -1; "sort")
			
			RELEASE MENU:C978($sub_menu)
			
		End if 
		
		$is_text:=True:C214
		
		//______________________________________________________
	: ($column=0)
		
		//{1,n} = line header
		
		$is_text:=($columnNumber>0)
		$is_data:=(($row>0) | ($row=qr grand total:K14906:3)) & ($columnNumber>0)
		
		If ($row#0)
			
			APPEND MENU ITEM:C411($main_menu; ":xliff:menu_hide_row")
			SET MENU ITEM PARAMETER:C1004($main_menu; -1; "hide")
			SET MENU ITEM MARK:C208($main_menu; -1; Char:C90(18)*Num:C11($hidden=1))
			
			
			If (<>withFeature110931)
				
				//$sub_menu:=Create menu
				
				$sub_menu:=mnu_border
				APPEND MENU ITEM:C411($main_menu; ":xliff:menu_borders"; $sub_menu)
				SET MENU ITEM PARAMETER:C1004($main_menu; -1; "")
				RELEASE MENU:C978($sub_menu)
				
			End if 
		End if 
		
		//______________________________________________________
	Else 
		
		//{n,n} - Cell
		
		If ($column#-1)
			
			$is_text:=True:C214
			$is_data:=($row>0) | ($row=qr grand total:K14906:3)
			
			If (<>withFeature110931)
				
				
				//$sub_menu:=Create menu
				
				$sub_menu:=mnu_border
				APPEND MENU ITEM:C411($main_menu; ":xliff:menu_borders"; $sub_menu)
				SET MENU ITEM PARAMETER:C1004($main_menu; -1; "")
				RELEASE MENU:C978($sub_menu)
				
			End if 
		End if 
		
		//______________________________________________________
End case 

If ($is_data)\
 & ($is_not_binary | ($column=0))
	
	If ($is_crossReport)\
		 & (($row=1)\
		 | ($column=1))
		
	Else 
		
		If (Count menu items:C405($main_menu)>0)
			
			APPEND MENU ITEM:C411($main_menu; "-")
			
		End if 
		
		APPEND MENU ITEM:C411($main_menu; ":xliff:menu_sum")
		SET MENU ITEM PARAMETER:C1004($main_menu; -1; "data_0")
		SET MENU ITEM MARK:C208($main_menu; -1; Char:C90(18)*Num:C11($operator ?? 0))
		
		APPEND MENU ITEM:C411($main_menu; ":xliff:menu_average")
		SET MENU ITEM PARAMETER:C1004($main_menu; -1; "data_1")
		SET MENU ITEM MARK:C208($main_menu; -1; Char:C90(18)*Num:C11($operator ?? 1))
		
		APPEND MENU ITEM:C411($main_menu; ":xliff:menu_min")
		SET MENU ITEM PARAMETER:C1004($main_menu; -1; "data_2")
		SET MENU ITEM MARK:C208($main_menu; -1; Char:C90(18)*Num:C11($operator ?? 2))
		
		APPEND MENU ITEM:C411($main_menu; ":xliff:menu_max")
		SET MENU ITEM PARAMETER:C1004($main_menu; -1; "data_3")
		SET MENU ITEM MARK:C208($main_menu; -1; Char:C90(18)*Num:C11($operator ?? 3))
		
		APPEND MENU ITEM:C411($main_menu; ":xliff:menu_count")
		SET MENU ITEM PARAMETER:C1004($main_menu; -1; "data_4")
		SET MENU ITEM MARK:C208($main_menu; -1; Char:C90(18)*Num:C11($operator ?? 4))
		
		APPEND MENU ITEM:C411($main_menu; ":xliff:menu_standard_deviation")
		SET MENU ITEM PARAMETER:C1004($main_menu; -1; "data_5")
		SET MENU ITEM MARK:C208($main_menu; -1; Char:C90(18)*Num:C11($operator ?? 5))
		
	End if 
End if 

If ($is_text)
	
	If ($is_not_binary | ($column=0))
		
		If (Count menu items:C405($main_menu)>0)
			
			APPEND MENU ITEM:C411($main_menu; "-")
			
		End if 
		
		$sub_menu:=mnu_Font
		APPEND MENU ITEM:C411($main_menu; ":xliff:menu_font"; $sub_menu)
		SET MENU ITEM PARAMETER:C1004($main_menu; -1; "")
		RELEASE MENU:C978($sub_menu)
		
		$sub_menu:=mnu_FontSize($font_size)
		APPEND MENU ITEM:C411($main_menu; ":xliff:menu_size"; $sub_menu)
		SET MENU ITEM PARAMETER:C1004($main_menu; -1; "")
		RELEASE MENU:C978($sub_menu)
		
		$sub_menu:=mnu_FontSyle($font_style)
		APPEND MENU ITEM:C411($main_menu; ":xliff:menu_style"; $sub_menu)
		SET MENU ITEM PARAMETER:C1004($main_menu; -1; "")
		RELEASE MENU:C978($sub_menu)
		
		$sub_menu:=mnu_Justification($justification)
		APPEND MENU ITEM:C411($main_menu; ":xliff:menu_justification"; $sub_menu)
		SET MENU ITEM PARAMETER:C1004($main_menu; -1; "")
		RELEASE MENU:C978($sub_menu)
		
		$sub_menu:=mnu_Color($font_color)
		APPEND MENU ITEM:C411($main_menu; ":xliff:menu_font_color"; $sub_menu)
		SET MENU ITEM PARAMETER:C1004($main_menu; -1; "")
		RELEASE MENU:C978($sub_menu)
		
	End if 
	
	$sub_menu:=mnu_Color($back_color; "back")
	APPEND MENU ITEM:C411($main_menu; ":xliff:menu_background_color"; $sub_menu)
	SET MENU ITEM PARAMETER:C1004($main_menu; -1; "")
	RELEASE MENU:C978($sub_menu)
	
	If ($row=qr detail:K14906:2)
		
		$sub_menu:=mnu_Color($alt_back_color; "backAlt")
		APPEND MENU ITEM:C411($main_menu; ":xliff:menu_alternate_background_color"; $sub_menu)
		SET MENU ITEM PARAMETER:C1004($main_menu; -1; "")
		RELEASE MENU:C978($sub_menu)
		
	End if 
	
	// #ACI0101161 
	//If ($row>0)
	If ($row>0) & Not:C34($is_crossReport)
		
		$sub_menu:=mnu_breakSpacing($sub_break_spacing)
		
		APPEND MENU ITEM:C411($main_menu; "-")
		APPEND MENU ITEM:C411($main_menu; ":xliff:menu_subtotalSpacingItem"; $sub_menu)
		SET MENU ITEM PARAMETER:C1004($main_menu; -1; "")
		RELEASE MENU:C978($sub_menu)
		
	End if 
	//ACI0101179
	//If ($row>0)
	If (($row=0) & (Not:C34($is_crossReport)))  //The format is global for a column
		
		$sub_menu:=menu_format($columnType; $column_format)
		
		If (Count menu items:C405($sub_menu)>0)
			
			APPEND MENU ITEM:C411($main_menu; "-")
			
			APPEND MENU ITEM:C411($main_menu; ":xliff:menu_format"; $sub_menu)
			RELEASE MENU:C978($sub_menu)
			
		End if 
	End if 
End if 

$action:=Dynamic pop up menu:C1006($main_menu)
RELEASE MENU:C978($main_menu)

If (Length:C16($action)#0)
	
	Case of 
			
			//______________________________________________________
		: ($action="dest_@")
			
			$destination:=Num:C11(Replace string:C233($action; "dest_"; ""))
			
			// #ACI0099118 : set destination is erasing the html template, so we need to save it and re-set it. 
			$template_name:=QR Get HTML template:C751($area)
			If (($template_name="") & Not:C34(ob_dialog.optionHTMLtemplate=Null:C1517))
				$template_name:=ob_dialog.optionHTMLtemplate
			End if 
			
			QR SET DESTINATION:C745($area; $destination)
			QR SET HTML TEMPLATE:C750($area; $template_name)
			
			//______________________________________________________
		: ($action="add")\
			 | ($action="insert")
			
			CLEAR VARIABLE:C89($formula)
			EDIT FORMULA:C806(Table:C252(QR Get report table:C758($area))->; $formula)
			
			
			Case of 
					
				: (OK=0)
					
				: (Length:C16($formula)=0)
					//mark:ACI0103550 empty formula is not accepted
					
				Else 
					
					$column:=Choose:C955($action="add"; $columnNumber+1; $column)
					
					QR INSERT COLUMN:C748($area; $column; $formula)
					QR SET INFO COLUMN:C765($area; $column; ""; $formula; 0; -1; 1; "")
					
					QR_SET_TITLE($area; $column)
					
			End case 
			
			//______________________________________________________
		: ($action="edit")
			
			$buffer:=Choose:C955($column=1; "headers"; "QR_column_2")
			OBJECT SET ENTERABLE:C238(*; $buffer; True:C214)
			EDIT ITEM:C870(*; $buffer; $row)
			
			// #ACI0101165
			ob_area.cellEdition:=True:C214
			
			//______________________________________________________
		: ($action="header_edit")
			
			If ($is_crossReport)
				
				report_EDIT_COLUMN_FORMULA($area; 1+Choose:C955($row>1; $column; 0))
				
			Else 
				
				report_EDIT_COLUMN_FORMULA($area; $column)
				
			End if 
			
			//______________________________________________________
		: ($action="delete")
			
			QR DELETE COLUMN:C749($area; $column)
			
			//______________________________________________________
		: ($action="hide")
			
			If ($column=0)
				
				//hide/show the row
				QR SET INFO ROW:C763($area; $row; Abs:C99(1-$hidden))
				
			Else 
				//hide/show the column
				QR SET INFO COLUMN:C765($area; $column; $title; $object_name; Abs:C99(1-$hidden); $width; $repeated; $format)
				
			End if 
			
			//______________________________________________________
		: ($action="border@")
			
			
			
			ARRAY LONGINT:C221($_arrColumns; 0)
			ARRAY LONGINT:C221($_arrOrders; 0)
			
			$action:=Substring:C12($action; 7)
			$is_color:=Choose:C955($action="@color@"; True:C214; False:C215)
			
			Case of 
					
					//________________________________________
				: ($action="All@")
					
					$border:=(qr bottom border:K14908:4+qr top border:K14908:2+qr left border:K14908:1+\
						qr right border:K14908:3+qr inside horizontal border:K14908:6+qr inside vertical border:K14908:5)
					
					//________________________________________
				: ($action="Out@")
					
					$border:=(qr bottom border:K14908:4+qr top border:K14908:2+qr left border:K14908:1+qr right border:K14908:3)
					
					//________________________________________
				: ($action="Ins@")
					
					$border:=qr inside vertical border:K14908:5
					
					//________________________________________
				: ($action="Ver@")
					
					$border:=qr inside vertical border:K14908:5
					
					//________________________________________
				: ($action="Hor@")
					
					$border:=qr inside horizontal border:K14908:6
					
					//________________________________________
				: ($action="Lef@")
					
					$border:=qr left border:K14908:1
					
					//________________________________________
				: ($action="Rig@")
					
					$border:=qr right border:K14908:3
					
					//________________________________________
				: ($action="Top@")
					
					$border:=qr top border:K14908:2
					
					//________________________________________
				: ($action="Bot@")
					
					$border:=qr bottom border:K14908:4
					
					//________________________________________
			End case 
			
			If (Not:C34(($border=15) | ($border=63)))
				
				// if not mixed we get the previous value
				QR GET BORDERS:C798($area; $column; $row; $border; $thickness; $color)
				
			Else 
				
				// if mixed we set the default value
				$thickness:=1
				$color:=1
				
			End if 
			
			$numeric_value:=Num:C11($action)
			
			If ($is_color)
				
				$color:=$numeric_value
				
			Else 
				
				$thickness:=$numeric_value
				
			End if 
			
			Case of 
					//________________________________________
				: (($column=0) & ($row=0))  // global cells
					
					$column_count:=QR Count columns:C764($area)
					QR GET SORTS:C753($area; $_arrColumns; $_arrOrders)
					
					For ($row; qr grand total:K14906:3; Size of array:C274($_arrColumns); 1)
						
						If ($row#0)
							
							For ($column; 1; $column_count; 1)
								
								QR SET BORDERS:C797($area; $column; $row; $border; $thickness; $color)
								
							End for 
						End if 
					End for 
					
					//________________________________________
				: ($column=0)  //  We are in row section
					
					For ($column; 1; QR Count columns:C764($area))
						
						QR SET BORDERS:C797($area; $column; $row; $border; $thickness; $color)
						
					End for 
					
					//________________________________________
				: ($row=0)  // we are in a column 
					
					QR GET SORTS:C753($area; $_arrColumns; $_arrOrders)
					
					For ($row; qr grand total:K14906:3; Size of array:C274($_arrColumns); 1)
						
						If ($row#0)
							
							QR SET BORDERS:C797($area; $column; $row; $border; $thickness; $color)
							
						End if 
					End for 
					
					//________________________________________
				Else   // we are in a cell
					
					QR SET BORDERS:C797($area; $column; $row; $border; $thickness; $color)
					
			End case 
			
			//______________________________________________________
		: ($action="header&footer")
			
			QR EXECUTE COMMAND:C791($area; qr cmd header and footer:K14900:23)
			
			//______________________________________________________
		: ($action="repeted_values")
			
			QR SET INFO COLUMN:C765($area; $column; $title; $formula; $hidden; $width; Abs:C99(1-$repeated); $format)
			
			//______________________________________________________
		: ($action="automatic_width")
			
			QR_SET_COLUMN_WIDTH($area; $column; Choose:C955($width=-1; 128; -1))
			
			//______________________________________________________
		: ($action="sort_@")
			
			$action:=Replace string:C233($action; "sort_"; "")
			
			Case of 
					
					//------------------------------------
				: ($action="none")
					
					If ($sort_index>0)
						
						DELETE FROM ARRAY:C228($_sorted_columns; $sort_index; 1)
						DELETE FROM ARRAY:C228($_sort_order; $sort_index; 1)
						
					End if 
					
					//------------------------------------
				: ($action="ascending")
					
					If ($sort_index>0)
						
						$_sort_order{$sort_index}:=1
						
					Else 
						
						APPEND TO ARRAY:C911($_sorted_columns; $column)
						APPEND TO ARRAY:C911($_sort_order; 1)
						
					End if 
					
					//------------------------------------
				: ($action="descending")
					
					If ($sort_index>0)
						
						$_sort_order{$sort_index}:=-1
						
					Else 
						
						APPEND TO ARRAY:C911($_sorted_columns; $column)
						APPEND TO ARRAY:C911($_sort_order; -1)
						
					End if 
					
					//------------------------------------
				Else 
					
					TRACE:C157
					
					//------------------------------------
			End case 
			
			QR SET SORTS:C752($area; $_sorted_columns; $_sort_order)
			
			//______________________________________________________
		: ($action="font_picker")
			
			GOTO OBJECT:C206(*; "font_picker")
			OPEN FONT PICKER:C1303(1)
			
			//______________________________________________________
		: ($action="font_@")
			
			QR_SET_TEXT_PROPERTY($area; qr font name:K14904:10; Replace string:C233($action; "font_"; ""); $column; $row)
			
			//______________________________________________________
		: ($action="fontSize_@")
			
			$buffer:=Replace string:C233($action; "fontSize_"; "")
			QR_SET_TEXT_PROPERTY($area; qr font size:K14904:2; $buffer; $column; $row)
			
			//______________________________________________________
		: ($action="fontStyle_@")
			
			$action:=Replace string:C233($action; "fontStyle_"; "")
			
			Case of 
					
					//------------------------------
				: ($action="plain")
					
					QR_SET_TEXT_PROPERTY($area; qr bold:K14904:3; "0"; $column; $row)
					QR_SET_TEXT_PROPERTY($area; qr italic:K14904:4; "0"; $column; $row)
					QR_SET_TEXT_PROPERTY($area; qr underline:K14904:5; "0"; $column; $row)
					
					//------------------------------
				: ($action="bold")
					
					QR_SET_TEXT_PROPERTY($area; qr bold:K14904:3; String:C10(1-Num:C11($font_style ?? 0)); $column; $row)
					
					//------------------------------
				: ($action="italic")
					
					QR_SET_TEXT_PROPERTY($area; qr italic:K14904:4; String:C10(1-Num:C11($font_style ?? 1)); $column; $row)
					
					//------------------------------
				: ($action="underline")
					
					QR_SET_TEXT_PROPERTY($area; qr underline:K14904:5; String:C10(1-Num:C11($font_style ?? 2)); $column; $row)
					
					//------------------------------
				Else 
					
					TRACE:C157
					
					//------------------------------
			End case 
			
			//______________________________________________________
		: ($action="justification_@")
			
			//WARNING
			//There is an offset of -1 between 4D justification and QR justification
			$action:=Replace string:C233($action; "justification_"; "")
			$action:=String:C10(Num:C11($action)-1)
			
			QR_SET_TEXT_PROPERTY($area; qr justification:K14904:7; $action; $column; $row)
			
			//______________________________________________________
		: ($action="@Color_@")
			
			$buffer:=Delete string:C232($action; 1; Position:C15("_"; $action))
			$color:=_hexToDec($buffer)
			
			Case of 
					
					//------------------------------------
				: ($color=1)  //automatic
					
					$color:=Choose:C955($action="back@"; Background color none:K23:10; Foreground color:K23:1)
					
					//------------------------------------
				: ($color=0)  //personalized
					
					//displays the system color selection window and returns the RGB value of the color selected by the user
					$color:=Select RGB color:C956($color)
					
					//------------------------------------
				Else 
					
					//NOTHING MORE TO DO
					
					//------------------------------------
			End case 
			
			QR_SET_TEXT_PROPERTY($area; \
				Choose:C955($action="front@"; qr text color:K14904:6; \
				Choose:C955($action="backAlt@"; qr alternate background color:K14904:9; qr background color:K14904:8)); \
				String:C10($color); \
				$column; $row)
			
			//______________________________________________________
		: ($action="data_@")
			
			$action:=Replace string:C233($action; "data_"; "")
			
			QR_SET_CELL_DATA($area; $column; $row; Num:C11($action))
			
			//______________________________________________________
		: ($action="format_@")
			
			$action:=Replace string:C233($action; "format_"; "")
			
			QR_SET_COLUMN_FORMAT($area; $column; $action)
			
			//______________________________________________________
		: ($action="spacing@")
			
			QR GET TOTALS SPACING:C762($area; $row; $numeric_value)
			
			Case of 
					
				: ($action="spacingPoint")
					
					$numeric_value:=Choose:C955($numeric_value=32000; 0; $numeric_value)
					$text_value:=Request:C163(Localized string:C991("menu_subtotalSpacingMnuInPoint"); String:C10(Abs:C99($numeric_value)))
					
					If (OK=1)
						
						$numeric_value:=(Abs:C99(Num:C11($text_value)))
						
					End if 
					
					//______________________________________________________
				: ($action="spacingPercent")
					
					$numeric_value:=Choose:C955($numeric_value=32000; 0; $numeric_value)
					$text_value:=Request:C163(Localized string:C991("menu_subtotalSpacingMnuInPercent"); String:C10(Abs:C99($numeric_value)))
					
					If (OK=1)
						
						$numeric_value:=(-Abs:C99(Num:C11($text_value)))
						
					End if 
					
					//______________________________________________________
				: ($action="spacingPageBreak")
					
					$numeric_value:=Choose:C955($numeric_value=32000; 0; 32000)
					
			End case 
			
			If (OK=1)
				
				QR SET TOTALS SPACING:C761($area; $row; $numeric_value)
				
			End if 
			
		Else 
			
			ASSERT:C1129(False:C215; "Action not yet available: \""+$action+"\"")
			
			//______________________________________________________
	End case 
	
	If ($action#"font_picker")
		
		report_AREA_UPDATE
		
	End if 
End if 

// ----------------------------------------------------
// End