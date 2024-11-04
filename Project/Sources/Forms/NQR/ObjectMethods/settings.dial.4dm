// ----------------------------------------------------
// Object method : NQR.message - (4D Report)
// ID[BD24E8DCC7684EB9A0A642A958F325B6]
// Created #4-12-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Declarations


var $e : Object

//var $self : Pointer
//var $my_name : Text

// ----------------------------------------------------
// Initialisations
$e:=FORM Event:C1606

//$my_name:=OBJECT Get name(Object current)
//$self:=OBJECT Get pointer(Object current)


// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($e.code<0)
		
		OBJECT SET VISIBLE:C603(*; "settings.@"; False:C215)
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Form event activated unnecessary ("+String:C10($e.code)+")")
		
		//______________________________________________________
End case 