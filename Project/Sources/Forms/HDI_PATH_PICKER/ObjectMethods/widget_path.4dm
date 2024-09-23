// ----------------------------------------------------
// Object method : HDI_PATH_PICKER.widget_path
// ID[5AC07F61D04D4C29A136AA0B224F1384]
// Created #9-9-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Declarations

var $e : Object
var $my_name : Text
var $self : Pointer

var $left; $top; $right; $bottom : Integer



// ----------------------------------------------------
// Initialisations

$e:=FORM Event:C1606
$my_name:=OBJECT Get name:C1087(Object current:K67:2)
$self:=OBJECT Get pointer:C1124(Object current:K67:2)


// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($e.code<0)
		
		//______________________________________________________
	: ($e.code=On Data Change:K2:15)
		
		//update UI
		SET TIMER:C645(-1)
		
		//______________________________________________________
	: ($e.code=On Load:K2:1)
		
		//Resize the widget
		OBJECT GET COORDINATES:C663(*; $my_name+".template"; $left; $top; $right; $bottom)
		OBJECT SET COORDINATES:C1248(*; $my_name; $left; $top; $right; $bottom)
		
		//Offsets of the widget
		subform_SET_OFFSET($my_name)
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Form event activated unnecessary ("+String:C10($e.code)+")")
		
		//______________________________________________________
End case 