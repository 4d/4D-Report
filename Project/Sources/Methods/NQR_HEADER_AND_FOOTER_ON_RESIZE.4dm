//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : NQR_HEADER_AND_FOOTER_ON_RESIZE
  // Database: 4D Report
  // ID[D00FA61C7A1F461A8B032960363C8CEF]
  // Created #11-6-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($kLon_close;$kLon_offset;$Lon_;$Lon_bottom;$Lon_boxBottom;$Lon_boxTop)
C_LONGINT:C283($Lon_height;$Lon_labelBottom;$Lon_labelTop;$Lon_left;$Lon_offset;$Lon_page)
C_LONGINT:C283($Lon_parameters;$Lon_right;$Lon_right2;$Lon_top;$Lon_width)
C_TEXT:C284($Txt_object)


  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
	$Lon_page:=FORM Get current page:C276(*)
	
	  //Optional parameters
	If ($Lon_parameters>=1)
		
		  //<NONE>
		
	End if 
	
	$kLon_offset:=30
	$kLon_close:=20
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
If (False:C215)
	
	  //Too long to execute !
	OBJECT GET COORDINATES:C663(*;"Matrix";$Lon_left;$Lon_;$Lon_right;$Lon_)
	
Else 
	
	  //Place the matrix & the close button
	OBJECT GET SUBFORM CONTAINER SIZE:C1148($Lon_width;$Lon_height)
	
	$Lon_left:=$kLon_offset
	$Lon_right:=$Lon_width-$kLon_offset
	OBJECT SET COORDINATES:C1248(*;"Matrix";$Lon_left;74;$Lon_right;125)
	
	OBJECT SET COORDINATES:C1248(*;"close";$Lon_width-$kLon_close;0;$Lon_width;$kLon_close)
End if 

Case of 
		
		  //______________________________________________________
	: ($Lon_page=1)
		
		  //Place the column's titles & boxes
		$Lon_width:=($Lon_right-$Lon_left)/3
		
		OBJECT GET COORDINATES:C663(*;"label.left";$Lon_;$Lon_labelTop;$Lon_;$Lon_labelBottom)
		OBJECT GET COORDINATES:C663(*;"box.left";$Lon_;$Lon_boxTop;$Lon_;$Lon_boxBottom)
		
		$Lon_right:=$Lon_left+$Lon_width
		OBJECT SET COORDINATES:C1248(*;"label.left";$Lon_left;$Lon_labelTop;$Lon_right;$Lon_labelBottom)
		OBJECT SET COORDINATES:C1248(*;"box.left";$Lon_left+5;$Lon_boxTop;$Lon_right-5;$Lon_boxBottom)
		
		$Lon_left:=$Lon_right
		$Lon_right:=$Lon_left+$Lon_width
		OBJECT SET COORDINATES:C1248(*;"label.center";$Lon_left;$Lon_labelTop;$Lon_right;$Lon_labelBottom)
		OBJECT SET COORDINATES:C1248(*;"box.center";$Lon_left+5;$Lon_boxTop;$Lon_right-5;$Lon_boxBottom)
		
		$Lon_left:=$Lon_right
		$Lon_right:=$Lon_left+$Lon_width
		OBJECT SET COORDINATES:C1248(*;"label.right";$Lon_left;$Lon_labelTop;$Lon_right;$Lon_labelBottom)
		OBJECT SET COORDINATES:C1248(*;"box.right";$Lon_left+5;$Lon_boxTop;$Lon_right-5;$Lon_boxBottom)
		
		  //Place the action button
		If (OBJECT Get visible:C1075(*;"textbox"))
			
			$Txt_object:=(OBJECT Get pointer:C1124(Object named:K67:5;"current_1"))->
			
			OBJECT GET COORDINATES:C663(*;"action";$Lon_;$Lon_;$Lon_right;$Lon_)
			OBJECT GET COORDINATES:C663(*;$Txt_object;$Lon_left;$Lon_top;$Lon_right2;$Lon_bottom)
			
			OBJECT SET COORDINATES:C1248(*;"textbox";$Lon_left;$Lon_top;$Lon_right2;$Lon_bottom)
			
			$Lon_offset:=$Lon_right2-$Lon_right
			OBJECT MOVE:C664(*;"action";$Lon_offset;0)
			
		End if 
		
		  //______________________________________________________
	: ($Lon_page=2)
		
		  //______________________________________________________
End case 

  // ----------------------------------------------------
  // Return
  //<NONE>
  // ----------------------------------------------------
  // End