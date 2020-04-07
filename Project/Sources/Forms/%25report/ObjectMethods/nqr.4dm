  // ----------------------------------------------------
  // Object method : %report.nqr - (4D Report)
  // ID[6D9EBFF1B14147F8BA6F339B74ECE19F]
  // Created #16-4-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($0)

C_BLOB:C604($Blb_buffer)
C_LONGINT:C283($kLon_offset;$Lon_bottom;$Lon_column;$Lon_columnNumber;$Lon_formEvent;$Lon_left)
C_LONGINT:C283($Lon_mouseButton;$Lon_right;$Lon_row;$Lon_top;$Lon_x;$Lon_y)
C_TEXT:C284($Txt_buffer)
C_OBJECT:C1216($Obj_pasteboard)

ARRAY BOOLEAN:C223($tBoo_visible;0)
ARRAY POINTER:C280($tPtr_columnVars;0)
ARRAY POINTER:C280($tPtr_headerVars;0)
ARRAY POINTER:C280($tPtr_styles;0)
ARRAY TEXT:C222($tTxt_columnNames;0)
ARRAY TEXT:C222($tTxt_headerNames;0)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388

  // ----------------------------------------------------
Case of 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Drag Over:K2:13)
		
		$0:=-1
		
		GET MOUSE:C468($Lon_x;$Lon_y;$Lon_mouseButton)
		
		  // #7-9-2015
		  //convert coordinates from global (window) to local (subform)
		CONVERT COORDINATES:C1365($Lon_x;$Lon_y;XY Current window:K27:6;XY Current form:K27:5)
		
		$Lon_row:=Drop position:C608($Lon_column)
		
		$Lon_columnNumber:=OB Get:C1224(ob_area;"qrColumnNumber";Is longint:K8:6)
		
		$Lon_column:=$Lon_column-1
		
		  //column = 0 should be accepted else move row is broken
		If ($Lon_column>=0)
			
			$0:=0  //accept
			
			GET PASTEBOARD DATA:C401("com.4d.wizard";$Blb_buffer)
			
			If ($Lon_column>0)\
				 & ((Not:C34(OB Get:C1224(ob_area;"4d-dialog";Is boolean:K8:9)))\
				 | (BLOB size:C605($Blb_buffer)>0))
				
				OBJECT SET VISIBLE:C603(*;"drop";True:C214)
				
				$Lon_column:=$Lon_column+1
				
				LISTBOX GET ARRAYS:C832(*;OB Get:C1224(<>report_params;"form-object";Is text:K8:3);\
					$tTxt_columnNames;\
					$tTxt_headerNames;\
					$tPtr_columnVars;\
					$tPtr_headerVars;\
					$tBoo_visible;\
					$tPtr_styles)
				
				OBJECT GET COORDINATES:C663(*;$tTxt_columnNames{$Lon_column};$Lon_left;$Lon_top;$Lon_right;$Lon_bottom)
				
				Case of 
						
						  //………………………………………………………………………………
					: ($Lon_column<=1)  //before the first column
						
						$Lon_left:=$Lon_right
						
						  //………………………………………………………………………………
					: ($Lon_column>($Lon_columnNumber+1))  //after the last column
						
						$Lon_right:=$Lon_left
						
						  //………………………………………………………………………………
					Else 
						
						$kLon_offset:=OB Get:C1224(<>report_params;"add-sensitive";Is longint:K8:6)
						
						Case of 
								
								  //-----------------------------------
							: ($Lon_x<=($Lon_left+$kLon_offset))  //into the left separator sensitive area
								
								$Lon_right:=$Lon_left
								
								  //-----------------------------------
							: ($Lon_x>=($Lon_right-$kLon_offset))  //into the right separator sensitive area
								
								$Lon_left:=$Lon_right
								
								  //-----------------------------------
							Else 
								
								  //NOTHING MORE TO DO
								
								  //-----------------------------------
						End case 
						
						  //………………………………………………………………………………
				End case 
				
				  //move the drop area
				OBJECT SET COORDINATES:C1248(*;"drop";$Lon_left;$Lon_top;$Lon_right;$Lon_bottom)
				
			Else 
				
				OBJECT SET VISIBLE:C603(*;"drop";False:C215)
				
			End if 
			
			  //generate On Drag Over event
			CALL SUBFORM CONTAINER:C1086(On Drag Over:K2:13)
			
		Else 
			
			OBJECT SET VISIBLE:C603(*;"drop";False:C215)
			
		End if 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Drop:K2:12)
		
		  //if the value is negative, it indicates a column number (i.e., -3 if the the drop
		  //was performed on column number 3)
		
		  //if the value is positive, it indicates that the drop was performed on a
		  //separator preceding the column (i.e., 3 if the drop was performed after column
		  //2). Keep in mind that the drop does not have to take place before an existing
		  //column.
		
		GET MOUSE:C468($Lon_x;$Lon_y;$Lon_mouseButton)
		
		  // #7-9-2015
		  //convert coordinates from global (window) to local (subform)
		CONVERT COORDINATES:C1365($Lon_x;$Lon_y;XY Current window:K27:6;XY Current form:K27:5)
		
		$Lon_row:=Drop position:C608($Lon_column)
		
		$Lon_columnNumber:=OB Get:C1224(ob_area;"qrColumnNumber";Is longint:K8:6)
		
		Case of 
				
				  //………………………………………………………………………………
			: ($Lon_column<=1)  //before the first column
				
				  //NOTHING MORE TO DO
				
				  //………………………………………………………………………………
			: ($Lon_column>($Lon_columnNumber+1))  //after the last column
				
				$Lon_column:=$Lon_columnNumber+1
				
				  //………………………………………………………………………………
			Else 
				
				LISTBOX GET ARRAYS:C832(*;OB Get:C1224(<>report_params;"form-object";Is text:K8:3);\
					$tTxt_columnNames;\
					$tTxt_headerNames;\
					$tPtr_columnVars;\
					$tPtr_headerVars;\
					$tBoo_visible;\
					$tPtr_styles)
				
				OBJECT GET COORDINATES:C663(*;$tTxt_columnNames{$Lon_column};$Lon_left;$Lon_top;$Lon_right;$Lon_bottom)
				
				$kLon_offset:=OB Get:C1224(<>report_params;"add-sensitive";Is longint:K8:6)
				
				Case of 
						
						  //-----------------------------------
					: ($Lon_x<=($Lon_left+$kLon_offset))  //into the left separator sensitive area
						
						$Lon_column:=$Lon_column-1
						
						  //-----------------------------------
					: ($Lon_x>=($Lon_right-$kLon_offset))  //into the right separator sensitive area
						
						$Lon_column:=$Lon_column
						
						  //-----------------------------------
					Else 
						
						$Lon_column:=-($Lon_column-1)
						
						  //-----------------------------------
				End case 
				
				  //………………………………………………………………………………
		End case 
		
		If ($Lon_column#0)
			
			GET PASTEBOARD DATA:C401("com.4d.wizard";$Blb_buffer)
			
			If (BLOB size:C605($Blb_buffer)>0)
				
				$Txt_buffer:=Convert to text:C1012($Blb_buffer;"utf-8")
				
				$Obj_pasteboard:=JSON Parse:C1218($Txt_buffer)
				
				OB SET:C1220(ob_dialog;"action";"insert_field";\
					"column";$Lon_column;\
					"table";OB Get:C1224($Obj_pasteboard;"table";Is longint:K8:6);\
					"field";OB Get:C1224($Obj_pasteboard;"field";Is longint:K8:6))
				
				CALL SUBFORM CONTAINER:C1086(-1)
				
			Else 
				
				QR SET AREA PROPERTY:C796(OB Get:C1224(ob_area;"area";Is longint:K8:6);-100;$Lon_column)
				
				  //generate On Drop event
				CALL SUBFORM CONTAINER:C1086(On Drop:K2:12)
				
			End if 
		End if 
		
		OBJECT SET VISIBLE:C603(*;"drop";False:C215)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Delete Action:K2:56)
		
		  //------------------------------------------------------------
		  //THIS EVENT IS NOT TRIGGERED IF THE LISTBOX SELECTION MODE IS "NONE" !!!
		  //------------------------------------------------------------
		
		  //management is done into the button "delete"
		
		  //______________________________________________________
	Else 
		
		OBJECT SET VISIBLE:C603(*;"drop";False:C215)
		
		If ($Lon_formEvent=On Load:K2:1)
			
			  //the area is loaded before the form
			COMPILER_report 
			
		End if 
		
		report_AREA_OBJECT_METHOD 
		
		  //______________________________________________________
End case 