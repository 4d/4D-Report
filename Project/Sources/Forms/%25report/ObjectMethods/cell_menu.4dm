// ----------------------------------------------------
// Object method : %report.cell_menu - (4D Report)
// ID[96DC938629A448768DC49CC85DAEF045]
// Created #22-1-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Declarations
C_LONGINT:C283($Lon_formEvent; $Lon_length; $Lon_start; $Lon_stop)
C_POINTER:C301($Ptr_box; $Ptr_me)
C_TEXT:C284($Mnu_main; $Txt_buffer; $Txt_choice; $Txt_me)

// ----------------------------------------------------
// Initialisations
$Lon_formEvent:=Form event code:C388
$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)
$Ptr_me:=OBJECT Get pointer:C1124(Object current:K67:2)

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($Lon_formEvent=On Clicked:K2:4)
		
		$Mnu_main:=Create menu:C408
		
		APPEND MENU ITEM:C411($Mnu_main; Char:C90(0x2211)+"   "+Get localized string:C991("nqr_sum"))
		SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; <>tTxt_nqr_data_tag{0})
		
		APPEND MENU ITEM:C411($Mnu_main; "n"+Char:C90(0x0305)+"   "+Get localized string:C991("nqr_average"))
		SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; <>tTxt_nqr_data_tag{1})
		
		APPEND MENU ITEM:C411($Mnu_main; "<   "+Get localized string:C991("nqr_min"))
		SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; <>tTxt_nqr_data_tag{2})
		
		APPEND MENU ITEM:C411($Mnu_main; ">   "+Get localized string:C991("nqr_max"))
		SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; <>tTxt_nqr_data_tag{3})
		
		APPEND MENU ITEM:C411($Mnu_main; "N   "+Get localized string:C991("nqr_count"))
		SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; <>tTxt_nqr_data_tag{4})
		
		APPEND MENU ITEM:C411($Mnu_main; Char:C90(0x03C3)+"   "+Get localized string:C991("nqr_standard_deviation"))
		SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; <>tTxt_nqr_data_tag{5})
		
		$Txt_choice:=Dynamic pop up menu:C1006($Mnu_main)
		RELEASE MENU:C978($Mnu_main)
		
		Case of 
				
				//______________________________________________________
			: (Length:C16($Txt_choice)=0)
				
				// nothing selected
				
				//______________________________________________________
			: ($Txt_choice="##@")  //insert tag
				
				$Ptr_box:=OBJECT Get pointer:C1124(Object with focus:K67:3)
				
				$Txt_buffer:=Get edited text:C655
				$Lon_length:=Length:C16($Txt_buffer)
				
				GET HIGHLIGHT:C209($Ptr_box->; $Lon_start; $Lon_stop)
				
				If ($Lon_start=$Lon_stop)
					
					If ($Lon_start=$Lon_length)
						
						//append
						$Txt_buffer:=$Txt_buffer+$Txt_choice
						
					Else 
						
						//insert
						$Txt_buffer:=Insert string:C231($Txt_buffer; $Txt_choice; $Lon_start)
						
					End if 
					
				Else 
					
					//replace the selection
					$Txt_buffer:=Substring:C12($Txt_buffer; 1; $Lon_start-1)+$Txt_choice+Substring:C12($Txt_buffer; $Lon_stop+1)
					
				End if 
				
				HIGHLIGHT TEXT:C210($Ptr_box->; $Lon_start+3; $Lon_start+3)
				
				//update the edited text
				//%W-533.3
				
				//$Ptr_box->{$Ptr_box->}:=$Txt_buffer
				
				//%W+533.3
				
				//______________________________________________________
			Else 
				
				ASSERT:C1129(False:C215; "Unknown entry point: \""+$Txt_choice+"\"")
				
				//______________________________________________________
		End case 
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		//______________________________________________________
End case 