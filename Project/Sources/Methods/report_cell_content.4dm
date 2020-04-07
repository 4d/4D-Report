//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : report_cell_content
  // Database: 4D Report
  // ID[C055C5B22D854C58AB923A9E36D539FC]
  // Created #17-3-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($0)
C_TEXT:C284($1)
C_LONGINT:C283($2)
C_BOOLEAN:C305($3)
C_BOOLEAN:C305($4)

C_BOOLEAN:C305($Boo_return;$Boo_styled)
C_LONGINT:C283($Lon_operator;$Lon_parameters;$Lon_x)
C_TEXT:C284($Txt_content;$Txt_space)

If (False:C215)
	C_TEXT:C284(report_cell_content ;$0)
	C_TEXT:C284(report_cell_content ;$1)
	C_LONGINT:C283(report_cell_content ;$2)
	C_BOOLEAN:C305(report_cell_content ;$3)
	C_BOOLEAN:C305(report_cell_content ;$4)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=2;"Missing parameter"))
	
	$Txt_content:=$1
	$Lon_operator:=$2
	
	If ($Lon_parameters>=3)
		
		$Boo_styled:=$3
		
		If ($Lon_parameters>=4)
			
			$Boo_return:=$4
			
		End if 
	End if 
	
	ARRAY TEXT:C222($tTxt_labels;5)
	
	If ($Boo_return)
		
		  //add labels & carriage return
		$Txt_space:="<span style='font-weight: normal;text-decoration:none'> </span>"
		
		$tTxt_labels{0}:=$Txt_space+Get localized string:C991("nqr_sum")+"\r"
		$tTxt_labels{1}:=$Txt_space+Get localized string:C991("nqr_average")+"\r"
		$tTxt_labels{2}:=$Txt_space+Get localized string:C991("nqr_min")+"\r"
		$tTxt_labels{3}:=$Txt_space+Get localized string:C991("nqr_max")+"\r"
		$tTxt_labels{4}:=$Txt_space+Get localized string:C991("nqr_count")+"\r"
		$tTxt_labels{5}:=$Txt_space+Get localized string:C991("nqr_standard_deviation")+"\r"
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
If (Length:C16($Txt_content)=0)
	
	If ($Lon_operator#0)
		
		If ($Boo_styled)
			
			$Txt_content:=((<>tTxt_nqr_data_styled{0}+$tTxt_labels{0})*Num:C11($Lon_operator ?? 0))\
				+((<>tTxt_nqr_data_styled{1}+$tTxt_labels{1})*Num:C11($Lon_operator ?? 1))\
				+((<>tTxt_nqr_data_styled{2}+$tTxt_labels{2})*Num:C11($Lon_operator ?? 2))\
				+((<>tTxt_nqr_data_styled{3}+$tTxt_labels{3})*Num:C11($Lon_operator ?? 3))\
				+((<>tTxt_nqr_data_styled{4}+$tTxt_labels{4})*Num:C11($Lon_operator ?? 4))\
				+((<>tTxt_nqr_data_styled{5}+$tTxt_labels{5})*Num:C11($Lon_operator ?? 5))
			
		Else 
			
			$Txt_content:=(<>tTxt_nqr_data_tag{0}*Num:C11($Lon_operator ?? 0))\
				+(<>tTxt_nqr_data_tag{1}*Num:C11($Lon_operator ?? 1))\
				+(<>tTxt_nqr_data_tag{2}*Num:C11($Lon_operator ?? 2))\
				+(<>tTxt_nqr_data_tag{3}*Num:C11($Lon_operator ?? 3))\
				+(<>tTxt_nqr_data_tag{4}*Num:C11($Lon_operator ?? 4))\
				+(<>tTxt_nqr_data_tag{5}*Num:C11($Lon_operator ?? 5))
			
		End if 
	End if 
End if 

  //remove last carriage return {
$Lon_x:=Position:C15("\r";$Txt_content)

If ($Lon_x=Length:C16($Txt_content))
	
	$Txt_content:=Delete string:C232($Txt_content;$Lon_x;1)
	
End if 
  //}

  // ----------------------------------------------------
  // Return
$0:=$Txt_content

  // ----------------------------------------------------
  // End