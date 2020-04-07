//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : list_ITEM_COPY_METADATA
  // Database: 4D Report
  // ID[4ED93A04726540C9AAA2A6D95799E9C0]
  // Created #9-12-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)
C_LONGINT:C283($4)

C_BOOLEAN:C305($Boo_sourceItemReference)
C_LONGINT:C283($Lon_i;$Lon_parameters;$Lon_sourceReference;$Lon_targetReference;$Lst_sourceList;$Lst_targetList)
C_PICTURE:C286($Pic_buffer)

ARRAY TEXT:C222($tTxt_keys;0)
ARRAY TEXT:C222($tTxt_values;0)

If (False:C215)
	C_LONGINT:C283(list_ITEM_COPY_METADATA ;$1)
	C_LONGINT:C283(list_ITEM_COPY_METADATA ;$2)
	C_LONGINT:C283(list_ITEM_COPY_METADATA ;$3)
	C_LONGINT:C283(list_ITEM_COPY_METADATA ;$4)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=2;"Missing parameter"))
	
	  //Required parameters
	$Lst_sourceList:=$1
	$Lst_targetList:=$2
	
	  //Optional parameters
	If ($Lon_parameters>=3)
		
		$Boo_sourceItemReference:=True:C214
		$Lon_sourceReference:=$3
		
		If ($Lon_parameters>=4)
			
			$Lon_targetReference:=$4
			
		End if 
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------

If ($Boo_sourceItemReference)
	
	GET LIST ITEM ICON:C951($Lst_sourceList;$Lon_sourceReference;$Pic_buffer)
	GET LIST ITEM PARAMETER ARRAYS:C1195($Lst_sourceList;$Lon_sourceReference;$tTxt_keys;$tTxt_values)
	
Else 
	
	GET LIST ITEM ICON:C951($Lst_sourceList;*;$Pic_buffer)
	GET LIST ITEM PARAMETER ARRAYS:C1195($Lst_sourceList;*;$tTxt_keys;$tTxt_values)
	
End if 

SET LIST ITEM ICON:C950($Lst_targetList;$Lon_targetReference;$Pic_buffer)

For ($Lon_i;1;Size of array:C274($tTxt_keys);1)
	
	SET LIST ITEM PARAMETER:C986($Lst_targetList;$Lon_targetReference;$tTxt_keys{$Lon_i};$tTxt_values{$Lon_i})
	
End for 

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End