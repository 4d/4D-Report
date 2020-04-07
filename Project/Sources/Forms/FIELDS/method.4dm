  // ----------------------------------------------------
  // Form method : FIELDS - (4D Report)
  // ID[2DF4FB63B26B4834AD030314606BABE4]
  // Created #1-12-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_formEvent)
C_POINTER:C301($Ptr_list)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388

  // ----------------------------------------------------

Case of 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Load:K2:1)
		
		OBJECT SET RGB COLORS:C628(*;"@.focus";Highlight text background color:K23:5;Background color none:K23:10)
		
		SET TIMER:C645(-1)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Unload:K2:2)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Timer:K2:25)
		
		SET TIMER:C645(0)
		
		$Ptr_list:=OBJECT Get pointer:C1124(Object named:K67:5;"field.list")
		
		If (Count list items:C380($Ptr_list->)=0)
			
			  //first use
			CLEAR LIST:C377($Ptr_list->)
			
			$Ptr_list->:=db_Get_field_list (C_QR_MASTERTABLE)
			
		End if 
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessarily ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 