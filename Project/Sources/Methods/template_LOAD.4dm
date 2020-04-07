//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : template_LOAD
  // Database: 4D Report
  // ID[735163575C524C28908B908F335C5193]
  // Created #12-10-2016 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($1)

C_LONGINT:C283($Lon_current;$Lon_i;$Lon_parameters;$Lst_templates)
C_TEXT:C284($File_template;$Txt_buffer;$Txt_type)
C_OBJECT:C1216($Obj_buffer)

If (False:C215)
	C_TEXT:C284(template_LOAD ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	  //Required parameters
	$Txt_type:=$1  //"list" | "cross"
	
	  //Optional parameters
	If ($Lon_parameters>=2)
		
		  // <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
$Lst_templates:=(OBJECT Get pointer:C1124(Object named:K67:5;"list"))->

If (Is a list:C621($Lst_templates))
	
	$Lon_current:=Selected list items:C379(*;"list")
	CLEAR LIST:C377($Lst_templates)
	
End if 

$Lst_templates:=New list:C375

  //get the user templates if exists
$File_template:=Get 4D folder:C485(Current resources folder:K5:16;*)+"reports"+Folder separator:K24:12+"templates.json"

If (Test path name:C476($File_template)#Is a document:K24:1)
	
	  //get component's templates
	$File_template:=Get 4D folder:C485(Current resources folder:K5:16)+"templates.json"
	
End if 

If (Test path name:C476($File_template)=Is a document:K24:1)
	
	  //load templates
	$Obj_buffer:=JSON Parse:C1218(Document to text:C1236($File_template))
	
	If (OB Is defined:C1231($Obj_buffer;$Txt_type))
		
		ARRAY OBJECT:C1221($tObj_templates;0x0000)
		OB GET ARRAY:C1229($Obj_buffer;$Txt_type;$tObj_templates)
		
		For ($Lon_i;1;Size of array:C274($tObj_templates);1)
			
			$Txt_buffer:=OB Get:C1224($tObj_templates{$Lon_i};"name";Is text:K8:3)
			
			APPEND TO LIST:C376($Lst_templates;$Txt_buffer;$Lon_i)
			SET LIST ITEM PARAMETER:C986($Lst_templates;0;"template";JSON Stringify:C1217($tObj_templates{$Lon_i}))
			
		End for 
	End if 
End if 

(OBJECT Get pointer:C1124(Object named:K67:5;"list"))->:=$Lst_templates
SELECT LIST ITEMS BY POSITION:C381(*;"list";Choose:C955($Lon_current=0;1;$Lon_current))

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End