//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : PathPicker SET OPTIONS
  // ID[E06B5F5E36284EB28516C73B5C393676]
  // Created #26-11-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($1)
C_BOOLEAN:C305($2)
C_LONGINT:C283($3)
C_LONGINT:C283(${4})

C_BOOLEAN:C305($Boo_enabled)
C_LONGINT:C283($kLon_optionNumber;$Lon_i;$Lon_option;$Lon_parameters)
C_POINTER:C301($Ptr_widget)
C_TEXT:C284($Txt_widget)
C_OBJECT:C1216($Obj_widget)

If (False:C215)
	C_TEXT:C284(PathPicker SET OPTIONS ;$1)
	C_BOOLEAN:C305(PathPicker SET OPTIONS ;$2)
	C_LONGINT:C283(PathPicker SET OPTIONS ;$3)
	C_LONGINT:C283(PathPicker SET OPTIONS ;${4})
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	  //Required parameters
	$Txt_widget:=$1  //Name of the widget object
	
	  //Optional parameters
	If ($Lon_parameters>=2)
		
		$Boo_enabled:=$2
		
		If ($Lon_parameters>=3)
			
			$Lon_option:=$3  // 1 = browse button | 2 = show on disk | 3 = copy path | 4 = open item | 0 = all
			
		End if 
	End if 
	
	$Ptr_widget:=path_picker_Get_object ($Txt_widget;->$Obj_widget)
	
	$kLon_optionNumber:=4
	
	ARRAY TEXT:C222($ktTxt_tags;$kLon_optionNumber)
	$ktTxt_tags{1}:="browse"
	$ktTxt_tags{2}:="showOnDisk"
	$ktTxt_tags{3}:="copyPath"
	$ktTxt_tags{4}:="openItem"
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
Case of 
		
		  //______________________________________________________
	: ($Lon_option=0)
		
		For ($Lon_i;1;Size of array:C274($ktTxt_tags);1)
			
			OB SET:C1220($Obj_widget;\
				$ktTxt_tags{$Lon_i};$Boo_enabled)
			
		End for 
		
		$Ptr_widget->:=JSON Stringify:C1217($Obj_widget)
		
		  //______________________________________________________
	Else 
		
		For ($Lon_i;3;$Lon_parameters;1)
			
			$Lon_option:=${$Lon_i}
			
			If ($Lon_option<=$kLon_optionNumber)
				
				OB SET:C1220($Obj_widget;\
					$ktTxt_tags{$Lon_option};$Boo_enabled)
				
			End if 
		End for 
		
		$Ptr_widget->:=JSON Stringify:C1217($Obj_widget)
		
		  //______________________________________________________
End case 

  //update UI
EXECUTE METHOD IN SUBFORM:C1085($Txt_widget;"path_picker_UPDATE_UI")

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End