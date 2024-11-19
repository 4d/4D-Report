//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : db_Get_field_list
// Database: 4D Labels
// ID[9E3958CA682F4D8B9907406D520269F9]
// Created #15-12-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations

#DECLARE($table_id : Integer; $filter : Text; $ordered : Boolean)->$list : Integer

/* 
  ----------------------------------------------------

  VARIABLES

  ----------------------------------------------------   
*/

var \
$count_parameters; \
$i; \
$j; \
$field_id; \
$field_type; \
$id; \
$related_field_id; \
$related_field_type; \
$related_table_id; \
$child_node : Integer

var \
$field : Pointer

var \
$icon : Picture


// ARRAYS

ARRAY LONGINT:C221($_field_id; 0)
ARRAY LONGINT:C221($_related_field_id; 0)
ARRAY TEXT:C222($_field_names; 0)
ARRAY TEXT:C222($_related_field_names; 0)

// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=1; "Missing parameter"))
	
	//Required parameters
	//$table_id:=$1
	
	//Optional parameters
	If ($count_parameters>=2)
		
		
		$filter:=Replace string:C233($filter; "@"; ""; *)
		
		//#redmine:25070
		//The list of field can be sort by field name or field number.
		If ($count_parameters>=3)
			
			//$Boo_nameOrder:=$3  //{false = creation order}
			
		End if 
		//}
		
	End if 
	
	$filter:=Choose:C955(Length:C16($filter)#0; "@"+$filter+"@"; "@")
	
	$list:=New list:C375
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
If ($table_id#0)
	//todo: object field path using extra external file #DD
	
	If (boo_useVirtualStructure)
		
		GET FIELD TITLES:C804((Table:C252($table_id))->; $_field_names; $_field_id)
		
	Else 
		
		
		
		var $count_fields; $int : Integer
		var $bool; $is_invisible; $in_design : Boolean
		
		
		
		$in_design:=((Process info:C1843(Current process:C322).type)<0)
		
		ARRAY TEXT:C222($_field_names; 0x0000)
		ARRAY LONGINT:C221($_field_id; 0x0000)
		
		
		
		$count_fields:=Last field number:C255($table_id)
		
		For ($j; 1; $count_fields; 1)
			
			If (Is field number valid:C1000($table_id; $j))
				
				GET FIELD PROPERTIES:C258($table_id; $j; $int; $int; $bool; $bool; $is_invisible)
				
				If (Not:C34($is_invisible) | $in_design)
					
					APPEND TO ARRAY:C911($_field_names; Field name:C257($table_id; $j))
					APPEND TO ARRAY:C911($_field_id; $j)
					
				End if 
				
			End if 
			
		End for 
		
	End if 
	
	
	For ($i; 1; Size of array:C274($_field_id); 1)
		
		$field_id:=$_field_id{$i}
		
		$field:=Field:C253($table_id; $field_id)
		
		GET RELATION PROPERTIES:C686($field; $related_table_id; $related_field_id)
		
		If ($_field_names{$i}=$filter)\
			 | (($related_table_id#0)\
			 & ($related_field_id#0))
			
			$field_type:=Type:C295($field->)
			
			Case of 
					
					//________________________________________
				: ($field_type=Is BLOB:K8:12)\
					 | ($field_type=Is subtable:K8:11)\
					 | ($field_type=Is object:K8:27)
					
					//These objects cannot be used in labels
					
					//________________________________________
				Else 
					
					GET RELATION PROPERTIES:C686($field; $related_table_id; $related_field_id)
					
					If ($related_table_id#0)\
						 & ($related_field_id#0)
						
						GET FIELD TITLES:C804((Table:C252($related_table_id))->; $_related_field_names; $_related_field_id)
						
						$child_node:=New list:C375
						
						For ($j; 1; Size of array:C274($_related_field_id); 1)
							
							$id:=$id+1
							$related_field_id:=$_related_field_id{$j}
							$related_field_type:=Type:C295(Field:C253($related_table_id; $related_field_id)->)
							
							Case of 
									
									//________________________________________
								: ($related_field_type=Is BLOB:K8:12)\
									 | ($related_field_type=Is subtable:K8:11)\
									 | ($related_field_type=Is object:K8:27)
									
									//These objects can not be used in labels
									
									//________________________________________
								: ($_related_field_names{$j}#$filter)
									
									//________________________________________
								Else 
									
									APPEND TO LIST:C376($child_node; $_related_field_names{$j}; $id)
									SET LIST ITEM PARAMETER:C986($child_node; 0; "tableId"; $related_table_id)
									SET LIST ITEM PARAMETER:C986($child_node; 0; "fieldId"; $related_field_id)
									SET LIST ITEM PARAMETER:C986($child_node; 0; "fieldType"; $related_field_type)
									$icon:=db_Get_field_icon($related_field_type)
									SET LIST ITEM ICON:C950($child_node; 0; $icon)
									
									//----------------------------------------
							End case 
						End for 
						
						If (Count list items:C380($child_node)>0)
							
							$id:=$id+1
							APPEND TO LIST:C376($list; $_field_names{$i}; $id; $child_node; True:C214)
							SET LIST ITEM PARAMETER:C986($list; 0; "tableId"; $table_id)
							SET LIST ITEM PARAMETER:C986($list; 0; "fieldId"; $field_id)
							SET LIST ITEM PARAMETER:C986($list; 0; "fieldType"; $field_type)
							SET LIST ITEM PROPERTIES:C386($list; 0; False:C215; Bold:K14:2; 0)
							$icon:=db_Get_field_icon($field_type)
							SET LIST ITEM ICON:C950($list; 0; $icon)
							
						Else 
							
							CLEAR LIST:C377($child_node)
							//MARK:ACI0103108
							
							If ($_field_names{$i}=$filter)
								
								$id:=$id+1
								APPEND TO LIST:C376($list; $_field_names{$i}; $id)
								SET LIST ITEM PARAMETER:C986($list; 0; "tableId"; $table_id)
								SET LIST ITEM PARAMETER:C986($list; 0; "fieldId"; $field_id)
								SET LIST ITEM PARAMETER:C986($list; 0; "fieldType"; $field_type)
								$icon:=db_Get_field_icon($field_type)
								SET LIST ITEM ICON:C950($list; 0; $icon)
								
							End if 
							
						End if 
						
					Else 
						
						$id:=$id+1
						APPEND TO LIST:C376($list; $_field_names{$i}; $id)
						SET LIST ITEM PARAMETER:C986($list; 0; "tableId"; $table_id)
						SET LIST ITEM PARAMETER:C986($list; 0; "fieldId"; $field_id)
						SET LIST ITEM PARAMETER:C986($list; 0; "fieldType"; $field_type)
						$icon:=db_Get_field_icon($field_type)
						SET LIST ITEM ICON:C950($list; 0; $icon)
						
					End if 
					
					//________________________________________
			End case 
		End if 
		
		If ($ordered)
			
			SORT LIST:C391($list)
			
		End if 
	End for 
End if 

// ----------------------------------------------------
// End