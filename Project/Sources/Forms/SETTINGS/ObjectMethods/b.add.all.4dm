// ----------------------------------------------------
// Object method : SETTINGS.b.add.all - (4D Report)
// ID[E9F67F5CD38144FFB04E87449C7C335A]
// Created #4-12-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Declarations

var $event_code : Integer
var $self : Pointer
var $my_name : Text



// ----------------------------------------------------
// Initialisations
$event_code:=Form event code:C388
$my_name:=OBJECT Get name:C1087(Object current:K67:2)
$self:=OBJECT Get pointer:C1124(Object current:K67:2)

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($event_code=On Clicked:K2:4)
		
		NQR_SETTING_HANDLER("add_all")
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Form event activated unnecessarily ("+String:C10($event_code)+")")
		
		//______________________________________________________
End case 