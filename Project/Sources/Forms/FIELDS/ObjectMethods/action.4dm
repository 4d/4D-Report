  // ----------------------------------------------------
  // Object method : FIELDS.action - (4D Report)
  // ID[1D5C3644052F484EB9A570303541FA8D]
  // Created #11-12-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_formEvent)
C_POINTER:C301($Ptr_container;$Ptr_me)
C_TEXT:C284($Mnu_pop;$Txt_action;$Txt_me)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388
$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)
$Ptr_me:=OBJECT Get pointer:C1124(Object current:K67:2)

  // ----------------------------------------------------
Case of 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Clicked:K2:4)
		
		$Mnu_pop:=Create menu:C408
		
		APPEND MENU ITEM:C411($Mnu_pop;":xliff:allFields")
		SET MENU ITEM PARAMETER:C1004($Mnu_pop;-1;"add_all")
		
		APPEND MENU ITEM:C411($Mnu_pop;":xliff:formula")
		SET MENU ITEM PARAMETER:C1004($Mnu_pop;-1;"formula")
		
		$Txt_action:=Dynamic pop up menu:C1006($Mnu_pop)
		RELEASE MENU:C978($Mnu_pop)
		
		If (Length:C16($Txt_action)>0)
			
			$Ptr_container:=OBJECT Get pointer:C1124(Object subform container:K67:4)
			
			OB SET:C1220($Ptr_container->;\
				"action";$Txt_action)
			
			CALL SUBFORM CONTAINER:C1086(-1)
			
		End if 
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessarily ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 