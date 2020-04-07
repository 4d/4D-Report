  // ----------------------------------------------------
  // Object method : NQR.toolbar.opened.fields - (4D Report)
  // ID[69EECC1C0B65428A924882EA8987C101]
  // Created #7-12-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($i;$l;$Lon_area;$Lon_bottom;$Lon_formEvent;$Lon_height)
C_LONGINT:C283($Lon_left;$Lon_offset;$Lon_right;$Lon_top)
C_REAL:C285($Num_wanted)
C_TEXT:C284($t;$Txt_formula;$Txt_title;$Txt_variableName)
C_OBJECT:C1216($o)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388

  // ----------------------------------------------------
Case of 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Clicked:K2:4)
		
		OBJECT GET COORDINATES:C663(*;"settings.mask";$l;$l;$l;$Lon_height)
		
		$Num_wanted:=$Lon_height*0.9
		$Lon_offset:=Round:C94(($Lon_height-$Num_wanted)/2;0)
		$Lon_top:=$Lon_offset
		$Lon_bottom:=$Lon_height-$Lon_offset
		
		OBJECT GET COORDINATES:C663(*;"settings.dial";$Lon_left;$l;$Lon_right;$l)
		OBJECT SET COORDINATES:C1248(*;"settings.dial";$Lon_left;$Lon_top;$Lon_right;$Lon_bottom)
		
		  // Adjust position
		Obj_CENTER ("settings.dial";"settings.mask";Horizontally centered:K39:1)
		
		  // Mask plus button
		OBJECT SET VISIBLE:C603(*;"plus@";False:C215)
		
		  // Show widget & mask
		OBJECT SET VISIBLE:C603(*;"settings.@";True:C214)
		
		  //#ACI0098813 [
		  //$Lon_area:=OB Get(ob_area;"area";Is longint)
		  //If ($Lon_area#0)
		  //$Lon_columns:=QR Count columns($Lon_area)
		  //ARRAY OBJECT($tObj_columns;$Lon_columns)
		  //For ($Lon_i;1;$Lon_columns;1)
		  //QR GET INFO COLUMN($Lon_area;$Lon_i;$Txt_title;$Txt_formula;$Lon_;$Lon_;$Lon_;$Txt_;$Txt_variableName)
		  //OB SET($tObj_columns{$Lon_i};\
			"column";$Lon_i;\
			"title";$Txt_title;\
			"formula";$Txt_formula;\
			"variable";$Txt_variableName)
		  //End for 
		  //  //touch the subform
		  //OB SET ARRAY((OBJECT Get pointer(Object named;"settings.dial"))->;"columns";$tObj_columns)
		  //End if 
		
		$Lon_area:=Num:C11(ob_area.area)
		
		If ($Lon_area#0)
			
			  //#ACI0098813
			$o:=New object:C1471(\
				"columns";New collection:C1472)
			
			For ($i;1;QR Count columns:C764($Lon_area);1)
				
				QR GET INFO COLUMN:C766($Lon_area;$i;$Txt_title;$Txt_formula;$l;$l;$l;$t;$Txt_variableName)
				
				$o.columns.push(New object:C1471(\
					"column";$i;\
					"title";$Txt_title;\
					"formula";$Txt_formula;\
					"variable";$Txt_variableName))
				
			End for 
			
			  // Touch the subform
			(OBJECT Get pointer:C1124(Object named:K67:5;"settings.dial"))->:=$o
			
		End if 
		  //]
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessarily ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 