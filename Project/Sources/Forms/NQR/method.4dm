// ----------------------------------------------------
// Form method : QR
// ID[02F11CFEFC5849D1BE760AC1E5CD509B]
// Created #13-3-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Declarations

var $auto_many; $auto_one : Boolean

var $e : Object

var $timer_pointer : Pointer
var $area; $timer_value : Integer


// ----------------------------------------------------
// Initialisations
$e:=FORM Event:C1606

$timer_pointer:=OBJECT Get pointer:C1124(Object named:K67:5; "timerEvent")

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($e.code=On Load:K2:1)
		
		COMPILER_NQR
		
		ob_area.window:=Current form window:C827
		
		//*******************************************************
		//UNAVALAIBLE FEATURES
		OBJECT SET VISIBLE:C603(*; "toolbar.opened.sep.4"; <>Boo_debug)
		
		//*******************************************************
		
		//*******************************************************
		//DEBUG OBJECTS
		If (Structure file:C489=Structure file:C489(*))
			
			C_QR_MASTERTABLE:=1
			//ALL RECORDS([Society]) 
			
		End if 
		
		//*******************************************************
		
		NQR_TOOLBAR("init")
		
		If ((OBJECT Get pointer:C1124(Object named:K67:5; "inited"))->=0)
			
			NQR_TOOLBAR("open")
			
			(OBJECT Get pointer:C1124(Object named:K67:5; "inited"))->:=1
			
		End if 
		
		OBJECT SET RGB COLORS:C628(*; "plus.line"; Highlight text background color:K23:5; Background color none:K23:10)
		
		OB SET:C1220(ob_area; "message"; False:C215)
		
		If (4D_MainProcess)  //Direct use
			
			//keep relation's status
			GET AUTOMATIC RELATIONS:C899($auto_one; $auto_many)
			
			OB SET:C1220(ob_area; "one"; $auto_one; "many"; $auto_many)
			
			//changes all into automatic relations
			SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
			
		End if 
		
		$timer_pointer->:=-1  //init
		SET TIMER:C645(-1)
		
		//If (<>withFeature102041)
		
		// do not modify .doAction C++ is using it for launching QR ON COMMAND
		Form:C1466.doAction:=Formula:C1597(NQR_doAction($1))
		
		//End if 
		
		//______________________________________________________
	: ($e.code=On Timer:K2:25)
		
		SET TIMER:C645(0)
		
		$timer_value:=$timer_pointer->
		$timer_pointer->:=0
		
		Case of 
				
				//………………………………………………………………………………
			: ($timer_value=-1)  //init
				
				If (QR_area=0)
					
					//#ACI0093088
					//the area was inited by the subform
					$area:=OB Get:C1224(ob_area; "area"; Is longint:K8:6)
					
					If ($area#0)
						
						QR_area:=$area
						
					Else 
						
						QR NEW AREA:C1320(->QR_area)
						
					End if 
				End if 
				
				Form:C1466.original_report_data:=4D:C1709.Blob.new(C_QR_INITBLOB)
				
				//load the last report for the master table if any
				If (BLOB size:C605(C_QR_INITBLOB)>0)
					
					QR BLOB TO REPORT:C771(QR_area; C_QR_INITBLOB)
					
					//update UI
					EXECUTE METHOD IN SUBFORM:C1085("myQR"; "report_DISPLAY_AREA"; *; QR_area)
					
				End if 
				
				//set the master table
				If (C_QR_MASTERTABLE#0)
					
					QR SET REPORT TABLE:C757(QR_area; C_QR_MASTERTABLE)
					
				End if 
				
				//update the hash
				//NQR_DIGEST
				
				//update UI
				NQR_STATUS_BAR("update")
				NQR_TOOLBAR("update")
				
				//………………………………………………………………………………
		End case 
		
		If ($timer_pointer->#0)
			
			SET TIMER:C645(-1)
			
		End if 
		
		//______________________________________________________
	: ($e.code=On Close Box:K2:21)
		
		NQR_CLOSE
		
		//______________________________________________________
	: ($e.code=On Unload:K2:2)
		
		QR REPORT TO BLOB:C770(QR_area; C_QR_INITBLOB)
		QR DELETE OFFSCREEN AREA:C754(QR_area)
		
		If (4D_MainProcess)  //Direct use
			
			//restore relations' status
			$auto_one:=OB Get:C1224(ob_area; "one"; Is boolean:K8:9)
			$auto_many:=OB Get:C1224(ob_area; "many"; Is boolean:K8:9)
			
			SET AUTOMATIC RELATIONS:C310($auto_one; $auto_many)
			
		End if 
		
		CLEAR VARIABLE:C89(ob_area)
		CLEAR VARIABLE:C89(ob_dialog)
		
		//______________________________________________________
	: ($e.code=On Resize:K2:27)
		
		SET TIMER:C645(0)
		
		//generate, if any, a resize event in the subforms
		(OBJECT Get pointer:C1124(Object named:K67:5; "tool.headerAndFooter"))->:=On Resize:K2:27
		
		OBJECT SET VISIBLE:C603(*; "plus@"; False:C215)
		
		EXECUTE METHOD IN SUBFORM:C1085("myQR"; "area_ADJUST")
		
		//keep widgets centered, if any
		Case of 
				
				//______________________________________________________
			: (OBJECT Get visible:C1075(*; "tool.templates"))
				
				EXECUTE METHOD IN SUBFORM:C1085("tool.templates"; "template_DRAW")
				
				//______________________________________________________
			: (OBJECT Get visible:C1075(*; "alert.box"))
				
				Obj_CENTER("alert.box"; "alert.mask"; Horizontally centered:K39:1)
				
				//______________________________________________________
			: (OBJECT Get visible:C1075(*; "settings.dial"))
				
				Obj_CENTER("settings.dial"; "settings.mask"; Horizontally centered:K39:1)
				
				//______________________________________________________
		End case 
		
		//adjust geometry of the setting subform
		EXECUTE METHOD IN SUBFORM:C1085("settings.dial"; "NQR_SETTING_GEOMETRY")
		
		REDRAW WINDOW:C456(Current form window:C827)
		
		If ($timer_pointer->#0)
			
			SET TIMER:C645(-1)
			
		End if 
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Form event activated unnecessary ("+String:C10($e.code)+")")
		
		//______________________________________________________
End case 