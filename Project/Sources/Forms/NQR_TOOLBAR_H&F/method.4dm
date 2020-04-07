  // ----------------------------------------------------
  // Form method : NQR_TOOLBAR_DATA - (4D Report)
  // ID[A820532271EA475882C8CA0AFA045D21]
  // Created #16-6-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($kLon_buttonMinWidth;$kLon_hOffset;$Lon_;$Lon_bottom;$Lon_formEvent;$Lon_height)
C_LONGINT:C283($Lon_left;$Lon_right;$Lon_top;$Lon_totalWidth;$Lon_width;$Lon_width_2)
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
		
		OBJECT GET BEST SIZE:C717(*;"header";$Lon_width;$Lon_height)
		$Lon_width:=Choose:C955($Lon_width<$kLon_buttonMinWidth;$kLon_buttonMinWidth;$Lon_width*1.1)
		
		OBJECT GET BEST SIZE:C717(*;"footer";$Lon_width_2;$Lon_height)
		$Lon_width_2:=Choose:C955($Lon_width_2<$kLon_buttonMinWidth;$kLon_buttonMinWidth;$Lon_width_2*1.1)
		
		$Lon_width:=Choose:C955($Lon_width_2>$Lon_width;$Lon_width_2;$Lon_width)
		
		OBJECT GET BEST SIZE:C717(*;"title";$Lon_width_2;$Lon_height)
		
		$Lon_width:=Choose:C955($Lon_width_2>$Lon_width;$Lon_width_2;$Lon_width)
		
		$Lon_totalWidth:=$Lon_width+$kLon_hOffset+10
		
		$Lon_right:=$Lon_totalWidth-$kLon_hOffset
		OBJECT GET COORDINATES:C663(*;"title";$Lon_;$Lon_top;$Lon_;$Lon_bottom)
		OBJECT SET COORDINATES:C1248(*;"title";$kLon_hOffset/2;$Lon_top;$Lon_right;$Lon_bottom)
		
		$Lon_left:=$kLon_hOffset
		$Lon_right:=$Lon_left+$Lon_width
		OBJECT GET COORDINATES:C663(*;"header";$Lon_;$Lon_top;$Lon_;$Lon_bottom)
		OBJECT SET COORDINATES:C1248(*;"header";$Lon_left;$Lon_top;$Lon_right;$Lon_bottom)
		
		OBJECT GET COORDINATES:C663(*;"footer";$Lon_;$Lon_top;$Lon_;$Lon_bottom)
		OBJECT SET COORDINATES:C1248(*;"footer";$Lon_left;$Lon_top;$Lon_right;$Lon_bottom)
		
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
		
		Obj_SET_ENABLED ($Ptr_subformContainer->>=0;"header";"footer")
		
		Case of 
				
				  //……………………………………………………………………
			: ($Ptr_subformContainer->=-1)
				
				  //NOTHING MORE TO DO
				
				  //……………………………………………………………………
			: ($Ptr_subformContainer->#0)
				
				OBJECT GET COORDINATES:C663(*;Choose:C955($Ptr_subformContainer->=1;"header";"footer");$Lon_left;$Lon_top;$Lon_right;$Lon_bottom)
				OBJECT SET COORDINATES:C1248(*;"tool.selected";$Lon_left-5;$Lon_top-5;$Lon_right+5;$Lon_bottom+5)
				OBJECT SET VISIBLE:C603(*;"tool.selected";True:C214)
				
				  //……………………………………………………………………
			Else 
				
				OBJECT SET VISIBLE:C603(*;"selected";False:C215)
				
				  //……………………………………………………………………
		End case 
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 