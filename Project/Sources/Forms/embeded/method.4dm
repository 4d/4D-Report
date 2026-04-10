// ----------------------------------------------------
// Form method : embeded - (4D Report)
// ID[03E59BA5877F4C55A8B9C32657BD9F76]
// Created #18-7-2016 by Vincent de Lachaux
// ----------------------------------------------------
// Declarations
C_LONGINT:C283($Lon_formEvent)
C_POINTER:C301($Ptr_area)

// ----------------------------------------------------
// Initialisations
$Lon_formEvent:=Form event code:C388

$Ptr_area:=OBJECT Get pointer:C1124(Object named:K67:5; "area")

// ----------------------------------------------------

Case of 
		//______________________________________________________
	: ($Lon_formEvent=On Load:K2:1)
		
		QR NEW AREA:C1320($Ptr_area)
		QR SET REPORT TABLE:C757($Ptr_area->; 1)
		QR SET REPORT KIND:C738($Ptr_area->; qr cross report:K14902:2)
		QR SET AREA PROPERTY:C796($Ptr_area->; qr view contextual menus:K14905:7; 1)
		
		var $area:=$Ptr_area->
		var $t:="Clients]Country"
		QR SET INFO COLUMN:C765($area; 1; $t; $t; 0; 128; 0; "")
		$t:="Clients]City"
		QR SET INFO COLUMN:C765($area; 2; $t; $t; 0; 128; 0; "")
		$t:="Clients]Sales"
		QR SET INFO COLUMN:C765($area; 3; $t; $t; 0; 128; 0; "")
		
		SET TIMER:C645(-1)
		//______________________________________________________
	: ($Lon_formEvent=On Unload:K2:2)
		
		QR DELETE OFFSCREEN AREA:C754($Ptr_area->)
		
		//______________________________________________________
	: ($Lon_formEvent=On Timer:K2:25)
		SET TIMER:C645(0)
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Form event activated unnecessarily ("+String:C10($Lon_formEvent)+")")
		
		//______________________________________________________
End case 