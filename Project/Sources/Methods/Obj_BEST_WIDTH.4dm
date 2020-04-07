//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : Obj_BEST_WIDTH
  // Database: runtime
  // ID[754FE76DAA6A49F293FAF5AA869135F4]
  // Created #26-11-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  // Sets the width of object(s) according to localisation
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($1)
C_TEXT:C284($2)
C_TEXT:C284(${3})

C_LONGINT:C283($Lon_alignment;$Lon_bottom;$Lon_height;$Lon_i;$Lon_left;$Lon_parameters)
C_LONGINT:C283($Lon_right;$Lon_top;$Lon_width)
C_TEXT:C284($Txt_objectName)

If (False:C215)
	C_LONGINT:C283(Obj_BEST_WIDTH ;$1)
	C_TEXT:C284(Obj_BEST_WIDTH ;$2)
	C_TEXT:C284(Obj_BEST_WIDTH ;${3})
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=2;"Missing parameter"))
	
	  //Required parameters
	$Lon_alignment:=$1
	$Txt_objectName:=$2  // Object name
	
	  //Optional parameters
	If ($Lon_parameters>=2)
		
		  // <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
For ($Lon_i;2;$Lon_parameters;1)
	
	$Txt_objectName:=${$Lon_i}
	
	OBJECT GET BEST SIZE:C717(*;$Txt_objectName;$Lon_width;$Lon_height)
	
	$Lon_width:=$Lon_width*1.2  //10% more
	
	  // #10-12-2018
	If ($Lon_width<80)
		
		$Lon_width:=80
		
	End if 
	
	OBJECT GET COORDINATES:C663(*;$Txt_objectName;$Lon_left;$Lon_top;$Lon_right;$Lon_bottom)
	
	Case of 
			
			  //______________________________________________________
		: ($Lon_alignment=Align left:K42:2)
			
			$Lon_right:=$Lon_left+$Lon_width
			
			  //______________________________________________________
		: ($Lon_alignment=Align right:K42:4)
			
			$Lon_left:=$Lon_right-$Lon_width
			
			  //______________________________________________________
		: ($Lon_alignment=Align center:K42:3)
			
			$Lon_left:=$Lon_left+((($Lon_right-$Lon_left)-$Lon_width)\2)
			$Lon_right:=$Lon_left+$Lon_width
			
			  //______________________________________________________
		Else 
			
			ASSERT:C1129(False:C215;"Unknown entry point: \""+String:C10($Lon_alignment)+"\"")
			
			  //______________________________________________________
	End case 
	
	OBJECT SET COORDINATES:C1248(*;$Txt_objectName;$Lon_left;$Lon_top;$Lon_right;$Lon_bottom)
	
End for 

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End