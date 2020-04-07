  // ----------------------------------------------------
  // Object method : NQR_HEADER_AND_FOOTER.height - (4D Report)
  // ID[BEF6A32186DE4ADD83BA02F6169A2F71]
  // Created #17-6-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($kLon_resolution;$Lon_formEvent;$Lon_height;$Lon_point;$Lon_unit)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388

  // ----------------------------------------------------
Case of 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Getting Focus:K2:7)
		
		(OBJECT Get pointer:C1124(Object named:K67:5;"current_2"))->:=OBJECT Get name:C1087(Object current:K67:2)
		
		  //______________________________________________________
	: ($Lon_formEvent=On After Edit:K2:43)
		
		$kLon_resolution:=72
		
		$Lon_height:=Num:C11(Get edited text:C655)
		
		  //convert height in points according to the selected unit
		$Lon_unit:=(OBJECT Get pointer:C1124(Object named:K67:5;"height.unit"))->
		$Lon_point:=Choose:C955($Lon_unit;\
			$Lon_height;\
			$Lon_height;\
			$Lon_height*$kLon_resolution;\
			$Lon_height*($kLon_resolution/2.54))
		
		  //get the converted value
		(OBJECT Get pointer:C1124(Object named:K67:5;"height.points"))->:=$Lon_point
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 