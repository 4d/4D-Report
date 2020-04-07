C_TEXT:C284($Txt_path)

$Txt_path:=Select folder:C670("";"";0)

If (OK=1)
	
	  //set the path
	(OBJECT Get pointer:C1124(Object named:K67:5;"widget_path"))->:=$Txt_path
	
	  //set the type, message & placeholder
	PathPicker SET TYPE ("widget_path";Is a folder:K24:2)
	pathPicker SET MESSAGE ("widget_path";"Select folder:")
	PathPicker SET PLACEHOLDER ("widget_path";"Please select a folder")
	
	  //update UI
	SET TIMER:C645(-1)
	
End if 