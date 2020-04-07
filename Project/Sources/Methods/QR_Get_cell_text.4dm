//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : QR_Get_cell_text
  // Database: 4D Report
  // ID[2DBD7F123CED4F2EACB7EF8CE16E7B71]
  // Created #1-4-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)

C_LONGINT:C283($Lon_;$Lon_area;$Lon_column;$Lon_operator;$Lon_parameters;$Lon_row;$Lon_size)
C_TEXT:C284($Txt_;$Txt_content)

If (False:C215)
	C_TEXT:C284(QR_Get_cell_text ;$0)
	C_LONGINT:C283(QR_Get_cell_text ;$1)
	C_LONGINT:C283(QR_Get_cell_text ;$2)
	C_LONGINT:C283(QR_Get_cell_text ;$3)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=3;"Missing parameter"))
	
	$Lon_area:=$1
	$Lon_column:=$2
	$Lon_row:=$3
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------

Case of 
		
		  //______________________________________________________
	: ($Lon_column=0)
		
		ASSERT:C1129(False:C215)
		
		  //______________________________________________________
	: ($Lon_row=qr title:K14906:1)
		
		QR GET INFO COLUMN:C766($Lon_area;$Lon_column;$Txt_content;$Txt_;$Lon_;$Lon_;$Lon_;$Txt_)
		
		  //______________________________________________________
	: ($Lon_row=qr detail:K14906:2)
		
		QR GET INFO COLUMN:C766($Lon_area;$Lon_column;$Txt_;$Txt_;$Lon_;$Lon_;$Lon_;$Txt_content)
		
		  //______________________________________________________
	Else 
		
		QR GET TOTALS DATA:C768($Lon_area;$Lon_column;$Lon_row;$Lon_operator;$Txt_content)
		
		  // #14-10-2014 - convert operator to text
		If (Length:C16($Txt_content)=0)
			
			$Txt_content:=(<>tTxt_nqr_data_tag{0}*Num:C11($Lon_operator ?? 0))\
				+(<>tTxt_nqr_data_tag{1}*Num:C11($Lon_operator ?? 1))\
				+(<>tTxt_nqr_data_tag{2}*Num:C11($Lon_operator ?? 2))\
				+(<>tTxt_nqr_data_tag{3}*Num:C11($Lon_operator ?? 3))\
				+(<>tTxt_nqr_data_tag{4}*Num:C11($Lon_operator ?? 4))\
				+(<>tTxt_nqr_data_tag{5}*Num:C11($Lon_operator ?? 5))
			
			  //remove the last CR if any
			If ($Txt_content="@\r")
				
				$Lon_size:=Length:C16($Txt_content)
				$Txt_content:=Substring:C12($Txt_content;1;$Lon_size-1)
				
			End if 
		End if 
		
		  //______________________________________________________
End case 

$0:=$Txt_content

  // ----------------------------------------------------
  // End