  // ----------------------------------------------------
  // Form method : NQR_DESTINATION - (4D Report)
  // ID[5554ADED683245A7B906095DA252B307]
  // Created #11-6-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_formEvent;$Lon_type)
C_TEXT:C284($Txt_default;$Txt_specific;$Txt_template)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388

  // ----------------------------------------------------

Case of 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Load:K2:1)
		
		COMPILER_NQR 
		
		  //SET TIMER(-1)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Activate:K2:9)
		
		SET TIMER:C645(-1)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Timer:K2:25)
		
		SET TIMER:C645(0)
		
		$Lon_type:=FORM Get current page:C276(*)
		
		QR GET DESTINATION:C756(QR_area;$Lon_type;$Txt_specific)
		
		Case of 
				
				  //………………………………………………………
			: ($Lon_type=qr printer:K14903:1)
				
				(OBJECT Get pointer:C1124(Object named:K67:5;"print.no_dialog"))->:=Num:C11($Txt_specific="*")
				
				  //………………………………………………………
			: ($Lon_type=qr text file:K14903:2)
				
				  //#ACI0093706 {
				(OBJECT Get pointer:C1124(Object named:K67:5;"FldDelimit"))->:=QR Get document property:C773(QR_area;qr field separator:K14907:3)
				(OBJECT Get pointer:C1124(Object named:K67:5;"RecDelimit"))->:=QR Get document property:C773(QR_area;qr record separator:K14907:4)
				  //}
				
				(OBJECT Get pointer:C1124(Object named:K67:5;"text.path"))->:=$Txt_specific
				
				PathPicker SET SELECTION OPTION ("text.path";Package selection:K24:9+Use sheet window:K24:11+File name entry:K24:17)
				PathPicker SET OPTIONS ("text.path";False:C215;2;3)
				pathPicker SET MESSAGE ("text.path";Get localized string:C991("DestinationFile"))
				PathPicker SET PLACEHOLDER ("text.path";Get localized string:C991("DestinationFile")+"…")
				pathPicker SET FILE TYPES ("text.path";".txt")
				pathPicker SET DIRECTORY ("text.path";"13893")
				
				GOTO OBJECT:C206(*;"FldDelimit")
				
				  //………………………………………………………
			: ($Lon_type=qr HTML file:K14903:5)
				
				(OBJECT Get pointer:C1124(Object named:K67:5;"html.path"))->:=$Txt_specific
				
				PathPicker SET SELECTION OPTION ("html.path";Package selection:K24:9+Use sheet window:K24:11+File name entry:K24:17)
				PathPicker SET OPTIONS ("html.path";False:C215;2;3)
				pathPicker SET MESSAGE ("html.path";Get localized string:C991("DestinationFile"))
				PathPicker SET PLACEHOLDER ("html.path";Get localized string:C991("DestinationFile")+"…")
				pathPicker SET FILE TYPES ("html.path";".html")
				pathPicker SET DIRECTORY ("html.path";"13893")
				
				$Txt_template:=Replace string:C233(QR Get HTML template:C751(QR_area);"\r";"<br/>")
				$Txt_default:=Get localized string:C991("html_default_template")
				
				If ($Txt_template=$Txt_default)
					
					(OBJECT Get pointer:C1124(Object named:K67:5;"html.template.default"))->:=1
					OBJECT SET ENABLED:C1123(*;"html.browse";False:C215)
					
				Else 
					
					(OBJECT Get pointer:C1124(Object named:K67:5;"html.template.default"))->:=0
					OBJECT SET ENABLED:C1123(*;"html.browse";True:C214)
					
				End if 
				
				  //………………………………………………………
		End case 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Page Change:K2:54)
		
		SET TIMER:C645(-1)
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 