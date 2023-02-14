// ----------------------------------------------------
// Object method : %report.cell_menu - (4D Report)
// ID[96DC938629A448768DC49CC85DAEF045]
// Created #22-1-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Declarations

var \
$length; \
$start; \
$stop; \
$event_code : Integer

var \
$menu; \
$buffer; \
$choice; \
$my_name : Text

var \
$self; \
$ui_focused : Pointer



// ----------------------------------------------------
// Initialisations
$event_code:=Form event code:C388

//todo:$my_name is unused
$my_name:=OBJECT Get name:C1087(Object current:K67:2)
$self:=OBJECT Get pointer:C1124(Object current:K67:2)

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($event_code=On Clicked:K2:4)
		
		$menu:=Create menu:C408
		
		APPEND MENU ITEM:C411($menu; Char:C90(0x2211)+"   "+Get localized string:C991("nqr_sum"))
		SET MENU ITEM PARAMETER:C1004($menu; -1; String:C10(Form:C1466.dataTags[0]))
		
		APPEND MENU ITEM:C411($menu; "n"+Char:C90(0x0305)+"   "+Get localized string:C991("nqr_average"))
		SET MENU ITEM PARAMETER:C1004($menu; -1; String:C10(Form:C1466.dataTags[1]))
		
		APPEND MENU ITEM:C411($menu; "<   "+Get localized string:C991("nqr_min"))
		SET MENU ITEM PARAMETER:C1004($menu; -1; String:C10(Form:C1466.dataTags[2]))
		
		APPEND MENU ITEM:C411($menu; ">   "+Get localized string:C991("nqr_max"))
		SET MENU ITEM PARAMETER:C1004($menu; -1; String:C10(Form:C1466.dataTags[3]))
		
		APPEND MENU ITEM:C411($menu; "N   "+Get localized string:C991("nqr_count"))
		SET MENU ITEM PARAMETER:C1004($menu; -1; String:C10(Form:C1466.dataTags[4]))
		
		APPEND MENU ITEM:C411($menu; Char:C90(0x03C3)+"   "+Get localized string:C991("nqr_standard_deviation"))
		SET MENU ITEM PARAMETER:C1004($menu; -1; String:C10(Form:C1466.dataTags[5]))
		
		$choice:=Dynamic pop up menu:C1006($menu)
		RELEASE MENU:C978($menu)
		
		Case of 
				
				//______________________________________________________
			: (Length:C16($choice)=0)
				
				// Nothing selected
				
				//______________________________________________________
			: ($choice="##@")  // Insert tag
				
				$ui_focused:=OBJECT Get pointer:C1124(Object with focus:K67:3)
				
				$buffer:=Get edited text:C655
				$length:=Length:C16($buffer)
				
				GET HIGHLIGHT:C209($ui_focused->; $start; $stop)
				
				If ($start=$stop)
					
					If ($start=$length)
						
						// Append
						$buffer:=$buffer+$choice
						
					Else 
						
						// Insert
						$buffer:=Insert string:C231($buffer; $choice; $start)
						
					End if 
					
				Else 
					
					// Replace the selection
					$buffer:=Substring:C12($buffer; 1; $start-1)+$choice+Substring:C12($buffer; $stop+1)
					
				End if 
				
				HIGHLIGHT TEXT:C210($ui_focused->; $start+3; $start+3)
				
				//______________________________________________________
			Else 
				
				ASSERT:C1129(False:C215; "Unknown entry point: \""+$choice+"\"")
				
				//______________________________________________________
		End case 
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Form event activated unnecessary ("+String:C10($event_code)+")")
		
		//______________________________________________________
End case 