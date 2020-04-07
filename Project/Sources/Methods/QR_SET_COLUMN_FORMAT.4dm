//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : QR_SET_COLUMN_FORMAT
  // Database: 4D report
  // ID[42E482B75C6D4237B0559B166DC177EB]
  // Created #3-4-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_TEXT:C284($3)
C_LONGINT:C283($4)

C_LONGINT:C283($Lon_area;$Lon_column;$Lon_columnType;$Lon_hidden;$Lon_i;$Lon_parameters;$Lon_repeated;$Lon_width)
C_TEXT:C284($Txt_;$Txt_buffer;$Txt_format;$Txt_formula;$Txt_object;$Txt_title;$Txt_type)

If (False:C215)
	C_LONGINT:C283(QR_SET_COLUMN_FORMAT ;$1)
	C_LONGINT:C283(QR_SET_COLUMN_FORMAT ;$2)
	C_TEXT:C284(QR_SET_COLUMN_FORMAT ;$3)
	C_LONGINT:C283(QR_SET_COLUMN_FORMAT ;$4)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=3;"Missing parameter"))
	
	$Lon_area:=$1
	$Lon_column:=$2
	$Txt_format:=$3
	
	If ($Lon_parameters>=4)
		
		$Lon_columnType:=$4
		
	End if 
	
	If ($Lon_columnType=0)
		
		$Lon_columnType:=QR_Get_column_type ($Lon_area;$Lon_column)
		
	End if 
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
  //ACI0099675
  //If ($Lon_columnType=Is picture)\
 | ($Lon_columnType=Is date)\
 | ($Lon_columnType=Is time)\
 | ($Lon_columnType=Is boolean)


If ($Lon_columnType=Is picture:K8:10)\
 | ($Lon_columnType=Is date:K8:7)\
 | ($Lon_columnType=Is time:K8:8)\
 | ($Lon_columnType=Is undefined:K8:13)\
 | ($Lon_columnType=Is boolean:K8:9)
	
	$Txt_type:=Choose:C955($Lon_columnType=Is picture:K8:10;"pict_";\
		Choose:C955($Lon_columnType=Is date:K8:7;"date_";\
		Choose:C955($Lon_columnType=Is time:K8:8;"time_";\
		Choose:C955($Lon_columnType=Is boolean:K8:9;"bolean_";""))))
	
	$Lon_i:=1
	
	Repeat 
		
		$Txt_buffer:=Get localized string:C991($Txt_type+String:C10($Lon_i))
		
		If ($Txt_buffer=$Txt_format)
			
			$Txt_format:=Char:C90($Lon_i)
			CLEAR VARIABLE:C89($Txt_buffer)  //stop
			
		End if 
		
		$Lon_i:=$Lon_i+1
		
	Until (Length:C16($Txt_buffer)=0)
End if 

QR GET INFO COLUMN:C766($Lon_area;\
$Lon_column;\
$Txt_title;\
$Txt_object;\
$Lon_hidden;\
$Lon_width;\
$Lon_repeated;\
$Txt_;\
$Txt_formula)

  //ACI0099675
  //QR SET INFO COLUMN($Lon_area;\
$Lon_column;\
$Txt_title;\
$Txt_formula;\
$Txt_object;\
$Lon_hidden;\
$Lon_width;\
$Lon_repeated;\
$Txt_format)

QR SET INFO COLUMN:C765($Lon_area;\
$Lon_column;\
$Txt_title;\
$Txt_object;\
$Lon_hidden;\
$Lon_width;\
$Lon_repeated;\
$Txt_format)

  // ----------------------------------------------------
  // End