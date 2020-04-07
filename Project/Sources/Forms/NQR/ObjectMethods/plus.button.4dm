  // ----------------------------------------------------
  // Object method : NQR.plus.button - (4D Report)
  // ID[7E126861FA474CFB9FEF2C1C4E465789]
  // Created #4-6-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_formEvent)
C_TEXT:C284($Mnu_pop;$Txt_action)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388

  // ----------------------------------------------------
Case of 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Mouse Enter:K2:33)\
		 | ($Lon_formEvent=On Mouse Move:K2:35)
		
		OBJECT SET VISIBLE:C603(*;"plus.@";True:C214)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Mouse Leave:K2:34)
		
		OBJECT SET VISIBLE:C603(*;"plus.@";QR Count columns:C764(QR_area)=0)  //if at least one column
		
		  //______________________________________________________
	: ($Lon_formEvent=On Clicked:K2:4)
		
		If (Contextual click:C713)
			
			$Mnu_pop:=Create menu:C408
			
			APPEND MENU ITEM:C411($Mnu_pop;":xliff:allFields")
			SET MENU ITEM PARAMETER:C1004($Mnu_pop;-1;"add_all")
			
			APPEND MENU ITEM:C411($Mnu_pop;":xliff:formula")
			SET MENU ITEM PARAMETER:C1004($Mnu_pop;-1;"formula")
			
			$Txt_action:=Dynamic pop up menu:C1006($Mnu_pop)
			
		Else 
			
			  //$Lon_columnNumber:=OB Get(ob_area;"qrColumnNumber";Is longint)
			
			$Txt_action:="insert_end"
			
		End if 
		
		  //Insert
		EXECUTE METHOD IN SUBFORM:C1085("myQR";"report_ADD_COLUMN";*;$Txt_action)
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 