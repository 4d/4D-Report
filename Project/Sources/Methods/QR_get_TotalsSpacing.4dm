//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : QR_Get_totalsSpacings
  // Database: 4D report
  // Created #9-4-2019 by Adrien Cagniant
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)

C_LONGINT:C283($Lon_area;$Lon_row;$lon_value;$Lon_parameters;$Lon_SubBreakSpacing)

If (False:C215)
	C_LONGINT:C283(QR_get_TotalsSpacing ;$0)
	C_LONGINT:C283(QR_get_TotalsSpacing ;$1)
	C_LONGINT:C283(QR_get_TotalsSpacing ;$2)
	C_LONGINT:C283(QR_get_TotalsSpacing ;$3)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=2;"Missing parameter"))
	
	$Lon_area:=$1
	$Lon_row:=$2
	
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
QR GET TOTALS SPACING:C762($Lon_area;$Lon_row;$lon_value)

Case of 
		
	: ($lon_value=32000)
		
		$Lon_SubBreakSpacing:=3
		
	: ($lon_value<0)
		
		$Lon_SubBreakSpacing:=2
		
	: ($lon_value>0)
		
		$Lon_SubBreakSpacing:=1
		
	Else 
		
		$Lon_SubBreakSpacing:=0
		
End case 


$0:=$Lon_SubBreakSpacing

  // ----------------------------------------------------
  // End