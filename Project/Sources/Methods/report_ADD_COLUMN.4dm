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
C_TEXT:C284($1)
C_OBJECT:C1216($2)

C_BOOLEAN:C305($Boo_update)
C_LONGINT:C283($Lon_;$Lon_area;$Lon_column;$Lon_columnNumber;$Lon_field;$Lon_fieldID)
C_LONGINT:C283($Lon_i;$Lon_parameters;$Lon_row;$Lon_rowNumber;$Lon_table;$Lon_tableID)
C_LONGINT:C283($Lon_x)
C_TEXT:C284($Txt_;$Txt_action;$Txt_formula;$Txt_object)
C_OBJECT:C1216($Obj_description)

If (False:C215)
	C_TEXT:C284(report_ADD_COLUMN;$1)
	C_OBJECT:C1216(report_ADD_COLUMN;$2)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259




If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	//NO PARAMETERS REQUIRED
	$Txt_action:="insert_end"//default
	
	//Optional parameters
	If ($Lon_parameters>=1)
		
		$Txt_action:=$1//values: "formula" - "add_all" - "insert_end/begin/after/before"
		
		If ($Lon_parameters>=2)
			
			$Obj_description:=$2
			
		End if 
	End if 
	
	$Lon_area:=OB Get:C1224(ob_area;"area";Is longint:K8:6)
	$Lon_column:=OB Get:C1224(ob_area;"qrColumn";Is longint:K8:6)
	$Lon_columnNumber:=OB Get:C1224(ob_area;"qrColumnNumber";Is longint:K8:6)
	$Lon_rowNumber:=OB Get:C1224(ob_area;"qrRowNumber";Is longint:K8:6)
	$Lon_tableID:=QR Get report table:C758($Lon_area)
	$Lon_x:=Find in array:C230(tLon_tableIDs;$Lon_tableID)
	
	If ($Txt_action="add_@")\
		 | ($Txt_action="insert_@")
		
		//get all column's objects
		ARRAY TEXT:C222($tTxt_fieldInQR;0x0000)
		
		For ($Lon_i;1;QR Count columns:C764($Lon_area);1)
			
			QR GET INFO COLUMN:C766($Lon_area;$Lon_i;$Txt_;$Txt_object;$Lon_;$Lon_;$Lon_;$Txt_)
			
			//#ACI0093166
			//APPEND TO ARRAY($tTxt_fieldInQR;report_virtualFieldName ($Txt_object))
			APPEND TO ARRAY:C911($tTxt_fieldInQR;$Txt_object)
			
		End for 
	End if 
	
	ASSERT:C1129(Not:C34(Shift down:C543))
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: (Length:C16($Txt_action)=0)
		
		//NOTHING MORE TO DO
		
		//______________________________________________________
	: ($Lon_x<0)
		
		TRACE:C157//MUST NOT THROUGH HERE
		
		//______________________________________________________
	: ($Txt_action="formula")//add a column formula
		
		EDIT FORMULA:C806(Table:C252($Lon_tableID)->;$Txt_formula)
		
		//#ACI0092848 - Test if the formula is not empty
		//$Boo_update:=(OK=1)
		$Boo_update:=(OK=1) & (Length:C16($Txt_formula)>0)
		
		If ($Boo_update)
			
			$Lon_column:=$Lon_column+1
			QR INSERT COLUMN:C748($Lon_area;$Lon_column;$Txt_formula)
			
		End if 
		
		//______________________________________________________
	: ($Txt_action="add_all")//add all fields that are not already included
		
		For ($Lon_i;1;Size of array:C274(tLon_fieldIDs{$Lon_x});1)
			
			If (tLon_fieldIDs{$Lon_x}{$Lon_i}#0)
				
				//If (QR_isValidField ($Lon_tableID;$Lon_i))
				If (QR_isValidField($Lon_tableID;tLon_fieldIDs{$Lon_x}{$Lon_i}))
					
					//#ACI0093166
					//$Txt_formula:="["+tTxt_tableNames{$Lon_x}+"]"+tTxt_fieldNames{$Lon_x}{$Lon_i}
					//$Txt_formula:="["+report_structureDefinition{0}{$Lon_tableID}+"]"+report_structureDefinition{$Lon_tableID}{$Lon_i}
					$Txt_formula:="["+report_structureDefinition{0}{$Lon_tableID}+"]"+report_structureDefinition{$Lon_x}{tLon_fieldIDs{$Lon_tableID}{$Lon_i}}
					
					If (Find in array:C230($tTxt_fieldInQR;$Txt_formula)=-1)
						
						$Lon_column:=$Lon_column+1
						QR INSERT COLUMN:C748($Lon_area;$Lon_column;$Txt_formula)
						QR SET INFO COLUMN:C765($Lon_area;$Lon_column;tTxt_fieldNames{$Lon_x}{$Lon_i};$Txt_formula;0;-1;0;"")
						
						QR_SET_TITLE($Lon_area;$Lon_column)
						
					End if 
				End if 
			End if 
		End for 
		
		$Boo_update:=True:C214
		
		//______________________________________________________
	: ($Txt_action="append_field")//append given field at the end
		
		$Lon_column:=$Lon_columnNumber+1
		
		$Lon_tableID:=OB Get:C1224($Obj_description;"table";Is longint:K8:6)
		$Lon_fieldID:=OB Get:C1224($Obj_description;"field";Is longint:K8:6)
		
		$Lon_table:=Find in array:C230(tLon_tableIDs;$Lon_tableID)
		
		If ($Lon_table#-1)
			
			$Lon_field:=Find in array:C230(tLon_fieldIDs{$Lon_tableID};$Lon_fieldID)
			
			If ($Lon_field#-1)
				
				$Txt_formula:="["+report_structureDefinition{0}{$Lon_table}+"]"+report_structureDefinition{$Lon_table}{tLon_fieldIDs{$Lon_table}{$Lon_field}}
				
				QR INSERT COLUMN:C748($Lon_area;$Lon_column;$Txt_formula)
				QR SET INFO COLUMN:C765($Lon_area;$Lon_column;tTxt_fieldNames{$Lon_tableID}{$Lon_fieldID};$Txt_formula;0;-1;0;"")
				
				QR_SET_TITLE($Lon_area;$Lon_column)
				
				//scroll list
				OBJECT GET SCROLL POSITION:C1114(*;"nqr";$Lon_row)
				OBJECT SET SCROLL POSITION:C906(*;"nqr";$Lon_row;$Lon_column;*)
				
			End if 
		End if 
		
		//______________________________________________________
	: ($Txt_action="insert_field")//append given field at the given column
		
		$Lon_column:=OB Get:C1224($Obj_description;"column";Is longint:K8:6)
		$Lon_tableID:=OB Get:C1224($Obj_description;"table";Is longint:K8:6)
		$Lon_fieldID:=OB Get:C1224($Obj_description;"field";Is longint:K8:6)
		
		$Lon_table:=Find in array:C230(tLon_tableIDs;$Lon_tableID)
		
		If ($Lon_table#-1)
			
			$Lon_field:=Find in array:C230(tLon_fieldIDs{$Lon_tableID};$Lon_fieldID)
			
			If ($Lon_field#-1)
				
				$Txt_formula:="["+report_structureDefinition{0}{$Lon_table}+"]"+report_structureDefinition{$Lon_table}{tLon_fieldIDs{$Lon_table}{$Lon_field}}
				
				If ($Lon_column>0)
					
					QR INSERT COLUMN:C748($Lon_area;$Lon_column;$Txt_formula)
					QR SET INFO COLUMN:C765($Lon_area;$Lon_column;tTxt_fieldNames{$Lon_tableID}{$Lon_fieldID};$Txt_formula;0;-1;0;"")
					
					QR_SET_TITLE($Lon_area;$Lon_column)
					
				Else 
					
					QR SET INFO COLUMN:C765($Lon_area;Abs:C99($Lon_column);tTxt_fieldNames{$Lon_tableID}{$Lon_fieldID};$Txt_formula;0;-1;0;"")
					
				End if 
			End if 
		End if 
		
		//______________________________________________________
	: ($Txt_action="insert_@")//add/insert first non included field
		
		Case of //where ?
				
				//------------------------------
			: ($Txt_action="insert_begin")
				
				$Lon_column:=1
				
				//------------------------------
			: ($Txt_action="insert_end")
				
				$Lon_column:=$Lon_columnNumber+1
				
				//------------------------------
			: ($Txt_action="insert_before")
				
				//NOTHING MORE TO DO
				
				//------------------------------
			: ($Txt_action="insert_after")
				
				$Lon_column:=$Lon_column+1
				
				//------------------------------
			Else 
				
				ASSERT:C1129(False:C215;"Unknown entry point: \""+$Txt_action+"\"")
				
				//------------------------------
		End case 
		
		//find an eligible field
		For ($Lon_i;1;Size of array:C274(tLon_fieldIDs{$Lon_x});1)
			
			If (tLon_fieldIDs{$Lon_x}{$Lon_i}>0)//#ACI0094998
				
				//If (QR_isValidField ($Lon_tableID;$Lon_i))
				If (QR_isValidField($Lon_tableID;tLon_fieldIDs{$Lon_x}{$Lon_i}))
					
					//#ACI0093166
					//$Txt_formula:="["+tTxt_tableNames{$Lon_x}+"]"+tTxt_fieldNames{$Lon_x}{$Lon_i}
					//$Txt_formula:="["+report_structureDefinition{0}{$Lon_x}+"]"+report_structureDefinition{$Lon_x}{$Lon_i}
					$Txt_formula:="["+report_structureDefinition{0}{$Lon_x}+"]"+report_structureDefinition{$Lon_x}{tLon_fieldIDs{$Lon_x}{$Lon_i}}
					
					If (Find in array:C230($tTxt_fieldInQR;$Txt_formula)=-1)
						
						QR INSERT COLUMN:C748($Lon_area;$Lon_column;$Txt_formula)
						QR SET INFO COLUMN:C765($Lon_area;$Lon_column;tTxt_fieldNames{$Lon_x}{$Lon_i};$Txt_formula;0;-1;0;"")
						
						QR_SET_TITLE($Lon_area;$Lon_column)
						
						$Lon_i:=MAXLONG:K35:2-1
						
					End if 
				End if 
			End if 
		End for 
		
		//found?
		$Boo_update:=($Lon_i=MAXLONG:K35:2)
		
		//if not found add a column formula
		If (Not:C34($Boo_update))
			
			CLEAR VARIABLE:C89($Txt_formula)
			EDIT FORMULA:C806(Table:C252($Lon_tableID)->;$Txt_formula)
			$Boo_update:=(OK=1) & (Length:C16($Txt_formula)>0)
			
			If ($Boo_update)
				
				QR INSERT COLUMN:C748($Lon_area;$Lon_column;$Txt_formula)
				
				QR_SET_TITLE($Lon_area;$Lon_column)
				
			End if 
		End if 
		
		//______________________________________________________
	: ($Txt_action="duplicate")
		
		QR_DUPLICATE_COLUMN($Lon_area;$Lon_column;OB Get:C1224(ob_area;"sortNumber";Is longint:K8:6);$Lon_column+1)
		$Boo_update:=True:C214
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Unknown entry point: \""+$Txt_action+"\"")
		
		//______________________________________________________
End case 

If ($Boo_update)
	
	report_AREA_UPDATE
	
End if 

// ----------------------------------------------------
// Return
//<NONE>
// ----------------------------------------------------
// End