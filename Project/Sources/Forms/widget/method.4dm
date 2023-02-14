// ----------------------------------------------------
// Form method : test - (4D Report)
// ID[4C5BEB9454924B158645C464796CF198]
// Created #3-12-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Declarations

var \
$form_event : Object

var \
$container : Pointer



// ----------------------------------------------------
// Initialisations

$form_event:=FORM Event:C1606

SET TIMER:C645(0)

// ----------------------------------------------------

Case of 
		
		//______________________________________________________
	: ($form_event.code=On Load:K2:1)
		
		
		//______________________________________________________
	: ($form_event.code=On Timer:K2:25)
		
		//______________________________________________________
	: ($form_event.code=On Bound Variable Change:K2:52)
		
		$container:=OBJECT Get pointer:C1124(Object subform container:K67:4)
		
		(OBJECT Get pointer:C1124(Object named:K67:5; "dynamic-bool"))->:=OB Get:C1224($container->; "bool"; Is longint:K8:6)
		(OBJECT Get pointer:C1124(Object named:K67:5; "dynamic-text"))->:=OB Get:C1224($container->; "text"; Is text:K8:3)
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Form event activated unnecessary ("+String:C10($form_event.code)+")")
		
		//______________________________________________________
End case 