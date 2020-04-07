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
C_LONGINT:C283($0)
C_LONGINT:C283($1)
C_TEXT:C284($2)
C_BOOLEAN:C305($3)

C_BOOLEAN:C305($Boo_;$Boo_invisible;$Boo_nameOrder)
C_LONGINT:C283($Lon_;$Lon_fieldID;$Lon_fieldType;$Lon_i;$Lon_ID;$Lon_j)
C_LONGINT:C283($Lon_parameters;$Lon_relationFieldID;$Lon_relationFieldType;$Lon_relationTableID;$Lon_tableID;$Lst_child)
C_LONGINT:C283($Lst_list)
C_PICTURE:C286($Pic_buffer)
C_POINTER:C301($Ptr_field)
C_TEXT:C284($Txt_filter)

ARRAY LONGINT:C221($tLon_fieldIDs;0)
ARRAY LONGINT:C221($tLon_relationFieldIDs;0)
ARRAY TEXT:C222($tTxt_fieldNames;0)
ARRAY TEXT:C222($tTxt_relationFieldNames;0)

If (False:C215)
	C_LONGINT:C283(db_Get_field_list ;$0)
	C_LONGINT:C283(db_Get_field_list ;$1)
	C_TEXT:C284(db_Get_field_list ;$2)
	C_BOOLEAN:C305(db_Get_field_list ;$3)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	  //Required parameters
	$Lon_tableID:=$1
	
	  //Optional parameters
	If ($Lon_parameters>=2)
		
		$Txt_filter:=$2
		$Txt_filter:=Replace string:C233($Txt_filter;"@";"";*)
		
		  //#redmine:25070
		  //The list of field can be sort by field name or field number.
		If ($Lon_parameters>=3)
			
			$Boo_nameOrder:=$3  //{false = creation order}
			
		End if 
		  //}
		
	End if 
	
	$Txt_filter:=Choose:C955(Length:C16($Txt_filter)#0;"@"+$Txt_filter+"@";"@")
	
	$Lst_list:=New list:C375
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
If ($Lon_tableID#0)
	
	If (True:C214)
		
		GET FIELD TITLES:C804((Table:C252($Lon_tableID))->;$tTxt_fieldNames;$tLon_fieldIDs)
		
	Else 
		
		For ($Lon_i;1;Get last field number:C255($Lon_tableID);1)
			
			If (Is field number valid:C1000($Lon_tableID;$Lon_i))
				
				GET FIELD PROPERTIES:C258($Lon_tableID;$Lon_i;$Lon_;$Lon_;$Boo_;$Boo_;$Boo_invisible)
				
				If (Not:C34($Boo_invisible))
					
					APPEND TO ARRAY:C911($tTxt_fieldNames;Field name:C257($Lon_tableID;$Lon_i))
					APPEND TO ARRAY:C911($tLon_fieldIDs;$Lon_i)
					
				End if 
			End if 
		End for 
	End if 
	
	For ($Lon_i;1;Size of array:C274($tLon_fieldIDs);1)
		
		$Lon_fieldID:=$tLon_fieldIDs{$Lon_i}
		
		$Ptr_field:=Field:C253($Lon_tableID;$Lon_fieldID)
		
		GET RELATION PROPERTIES:C686($Ptr_field;$Lon_relationTableID;$Lon_relationFieldID)
		
		If ($tTxt_fieldNames{$Lon_i}=$Txt_filter)\
			 | (($Lon_relationTableID#0)\
			 & ($Lon_relationFieldID#0))
			
			$Lon_fieldType:=Type:C295($Ptr_field->)
			
			Case of 
					
					  //________________________________________
				: ($Lon_fieldType=Is BLOB:K8:12)\
					 | ($Lon_fieldType=Is subtable:K8:11)\
					 | ($Lon_fieldType=Is object:K8:27)
					
					  //These objects cannot be used in labels
					
					  //________________________________________
				Else 
					
					GET RELATION PROPERTIES:C686($Ptr_field;$Lon_relationTableID;$Lon_relationFieldID)
					
					If ($Lon_relationTableID#0)\
						 & ($Lon_relationFieldID#0)
						
						If (True:C214)
							
							GET FIELD TITLES:C804((Table:C252($Lon_relationTableID))->;$tTxt_relationFieldNames;$tLon_relationFieldIDs)
							
						Else 
							
							For ($Lon_j;1;Get last field number:C255($Lon_relationTableID);1)
								
								If (Is field number valid:C1000($Lon_relationTableID;$Lon_j))
									
									GET FIELD PROPERTIES:C258($Lon_relationTableID;$Lon_j;$Lon_;$Lon_;$Boo_;$Boo_;$Boo_invisible)
									
									If (Not:C34($Boo_invisible))
										
										APPEND TO ARRAY:C911($tTxt_relationFieldNames;Field name:C257($Lon_relationTableID;$Lon_j))
										APPEND TO ARRAY:C911($tLon_relationFieldIDs;$Lon_j)
										
									End if 
								End if 
							End for 
						End if 
						
						$Lst_child:=New list:C375
						
						For ($Lon_j;1;Size of array:C274($tLon_relationFieldIDs);1)
							
							$Lon_ID:=$Lon_ID+1
							$Lon_relationFieldID:=$tLon_relationFieldIDs{$Lon_j}
							$Lon_relationFieldType:=Type:C295(Field:C253($Lon_relationTableID;$Lon_relationFieldID)->)
							
							Case of 
									
									  //________________________________________
								: ($Lon_relationFieldType=Is BLOB:K8:12)\
									 | ($Lon_relationFieldType=Is subtable:K8:11)\
									 | ($Lon_relationFieldType=Is object:K8:27)
									
									  //These objects can not be used in labels
									
									  //________________________________________
								: ($tTxt_relationFieldNames{$Lon_j}#$Txt_filter)
									
									  //________________________________________
								Else 
									
									APPEND TO LIST:C376($Lst_child;$tTxt_relationFieldNames{$Lon_j};$Lon_ID)
									SET LIST ITEM PARAMETER:C986($Lst_child;0;"tableId";$Lon_relationTableID)
									SET LIST ITEM PARAMETER:C986($Lst_child;0;"fieldId";$Lon_relationFieldID)
									SET LIST ITEM PARAMETER:C986($Lst_child;0;"fieldType";$Lon_relationFieldType)
									$Pic_buffer:=db_Get_field_icon ($Lon_relationFieldType)
									SET LIST ITEM ICON:C950($Lst_child;0;$Pic_buffer)
									
									  //----------------------------------------
							End case 
						End for 
						
						If (Count list items:C380($Lst_child)>0)
							
							$Lon_ID:=$Lon_ID+1
							APPEND TO LIST:C376($Lst_list;$tTxt_fieldNames{$Lon_i};$Lon_ID;$Lst_child;True:C214)
							SET LIST ITEM PARAMETER:C986($Lst_list;0;"tableId";$Lon_tableID)
							SET LIST ITEM PARAMETER:C986($Lst_list;0;"fieldId";$Lon_fieldID)
							SET LIST ITEM PARAMETER:C986($Lst_list;0;"fieldType";$Lon_fieldType)
							SET LIST ITEM PROPERTIES:C386($Lst_list;0;False:C215;Bold:K14:2;0)
							$Pic_buffer:=db_Get_field_icon ($Lon_fieldType)
							SET LIST ITEM ICON:C950($Lst_list;0;$Pic_buffer)
							
						Else 
							
							CLEAR LIST:C377($Lst_child)
							
						End if 
						
					Else 
						
						$Lon_ID:=$Lon_ID+1
						APPEND TO LIST:C376($Lst_list;$tTxt_fieldNames{$Lon_i};$Lon_ID)
						SET LIST ITEM PARAMETER:C986($Lst_list;0;"tableId";$Lon_tableID)
						SET LIST ITEM PARAMETER:C986($Lst_list;0;"fieldId";$Lon_fieldID)
						SET LIST ITEM PARAMETER:C986($Lst_list;0;"fieldType";$Lon_fieldType)
						$Pic_buffer:=db_Get_field_icon ($Lon_fieldType)
						SET LIST ITEM ICON:C950($Lst_list;0;$Pic_buffer)
						
					End if 
					
					  //________________________________________
			End case 
		End if 
		
		If ($Boo_nameOrder)
			
			SORT LIST:C391($Lst_list)
			
		End if 
	End for 
End if 

  // ----------------------------------------------------
  // Return
$0:=$Lst_list

  // ----------------------------------------------------
  // End