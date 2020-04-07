  // ----------------------------------------------------
  // Form method : NQR_REPORT_TYPE - (4D Report)
  // ID[9EAC746847BC48C0ACE09E7A6159B342]
  // Created #16-6-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($kLon_buttonMinWidth;$kLon_hOffset;$Lon_;$Lon_bottom;$Lon_formEvent;$Lon_height)
C_LONGINT:C283($Lon_left;$Lon_offset;$Lon_right;$Lon_top;$Lon_totalWidth;$Lon_type)
C_LONGINT:C283($Lon_width)
C_POINTER:C301($Ptr_subformContainer)
C_REAL:C285($Num_width)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388

  // ----------------------------------------------------

Case of 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Load:K2:1)
		
		COMPILER_NQR 
		
		$kLon_hOffset:=10
		$kLon_buttonMinWidth:=30
		
		OBJECT GET BEST SIZE:C717(*;"list";$Lon_width;$Lon_height)
		$Lon_width:=Choose:C955($Lon_width<$kLon_buttonMinWidth;$kLon_buttonMinWidth;$Lon_width)
		$Lon_width:=$Lon_width*1.2
		$Lon_totalWidth:=$kLon_hOffset+$Lon_width+$kLon_hOffset
		
		OBJECT GET BEST SIZE:C717(*;"cross";$Lon_width;$Lon_height)
		$Lon_width:=Choose:C955($Lon_width<$kLon_buttonMinWidth;$kLon_buttonMinWidth;$Lon_width)
		$Lon_width:=$Lon_width*1.2
		$Lon_totalWidth:=$Lon_totalWidth+$Lon_width+$kLon_hOffset+2
		
		$Lon_width:=$Lon_totalWidth/2
		
		OBJECT GET COORDINATES:C663(*;"title";$Lon_;$Lon_top;$Lon_right;$Lon_bottom)
		OBJECT SET COORDINATES:C1248(*;"title";0;$Lon_top;$Lon_totalWidth;$Lon_bottom)
		
		OBJECT GET COORDINATES:C663(*;"matrix";$Lon_;$Lon_top;$Lon_;$Lon_bottom)
		OBJECT SET COORDINATES:C1248(*;"matrix";0;$Lon_top;$Lon_totalWidth;$Lon_bottom)
		
		OBJECT GET COORDINATES:C663(*;"list";$Lon_;$Lon_top;$Lon_right;$Lon_bottom)
		OBJECT SET COORDINATES:C1248(*;"list";0;$Lon_top;$Lon_width;$Lon_bottom)
		
		OBJECT GET COORDINATES:C663(*;"cross";$Lon_left;$Lon_top;$Lon_right;$Lon_bottom)
		OBJECT SET COORDINATES:C1248(*;"cross";$Lon_width;$Lon_top;$Lon_totalWidth;$Lon_bottom)
		
		CALL SUBFORM CONTAINER:C1086(-($Lon_totalWidth))
		
		OBJECT SET ENABLED:C1123(*;"cross";<>Boo_debug)
		
		SET TIMER:C645(-1)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Unload:K2:2)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Timer:K2:25)
		
		SET TIMER:C645(0)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Bound Variable Change:K2:52)
		
		$Ptr_subformContainer:=OBJECT Get pointer:C1124(Object subform container:K67:4)
		$Lon_type:=$Ptr_subformContainer->
		
		If ($Lon_type>0)
			
			OBJECT SET ENABLED:C1123(*;"list";True:C214)
			OBJECT SET ENABLED:C1123(*;"cross";<>Boo_debug)
			
			OBJECT GET COORDINATES:C663(*;"matrix";$Lon_left;$Lon_top;$Lon_right;$Lon_bottom)
			
			$Num_width:=($Lon_right-$Lon_left)/2
			$Lon_offset:=Num:C11((($Lon_right-$Lon_left)\2)#$Num_width)
			
			If ($Lon_type=qr list report:K14902:1)
				
				$Lon_right:=$Lon_left+$Num_width+(1-$Lon_offset)
				
			Else 
				
				$Lon_left:=$Lon_left+$Num_width-$Lon_offset
				
			End if 
			
			OBJECT SET COORDINATES:C1248(*;"selection";$Lon_left;$Lon_top;$Lon_right;$Lon_bottom)
			OBJECT SET VISIBLE:C603(*;"selection";True:C214)
			
		Else 
			
			OBJECT SET ENABLED:C1123(*;"list";False:C215)
			OBJECT SET ENABLED:C1123(*;"cross";False:C215)
			OBJECT SET VISIBLE:C603(*;"selection";False:C215)
			
		End if 
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 