//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : NQR_OPTIONS_ACTION
  // Database: 4D Report
  // ID[BB6A763390594616865A4A85722168DD]
  // Created #28-9-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($1)

C_LONGINT:C283($Lon_;$Lon_left;$Lon_offset;$Lon_parameters;$Lon_right;$Lon_value)
C_TEXT:C284($kMnu_mark;$Mnu_main;$Txt_action;$Txt_choice;$Txt_object)

If (False:C215)
	C_TEXT:C284(NQR_OPTIONS_ACTION ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	  //Required parameters
	$Txt_action:=$1
	
	  //Optional parameters
	If ($Lon_parameters>=2)
		
		  // <NONE>
		
	End if 
	
	$Txt_object:=OBJECT Get name:C1087(Object with focus:K67:3)
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
Case of 
		
		  //______________________________________________________
	: ($Txt_action="hide")
		
		OBJECT SET VISIBLE:C603(*;"action";False:C215)
		
		  //______________________________________________________
	: ($Txt_action="show")
		
		OBJECT GET COORDINATES:C663(*;"action";$Lon_left;$Lon_;$Lon_;$Lon_)
		OBJECT GET COORDINATES:C663(*;$Txt_object;$Lon_;$Lon_;$Lon_right;$Lon_)
		
		$Lon_offset:=($Lon_right+5)-$Lon_left
		OBJECT MOVE:C664(*;"action";$Lon_offset;0)
		OBJECT SET VISIBLE:C603(*;"action";True:C214)
		
		  //______________________________________________________
	: ($Txt_action="menu.delimiter")
		
		$Lon_value:=(OBJECT Get pointer:C1124(Object named:K67:5;$Txt_object))->
		$kMnu_mark:=Char:C90(18)
		
		$Mnu_main:=Create menu:C408
		
		APPEND MENU ITEM:C411($Mnu_main;":xliff:default")
		SET MENU ITEM PARAMETER:C1004($Mnu_main;-1;Choose:C955($Txt_object="FldDelimit";"9";"13"))
		
		APPEND MENU ITEM:C411($Mnu_main;"-")
		
		Case of 
				
				  //………………………………………………………………………………………………………
			: ($Txt_object="FldDelimit")
				
				APPEND MENU ITEM:C411($Mnu_main;":xliff:tabulation")
				SET MENU ITEM PARAMETER:C1004($Mnu_main;-1;"9")
				
				If ($Lon_value=9)
					
					SET MENU ITEM MARK:C208($Mnu_main;-1;$kMnu_mark)
					
				End if 
				
				APPEND MENU ITEM:C411($Mnu_main;":xliff:comma")
				SET MENU ITEM PARAMETER:C1004($Mnu_main;-1;"44")
				
				If ($Lon_value=44)
					
					SET MENU ITEM MARK:C208($Mnu_main;-1;$kMnu_mark)
					
				End if 
				
				APPEND MENU ITEM:C411($Mnu_main;":xliff:semicolumn")
				SET MENU ITEM PARAMETER:C1004($Mnu_main;-1;"59")
				
				If ($Lon_value=59)
					
					SET MENU ITEM MARK:C208($Mnu_main;-1;$kMnu_mark)
					
				End if 
				
				APPEND MENU ITEM:C411($Mnu_main;":xliff:colon")
				SET MENU ITEM PARAMETER:C1004($Mnu_main;-1;"58")
				
				If ($Lon_value=58)
					
					SET MENU ITEM MARK:C208($Mnu_main;-1;$kMnu_mark)
					
				End if 
				
				APPEND MENU ITEM:C411($Mnu_main;":xliff:verticalBar")
				SET MENU ITEM PARAMETER:C1004($Mnu_main;-1;"124")
				
				If ($Lon_value=124)
					
					SET MENU ITEM MARK:C208($Mnu_main;-1;$kMnu_mark)
					
				End if 
				
				APPEND MENU ITEM:C411($Mnu_main;":xliff:space")
				SET MENU ITEM PARAMETER:C1004($Mnu_main;-1;"32")
				
				If ($Lon_value=32)
					
					SET MENU ITEM MARK:C208($Mnu_main;-1;$kMnu_mark)
					
				End if 
				
				  //………………………………………………………………………………………………………
			: ($Txt_object="RecDelimit")
				
				APPEND MENU ITEM:C411($Mnu_main;":xliff:carriageReturn")
				SET MENU ITEM PARAMETER:C1004($Mnu_main;-1;"13")
				
				If ($Lon_value=13)
					
					SET MENU ITEM MARK:C208($Mnu_main;-1;$kMnu_mark)
					
				End if 
				
				APPEND MENU ITEM:C411($Mnu_main;":xliff:lineFeed")
				SET MENU ITEM PARAMETER:C1004($Mnu_main;-1;"10")
				
				If ($Lon_value=10)
					
					SET MENU ITEM MARK:C208($Mnu_main;-1;$kMnu_mark)
					
				End if 
				
				APPEND MENU ITEM:C411($Mnu_main;":xliff:semicolumn")
				SET MENU ITEM PARAMETER:C1004($Mnu_main;-1;"59")
				
				If ($Lon_value=59)
					
					SET MENU ITEM MARK:C208($Mnu_main;-1;$kMnu_mark)
					
				End if 
				
				APPEND MENU ITEM:C411($Mnu_main;":xliff:tabulation")
				SET MENU ITEM PARAMETER:C1004($Mnu_main;-1;"9")
				
				If ($Lon_value=9)
					
					SET MENU ITEM MARK:C208($Mnu_main;-1;$kMnu_mark)
					
				End if 
				
				APPEND MENU ITEM:C411($Mnu_main;":xliff:recordSeparator")
				SET MENU ITEM PARAMETER:C1004($Mnu_main;-1;"30")
				
				If ($Lon_value=30)
					
					SET MENU ITEM MARK:C208($Mnu_main;-1;$kMnu_mark)
					
				End if 
				
				  //………………………………………………………………………………………………………
			Else 
				
				ASSERT:C1129(False:C215;"Unknown entry point: \""+$Txt_object+"\"")
				
				  //………………………………………………………………………………………………………
		End case 
		
		$Txt_choice:=Dynamic pop up menu:C1006($Mnu_main)
		RELEASE MENU:C978($Mnu_main)
		
		If (Length:C16($Txt_choice)#0)
			
			$Lon_:=Num:C11($Txt_choice)
			
			(OBJECT Get pointer:C1124(Object named:K67:5;$Txt_object))->:=$Lon_
			
			  //#ACI0093706
			QR SET DOCUMENT PROPERTY:C772(QR_area;Choose:C955($Txt_object="FldDelimit";qr field separator:K14907:3;qr record separator:K14907:4);$Lon_)
			
		End if 
		
		  //________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Unknown entry point: \""+$Txt_action+"\"")
		
		  //______________________________________________________
End case 

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End