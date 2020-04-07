  // ----------------------------------------------------
  // Form method : HDI_PATH_PICKER
  // ID[6422098872994C57B8AC9F8BBA079A42]
  // Created #9-9-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_formEvent)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388

  // ----------------------------------------------------

Case of 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Load:K2:1)
		
		GOTO OBJECT:C206(*;"")
		
		SET TIMER:C645(-1)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Unload:K2:2)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Timer:K2:25)
		
		SET TIMER:C645(0)
		
		  //options
		(OBJECT Get pointer:C1124(Object named:K67:5;"browse"))->:=Num:C11(PathPicker Get option ("widget_path";1))
		(OBJECT Get pointer:C1124(Object named:K67:5;"showOnDisk"))->:=Num:C11(PathPicker Get option ("widget_path";2))
		(OBJECT Get pointer:C1124(Object named:K67:5;"copyPath"))->:=Num:C11(PathPicker Get option ("widget_path";3))
		(OBJECT Get pointer:C1124(Object named:K67:5;"openItem"))->:=Num:C11(PathPicker Get option ("widget_path";4))
		(OBJECT Get pointer:C1124(Object named:K67:5;"type"))->:=1+PathPicker Get type ("widget_path")
		(OBJECT Get pointer:C1124(Object named:K67:5;"message"))->:=PathPicker Get message ("widget_path")
		(OBJECT Get pointer:C1124(Object named:K67:5;"placeholder"))->:=PathPicker Get placeholder ("widget_path")
		
		  //path
		(OBJECT Get pointer:C1124(Object named:K67:5;"path"))->:=(OBJECT Get pointer:C1124(Object named:K67:5;"widget_path"))->
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 