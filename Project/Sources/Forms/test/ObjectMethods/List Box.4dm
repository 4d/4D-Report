// ----------------------------------------------------
// Object method : test.List Box - (4D Report)
// ID[C050FD44B4104EF2BAE199A34FB2F265]
// Created #12-1-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Declarations
C_LONGINT:C283($Lon_formEvent; $Lon_i)
C_POINTER:C301($Ptr_me)
C_TEXT:C284($Txt_me)

// ----------------------------------------------------
// Initialisations
$Lon_formEvent:=Form event code:C388
$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)
$Ptr_me:=OBJECT Get pointer:C1124(Object current:K67:2)

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($Lon_formEvent=On Load:K2:1)
		
		ARRAY TEXT:C222($tTxt_buffer; 10)
		
		For ($Lon_i; 1; 5; 1)
			
			$tTxt_buffer{$Lon_i}:=String:C10($Lon_i)
			
		End for 
		
		//%W-518.1
		COPY ARRAY:C226($tTxt_buffer; (OBJECT Get pointer:C1124(Object named:K67:5; "Column1"))->)
		//%W+518.1
		
		//______________________________________________________
	: ($Lon_formEvent=On Delete Action:K2:56)
		
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		//______________________________________________________
End case 