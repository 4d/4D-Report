//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : ALIGN_OBJECTS
  // Database: 4D Report
  // ID[2E27581B02674D8D953798785A3FE47D]
  // Created #13-6-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_OBJECT:C1216($1)

C_BOOLEAN:C305($Boo_visible)
C_LONGINT:C283($kLon_buttonMinWidth;$kLon_hOffset;$Lon_alignment;$Lon_bottom;$Lon_height;$Lon_hOffset)
C_LONGINT:C283($Lon_i;$Lon_left;$Lon_parameters;$Lon_positionLeft;$Lon_positionRight;$Lon_right)
C_LONGINT:C283($Lon_top;$Lon_width)
C_TEXT:C284($Txt_object;$Txt_type)
C_OBJECT:C1216($Obj_param)

ARRAY OBJECT:C1221($tObj_objects;0)

If (False:C215)
	C_OBJECT:C1216(ALIGN_OBJECTS ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	  //Required parameters
	$Obj_param:=$1
	
	  //Optional parameters
	If ($Lon_parameters>=2)
		
		  //<NONE>
		
	End if 
	
	OB GET ARRAY:C1229($Obj_param;"toolbar";$tObj_objects)
	
	$Lon_positionRight:=OB Get:C1224($Obj_param;"width";Is longint:K8:6)
	
	$kLon_hOffset:=8
	$kLon_buttonMinWidth:=45
	$Lon_positionLeft:=$kLon_hOffset
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
For ($Lon_i;1;Size of array:C274($tObj_objects);1)
	
	$Txt_object:=OB Get:C1224($tObj_objects{$Lon_i};"object";Is text:K8:3)
	$Txt_type:=OB Get:C1224($tObj_objects{$Lon_i};"type";Is text:K8:3)
	$Boo_visible:=OB Get:C1224($tObj_objects{$Lon_i};"visible";Is boolean:K8:9)
	$Lon_alignment:=OB Get:C1224($tObj_objects{$Lon_i};"align";Is longint:K8:6)
	
	$Lon_hOffset:=OB Get:C1224($tObj_objects{$Lon_i};"offset";Is longint:K8:6)
	
	If ($Boo_visible)
		
		If (Length:C16($Txt_object)>0)
			
			OBJECT GET COORDINATES:C663(*;$Txt_object;$Lon_left;$Lon_top;$Lon_right;$Lon_bottom)
			
		End if 
		
		Case of 
				
				  //______________________________________________________
			: ($Txt_type="button")
				
				OBJECT GET BEST SIZE:C717(*;$Txt_object;$Lon_width;$Lon_height)
				$Lon_width:=Choose:C955($Lon_width<$kLon_buttonMinWidth;$kLon_buttonMinWidth;$Lon_width*1.2)+$Lon_hOffset
				
				If ($Lon_alignment=On the right:K39:3)
					
					$Lon_positionRight:=$Lon_positionRight-$kLon_hOffset
					OBJECT SET COORDINATES:C1248(*;$Txt_object;$Lon_positionRight-$Lon_width;$Lon_top;$Lon_positionRight;$Lon_bottom)
					
				Else 
					
					$Lon_positionLeft:=$Lon_positionLeft+$kLon_hOffset
					OBJECT SET COORDINATES:C1248(*;$Txt_object;$Lon_positionLeft;$Lon_top;$Lon_positionLeft+$Lon_width;$Lon_bottom)
					
				End if 
				
				  //______________________________________________________
			: ($Txt_type="separator")
				
				$Lon_width:=$Lon_right-$Lon_left
				
				If ($Lon_alignment=On the right:K39:3)
					
					$Lon_positionRight:=$Lon_positionRight-$kLon_hOffset
					OBJECT SET COORDINATES:C1248(*;$Txt_object;$Lon_positionRight;$Lon_top)
					
				Else 
					
					$Lon_positionLeft:=$Lon_positionLeft+$kLon_hOffset
					OBJECT SET COORDINATES:C1248(*;$Txt_object;$Lon_positionLeft;$Lon_top)
					
				End if 
				
				  //______________________________________________________
			: ($Txt_type="widget")
				
				$Lon_width:=$Lon_right-$Lon_left
				
				If ($Lon_alignment=On the right:K39:3)
					
					$Lon_positionRight:=$Lon_positionRight-$kLon_hOffset
					OBJECT SET COORDINATES:C1248(*;$Txt_object;$Lon_positionRight-$Lon_width;$Lon_top;$Lon_positionRight;$Lon_bottom)
					
				Else 
					
					$Lon_positionLeft:=$Lon_positionLeft+$kLon_hOffset
					OBJECT SET COORDINATES:C1248(*;$Txt_object;$Lon_positionLeft;$Lon_top;$Lon_positionLeft+$Lon_width;$Lon_bottom)
					
				End if 
				
				  //______________________________________________________
			Else 
				
				  //
				
				  //______________________________________________________
		End case 
		
		If ($Lon_alignment=On the right:K39:3)
			
			$Lon_positionRight:=$Lon_positionRight-$Lon_width
			
		Else 
			
			$Lon_positionLeft:=$Lon_positionLeft+$Lon_width
			
		End if 
		
	Else 
		
		  //put offscreen
		OBJECT SET COORDINATES:C1248(*;$Txt_object;-1000;-1000;-1000;-1000)
		
	End if 
End for 

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End