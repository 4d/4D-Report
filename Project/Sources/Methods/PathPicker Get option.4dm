//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : PathPicker Get option
  // ID[C135460FA6414D3AA834ECC6E198CB5F]
  // Created #26-11-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_BOOLEAN:C305($0)
C_TEXT:C284($1)
C_LONGINT:C283($2)

C_BOOLEAN:C305($Boo_enabled)
C_LONGINT:C283($Lon_option;$Lon_parameters)
C_TEXT:C284($Txt_widget)
C_OBJECT:C1216($Obj_widget)

If (False:C215)
	C_BOOLEAN:C305(PathPicker Get option ;$0)
	C_TEXT:C284(PathPicker Get option ;$1)
	C_LONGINT:C283(PathPicker Get option ;$2)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=2;"Missing parameter"))
	
	  //Required parameters
	$Txt_widget:=$1  //Name of the widget object
	$Lon_option:=$2  // 1 = browse button | 2 = show on disk | 3 = copy path | 4 = open item
	
	  //Optional parameters
	If ($Lon_parameters>=3)
		
		  // <NONE>
		
	End if 
	
	path_picker_Get_object ($Txt_widget;->$Obj_widget)
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
If ($Lon_option>0)
	
	ARRAY TEXT:C222($tTxt_tags;4)
	$tTxt_tags{1}:="browse"
	$tTxt_tags{2}:="showOnDisk"
	$tTxt_tags{3}:="copyPath"
	$tTxt_tags{4}:="openItem"
	
	If (OB Is defined:C1231($Obj_widget))
		
		$Boo_enabled:=OB Get:C1224($Obj_widget;$tTxt_tags{$Lon_option};Is boolean:K8:9)
		
	End if 
End if 

  // ----------------------------------------------------
  // Return
$0:=$Boo_enabled

  // ----------------------------------------------------
  // End