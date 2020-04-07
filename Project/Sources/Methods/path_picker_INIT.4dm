//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : path_picker_INIT
  // ID[9639159F9EBF4D44976176215E23838B]
  // Created #10-9-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_OBJECT:C1216($0)

C_LONGINT:C283($Lon_parameters)
C_OBJECT:C1216($Obj_widget)

If (False:C215)
	C_OBJECT:C1216(path_picker_INIT ;$0)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
	  //Optional parameters
	If ($Lon_parameters>=1)
		
		  // <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
OB SET:C1220($Obj_widget;\
"accessPath";"";\
"browse";True:C214;\
"showOnDisk";True:C214;\
"copyPath";True:C214;\
"openItem";True:C214;\
"type";Is a document:K24:1;\
"options";Package selection:K24:9+Use sheet window:K24:11;\
"directory";"8858";\
"fileTypes";"";\
"message";"";\
"placeHolder";"";\
"_lastPath";"")

  // ----------------------------------------------------
  // Return
$0:=$Obj_widget

  // ----------------------------------------------------
  // End