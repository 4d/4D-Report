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
#DECLARE($content : Text; $operator : Integer; $isStyled : Boolean; $withReturn : Boolean) : Text



If (Length:C16($content)=0)\
 & ($operator#0)
	
	If ($isStyled)
		
		$content:=((String:C10(Form:C1466.dataStyled[0])+String:C10(Form:C1466.dataLabels[0]))*Num:C11($operator ?? 0))\
			+((String:C10(Form:C1466.dataStyled[1])+String:C10(Form:C1466.dataLabels[1]))*Num:C11($operator ?? 1))\
			+((String:C10(Form:C1466.dataStyled[2])+String:C10(Form:C1466.dataLabels[2]))*Num:C11($operator ?? 2))\
			+((String:C10(Form:C1466.dataStyled[3])+String:C10(Form:C1466.dataLabels[3]))*Num:C11($operator ?? 3))\
			+((String:C10(Form:C1466.dataStyled[4])+String:C10(Form:C1466.dataLabels[4]))*Num:C11($operator ?? 4))\
			+((String:C10(Form:C1466.dataStyled[5])+String:C10(Form:C1466.dataLabels[5]))*Num:C11($operator ?? 5))
		
	Else 
		
		$content:=(String:C10(Form:C1466.dataTags[0])*Num:C11($operator ?? 0))\
			+(String:C10(Form:C1466.dataTags[1])*Num:C11($operator ?? 1))\
			+(String:C10(Form:C1466.dataTags[2])*Num:C11($operator ?? 2))\
			+(String:C10(Form:C1466.dataTags[3])*Num:C11($operator ?? 3))\
			+(String:C10(Form:C1466.dataTags[4])*Num:C11($operator ?? 4))\
			+(String:C10(Form:C1466.dataTags[5])*Num:C11($operator ?? 5))
		
	End if 
	
	// Remove last carriage return
	$content:=Split string:C1554($content; "\r").join("\r")
	
End if 

return $content