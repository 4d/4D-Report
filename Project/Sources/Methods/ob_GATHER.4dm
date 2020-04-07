//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : ob_GATHER
  // Database: 4D Report
  // ID[D03215F8B2E9499B84B35AC982248205]
  // Created #6-10-2016 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_OBJECT:C1216($1)
C_OBJECT:C1216($2)

C_LONGINT:C283($Lon_i;$Lon_parameters)
C_OBJECT:C1216($Obj_master;$Obj_slave)

ARRAY LONGINT:C221($tLon_types;0)
ARRAY TEXT:C222($tTxt_buffer;0)
ARRAY TEXT:C222($tTxt_properties;0)
ARRAY OBJECT:C1221($tObj_buffer;0)

If (False:C215)
	C_OBJECT:C1216(ob_GATHER ;$1)
	C_OBJECT:C1216(ob_GATHER ;$2)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=2;"Missing parameter"))
	
	  //Required parameters
	$Obj_master:=$1
	$Obj_slave:=$2
	
	  //Optional parameters
	If ($Lon_parameters>=3)
		
		  // <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
OB GET PROPERTY NAMES:C1232($Obj_slave;$tTxt_properties;$tLon_types)

For ($Lon_i;1;Size of array:C274($tTxt_properties);1)
	
	If (Not:C34(OB Is defined:C1231($Obj_master;$tTxt_properties{$Lon_i})))
		
		If ($tLon_types{$Lon_i}=Object array:K8:28)
			
			OB GET ARRAY:C1229($Obj_slave;$tTxt_properties{$Lon_i};$tObj_buffer)
			
			If (OB Is defined:C1231($tObj_buffer{1}))
				
				OB SET ARRAY:C1227($Obj_master;$tTxt_properties{$Lon_i};$tObj_buffer)
				
			Else 
				
				  //#TO_DO: Manage all array types
				OB GET ARRAY:C1229($Obj_slave;$tTxt_properties{$Lon_i};$tTxt_buffer)
				OB SET ARRAY:C1227($Obj_master;$tTxt_properties{$Lon_i};$tTxt_buffer)
				
			End if 
			
		Else 
			
			OB SET:C1220($Obj_master;\
				$tTxt_properties{$Lon_i};OB Get:C1224($Obj_slave;$tTxt_properties{$Lon_i};$tLon_types{$Lon_i}))
			
		End if 
	End if 
End for 

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End