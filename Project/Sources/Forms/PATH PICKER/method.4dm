// ----------------------------------------------------
// Form method : PATH PICKER - (4D Report)
// ID[FA1AC624FC504898B4D7D3EF0766501C]
// Created #9-9-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Declarations

var $left; $top; $right; $bottom; $browseLeft; $browseRight : Integer
var $long : Integer

var $e : Object
var $widget : Object
var $widget_pointer : Pointer
var $widget_name : Text



// ----------------------------------------------------
// Initialisations

$e:=FORM Event:C1606

$widget_name:=OBJECT Get name:C1087(Object current:K67:2)

$widget_pointer:=OBJECT Get pointer:C1124(Object named:K67:5; "ob_widget")

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($e.code=On Load:K2:1)
		
		If (Length:C16($widget_pointer->)=0)
			
			//default values
			$widget_pointer->:=JSON Stringify:C1217(path_picker_INIT)
			
		End if 
		
		SET TIMER:C645(-1)
		
		//______________________________________________________
	: ($e.code=On Timer:K2:25)
		
		SET TIMER:C645(0)
		
		$widget:=JSON Parse:C1218($widget_pointer->)
		
		If (OB Get:C1224($widget; "browse"; Is boolean:K8:9))
			
			If (Not:C34(OBJECT Get visible:C1075(*; "browse")))
				
				OBJECT SET VISIBLE:C603(*; "browse"; True:C214)
				
				OBJECT GET COORDINATES:C663(*; "browse"; $browseLeft; $long; $browseRight; $long)
				$right:=$browseLeft-5
				
				OBJECT GET COORDINATES:C663(*; "accessPath"; $left; $top; $long; $bottom)
				OBJECT SET COORDINATES:C1248(*; "accessPath"; $left; $top; $right; $bottom)
				OBJECT GET COORDINATES:C663(*; "border"; $left; $top; $long; $bottom)
				OBJECT SET COORDINATES:C1248(*; "border"; $left; $top; $right; $bottom)
				
			End if 
			
		Else 
			
			If (OBJECT Get visible:C1075(*; "browse"))
				
				OBJECT SET VISIBLE:C603(*; "browse"; False:C215)
				
				OBJECT GET COORDINATES:C663(*; "browse"; $browseLeft; $long; $browseRight; $long)
				$right:=$browseRight
				
				OBJECT GET COORDINATES:C663(*; "accessPath"; $left; $top; $long; $bottom)
				OBJECT SET COORDINATES:C1248(*; "accessPath"; $left; $top; $right; $bottom)
				OBJECT GET COORDINATES:C663(*; "border"; $left; $top; $long; $bottom)
				OBJECT SET COORDINATES:C1248(*; "border"; $left; $top; $right; $bottom)
				
			End if 
		End if 
		
		OBJECT SET PLACEHOLDER:C1295(*; "accessPath"; OB Get:C1224($widget; "placeHolder"; Is text:K8:3))
		
		//______________________________________________________
	: ($e.code=On Bound Variable Change:K2:52)
		
		$widget:=JSON Parse:C1218($widget_pointer->)
		
		OB SET:C1220($widget; \
			"accessPath"; (OBJECT Get pointer:C1124(Object subform container:K67:4))->)
		
		$widget_pointer->:=JSON Stringify:C1217($widget)
		
		path_picker_SET_LABEL($widget_pointer)
		
		SET TIMER:C645(-1)
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Form event activated unnecessary ("+String:C10($e.code)+")")
		
		//______________________________________________________
End case 