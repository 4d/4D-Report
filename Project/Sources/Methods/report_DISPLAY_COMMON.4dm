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
C_OBJECT:C1216($1)

C_LONGINT:C283($Lon_bestHeight; $Lon_bestWidth; $Lon_bottom; $Lon_column)
C_LONGINT:C283($Lon_columnNumber; $Lon_defaultColumnWidth; $Lon_defaultRowHeight; $Lon_hOffset; $Lon_i; $Lon_index)
C_LONGINT:C283($Lon_left; $Lon_parameters; $Lon_posBottom; $Lon_posLeft; $Lon_posRight; $Lon_posTop)
C_LONGINT:C283($Lon_right; $Lon_row; $Lon_rowNumber; $Lon_top; $Lon_width; $Lon_x)
C_POINTER:C301($Ptr_bestObectSize; $Ptr_nil; $Ptr_rowHightArray)
C_TEXT:C284($kTxt_reportObject; $Txt_action; $Txt_column; $Txt_header)
C_OBJECT:C1216($Obj_params)

ARRAY BOOLEAN:C223($tBoo_visibles; 0)
ARRAY POINTER:C280($tPtr_arrays; 0)
ARRAY POINTER:C280($tPtr_columns; 0)
ARRAY POINTER:C280($tPtr_headers; 0)
ARRAY TEXT:C222($tTxt_columns; 0)
ARRAY TEXT:C222($tTxt_headers; 0)

If (False:C215)
	C_OBJECT:C1216(report_DISPLAY_COMMON; $1)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1; "Missing parameter"))
	
	//Required parameters
	$Obj_params:=$1
	
	//Optional parameters
	If ($Lon_parameters>=2)
		
		// <NONE>
		
	End if 
	
	$Txt_action:=OB Get:C1224($Obj_params; "action"; Is text:K8:3)
	$kTxt_reportObject:=OB Get:C1224($Obj_params; "object"; Is text:K8:3)
	
	LISTBOX GET ARRAYS:C832(*; $kTxt_reportObject; $tTxt_columns; $tTxt_headers; $tPtr_columns; $tPtr_headers; $tBoo_visibles; $tPtr_arrays)
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($Txt_action="adjustColumnNumber")
		
		$Lon_index:=OB Get:C1224($Obj_params; "columnsNumber"; Is longint:K8:6)
		
		Repeat 
			
			$Lon_x:=Find in array:C230($tTxt_columns; "QR_column_"+String:C10($Lon_index))
			
			If ($Lon_x>0)
				
				LISTBOX DELETE COLUMN:C830(*; $kTxt_reportObject; $Lon_x; 1)
				$Lon_index:=$Lon_index+1
				
				LISTBOX GET ARRAYS:C832(*; $kTxt_reportObject; $tTxt_columns; $tTxt_headers; $tPtr_columns; $tPtr_headers; $tBoo_visibles; $tPtr_arrays)
				
			End if 
		Until ($Lon_x=-1)
		
		//______________________________________________________
	: ($Txt_action="adjustRowsNumber")
		
		Repeat 
			
			$Lon_rowNumber:=LISTBOX Get number of rows:C915(*; $kTxt_reportObject)
			
			If ($Lon_rowNumber>0)
				
				LISTBOX DELETE ROWS:C914(*; $kTxt_reportObject; 1; $Lon_rowNumber)
				
			End if 
		Until ($Lon_rowNumber=0)
		
		$Lon_rowNumber:=OB Get:C1224($Obj_params; "rowsNumber"; Is longint:K8:6)
		LISTBOX INSERT ROWS:C913(*; $kTxt_reportObject; 1; $Lon_rowNumber)
		
		//______________________________________________________
	: ($Txt_action="createColumn")
		
		$Txt_column:=OB Get:C1224($Obj_params; "columnName"; Is text:K8:3)
		$Txt_header:=OB Get:C1224($Obj_params; "headerName"; Is text:K8:3)
		$Lon_index:=OB Get:C1224($Obj_params; "columnPosition"; Is longint:K8:6)
		
		$Lon_x:=Find in array:C230($tTxt_columns; $Txt_column)
		
		If ($Lon_x<0)
			
			//append a new column
			LISTBOX DUPLICATE COLUMN:C1273(*; "tmpl_column"; $Lon_index; $Txt_column; $Ptr_nil; $Txt_header; $Ptr_nil)
			APPEND TO ARRAY:C911((OBJECT Get pointer:C1124(Object named:K67:5; $Txt_column))->; "")  //set the type as text
			DELETE FROM ARRAY:C228((OBJECT Get pointer:C1124(Object named:K67:5; $Txt_column))->; 1; 1)
			OBJECT SET VISIBLE:C603(*; $Txt_column; True:C214)
			
		End if 
		
		If (OB Is defined:C1231($Obj_params; "columnWidth"))
			
			LISTBOX SET COLUMN WIDTH:C833(*; $Txt_column; OB Get:C1224($Obj_params; "columnWidth"; Is longint:K8:6))
			
		End if 
		
		//______________________________________________________
	: ($Txt_action="filler")
		
		$Txt_column:="filler"
		
		$Lon_x:=Find in array:C230($tTxt_columns; $Txt_column)
		
		If ($Lon_x<0)
			
			LISTBOX INSERT COLUMN:C829(*; $kTxt_reportObject; Size of array:C274($tTxt_columns)+1; $Txt_column; $Ptr_nil; "head_filler"; $Ptr_nil)
			//set the type - [ARRAY OBJECT] for future use ;-)
			EXECUTE FORMULA:C63("ARRAY OBJECT:C1221((OBJECT Get pointer:C1124(Object named:K67:5;\""+$Txt_column+"\"))->;0)")
			
		End if 
		
		//______________________________________________________
	: ($Txt_action="headercolumnWidth")
		
		//#DO_NOT_WORKS [
		//OBJECT GET BEST SIZE(*;$tTxt_columns{1};$Lon_bestWidth;$Lon_bestHeight)
		//LISTBOX SET COLUMN WIDTH(*;$tTxt_columns{1};$Lon_bestWidth)
		$Lon_rowNumber:=OB Get:C1224($Obj_params; "rowNumber"; Is longint:K8:6)
		$Ptr_bestObectSize:=OBJECT Get pointer:C1124(Object named:K67:5; "bestobjectsize")
		
		If (OB Get:C1224(ob_area; "reportType"; Is longint:K8:6)=qr list report:K14902:1)
			
			For ($Lon_i; 1; $Lon_rowNumber; 1)
				
				$Ptr_bestObectSize->:=$tPtr_columns{1}->{$Lon_i}+"\r"
				OBJECT GET BEST SIZE:C717(*; "bestobjectsize"; $Lon_bestWidth; $Lon_bestHeight)
				
				$Lon_bestWidth:=$Lon_bestWidth*1.3
				
				If ($Lon_bestWidth>$Lon_width)
					
					$Lon_width:=$Lon_bestWidth
					
				End if 
			End for 
			
			
			//mark:- ACI0103452
			//#DD si un jour nous voulons contrôler la largeur de la colonne 1, c'est ici que cela se passe
			//If ($Lon_width>=256)
			//LISTBOX SET PROPERTY(*; $tTxt_columns{1}; lk truncate; lk with ellipsis)
			//$Lon_width:=256
			//Else 
			//LISTBOX SET PROPERTY(*; $tTxt_columns{1}; lk truncate; lk without ellipsis)
			//End if 
			//mark:- END
			
			
			//not resizable
			LISTBOX SET COLUMN WIDTH:C833(*; $tTxt_columns{1}; $Lon_width; $Lon_width; $Lon_width)
			
		Else 
			
			LISTBOX SET COLUMN WIDTH:C833(*; $tTxt_columns{1}; Form:C1466.defaultColumWidth; 10; MAXTEXTLENBEFOREV11:K35:3)
			
		End if 
		//]
		
		//______________________________________________________
	: ($Txt_action="rowHeight")
		
		$Lon_columnNumber:=OB Get:C1224($Obj_params; "columnNumber"; Is longint:K8:6)
		$Lon_rowNumber:=OB Get:C1224($Obj_params; "rowNumber"; Is longint:K8:6)
		$Lon_defaultColumnWidth:=OB Get:C1224($Obj_params; "columnWidth"; Is longint:K8:6)  //width for automatic size
		$Lon_defaultRowHeight:=OB Get:C1224($Obj_params; "rowHeight"; Is longint:K8:6)  //default height (pixels) for rows in the list mode
		
		$Ptr_bestObectSize:=OBJECT Get pointer:C1124(Object named:K67:5; "bestobjectsize")
		
		//#WARNING: 4D View Pro license required
		$Ptr_rowHightArray:=LISTBOX Get array:C1278(*; $kTxt_reportObject; lk row height array:K53:34)
		
		//#DO_NOT_WORKS - ALWAYS NIL
		//#TURN_AROUND - Use a process variable
		ARRAY LONGINT:C221(tLon_rowHeights; $Lon_rowNumber)
		
		//for each row
		For ($Lon_row; 1; $Lon_rowNumber; 1)
			
			//set default height
			tLon_rowHeights{$Lon_row}:=$Lon_defaultRowHeight
			
			//for each cell of the row
			For ($Lon_column; 1; $Lon_columnNumber; 1)
				
				//get best cell height
				$Ptr_bestObectSize->:=$tPtr_columns{$Lon_column}->{$Lon_row}
				
				OBJECT GET BEST SIZE:C717(*; "bestobjectsize"; $Lon_bestWidth; $Lon_bestHeight; LISTBOX Get column width:C834(*; $tTxt_columns{$Lon_column}))
				
				tLon_rowHeights{$Lon_row}:=_max(tLon_rowHeights{$Lon_row}; $Lon_bestHeight+10)  //add 10px offset
				
			End for 
		End for 
		
		LISTBOX SET ARRAY:C1279(*; $kTxt_reportObject; lk row height array:K53:34; ->tLon_rowHeights)
		
		//______________________________________________________
	: ($Txt_action="adjustBalloon")
		
		$Lon_column:=OB Get:C1224($Obj_params; "column"; Is longint:K8:6)
		
		//header
		OBJECT GET COORDINATES:C663(*; $tTxt_headers{$Lon_column}; $Lon_left; $Lon_top; $Lon_right; $Lon_bottom)
		
		$Lon_posLeft:=$Lon_right-Form:C1466.headerButtonWidth
		$Lon_posTop:=$Lon_top+Form:C1466.headerButtonOffset
		$Lon_posRight:=$Lon_posLeft+Form:C1466.headerButtonWidth
		$Lon_posBottom:=$Lon_posTop+Form:C1466.headerButtonWidth
		
		OBJECT GET COORDINATES:C663(*; "header_action"; $Lon_left; $Lon_top; $Lon_right; $Lon_bottom)
		
		If ($Lon_left#$Lon_posLeft)
			
			$Lon_hOffset:=$Lon_posLeft-$Lon_left
			
			If (Not:C34(ob_area.crossReport))
				
				OBJECT MOVE:C664(*; "header_action"; $Lon_hOffset; 0)
				OBJECT MOVE:C664(*; "balloon.subform"; $Lon_hOffset; 0)
				
			End if 
			
		End if 
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Unknown entry point: \""+$Txt_action+"\"")
		
		//______________________________________________________
End case 

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End