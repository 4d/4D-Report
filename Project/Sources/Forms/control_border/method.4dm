
  // ----------------------------------------------------
  // Created #4-09-2019 by Adrien Cagniant
  // Form method : CONTROL_border
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
  //C_LONGINT($0)

C_LONGINT:C283($Lon_formEvent;$Lon_parameters;$lon_borderValue)
C_TEXT:C284($txt_objectNamed;$txt_buttonFormat)
C_OBJECT:C1216($obj_imageFolder)

If (False:C215)
	C_LONGINT:C283(CONTROL_Form_hdl ;$0)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
	$Lon_formEvent:=Form event code:C388
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
Case of 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Load:K2:1)
		
		COMPILER_CONTROL 
		
		SET TIMER:C645(-1)
		
	: ($Lon_formEvent=On Timer:K2:25)
		
		SET TIMER:C645(0)
		
		  //on load: init
		
		
		  //______________________________________________________
	: ($Lon_formEvent=On Bound Variable Change:K2:52)
		
		If (Form:C1466#Null:C1517)
			
			
			  //initialize all checkboxes
			(OBJECT Get pointer:C1124(Object named:K67:5;"bAll")->):=0
			(OBJECT Get pointer:C1124(Object named:K67:5;"bInside")->):=0
			(OBJECT Get pointer:C1124(Object named:K67:5;"bHorizontal")->):=0
			(OBJECT Get pointer:C1124(Object named:K67:5;"bVertical")->):=0
			(OBJECT Get pointer:C1124(Object named:K67:5;"bOutside")->):=0
			(OBJECT Get pointer:C1124(Object named:K67:5;"bBottom")->):=0
			(OBJECT Get pointer:C1124(Object named:K67:5;"bRight")->):=0
			(OBJECT Get pointer:C1124(Object named:K67:5;"bTop")->):=0
			(OBJECT Get pointer:C1124(Object named:K67:5;"bLeft")->):=0
			$txt_buttonFormat:=OBJECT Get format:C894(*;"bAll")
			$txt_buttonFormat:=Replace string:C233($txt_buttonFormat;"on";"off")
			OBJECT SET FORMAT:C236(*;"bAll";$txt_buttonFormat)
			$txt_buttonFormat:=OBJECT Get format:C894(*;"bInside")
			$txt_buttonFormat:=Replace string:C233($txt_buttonFormat;"on";"off")
			OBJECT SET FORMAT:C236(*;"bInside";$txt_buttonFormat)
			$txt_buttonFormat:=OBJECT Get format:C894(*;"bHorizontal")
			$txt_buttonFormat:=Replace string:C233($txt_buttonFormat;"on";"off")
			OBJECT SET FORMAT:C236(*;"bHorizontal";$txt_buttonFormat)
			$txt_buttonFormat:=OBJECT Get format:C894(*;"bVertical")
			$txt_buttonFormat:=Replace string:C233($txt_buttonFormat;"on";"off")
			OBJECT SET FORMAT:C236(*;"bVertical";$txt_buttonFormat)
			$txt_buttonFormat:=OBJECT Get format:C894(*;"bOutside")
			$txt_buttonFormat:=Replace string:C233($txt_buttonFormat;"on";"off")
			OBJECT SET FORMAT:C236(*;"bOutside";$txt_buttonFormat)
			$txt_buttonFormat:=OBJECT Get format:C894(*;"bBottom")
			$txt_buttonFormat:=Replace string:C233($txt_buttonFormat;"on";"off")
			OBJECT SET FORMAT:C236(*;"bBottom";$txt_buttonFormat)
			$txt_buttonFormat:=OBJECT Get format:C894(*;"bRight")
			$txt_buttonFormat:=Replace string:C233($txt_buttonFormat;"on";"off")
			OBJECT SET FORMAT:C236(*;"bRight";$txt_buttonFormat)
			$txt_buttonFormat:=OBJECT Get format:C894(*;"bTop")
			$txt_buttonFormat:=Replace string:C233($txt_buttonFormat;"on";"off")
			OBJECT SET FORMAT:C236(*;"bTop";$txt_buttonFormat)
			$txt_buttonFormat:=OBJECT Get format:C894(*;"bLeft")
			$txt_buttonFormat:=Replace string:C233($txt_buttonFormat;"on";"off")
			OBJECT SET FORMAT:C236(*;"bLeft";$txt_buttonFormat)
			
			
			
			
			
			
			$lon_borderValue:=0
			$lon_borderValue:=Choose:C955(Form:C1466.bottom.thickness#0;$lon_borderValue+qr bottom border:K14908:4;$lon_borderValue)
			$lon_borderValue:=Choose:C955(Form:C1466.insideHorizontal.thickness#0;$lon_borderValue+qr inside horizontal border:K14908:6;$lon_borderValue)
			$lon_borderValue:=Choose:C955(Form:C1466.insideVertical.thickness#0;$lon_borderValue+qr inside vertical border:K14908:5;$lon_borderValue)
			$lon_borderValue:=Choose:C955(Form:C1466.left.thickness#0;$lon_borderValue+qr left border:K14908:1;$lon_borderValue)
			$lon_borderValue:=Choose:C955(Form:C1466.right.thickness#0;$lon_borderValue+qr right border:K14908:3;$lon_borderValue)
			$lon_borderValue:=Choose:C955(Form:C1466.top.thickness#0;$lon_borderValue+qr top border:K14908:2;$lon_borderValue)
			
			  //32 qr inside horizontal border
			  //16 qr inside vertical border
			  //8 qr bottom border
			  //4 qr right border
			  //2 qr top border
			  //1 qr left border
			
			While ($lon_borderValue>0)
				
				Case of 
						
					: ($lon_borderValue=(qr bottom border:K14908:4+qr top border:K14908:2+qr left border:K14908:1+\
						qr right border:K14908:3+qr inside horizontal border:K14908:6+qr inside vertical border:K14908:5))  // full 63: bAll
						
						(OBJECT Get pointer:C1124(Object named:K67:5;"bAll")->):=1
						
						$txt_buttonFormat:=OBJECT Get format:C894(*;"bAll")
						$txt_buttonFormat:=Replace string:C233($txt_buttonFormat;"off";"on")
						OBJECT SET FORMAT:C236(*;"bAll";$txt_buttonFormat)
						
						
						$lon_borderValue:=$lon_borderValue-(qr bottom border:K14908:4+qr top border:K14908:2+qr left border:K14908:1+\
							qr right border:K14908:3+qr inside horizontal border:K14908:6+qr inside vertical border:K14908:5)
						
						
					: ($lon_borderValue>=(qr inside horizontal border:K14908:6+qr inside vertical border:K14908:5))  // inside 48: bInside
						
						(OBJECT Get pointer:C1124(Object named:K67:5;"bInside")->):=1
						$lon_borderValue:=$lon_borderValue-(qr inside horizontal border:K14908:6+qr inside vertical border:K14908:5)
						
						$txt_buttonFormat:=OBJECT Get format:C894(*;"bInside")
						$txt_buttonFormat:=Replace string:C233($txt_buttonFormat;"off";"on")
						OBJECT SET FORMAT:C236(*;"bInside";$txt_buttonFormat)
						
					: ($lon_borderValue>=(qr inside horizontal border:K14908:6))  // inside horizontal 32: bHorizontal
						
						(OBJECT Get pointer:C1124(Object named:K67:5;"bHorizontal")->):=1
						
						$lon_borderValue:=$lon_borderValue-qr inside horizontal border:K14908:6
						
						$txt_buttonFormat:=OBJECT Get format:C894(*;"bHorizontal")
						$txt_buttonFormat:=Replace string:C233($txt_buttonFormat;"off";"on")
						OBJECT SET FORMAT:C236(*;"bHorizontal";$txt_buttonFormat)
						
					: ($lon_borderValue>=(qr inside vertical border:K14908:5))  // inside vertical 16: bVertical
						
						(OBJECT Get pointer:C1124(Object named:K67:5;"bVertical")->):=1
						
						$lon_borderValue:=$lon_borderValue-qr inside vertical border:K14908:5
						
						$txt_buttonFormat:=OBJECT Get format:C894(*;"bVertical")
						$txt_buttonFormat:=Replace string:C233($txt_buttonFormat;"off";"on")
						OBJECT SET FORMAT:C236(*;"bVertical";$txt_buttonFormat)
						
					: ($lon_borderValue>=(qr bottom border:K14908:4+qr top border:K14908:2+qr left border:K14908:1+qr right border:K14908:3))  // outside 15 : bOutside 
						
						(OBJECT Get pointer:C1124(Object named:K67:5;"bOutside")->):=1
						
						$lon_borderValue:=$lon_borderValue-(qr bottom border:K14908:4+qr top border:K14908:2+qr left border:K14908:1+qr right border:K14908:3)
						
						$txt_buttonFormat:=OBJECT Get format:C894(*;"bOutside")
						$txt_buttonFormat:=Replace string:C233($txt_buttonFormat;"off";"on")
						OBJECT SET FORMAT:C236(*;"bOutside";$txt_buttonFormat)
						
					: ($lon_borderValue>=(qr bottom border:K14908:4))  // bottom 8: bBottom
						
						(OBJECT Get pointer:C1124(Object named:K67:5;"bBottom")->):=1
						$lon_borderValue:=$lon_borderValue-(qr bottom border:K14908:4)
						
						$txt_buttonFormat:=OBJECT Get format:C894(*;"bBottom")
						$txt_buttonFormat:=Replace string:C233($txt_buttonFormat;"off";"on")
						OBJECT SET FORMAT:C236(*;"bBottom";$txt_buttonFormat)
						
					: ($lon_borderValue>=(qr right border:K14908:3))  // right 4: bRight
						
						(OBJECT Get pointer:C1124(Object named:K67:5;"bRight")->):=1
						$lon_borderValue:=$lon_borderValue-(qr right border:K14908:3)
						
						$txt_buttonFormat:=OBJECT Get format:C894(*;"bRight")
						$txt_buttonFormat:=Replace string:C233($txt_buttonFormat;"off";"on")
						OBJECT SET FORMAT:C236(*;"bRight";$txt_buttonFormat)
						
					: ($lon_borderValue>=(qr top border:K14908:2))  // top 2: bTop
						
						(OBJECT Get pointer:C1124(Object named:K67:5;"bTop")->):=1
						$lon_borderValue:=$lon_borderValue-(qr top border:K14908:2)
						
						$txt_buttonFormat:=OBJECT Get format:C894(*;"bTop")
						$txt_buttonFormat:=Replace string:C233($txt_buttonFormat;"off";"on")
						OBJECT SET FORMAT:C236(*;"bTop";$txt_buttonFormat)
						
					: ($lon_borderValue=(qr left border:K14908:1))  // left 1: bLeft
						
						(OBJECT Get pointer:C1124(Object named:K67:5;"bLeft")->):=1
						$lon_borderValue:=$lon_borderValue-(qr left border:K14908:1)
						
						$txt_buttonFormat:=OBJECT Get format:C894(*;"bLeft")
						$txt_buttonFormat:=Replace string:C233($txt_buttonFormat;"off";"on")
						OBJECT SET FORMAT:C236(*;"bLeft";$txt_buttonFormat)
						
					Else 
						  // ?? normally never goes there
						$lon_borderValue:=0
						
				End case 
				
			End while 
			
			
		Else 
			
			  // form not yet set
			  //TRACE
			
			
		End if 
	: ($Lon_formEvent=On Data Change:K2:15)
		
		If (Shift down:C543)
			
			TRACE:C157
		End if 
		
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 

$txt_buttonFormat:=OBJECT Get format:C894(*;OBJECT Get name:C1087(Object current:K67:2))
$txt_buttonFormat:=Replace string:C233($txt_buttonFormat;"off";"on")
OBJECT SET FORMAT:C236(*;OBJECT Get name:C1087(Object current:K67:2);$txt_buttonFormat)



  // ----------------------------------------------------
  // End