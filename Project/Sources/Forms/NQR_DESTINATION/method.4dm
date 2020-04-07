  // ----------------------------------------------------
  // Form method : NQR_DESTINATION - (4D Report)
  // ID[5554ADED683245A7B906095DA252B307]
  // Created #11-6-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_BOOLEAN:C305($Boo_avalaible)
C_LONGINT:C283($Lon_formEvent)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388

  // ----------------------------------------------------

Case of 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Load:K2:1)
		
		COMPILER_NQR 
		
		  //the destination "4D view" is attached to the availibility of the licence
		  //in a compiled database (final user), the button is hidden
		  //if not (development), the button is simply disabled
		
		  //#ACI0092842 [
		  //add the testing for the presence of the plugin
		  //$Boo_avalaible:=(Is license available(4D View license))
		ARRAY LONGINT:C221($tLon_IDs;0x0000)
		ARRAY TEXT:C222($tTxt_names;0x0000)
		PLUGIN LIST:C847($tLon_IDs;$tTxt_names)
		
		$Boo_avalaible:=(Is license available:C714(4D View license:K44:4))\
			 & (Find in array:C230($tTxt_names;"4D View")>0)
		  //]
		
		  //#ACI0093102 4DView is available only in 32 bits [
		  //If (Is compiled mode(*))
		  //OBJECT SET VISIBLE(*;"4Dview";$Boo_avalaible)
		  //Else
		  //Obj_SET_ENABLED ($Boo_avalaible;"4Dview")
		  //End if
		
		  //Case of 
		  //  //………………………………………………………………………………
		  //: (Version type ?? 64 bit version)
		  //OBJECT SET VISIBLE(*;"4Dview";False)
		  //  //………………………………………………………………………………
		  //: (Is compiled mode(*))
		  //OBJECT SET VISIBLE(*;"4Dview";$Boo_avalaible)
		  //  //………………………………………………………………………………
		  //Else 
		  //Obj_SET_ENABLED ($Boo_avalaible;"4Dview")
		  //  //………………………………………………………………………………
		  //End case 
		  //]
		
		OBJECT SET RGB COLORS:C628(*;"select";Highlight text background color:K23:5;Background color none:K23:10)
		
		SET TIMER:C645(-1)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Timer:K2:25)
		
		SET TIMER:C645(0)
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 