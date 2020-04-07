  // ----------------------------------------------------
  // Form method : parent_form.dynamic-object - (4D Report)
  // ID[C81D393699CD477196B68D17C761F2A3]
  // Created #3-12-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_formEvent)
C_POINTER:C301($Ptr_;$Ptr_me)
C_OBJECT:C1216($Obj_buffer)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388
$Ptr_me:=OBJECT Get pointer:C1124(Object current:K67:2)

  // ----------------------------------------------------
Case of 
		  //______________________________________________________
	: ($Lon_formEvent=On Load:K2:1)
		
		OB SET:C1220($Obj_buffer;\
			"bool";True:C214)
		OB SET:C1220($Obj_buffer;\
			"text";"Hello world!")
		
		VARIABLE TO VARIABLE:C635(Current process:C322;$Ptr_me->;$Obj_buffer)
		
		OB SET:C1220($Obj_buffer;"test";True:C214)
		
		  //$Ptr_me->:=OB Copy($Obj_buffer)
		
		
		$Ptr_:=(OBJECT Get pointer:C1124(Object named:K67:5;"undefined"))
		
		VARIABLE TO VARIABLE:C635(Current process:C322;$Ptr_->;$Lon_formEvent)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Data Change:K2:15)
		
		(OBJECT Get pointer:C1124(Object named:K67:5;"dynamic-bool"))->:=OB Get:C1224($Ptr_me->;"bool";Is longint:K8:6)
		(OBJECT Get pointer:C1124(Object named:K67:5;"dynamic-text"))->:=OB Get:C1224($Ptr_me->;"text";Is text:K8:3)
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 