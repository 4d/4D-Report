//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : template_Get_style
  // Database: 4D Report
  // ID[75D5075E3E66470A915EE51461D6CC47]
  // Created #5-10-2016 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($0)
C_OBJECT:C1216($1)
C_TEXT:C284($2)
C_LONGINT:C283($3)
C_LONGINT:C283($4)

C_LONGINT:C283($Lon_column;$Lon_count;$Lon_i;$Lon_Line;$Lon_parameters)
C_TEXT:C284($Txt_buffer;$Txt_key;$Txt_style;$Txt_what)
C_OBJECT:C1216($Obj_buffer)

ARRAY TEXT:C222($tTxt_buffer;0)

If (False:C215)
	C_TEXT:C284(template_Get_style ;$0)
	C_OBJECT:C1216(template_Get_style ;$1)
	C_TEXT:C284(template_Get_style ;$2)
	C_LONGINT:C283(template_Get_style ;$3)
	C_LONGINT:C283(template_Get_style ;$4)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=2;"Missing parameter"))
	
	  //Required parameters
	$Obj_buffer:=$1
	$Txt_what:=$2
	
	$Lon_column:=1
	$Lon_Line:=1
	
	  //Optional parameters
	If ($Lon_parameters>=3)
		
		$Lon_column:=$3
		
		If ($Lon_parameters>=4)
			
			$Lon_Line:=$4
			
		End if 
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
$Txt_style:="{"

Case of 
		
		  //______________________________________________________
	: ($Txt_what="text")
		
		  //font name {
		OB GET ARRAY:C1229($Obj_buffer;"font";$tTxt_buffer)
		
		$Lon_count:=Size of array:C274($tTxt_buffer)
		
		If ($Lon_count>0)
			
			$Txt_style:=$Txt_style+"font-family: "
			
			For ($Lon_i;1;Size of array:C274($tTxt_buffer);1)
				
				If ($tTxt_buffer{$Lon_i}="serif")\
					 | ($tTxt_buffer{$Lon_i}="sans-serif")\
					 | ($tTxt_buffer{$Lon_i}="cursive")\
					 | ($tTxt_buffer{$Lon_i}="fantasy")\
					 | ($tTxt_buffer{$Lon_i}="monospace")
					
					$Txt_style:=$Txt_style+$tTxt_buffer{$Lon_i}
					
				Else 
					
					$Txt_style:=$Txt_style+"'"+$tTxt_buffer{$Lon_i}+"'"
					
				End if 
				
				$Txt_style:=$Txt_style+(","*Num:C11($Lon_i<$Lon_count))
				
			End for 
			
			$Txt_style:=$Txt_style+";"
			
		Else 
			
			$Txt_buffer:=OB Get:C1224($Obj_buffer;"font";Is text:K8:3)
			
			If (Length:C16($Txt_buffer)>0)
				
				$Txt_style:=$Txt_style+"font-family: '"+$Txt_buffer+"';"
				
			End if 
		End if   //}
		
		  //font size {
		$Txt_buffer:=OB Get:C1224($Obj_buffer;"fontSize";Is text:K8:3)
		
		If (Length:C16($Txt_buffer)>0)
			
			$Txt_style:=$Txt_style+"font-size: "+$Txt_buffer+"pt;"
			
		End if   ///
		
		  //font color
		$Txt_buffer:=OB Get:C1224($Obj_buffer;"fontColor";Is text:K8:3)
		
		If (Length:C16($Txt_buffer)>0)
			
			$Txt_style:=$Txt_style+"fill: "+$Txt_buffer+";"
			
		End if 
		
		  //style {
		OB GET ARRAY:C1229($Obj_buffer;"fontSyle";$tTxt_buffer)
		
		If (Size of array:C274($tTxt_buffer)>0)
			
			If (Find in array:C230($tTxt_buffer;"bold")>0)
				
				$Txt_style:=$Txt_style+"font-weight: bold;"
				
			End if 
			
			If (Find in array:C230($tTxt_buffer;"italic")>0)
				
				$Txt_style:=$Txt_style+"font-style: italic;"
				
			End if 
			
			If (Find in array:C230($tTxt_buffer;"underline")>0)
				
				$Txt_style:=$Txt_style+"text-decoration: underline;"
				
			End if 
		End if   //}
		
		  //alignment {
		If (OB Is defined:C1231($Obj_buffer;"textAlignement"))
			
			If (OB Get type:C1230($Obj_buffer;"textAlignement")=Object array:K8:28)
				
				OB GET ARRAY:C1229($Obj_buffer;"textAlignement";$tTxt_buffer)
				
				If ($Lon_column<=Size of array:C274($tTxt_buffer))
					
					$Txt_buffer:=$tTxt_buffer{$Lon_column}
					
				End if 
				
			Else 
				
				$Txt_buffer:=OB Get:C1224($Obj_buffer;"textAlignement";Is text:K8:3)
				
			End if 
			
			$Txt_style:=$Txt_style+"text-align: "+$Txt_buffer+";"
			
		End if   //}
		
		  //default
		$Txt_style:=$Txt_style+"display-align:center;"
		
		  //______________________________________________________
	: ($Txt_what="rect")
		
		  //background color {
		$Txt_key:=Choose:C955(($Lon_line%2)=0;"alternateColor";"color")
		
		If (OB Is defined:C1231($Obj_buffer;$Txt_key))
			
			If (OB Get type:C1230($Obj_buffer;$Txt_key)=Object array:K8:28)
				
				OB GET ARRAY:C1229($Obj_buffer;$Txt_key;$tTxt_buffer)
				
				If ($Lon_column<=Size of array:C274($tTxt_buffer))
					
					$Txt_buffer:=$tTxt_buffer{$Lon_column}
					
				End if 
				
			Else 
				
				$Txt_buffer:=OB Get:C1224($Obj_buffer;$Txt_key;Is text:K8:3)
				
			End if 
		End if 
		
		If (Length:C16($Txt_buffer)#0)
			
			$Txt_style:=$Txt_style+"fill: "+$Txt_buffer+";"
			
		End if 
		  //}
		
		  //______________________________________________________
	Else 
		
		  //______________________________________________________
End case 

$Txt_style:=$Txt_style+"}"

  // ----------------------------------------------------
  // Return
$0:=$Txt_style

  // ----------------------------------------------------
  // End