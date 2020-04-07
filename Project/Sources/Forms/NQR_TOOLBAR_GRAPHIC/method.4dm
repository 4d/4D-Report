  // ----------------------------------------------------
  // Form method : NQR_REPORT_TYPE - (4D Report)
  // ID[9EAC746847BC48C0ACE09E7A6159B342]
  // Created #16-6-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($kLon_buttonMinWidth;$kLon_hOffset;$Lon_;$Lon_bottom;$Lon_formEvent;$Lon_height)
C_LONGINT:C283($Lon_left;$Lon_position;$Lon_right;$Lon_top;$Lon_width;$Lon_width_1)
C_LONGINT:C283($Lon_width_2)
C_POINTER:C301($Ptr_container)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388

  // ----------------------------------------------------

Case of 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Load:K2:1)
		
		COMPILER_NQR 
		
		$kLon_hOffset:=8
		$kLon_buttonMinWidth:=30
		
		OBJECT GET BEST SIZE:C717(*;"templates";$Lon_width_1;$Lon_height)
		$Lon_width_1:=Choose:C955($Lon_width_1<$kLon_buttonMinWidth;$kLon_buttonMinWidth;$Lon_width_1)
		
		OBJECT GET BEST SIZE:C717(*;"borders";$Lon_width_2;$Lon_height)
		$Lon_width_2:=Choose:C955($Lon_width_2<$kLon_buttonMinWidth;$kLon_buttonMinWidth;$Lon_width_2)
		
		$Lon_width:=$kLon_hOffset+$Lon_width_1+$kLon_hOffset+$Lon_width_2+$kLon_hOffset
		
		OBJECT GET COORDINATES:C663(*;"title";$Lon_;$Lon_top;$Lon_right;$Lon_bottom)
		OBJECT SET COORDINATES:C1248(*;"title";1;$Lon_top;$Lon_width-1;$Lon_bottom)
		
		$Lon_position:=$kLon_hOffset
		
		OBJECT GET COORDINATES:C663(*;"templates";$Lon_;$Lon_top;$Lon_;$Lon_bottom)
		$Lon_left:=$kLon_hOffset
		$Lon_right:=$Lon_left+$Lon_width_1
		OBJECT SET COORDINATES:C1248(*;"templates";$Lon_left;$Lon_top;$Lon_right;$Lon_bottom)
		
		OBJECT GET COORDINATES:C663(*;"borders";$Lon_;$Lon_top;$Lon_;$Lon_bottom)
		$Lon_left:=$Lon_left+$Lon_width_1+$kLon_hOffset
		$Lon_right:=$Lon_left+$Lon_width_2
		OBJECT SET COORDINATES:C1248(*;"borders";$Lon_left;$Lon_top;$Lon_right;$Lon_bottom)
		
		CALL SUBFORM CONTAINER:C1086(-($Lon_width))
		
		SET TIMER:C645(-1)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Unload:K2:2)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Timer:K2:25)
		
		SET TIMER:C645(0)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Bound Variable Change:K2:52)
		
		$Ptr_container:=OBJECT Get pointer:C1124(Object subform container:K67:4)
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 