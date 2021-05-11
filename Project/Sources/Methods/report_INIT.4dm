//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : report_init
// Database: 4D Report
// ID[88A2D0B42B214AD2B75BC53A01922DE3]
// Created #24-3-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
// initialisation of the 'nqr' module
// ----------------------------------------------------
// Declarations
C_LONGINT:C283($Lon_parameters; $Lon_platform; $lon_backcolor; $lon_strokecolor; $lon_backcolor)

C_TEXT:C284($Txt_buffer; $Txt_fontFamily; $Txt_label; $Txt_template)

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0; "Missing parameter"))
	
	//NO PARAMETERS REQUIRED
	_O_PLATFORM PROPERTIES:C365($Lon_platform)
	
	//$Txt_fontFamily:="'"+OBJECT Get font(*;"default_font")+"'"
	$Txt_fontFamily:=Choose:C955($Lon_platform=Windows:K25:3; "Segoe UI"; "Lucida Grande")
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
//Load structure definition and virtual structure


db_INIT_STRUCTURE


If (Not:C34(OB Is defined:C1231(<>report_params)))  //| Shift down
	
	_O_PLATFORM PROPERTIES:C365($Lon_platform)
	
	
	If (FORM Get color scheme:C1761="light")
		
		$lon_strokecolor:=Black:K11:16
		$lon_backcolor:=Choose:C955($Lon_platform=Windows:K25:3; 0x00FBFBFB; 0x00F4F4F4)
		
	Else 
		$lon_strokecolor:=White:K11:1
		$lon_backcolor:=0x00303133
		
	End if 
	
	OB SET:C1220(<>report_params; \
		"form-object"; "nqr"; \
		"header-height"; 30; \
		"header-button-offset"; 8; \
		"header-button-width"; 23; \
		"locked-columns"; 1; \
		"header-background-color"; $lon_backcolor; \
		"headerFontColor"; $lon_strokecolor; \
		"add-sensitive"; 15; \
		"default-column-width"; 128; \
		"default-row-height"; 30; \
		"selected-background-color"; Highlight menu background color:K23:7; \
		"selected-foreground-color"; Highlight text color:K23:6\
		)
	
	//======================================================
	//                       DEV FLAGS
	//======================================================
	<>Boo_debug:=Not:C34(Is compiled mode:C492)
	
	//======================================================
	//         Labels for automatic calculations
	//======================================================
	ARRAY TEXT:C222(<>tTxt_nqr_data_styled; 5)
	
	$Txt_template:="<span style=\"font-family:'"+$Txt_fontFamily+"';font-size:{size};font-weight:{bold};font-style:normal;text-decoration:none;color:{color}\">{value} </span>"
	
	//------------------------- SUM -------------------------
	$Txt_buffer:=Replace string:C233($Txt_template; "{size}"; Choose:C955($Lon_platform=Windows:K25:3; "16"; "18"))
	$Txt_buffer:=Replace string:C233($Txt_buffer; "{bold}"; "normal")
	$Txt_buffer:=Replace string:C233($Txt_buffer; "{color}"; "#FF0000")  //red
	$Txt_buffer:=Replace string:C233($Txt_buffer; "{value}"; Char:C90(0x2211))
	
	$Txt_label:=Get localized string:C991("nqr_sum")
	
	<>tTxt_nqr_data_styled{0}:=$Txt_buffer  //+$Txt_label+"\r"
	
	//---------------------- AVERAGE ----------------------
	$Txt_buffer:=Replace string:C233($Txt_template; "{size}"; "18")
	$Txt_buffer:=Replace string:C233($Txt_buffer; "{bold}"; "normal")
	$Txt_buffer:=Replace string:C233($Txt_buffer; "{color}"; "#0000FF")  //blue
	$Txt_buffer:=Replace string:C233($Txt_buffer; "{value}"; "n"+Char:C90(0x0305))
	
	$Txt_label:=Get localized string:C991("nqr_average")
	
	<>tTxt_nqr_data_styled{1}:=$Txt_buffer  //+$Txt_label+"\r"
	
	//------------------------ MIN ------------------------
	$Txt_buffer:=Replace string:C233($Txt_template; "{size}"; "18")
	$Txt_buffer:=Replace string:C233($Txt_buffer; "{bold}"; "bold")
	$Txt_buffer:=Replace string:C233($Txt_buffer; "{color}"; "#FFA500")  //orange
	$Txt_buffer:=Replace string:C233($Txt_buffer; "{value}"; "&lt;")
	
	$Txt_label:=Get localized string:C991("nqr_min")
	
	<>tTxt_nqr_data_styled{2}:=$Txt_buffer  //+$Txt_label+"\r"
	
	//------------------------ MAX ------------------------
	$Txt_buffer:=Replace string:C233($Txt_template; "{size}"; "18")
	$Txt_buffer:=Replace string:C233($Txt_buffer; "{bold}"; "bold")
	$Txt_buffer:=Replace string:C233($Txt_buffer; "{color}"; "#FFA500")  //orange
	$Txt_buffer:=Replace string:C233($Txt_buffer; "{value}"; "&gt;")
	
	$Txt_label:=Get localized string:C991("nqr_max")
	
	<>tTxt_nqr_data_styled{3}:=$Txt_buffer  //+$Txt_label+"\r"
	
	//------------------------ COUNT ------------------------
	$Txt_buffer:=Replace string:C233($Txt_template; "{size}"; Choose:C955($Lon_platform=Windows:K25:3; "16"; "18"))
	$Txt_buffer:=Replace string:C233($Txt_buffer; "{bold}"; "bold")
	$Txt_buffer:=Replace string:C233($Txt_buffer; "{color}"; "#0000FF")  //blue
	$Txt_buffer:=Replace string:C233($Txt_buffer; "{value}"; "N")
	
	$Txt_label:=Get localized string:C991("nqr_count")
	
	<>tTxt_nqr_data_styled{4}:=$Txt_buffer  //+$Txt_label+"\r"
	
	//----------------- STANDARD DEVIATION ------------------
	$Txt_buffer:=Replace string:C233($Txt_template; "{size}"; "18")
	$Txt_buffer:=Replace string:C233($Txt_buffer; "{bold}"; "normal")
	$Txt_buffer:=Replace string:C233($Txt_buffer; "{color}"; "#0000FF")  //blue
	$Txt_buffer:=Replace string:C233($Txt_buffer; "{value}"; Char:C90(0x03C3))
	
	$Txt_label:=Get localized string:C991("nqr_standard_deviation")
	
	<>tTxt_nqr_data_styled{5}:=$Txt_buffer  //+$Txt_label+"\r"
	
	//======================================================
	//           Tags for automatic calculations
	//======================================================
	ARRAY TEXT:C222(<>tTxt_nqr_data_tag; 5)
	
	<>tTxt_nqr_data_tag{0}:="##S"  //\r"
	<>tTxt_nqr_data_tag{1}:="##A"  //\r"
	<>tTxt_nqr_data_tag{2}:="##N"  //\r"
	<>tTxt_nqr_data_tag{3}:="##X"  //\r"
	<>tTxt_nqr_data_tag{4}:="##C"  //\r"
	<>tTxt_nqr_data_tag{5}:="##D"  //\r"
	
End if 

// ----------------------------------------------------
// End