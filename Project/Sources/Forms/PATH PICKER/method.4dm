  // ----------------------------------------------------
  // Form method : PATH PICKER - (4D Report)
  // ID[FA1AC624FC504898B4D7D3EF0766501C]
  // Created #9-9-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_;$Lon_bottom;$Lon_browseLeft;$Lon_browseRight;$Lon_formEvent;$Lon_left)
C_LONGINT:C283($Lon_right;$Lon_top)
C_POINTER:C301($Ptr_widget)
C_TEXT:C284($Txt_me)
C_OBJECT:C1216($Obj_widget)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388
$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)

$Ptr_widget:=OBJECT Get pointer:C1124(Object named:K67:5;"ob_widget")

  // ----------------------------------------------------
Case of 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Load:K2:1)
		
		If (Length:C16($Ptr_widget->)=0)
			
			  //default values
			$Ptr_widget->:=JSON Stringify:C1217(path_picker_INIT )
			
		End if 
		
		SET TIMER:C645(-1)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Timer:K2:25)
		
		SET TIMER:C645(0)
		
		$Obj_widget:=JSON Parse:C1218($Ptr_widget->)
		
		If (OB Get:C1224($Obj_widget;"browse";Is boolean:K8:9))
			
			If (Not:C34(OBJECT Get visible:C1075(*;"browse")))
				
				OBJECT SET VISIBLE:C603(*;"browse";True:C214)
				
				OBJECT GET COORDINATES:C663(*;"browse";$Lon_browseLeft;$Lon_;$Lon_browseRight;$Lon_)
				$Lon_right:=$Lon_browseLeft-5
				
				OBJECT GET COORDINATES:C663(*;"accessPath";$Lon_left;$Lon_top;$Lon_;$Lon_bottom)
				OBJECT SET COORDINATES:C1248(*;"accessPath";$Lon_left;$Lon_top;$Lon_right;$Lon_bottom)
				OBJECT GET COORDINATES:C663(*;"border";$Lon_left;$Lon_top;$Lon_;$Lon_bottom)
				OBJECT SET COORDINATES:C1248(*;"border";$Lon_left;$Lon_top;$Lon_right;$Lon_bottom)
				
			End if 
			
		Else 
			
			If (OBJECT Get visible:C1075(*;"browse"))
				
				OBJECT SET VISIBLE:C603(*;"browse";False:C215)
				
				OBJECT GET COORDINATES:C663(*;"browse";$Lon_browseLeft;$Lon_;$Lon_browseRight;$Lon_)
				$Lon_right:=$Lon_browseRight
				
				OBJECT GET COORDINATES:C663(*;"accessPath";$Lon_left;$Lon_top;$Lon_;$Lon_bottom)
				OBJECT SET COORDINATES:C1248(*;"accessPath";$Lon_left;$Lon_top;$Lon_right;$Lon_bottom)
				OBJECT GET COORDINATES:C663(*;"border";$Lon_left;$Lon_top;$Lon_;$Lon_bottom)
				OBJECT SET COORDINATES:C1248(*;"border";$Lon_left;$Lon_top;$Lon_right;$Lon_bottom)
				
			End if 
		End if 
		
		OBJECT SET PLACEHOLDER:C1295(*;"accessPath";OB Get:C1224($Obj_widget;"placeHolder";Is text:K8:3))
		
		  //______________________________________________________
	: ($Lon_formEvent=On Bound Variable Change:K2:52)
		
		$Obj_widget:=JSON Parse:C1218($Ptr_widget->)
		
		OB SET:C1220($Obj_widget;\
			"accessPath";(OBJECT Get pointer:C1124(Object subform container:K67:4))->)
		
		$Ptr_widget->:=JSON Stringify:C1217($Obj_widget)
		
		path_picker_SET_LABEL ($Ptr_widget)
		
		SET TIMER:C645(-1)
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 