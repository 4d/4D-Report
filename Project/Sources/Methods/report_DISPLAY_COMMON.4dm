//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : report_DISPLAY_COMMON
// Database: 4D Report
// ID[85929BF03AD043D7A768491DAAFEA156]
// Created #12-7-2016 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations

#DECLARE($Obj_params : Object)


var $action; $column_name; $header_name; $listbox_name : Text

var $i; $index; $x : Integer
var $count_parameters; $row_number; $column_number; $row; $column : Integer

var $best_height; $best_width : Integer
var $default_column_width; $default_row_height : Integer

var $left; $top; $right; $bottom; $width : Integer
var $left_position; $top_position; $right_position; $bottom_position : Integer
var $h_offset : Integer

var $best_object_size; $nil; $row_height_array : Pointer



ARRAY BOOLEAN:C223($_visibles; 0)
ARRAY POINTER:C280($_styles; 0)
ARRAY POINTER:C280($_columns; 0)
ARRAY POINTER:C280($_headers; 0)
ARRAY TEXT:C222($_columns_name; 0)
ARRAY TEXT:C222($_headers_name; 0)



// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=1; "Missing parameter"))
	
	//Required parameters
	//$Obj_params:=$1
	
	//Optional parameters
	If ($count_parameters>=2)
		
		// <NONE>
		
	End if 
	
	$action:=OB Get:C1224($Obj_params; "action"; Is text:K8:3)
	$listbox_name:=OB Get:C1224($Obj_params; "object"; Is text:K8:3)
	
	LISTBOX GET ARRAYS:C832(*; $listbox_name; $_columns_name; $_headers_name; $_columns; $_headers; $_visibles; $_styles)
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($action="adjustColumnNumber")
		
		$index:=OB Get:C1224($Obj_params; "columnsNumber"; Is longint:K8:6)
		
		Repeat 
			
			$x:=Find in array:C230($_columns_name; "QR_column_"+String:C10($index))
			
			If ($x>0)
				
				LISTBOX DELETE COLUMN:C830(*; $listbox_name; $x; 1)
				$index:=$index+1
				
				LISTBOX GET ARRAYS:C832(*; $listbox_name; $_columns_name; $_headers_name; $_columns; $_headers; $_visibles; $_styles)
				
			End if 
		Until ($x=-1)
		
		//______________________________________________________
	: ($action="adjustRowsNumber")
		
		Repeat 
			
			$row_number:=LISTBOX Get number of rows:C915(*; $listbox_name)
			
			If ($row_number>0)
				
				LISTBOX DELETE ROWS:C914(*; $listbox_name; 1; $row_number)
				
			End if 
		Until ($row_number=0)
		
		$row_number:=OB Get:C1224($Obj_params; "rowsNumber"; Is longint:K8:6)
		LISTBOX INSERT ROWS:C913(*; $listbox_name; 1; $row_number)
		
		//______________________________________________________
	: ($action="createColumn")
		
		$column_name:=OB Get:C1224($Obj_params; "columnName"; Is text:K8:3)
		$header_name:=OB Get:C1224($Obj_params; "headerName"; Is text:K8:3)
		$index:=OB Get:C1224($Obj_params; "columnPosition"; Is longint:K8:6)
		
		$x:=Find in array:C230($_columns_name; $column_name)
		
		If ($x<0)
			
			//append a new column
			LISTBOX DUPLICATE COLUMN:C1273(*; "tmpl_column"; $index; $column_name; $nil; $header_name; $nil)
			APPEND TO ARRAY:C911((OBJECT Get pointer:C1124(Object named:K67:5; $column_name))->; "")  //set the type as text
			DELETE FROM ARRAY:C228((OBJECT Get pointer:C1124(Object named:K67:5; $column_name))->; 1; 1)
			OBJECT SET VISIBLE:C603(*; $column_name; True:C214)
			
		End if 
		
		If (OB Is defined:C1231($Obj_params; "columnWidth"))
			
			LISTBOX SET COLUMN WIDTH:C833(*; $column_name; OB Get:C1224($Obj_params; "columnWidth"; Is longint:K8:6))
			
		End if 
		
		//______________________________________________________
	: ($action="filler")
		
		$column_name:="filler"
		
		$x:=Find in array:C230($_columns_name; $column_name)
		
		If ($x<0)
			
			LISTBOX INSERT COLUMN:C829(*; $listbox_name; Size of array:C274($_columns_name)+1; $column_name; $nil; "head_filler"; $nil)
			//set the type - [ARRAY OBJECT] for future use ;-)
			EXECUTE FORMULA:C63("ARRAY OBJECT:C1221((OBJECT Get pointer:C1124(Object named:K67:5;\""+$column_name+"\"))->;0)")
			
		End if 
		
		//______________________________________________________
	: ($action="headercolumnWidth")
		
		//#DO_NOT_WORKS [
		//OBJECT GET BEST SIZE(*;$tTxt_columns{1};$best_width;$best_height)
		//LISTBOX SET COLUMN WIDTH(*;$tTxt_columns{1};$best_width)
		$row_number:=OB Get:C1224($Obj_params; "rowNumber"; Is longint:K8:6)
		$best_object_size:=OBJECT Get pointer:C1124(Object named:K67:5; "bestobjectsize")
		
		If (OB Get:C1224(ob_area; "reportType"; Is longint:K8:6)=qr list report:K14902:1)
			
			For ($i; 1; $row_number; 1)
				
				$best_object_size->:=$_columns{1}->{$i}+"\r"
				OBJECT GET BEST SIZE:C717(*; "bestobjectsize"; $best_width; $best_height)
				
				$best_width:=$best_width*1.3
				
				If ($best_width>$width)
					
					$width:=$best_width
					
				End if 
			End for 
			
			
			//mark:- ACI0103452
			//#DD si un jour nous voulons contrôler la largeur de la colonne 1, c'est ici que cela se passe
			//If ($width>=256)
			//LISTBOX SET PROPERTY(*; $tTxt_columns{1}; lk truncate; lk with ellipsis)
			//$width:=256
			//Else 
			//LISTBOX SET PROPERTY(*; $tTxt_columns{1}; lk truncate; lk without ellipsis)
			//End if 
			//mark:- END
			
			
			//not resizable
			LISTBOX SET COLUMN WIDTH:C833(*; $_columns_name{1}; $width; $width; $width)
			
		Else 
			
			LISTBOX SET COLUMN WIDTH:C833(*; $_columns_name{1}; Form:C1466.defaultColumWidth; 10; MAXTEXTLENBEFOREV11:K35:3)
			
		End if 
		//]
		
		//______________________________________________________
	: ($action="rowHeight")
		
		$column_number:=OB Get:C1224($Obj_params; "columnNumber"; Is longint:K8:6)
		$row_number:=OB Get:C1224($Obj_params; "rowNumber"; Is longint:K8:6)
		$default_column_width:=OB Get:C1224($Obj_params; "columnWidth"; Is longint:K8:6)  //width for automatic size
		$default_row_height:=OB Get:C1224($Obj_params; "rowHeight"; Is longint:K8:6)  //default height (pixels) for rows in the list mode
		
		$best_object_size:=OBJECT Get pointer:C1124(Object named:K67:5; "bestobjectsize")
		
		//#WARNING: 4D View Pro license required
		$row_height_array:=LISTBOX Get array:C1278(*; $listbox_name; lk row height array:K53:34)
		
		//#DO_NOT_WORKS - ALWAYS NIL
		//#TURN_AROUND - Use a process variable
		ARRAY LONGINT:C221(tLon_rowHeights; $row_number)
		
		//for each row
		For ($row; 1; $row_number; 1)
			
			//set default height
			tLon_rowHeights{$row}:=$default_row_height
			
			//for each cell of the row
			For ($column; 1; $column_number; 1)
				
				//get best cell height
				$best_object_size->:=$_columns{$column}->{$row}
				
				OBJECT GET BEST SIZE:C717(*; "bestobjectsize"; $best_width; $best_height; LISTBOX Get column width:C834(*; $_columns_name{$column}))
				
				tLon_rowHeights{$row}:=_max(tLon_rowHeights{$row}; $best_height+10)  //add 10px offset
				
			End for 
		End for 
		
		LISTBOX SET ARRAY:C1279(*; $listbox_name; lk row height array:K53:34; ->tLon_rowHeights)
		
		//______________________________________________________
	: ($action="adjustBalloon")
		
		$column:=OB Get:C1224($Obj_params; "column"; Is longint:K8:6)
		
		//header
		OBJECT GET COORDINATES:C663(*; $_headers_name{$column}; $left; $top; $right; $bottom)
		
		$left_position:=$right-Form:C1466.headerButtonWidth
		$top_position:=$top+Form:C1466.headerButtonOffset
		$right_position:=$left_position+Form:C1466.headerButtonWidth
		$bottom_position:=$top_position+Form:C1466.headerButtonWidth
		
		OBJECT GET COORDINATES:C663(*; "header_action"; $left; $top; $right; $bottom)
		
		If ($left#$left_position)
			
			$h_offset:=$left_position-$left
			
			If (Not:C34(ob_area.crossReport))
				
				OBJECT MOVE:C664(*; "header_action"; $h_offset; 0)
				OBJECT MOVE:C664(*; "balloon.subform"; $h_offset; 0)
				
			End if 
			
		End if 
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Unknown entry point: \""+$action+"\"")
		
		//______________________________________________________
End case 

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End