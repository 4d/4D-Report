//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : QR_isValidField
  // Database: 4D Report
  // ID[1F3C7ACBA19D43B1B13C41010BC49DC5]
  // Created #5-6-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  // Tests if a field could be a candidate for a report
  // Returns true if this is the case
  // ----------------------------------------------------
  // Declarations
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)

C_BOOLEAN:C305($Boo_;$Boo_invisible;$Boo_OK)
C_LONGINT:C283($Lon_;$Lon_field;$Lon_fieldNum;$Lon_parameters;$Lon_table;$Lon_tableNum)
C_LONGINT:C283($Lon_type)

If (False:C215)
	C_BOOLEAN:C305(QR_isValidField ;$0)
	C_LONGINT:C283(QR_isValidField ;$1)
	C_LONGINT:C283(QR_isValidField ;$2)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=2;"Missing parameter"))
	
	  //Required parameters
	$Lon_tableNum:=$1
	$Lon_fieldNum:=$2
	
	  //Optional parameters
	If ($Lon_parameters>=3)
		
		  //<NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
  //First, test the virtual structure
$Lon_table:=Find in array:C230(tLon_tableIDs;$Lon_tableNum)

If ($Lon_table>0)
	
	$Lon_field:=Find in array:C230(tLon_fieldIDs{$Lon_table};$Lon_fieldNum)
	
	If ($Lon_field>0)
		
		  //ACI0099768 : we don't want the deleted fields here
		If (Is field number valid:C1000($Lon_tableNum;$Lon_fieldNum))
			
			  //Then, test the type & visibility
			GET FIELD PROPERTIES:C258($Lon_tableNum;$Lon_fieldNum;$Lon_type;$Lon_;$Boo_;$Boo_;$Boo_invisible)
			
			If (Not:C34($Boo_invisible))
				
				  //#redmine:14948
				  //The user shall be restricted from using an object field.
				If ($Lon_type#Is BLOB:K8:12)\
					 & ($Lon_type#Is subtable:K8:11)\
					 & ($Lon_type#Is object:K8:27)
					
					$Boo_OK:=True:C214
					
				End if 
			End if 
		End if 
	End if 
End if 

  // ----------------------------------------------------
  // Return
$0:=$Boo_OK  //true if field is candidate for QR

  // ----------------------------------------------------
  // End