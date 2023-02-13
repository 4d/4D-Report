//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : report_ADD_COLUMN
// Database: 4D Report
// ID[38903F9EB91A480BB18422581B7930DE]
// Created #5-6-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
// ----------------------------------------------------
// Declarations

#DECLARE($action : Text; $description : Object)


var \
$area; \
$count_parameters; \
$column; \
$columnNumber; \
$i; \
$int; \
$rowNumber; \
$currentRow; \
$tableID; \
$tableIndex; \
$fieldID; \
$fieldIndex : Integer

var \
$objectName; \
$formula; \
$text : Text

var \
$need_update : Boolean


If (False:C215)
	C_TEXT:C284(report_ADD_COLUMN; $1)
	C_OBJECT:C1216(report_ADD_COLUMN; $2)
End if 

// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=0; "Missing parameter"))
	
	//NO PARAMETERS REQUIRED
	
	//Optional parameters
	If ($count_parameters>=1)
		
		//$action:=$1  //values: "formula" - "add_all" - "insert_end/begin/after/before"
		
		If ($count_parameters>=2)
			
			//$description:=$2
			
		End if 
		
	Else 
		
		$action:="insert_end"  //default action
		
	End if 
	
	$area:=OB Get:C1224(ob_area; "area"; Is longint:K8:6)
	$column:=OB Get:C1224(ob_area; "qrColumn"; Is longint:K8:6)
	$columnNumber:=OB Get:C1224(ob_area; "qrColumnNumber"; Is longint:K8:6)
	$rowNumber:=OB Get:C1224(ob_area; "qrRowNumber"; Is longint:K8:6)
	$tableID:=QR Get report table:C758($area)
	$tableIndex:=Find in array:C230(tLon_tableIDs; $tableID)
	
	If ($action="add_@")\
		 | ($action="insert_@")
		
		//get all column's objects
		ARRAY TEXT:C222($_fieldInQR; 0x0000)
		
		For ($i; 1; QR Count columns:C764($area); 1)
			
			QR GET INFO COLUMN:C766($area; $i; $text; $objectName; $int; $int; $int; $text)
			
			//#ACI0093166
			//APPEND TO ARRAY($tTxt_fieldInQR;report_virtualFieldName ($Txt_object))
			APPEND TO ARRAY:C911($_fieldInQR; $objectName)
			
		End for 
		
	End if 
	
	ASSERT:C1129(Not:C34(Shift down:C543))
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: (Length:C16($action)=0)
		
		//NOTHING MORE TO DO
		
		//______________________________________________________
	: ($tableIndex<0)
		
		TRACE:C157  //MUST NOT THROUGH HERE
		
		//______________________________________________________
	: ($action="formula")  //add a column formula
		
		EDIT FORMULA:C806(Table:C252($tableID)->; $formula)
		
		//#ACI0092848 - Test if the formula is not empty
		//$Boo_update:=(OK=1)
		$need_update:=(OK=1) & (Length:C16($formula)>0)
		
		If ($need_update)
			
			$column:=$column+1
			QR INSERT COLUMN:C748($area; $column; $formula)
			
		End if 
		
		//______________________________________________________
	: ($action="add_all")  //add all fields that are not already included
		
		For ($i; 1; Size of array:C274(tLon_fieldIDs{$tableIndex}); 1)
			
			If (tLon_fieldIDs{$tableIndex}{$i}#0)
				
				If (QR_isValidField($tableID; tLon_fieldIDs{$tableIndex}{$i}))
					
					//#ACI0093166
					//$Txt_formula:="["+tTxt_tableNames{$Lon_x}+"]"+tTxt_fieldNames{$Lon_x}{$Lon_i}
					//$Txt_formula:="["+report_structureDefinition{0}{$Lon_tableID}+"]"+report_structureDefinition{$Lon_tableID}{$Lon_i}
					
					$formula:="["+report_structureDefinition{0}{$tableID}+"]"+report_structureDefinition{$tableIndex}{tLon_fieldIDs{$tableID}{$i}}
					
					If (Find in array:C230($_fieldInQR; $formula)=-1)
						
						$column:=$column+1
						QR INSERT COLUMN:C748($area; $column; $formula)
						QR SET INFO COLUMN:C765($area; $column; tTxt_fieldNames{$tableIndex}{$i}; $formula; 0; -1; 0; "")
						
						QR_SET_TITLE($area; $column)
						
					End if 
					
				End if 
				
			End if 
			
		End for 
		
		$need_update:=True:C214
		
		//______________________________________________________
	: ($action="append_field")  //append given field at the end
		
		$column:=$columnNumber+1
		
		$tableID:=OB Get:C1224($description; "table"; Is longint:K8:6)
		$fieldID:=OB Get:C1224($description; "field"; Is longint:K8:6)
		
		$tableIndex:=Find in array:C230(tLon_tableIDs; $tableID)
		
		If ($tableIndex#-1)
			
			$fieldIndex:=Find in array:C230(tLon_fieldIDs{$tableID}; $fieldID)
			
			If ($fieldIndex#-1)
				
				$formula:="["+report_structureDefinition{0}{$tableIndex}+"]"+report_structureDefinition{$tableIndex}{tLon_fieldIDs{$tableIndex}{$fieldIndex}}
				
				QR INSERT COLUMN:C748($area; $column; $formula)
				QR SET INFO COLUMN:C765($area; $column; tTxt_fieldNames{$tableID}{$fieldID}; $formula; 0; -1; 0; "")
				
				QR_SET_TITLE($area; $column)
				
				//scroll list
				OBJECT GET SCROLL POSITION:C1114(*; Form:C1466.areaObject; $currentRow)
				OBJECT SET SCROLL POSITION:C906(*; Form:C1466.areaObject; $currentRow; $column; *)
				
			End if 
			
		End if 
		
		//______________________________________________________
	: ($action="insert_field")  //append given field at the given column
		
		$column:=OB Get:C1224($description; "column"; Is longint:K8:6)
		$tableID:=OB Get:C1224($description; "table"; Is longint:K8:6)
		$fieldID:=OB Get:C1224($description; "field"; Is longint:K8:6)
		
		$tableIndex:=Find in array:C230(tLon_tableIDs; $tableID)
		
		If ($tableIndex#-1)
			
			$fieldIndex:=Find in array:C230(tLon_fieldIDs{$tableID}; $fieldID)
			
			If ($fieldIndex#-1)
				
				$formula:="["+report_structureDefinition{0}{$tableIndex}+"]"+report_structureDefinition{$tableIndex}{tLon_fieldIDs{$tableIndex}{$fieldIndex}}
				
				If ($column>0)
					
					QR INSERT COLUMN:C748($area; $column; $formula)
					QR SET INFO COLUMN:C765($area; $column; tTxt_fieldNames{$tableID}{$fieldID}; $formula; 0; -1; 0; "")
					
					QR_SET_TITLE($area; $column)
					
				Else 
					
					QR SET INFO COLUMN:C765($area; Abs:C99($column); tTxt_fieldNames{$tableID}{$fieldID}; $formula; 0; -1; 0; "")
					
				End if 
				
			End if 
			
		End if 
		
		//______________________________________________________
	: ($action="insert_@")  //add/insert first non included field
		
		Case of   //where ?
				
				//------------------------------
			: ($action="insert_begin")
				
				$column:=1
				
				//------------------------------
			: ($action="insert_end")
				
				$column:=$columnNumber+1
				
				//------------------------------
			: ($action="insert_before")
				
				//NOTHING MORE TO DO
				
				//------------------------------
			: ($action="insert_after")
				
				$column:=$column+1
				
				//------------------------------
			Else 
				
				ASSERT:C1129(False:C215; "Unknown entry point: \""+$action+"\"")
				
				//------------------------------
		End case 
		
		//find an eligible field
		For ($i; 1; Size of array:C274(tLon_fieldIDs{$tableIndex}); 1)
			
			If (tLon_fieldIDs{$tableIndex}{$i}>0)  //#ACI0094998
				
				//If (QR_isValidField ($Lon_tableID;$Lon_i))
				
				If (QR_isValidField($tableID; tLon_fieldIDs{$tableIndex}{$i}))
					
					//#ACI0093166
					//$Txt_formula:="["+tTxt_tableNames{$Lon_x}+"]"+tTxt_fieldNames{$Lon_x}{$Lon_i}
					//$Txt_formula:="["+report_structureDefinition{0}{$Lon_x}+"]"+report_structureDefinition{$Lon_x}{$Lon_i}
					
					$formula:="["+report_structureDefinition{0}{$tableIndex}+"]"+report_structureDefinition{$tableIndex}{tLon_fieldIDs{$tableIndex}{$i}}
					
					If (Find in array:C230($_fieldInQR; $formula)=-1)
						
						QR INSERT COLUMN:C748($area; $column; $formula)
						QR SET INFO COLUMN:C765($area; $column; tTxt_fieldNames{$tableIndex}{$i}; $formula; 0; -1; 0; "")
						
						QR_SET_TITLE($area; $column)
						
						$i:=MAXLONG:K35:2-1
						
					End if 
					
				End if 
				
			End if 
			
		End for 
		
		//found?
		$need_update:=($i=MAXLONG:K35:2)
		
		//if not found add a column formula
		If (Not:C34($need_update))
			
			CLEAR VARIABLE:C89($formula)
			EDIT FORMULA:C806(Table:C252($tableID)->; $formula)
			$need_update:=(OK=1) & (Length:C16($formula)>0)
			
			If ($need_update)
				
				QR INSERT COLUMN:C748($area; $column; $formula)
				
				QR_SET_TITLE($area; $column)
				
			End if 
			
		End if 
		
		//______________________________________________________
	: ($action="duplicate")
		
		QR_DUPLICATE_COLUMN($area; $column; OB Get:C1224(ob_area; "sortNumber"; Is longint:K8:6); $column+1)
		$need_update:=True:C214
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Unknown entry point: \""+$action+"\"")
		
		//______________________________________________________
End case 

ob_area.modified:=True:C214

If ($need_update)
	
	report_AREA_UPDATE
	
End if 

// ----------------------------------------------------
// Return
//<NONE>
// ----------------------------------------------------
// End