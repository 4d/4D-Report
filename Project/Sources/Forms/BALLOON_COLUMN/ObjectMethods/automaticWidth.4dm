// ----------------------------------------------------
// Object method : BALLOON_COLUMN.automaticWidth - (4D Report)
// ID[7E69D981BE5649A186C70318C58A441D]
// Created #16-10-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Declarations
C_LONGINT:C283($kLon_defaultWidth; $Lon_area; $Lon_column; $Lon_formEvent; $Lon_hidden; $Lon_repeated)
C_LONGINT:C283($Lon_row; $Lon_width)
C_POINTER:C301($Ptr_me)
C_TEXT:C284($Txt_format; $Txt_me; $Txt_object; $Txt_title)
C_OBJECT:C1216($Obj_caller)

// ----------------------------------------------------
// Initialisations
$Lon_formEvent:=Form event code:C388
$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)
$Ptr_me:=OBJECT Get pointer:C1124(Object current:K67:2)

$kLon_defaultWidth:=128

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($Lon_formEvent=On Clicked:K2:4)
		
		$Obj_caller:=JSON Parse:C1218((OBJECT Get pointer:C1124(Object named:K67:5; "caller"))->)
		
		If (OB Is defined:C1231($Obj_caller))
			
			If (OB Is defined:C1231($Obj_caller; "area"))
				
				$Lon_area:=report_Get_target($Obj_caller; ->$Lon_column; ->$Lon_row)
				CLEAR VARIABLE:C89($Obj_caller)
				
				QR GET INFO COLUMN:C766($Lon_area; $Lon_column; \
					$Txt_title; \
					$Txt_object; \
					$Lon_hidden; \
					$Lon_width; \
					$Lon_repeated; \
					$Txt_format)
				
				$Lon_width:=Choose:C955($Ptr_me->=1; -1; Choose:C955($Lon_width=-1; $kLon_defaultWidth; $Lon_width))
				
				QR SET INFO COLUMN:C765($Lon_area; $Lon_column; \
					$Txt_title; \
					$Txt_object; \
					$Lon_hidden; \
					$Lon_width; \
					$Lon_width; \
					$Txt_format)
				
				ob_area.modified:=True:C214
				
			End if 
		End if 
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		//______________________________________________________
End case 