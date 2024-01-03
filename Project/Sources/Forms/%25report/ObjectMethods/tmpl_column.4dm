// ----------------------------------------------------
// Object method : %report.tmpl_column - (4D Report)
// ID[FA7FC961577D4B7AAA12929FFEFE7C72]
// Created #30-9-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Declarations
C_LONGINT:C283($Lon_char; $Lon_formEvent; $Lon_length; $Lon_start; $Lon_stop)
C_POINTER:C301($Ptr_me)
C_TEXT:C284($Txt_buffer; $Txt_filter; $Txt_me)

// ----------------------------------------------------
// Initialisations
$Lon_formEvent:=Form event code:C388
$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)
$Ptr_me:=OBJECT Get pointer:C1124(Object current:K67:2)

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($Lon_formEvent=On Before Keystroke:K2:6)
		
		$Lon_char:=Character code:C91(Keystroke:C390)
		
		If ($Lon_char=Carriage return:K15:38)
			
			$Txt_buffer:=Get edited text:C655
			$Lon_length:=Length:C16($Txt_buffer)
			
			GET HIGHLIGHT:C209(*; $Txt_me; $Lon_start; $Lon_stop)
			
			If ($Lon_start=$Lon_stop)
				
				If ($Lon_start=$Lon_length)
					
					// Append a carriage return
					$Txt_buffer:=$Txt_buffer+Char:C90(Carriage return:K15:38)
					$Lon_stop:=$Lon_length+1
					
				Else 
					
					// Insert a carriage return
					$Txt_buffer:=Insert string:C231($Txt_buffer; Char:C90(Carriage return:K15:38); $Lon_start)
					$Lon_stop:=$Lon_start+1
					$Txt_filter:=Char:C90(Right arrow key:K12:17)
					
				End if 
				
			Else 
				
				// Replace the selection with a carriage return
				$Txt_buffer:=Substring:C12($Txt_buffer; 1; $Lon_start-1)+Char:C90(Carriage return:K15:38)+Substring:C12($Txt_buffer; $Lon_stop+1)
				$Lon_stop:=$Lon_start
				
			End if 
			
			// Replace the character entered
			FILTER KEYSTROKE:C389($Txt_filter)
			
			// Update the edited text
			//%W-533.3
			$Ptr_me->{$Ptr_me->}:=$Txt_buffer
			//%W+533.3
			
			// Move the cursor
			HIGHLIGHT TEXT:C210(*; $Txt_me; $Lon_stop; $Lon_stop)
			
		End if 
		
		//______________________________________________________
	: ($Lon_formEvent=On Losing Focus:K2:8)
		
		report_AFTER_EDIT  //#DD ACI0104452 ob_area is undefined at this level when esc keydown 
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		//______________________________________________________
End case 