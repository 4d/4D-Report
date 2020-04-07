//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : menu_format
  // Database: 4D Report
  // ID[72DC3126FC154F24BD51A45EDC9A5D6A]
  // Created #18-9-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($0)
C_LONGINT:C283($1)
C_TEXT:C284($2)

C_LONGINT:C283($Lon_i;$Lon_parameters;$Lon_type)
C_TEXT:C284($Mnu_format;$Txt_buffer;$Txt_columnFormat)

If (False:C215)
	C_TEXT:C284(menu_format ;$0)
	C_LONGINT:C283(menu_format ;$1)
	C_TEXT:C284(menu_format ;$2)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	  //Required parameters
	$Lon_type:=$1
	
	  //Optional parameters
	If ($Lon_parameters>=2)
		
		$Txt_columnFormat:=$2
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
$Mnu_format:=Create menu:C408

Case of 
		
		  //______________________________________________________
	: ($Lon_type=Is undefined:K8:13)  //formula
		
		$Lon_i:=1
		
		Repeat 
			
			$Txt_buffer:=Get localized string:C991("alpha_"+String:C10($Lon_i))
			
			If (Length:C16($Txt_buffer)>0)
				
				APPEND MENU ITEM:C411($Mnu_format;$Txt_buffer;*)
				SET MENU ITEM PARAMETER:C1004($Mnu_format;-1;"format_"+$Txt_buffer)
				SET MENU ITEM MARK:C208($Mnu_format;-1;Char:C90(18)*Num:C11($Txt_buffer=$Txt_columnFormat))
				
				$Lon_i:=$Lon_i+1
				
			End if 
		Until (Length:C16($Txt_buffer)=0)
		
		APPEND MENU ITEM:C411($Mnu_format;"-";*)
		
		$Lon_i:=1
		
		Repeat 
			
			$Txt_buffer:=Get localized string:C991("number_"+String:C10($Lon_i))
			
			If (Length:C16($Txt_buffer)>0)
				
				APPEND MENU ITEM:C411($Mnu_format;$Txt_buffer;*)
				SET MENU ITEM PARAMETER:C1004($Mnu_format;-1;"format_"+$Txt_buffer)
				SET MENU ITEM MARK:C208($Mnu_format;-1;Char:C90(18)*Num:C11($Txt_buffer=$Txt_columnFormat))
				
				$Lon_i:=$Lon_i+1
				
			End if 
		Until (Length:C16($Txt_buffer)=0)
		
		  //______________________________________________________
	: ($Lon_type=Is integer:K8:5)\
		 | ($Lon_type=Is integer 64 bits:K8:25)\
		 | ($Lon_type=Is longint:K8:6)\
		 | ($Lon_type=Is real:K8:4)
		
		$Lon_i:=1
		
		Repeat 
			
			$Txt_buffer:=Get localized string:C991("number_"+String:C10($Lon_i))
			
			If (Length:C16($Txt_buffer)>0)
				
				APPEND MENU ITEM:C411($Mnu_format;$Txt_buffer;*)
				SET MENU ITEM PARAMETER:C1004($Mnu_format;-1;"format_"+$Txt_buffer)
				SET MENU ITEM MARK:C208($Mnu_format;-1;Char:C90(18)*Num:C11($Txt_buffer=$Txt_columnFormat))
				
				$Lon_i:=$Lon_i+1
				
			End if 
		Until (Length:C16($Txt_buffer)=0)
		
		  //______________________________________________________
	: ($Lon_type=Is date:K8:7)
		
		$Lon_i:=1
		
		Repeat 
			
			$Txt_buffer:=Get localized string:C991("date_"+String:C10($Lon_i))
			
			If (Length:C16($Txt_buffer)>0)
				
				APPEND MENU ITEM:C411($Mnu_format;$Txt_buffer;*)
				SET MENU ITEM PARAMETER:C1004($Mnu_format;-1;"format_"+$Txt_buffer)
				SET MENU ITEM MARK:C208($Mnu_format;-1;Char:C90(18)*Num:C11($Txt_buffer=$Txt_columnFormat))
				
				$Lon_i:=$Lon_i+1
				
			End if 
		Until (Length:C16($Txt_buffer)=0)
		
		  //______________________________________________________
	: ($Lon_type=Is time:K8:8)
		
		$Lon_i:=1
		
		Repeat 
			
			$Txt_buffer:=Get localized string:C991("time_"+String:C10($Lon_i))
			
			If (Length:C16($Txt_buffer)>0)
				
				APPEND MENU ITEM:C411($Mnu_format;$Txt_buffer;*)
				SET MENU ITEM PARAMETER:C1004($Mnu_format;-1;"format_"+$Txt_buffer)
				SET MENU ITEM MARK:C208($Mnu_format;-1;Char:C90(18)*Num:C11($Txt_buffer=$Txt_columnFormat))
				
				$Lon_i:=$Lon_i+1
				
			End if 
		Until (Length:C16($Txt_buffer)=0)
		
		  //______________________________________________________
	: ($Lon_type=Is boolean:K8:9)
		
		$Lon_i:=1
		
		Repeat 
			
			$Txt_buffer:=Get localized string:C991("boolean_"+String:C10($Lon_i))
			
			If (Length:C16($Txt_buffer)>0)
				
				APPEND MENU ITEM:C411($Mnu_format;$Txt_buffer;*)
				SET MENU ITEM PARAMETER:C1004($Mnu_format;-1;"format_"+$Txt_buffer)
				SET MENU ITEM MARK:C208($Mnu_format;-1;Char:C90(18)*Num:C11($Txt_buffer=$Txt_columnFormat))
				
				$Lon_i:=$Lon_i+1
				
			End if 
		Until (Length:C16($Txt_buffer)=0)
		
		  //______________________________________________________
	: ($Lon_type=Is picture:K8:10)
		
		$Lon_i:=1
		
		Repeat 
			
			$Txt_buffer:=Get localized string:C991("pict_"+String:C10($Lon_i))
			
			If (Length:C16($Txt_buffer)>0)
				
				APPEND MENU ITEM:C411($Mnu_format;$Txt_buffer;*)
				SET MENU ITEM PARAMETER:C1004($Mnu_format;-1;"format_"+$Txt_buffer)
				SET MENU ITEM MARK:C208($Mnu_format;-1;Char:C90(18)*Num:C11($Txt_buffer=$Txt_columnFormat))
				
				$Lon_i:=$Lon_i+1
				
			End if 
		Until (Length:C16($Txt_buffer)=0)
		
		  //______________________________________________________
	: ($Lon_type=Is text:K8:3)\
		 | ($Lon_type=Is alpha field:K8:1)\
		 | ($Lon_type=Is string var:K8:2)
		
		$Lon_i:=1
		
		Repeat 
			
			$Txt_buffer:=Get localized string:C991("alpha_"+String:C10($Lon_i))
			
			If (Length:C16($Txt_buffer)>0)
				
				APPEND MENU ITEM:C411($Mnu_format;$Txt_buffer;*)
				SET MENU ITEM PARAMETER:C1004($Mnu_format;-1;"format_"+$Txt_buffer)
				SET MENU ITEM MARK:C208($Mnu_format;-1;Char:C90(18)*Num:C11($Txt_buffer=$Txt_columnFormat))
				
				$Lon_i:=$Lon_i+1
				
			End if 
		Until (Length:C16($Txt_buffer)=0)
		
		  //______________________________________________________
End case 

  //add none item {
INSERT MENU ITEM:C412($Mnu_format;0;"-")
INSERT MENU ITEM:C412($Mnu_format;0;Get localized string:C991("none"))
SET MENU ITEM PARAMETER:C1004($Mnu_format;-1;"format_")
SET MENU ITEM MARK:C208($Mnu_format;-1;Char:C90(18)*Num:C11(""=$Txt_columnFormat))
  //}

  // ----------------------------------------------------
  // Return
$0:=$Mnu_format

  // ----------------------------------------------------
  // End