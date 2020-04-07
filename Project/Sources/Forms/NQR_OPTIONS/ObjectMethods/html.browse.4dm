  // ----------------------------------------------------
  // Object method : NQR_OPTIONS.html.browse - (4D Report)
  // ID[343CEB168DA94DD49D1B12BFF7D49C30]
  // Created #11-9-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($0)

C_BOOLEAN:C305($Boo_OK)
C_LONGINT:C283($Lon_formEvent)
C_POINTER:C301($Ptr_me)
C_TEXT:C284($Txt_buffer;$Txt_me;$Txt_path)
C_OBJECT:C1216($Obj_widget)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388
$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)
$Ptr_me:=OBJECT Get pointer:C1124(Object current:K67:2)

$0:=-1

  // ----------------------------------------------------
Case of 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Clicked:K2:4)
		
		$Txt_path:=Select document:C905(13893;".html";Get localized string:C991("SelectTemplate");Package open:K24:8+Use sheet window:K24:11)
		
		$Boo_OK:=(OK=1)
		
		If ($Boo_OK)
			
			$Txt_path:=DOCUMENT
			
		End if 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Drag Over:K2:13)
		
		$Txt_path:=Get file from pasteboard:C976(1)
		
		If (Test path name:C476($Txt_path)=Is a document:K24:1)
			
			$0:=0
			
		End if 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Drop:K2:12)
		
		$Txt_path:=Get file from pasteboard:C976(1)
		
		$Boo_OK:=(Test path name:C476($Txt_path)=Is a document:K24:1)
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 

If ($Boo_OK)
	
	$Txt_buffer:=Document to text:C1236($Txt_path)
	
	If (Position:C15("<!--#4DQR";$Txt_buffer)>0)
		
		QR SET HTML TEMPLATE:C750(QR_area;$Txt_buffer)
		ob_dialog.optionHTMLtemplate:=$Txt_buffer
		
	Else 
		
		ALERT:C41(Get localized string:C991("invalidHTML"))
		
	End if 
End if 

CLEAR VARIABLE:C89($Obj_widget)