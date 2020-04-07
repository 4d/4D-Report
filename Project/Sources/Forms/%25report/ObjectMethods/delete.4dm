  // ----------------------------------------------------
  // Object method : %report.delete - (4D Report)
  // ID[DEDAF7F0249D42EBA56E9D8EE31A380A]
  // Created #19-8-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_area;$Lon_bottom;$Lon_column;$Lon_formEvent;$Lon_left;$Lon_right)
C_LONGINT:C283($Lon_top)
C_POINTER:C301($Ptr_me)
C_TEXT:C284($Txt_me)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388
$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)
$Ptr_me:=OBJECT Get pointer:C1124(Object current:K67:2)

  // ----------------------------------------------------
Case of 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Clicked:K2:4)
		
		$Lon_area:=OB Get:C1224(ob_area;"area";Is longint:K8:6)
		
		If ($Lon_area#0)
			
			QR GET SELECTION:C793($Lon_area;$Lon_left;$Lon_top;$Lon_right;$Lon_bottom)
			
		End if 
		
		Case of 
				
				  //-------------------------------------
			: ($Lon_left=-1)\
				 & ($Lon_top=-1)\
				 & ($Lon_right=-1)\
				 & ($Lon_bottom=-1)
				
				  //NO SELECTION
				
				  //-------------------------------------
			: ($Lon_left=0)\
				 & ($Lon_top=0)
				
				  //
				
				  //-------------------------------------
			: ($Lon_top=0)
				
				  //delete column
				$Lon_column:=OB Get:C1224(ob_area;"qrColumn";Is longint:K8:6)
				QR DELETE COLUMN:C749($Lon_area;$Lon_column)
				
				If ($Lon_left<=QR Count columns:C764($Lon_area))
					
					QR SET SELECTION:C794($Lon_area;$Lon_left;$Lon_top;$Lon_right;$Lon_bottom)
					report_SELECTION ("select_column";$Lon_left+1)
					
				Else 
					
					QR SET SELECTION:C794($Lon_area;-1;-1;-1;-1)
					report_SELECTION ("select_none")
					
				End if 
				
				report_AREA_UPDATE 
				
				  //-------------------------------------
			: ($Lon_left=0)
				
				  //delete sort if it is
				
				  //#TO_BE_DONE
				
				  //-------------------------------------
			Else 
				
				  //delete cell content
				
				  //#TO_BE_DONE
				
				  //-------------------------------------
		End case 
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 