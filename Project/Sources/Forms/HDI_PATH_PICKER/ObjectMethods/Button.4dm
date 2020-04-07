C_TEXT:C284($Txt_fileName)

$Txt_fileName:=Select document:C905("";"";"";0)

If (OK=1)
	
	  //set the path
	(OBJECT Get pointer:C1124(Object named:K67:5;"widget_path"))->:=DOCUMENT
	
	  //set the type, message & placeholder
	PathPicker SET TYPE ("widget_path";Is a document:K24:1)
	pathPicker SET MESSAGE ("widget_path";"Select file:")
	PathPicker SET PLACEHOLDER ("widget_path";"Please select a file")
	
	  //update UI
	SET TIMER:C645(-1)
	
End if 