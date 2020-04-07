  // ----------------------------------------------------
  // Form method : NQR_TOOLBAR_DATA - (4D Report)
  // ID[A820532271EA475882C8CA0AFA045D21]
  // Created #16-6-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($kLon_buttonMinWidth;$kLon_hOffset;$Lon_;$Lon_bottom;$Lon_formEvent;$Lon_height)
C_LONGINT:C283($Lon_left;$Lon_right;$Lon_top;$Lon_totalWidth;$Lon_value;$Lon_width)
C_LONGINT:C283($Lon_width_2)
C_POINTER:C301($Ptr_subformContainer)

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
		
		OBJECT GET BEST SIZE:C717(*;"clear";$Lon_width;$Lon_height)
		$Lon_width:=Choose:C955($Lon_width<$kLon_buttonMinWidth;$kLon_buttonMinWidth;$Lon_width*1.2)
		
		OBJECT GET BEST SIZE:C717(*;"reload";$Lon_width_2;$Lon_height)
		$Lon_width_2:=Choose:C955($Lon_width_2<$kLon_buttonMinWidth;$kLon_buttonMinWidth;$Lon_width_2*1.2)
		
		$Lon_width:=Choose:C955($Lon_width_2>$Lon_width;$Lon_width_2;$Lon_width)
		
		OBJECT GET BEST SIZE:C717(*;"title";$Lon_width_2;$Lon_height)
		$Lon_width_2:=$Lon_width_2*1.2
		
		$Lon_width:=Choose:C955($Lon_width_2>$Lon_width;$Lon_width_2;$Lon_width)
		
		$Lon_totalWidth:=$Lon_width+$kLon_hOffset
		
		$Lon_right:=$Lon_totalWidth
		OBJECT GET COORDINATES:C663(*;"title";$Lon_;$Lon_top;$Lon_;$Lon_bottom)
		OBJECT SET COORDINATES:C1248(*;"title";0;$Lon_top;$Lon_right;$Lon_bottom)
		
		$Lon_left:=$kLon_hOffset/2
		$Lon_right:=$Lon_left+$Lon_width
		OBJECT GET COORDINATES:C663(*;"clear";$Lon_;$Lon_top;$Lon_;$Lon_bottom)
		OBJECT SET COORDINATES:C1248(*;"clear";$Lon_left;$Lon_top;$Lon_right;$Lon_bottom)
		
		OBJECT GET COORDINATES:C663(*;"reload";$Lon_;$Lon_top;$Lon_;$Lon_bottom)
		OBJECT SET COORDINATES:C1248(*;"reload";$Lon_left;$Lon_top;$Lon_right;$Lon_bottom)
		
		CALL SUBFORM CONTAINER:C1086(-($Lon_totalWidth))
		
		SET TIMER:C645(-1)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Unload:K2:2)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Timer:K2:25)
		
		SET TIMER:C645(0)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Bound Variable Change:K2:52)
		
		$Ptr_subformContainer:=OBJECT Get pointer:C1124(Object subform container:K67:4)
		$Lon_value:=$Ptr_subformContainer->
		
		OBJECT SET ENABLED:C1123(*;"clear";$Lon_value ?? 1)
		OBJECT SET ENABLED:C1123(*;"reload";$Lon_value ?? 2)
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 