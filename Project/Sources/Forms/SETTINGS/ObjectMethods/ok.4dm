// ----------------------------------------------------
// Object method : SETTINGS.ok - (4D Report)
// ID[97C264B793FC4B8796EE349A1F97228D]
// Created #7-12-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Declarations
C_LONGINT:C283($Lon_; $Lon_area; $Lon_columnNumber; $Lon_currentColumn; $Lon_field; $Lon_formEvent)
C_LONGINT:C283($Lon_i; $Lon_ID; $Lon_offset; $Lon_qrColumnNumber; $Lon_reporType; $Lon_table)
C_LONGINT:C283($Lon_virtualID; $Lon_width; $Lon_x)
C_POINTER:C301($Ptr_me; $Ptr_report)
C_TEXT:C284($Txt_; $Txt_format; $Txt_formula; $Txt_label; $Txt_me; $Txt_object)

// ----------------------------------------------------
// Initialisations
$Lon_formEvent:=Form event code:C388
$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)
$Ptr_me:=OBJECT Get pointer:C1124(Object current:K67:2)

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($Lon_formEvent=On Clicked:K2:4)
		
		If (Is nil pointer:C315(OBJECT Get pointer:C1124(Object subform container:K67:4)))
			
			ACCEPT:C269
			
		Else 
			
			$Lon_area:=OB Get:C1224(ob_area; "area"; Is longint:K8:6)
			$Lon_reporType:=OB Get:C1224(ob_area; "reportType"; Is longint:K8:6)
			$Ptr_report:=OBJECT Get pointer:C1124(Object named:K67:5; "report.list")
			
			If ($Lon_reporType=qr list report:K14902:1)
				
				$Lon_qrColumnNumber:=QR Count columns:C764($Lon_area)
				$Lon_columnNumber:=Count list items:C380($Ptr_report->)
				
				ASSERT:C1129(Not:C34(Shift down:C543) & Not:C34(Is compiled mode:C492))
				
				For ($Lon_i; 1; $Lon_qrColumnNumber; 1)
					
					If ($Lon_i<=$Lon_columnNumber)
						
						$Lon_currentColumn:=$Lon_currentColumn+1
						
						GET LIST ITEM:C378($Ptr_report->; $Lon_currentColumn; $Lon_ID; $Txt_label)
						
						$Lon_virtualID:=$Lon_ID+$Lon_offset
						
						Case of 
								
								//______________________________________________________
							: ($Lon_virtualID=$Lon_i)
								
								//NOTHING MORE TO DO
								
								//______________________________________________________
							: ($Lon_ID<0)  //NEW
								
								GET LIST ITEM PARAMETER:C985($Ptr_report->; $Lon_ID; "tableId"; $Lon_table)
								GET LIST ITEM PARAMETER:C985($Ptr_report->; $Lon_ID; "fieldId"; $Lon_field)
								
								$Lon_x:=Find in array:C230(tLon_fieldIDs{$Lon_table}; $Lon_field)
								
								If ($Lon_x>0)
									
									QR INSERT COLUMN:C748($Lon_area; $Lon_i; db_designFieldName($Lon_table; $Lon_field))
									QR SET INFO COLUMN:C765($Lon_area; $Lon_i; tTxt_fieldNames{$Lon_table}{$Lon_x}; $Txt_formula; 0; -1; 0; "")
									
									QR_SET_TITLE($Lon_area; $Lon_i)
									
									$Lon_offset:=$Lon_offset+1
									
								End if 
								
								//______________________________________________________
							: ($Lon_ID>$Lon_i)\
								 | ($Lon_virtualID>$Lon_i)  //MOVE
								
								If ($Lon_virtualID<=QR Count columns:C764($Lon_area))
									
									QR MOVE COLUMN:C1325($Lon_area; $Lon_virtualID; $Lon_i)
									
									If (($Lon_virtualID-$Lon_i)>1)
										
										$Lon_offset:=$Lon_offset+1
										
									End if 
								End if 
								
								//______________________________________________________
							Else 
								
								//NOTHING MORE TO DO
								
								//______________________________________________________
						End case 
					End if 
				End for 
				
				//additional columns
				For ($Lon_i; $Lon_qrColumnNumber+1; $Lon_columnNumber; 1)
					
					$Lon_currentColumn:=$Lon_currentColumn+1
					
					GET LIST ITEM:C378($Ptr_report->; $Lon_currentColumn; $Lon_ID; $Txt_label)
					
					$Lon_virtualID:=$Lon_ID+$Lon_offset
					
					Case of 
							
							//______________________________________________________
						: ($Lon_virtualID=$Lon_i)
							
							//NOTHING MORE TO DO
							
							//______________________________________________________
						: ($Lon_ID<0)  //NEW
							
							GET LIST ITEM PARAMETER:C985($Ptr_report->; $Lon_ID; "tableId"; $Lon_table)
							GET LIST ITEM PARAMETER:C985($Ptr_report->; $Lon_ID; "fieldId"; $Lon_field)
							
							$Lon_x:=Find in array:C230(tLon_fieldIDs{$Lon_table}; $Lon_field)
							
							If ($Lon_x>0)
								
								QR INSERT COLUMN:C748($Lon_area; $Lon_i; db_designFieldName($Lon_table; $Lon_field))
								QR SET INFO COLUMN:C765($Lon_area; $Lon_i; tTxt_fieldNames{$Lon_table}{$Lon_x}; $Txt_formula; 0; -1; 0; "")
								
								QR_SET_TITLE($Lon_area; $Lon_i)
								
								$Lon_offset:=$Lon_offset+1
								
							End if 
							
							//______________________________________________________
						: ($Lon_ID>$Lon_i)\
							 | ($Lon_virtualID>$Lon_i)  //MOVE
							
							If ($Lon_virtualID<=QR Count columns:C764($Lon_area))
								
								QR MOVE COLUMN:C1325($Lon_area; $Lon_virtualID; $Lon_i)
								
								If (($Lon_virtualID-$Lon_i)>1)
									
									$Lon_offset:=$Lon_offset+1
									
								End if 
							End if 
							
							//______________________________________________________
						Else 
							
							//NOTHING MORE TO DO
							
							//______________________________________________________
					End case 
				End for 
				
				//delete all of the following
				For ($Lon_i; $Lon_currentColumn+1; QR Count columns:C764($Lon_area); 1)
					
					QR DELETE COLUMN:C749($Lon_area; $Lon_currentColumn+1)
					
				End for 
				
			Else 
				//update the 3 data sources
				For ($Lon_i; 1; 3; 1)
					CLEAR VARIABLE:C89($Txt_formula)
					
					GET LIST ITEM:C378($Ptr_report->; $Lon_i; $Lon_ID; $Txt_label)
					QR GET INFO COLUMN:C766($Lon_area; $Lon_i; $Txt_; $Txt_object; $Lon_; $Lon_width; $Lon_; $Txt_format; $Txt_formula)
					
					If ($Txt_label#"C@")
						
						QR SET INFO COLUMN:C765($Lon_area; $Lon_i; $Txt_; Parse formula:C1576($Txt_label; Formula in with virtual structure:K88:1); 0; $Lon_width; 0; $Txt_format)
						
					End if 
					
					QR_SET_TITLE($Lon_area; $Lon_i)
					
				End for 
			End if 
			
			//call the container to hide
			CALL SUBFORM CONTAINER:C1086(-1)
			
		End if 
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Form event activated unnecessarily ("+String:C10($Lon_formEvent)+")")
		
		//______________________________________________________
End case 