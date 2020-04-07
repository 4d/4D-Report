//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : QR_Get_colum_format
  // Database: 4D report
  // ID[40DC8AADD82C4692A5189DA28EAAA5FC]
  // Created #3-4-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)

C_LONGINT:C283($kLon_mixed;$Lon_;$Lon_area;$Lon_column;$Lon_columnNumber;$Lon_parameters)
C_LONGINT:C283($Lon_type)
C_TEXT:C284($Txt_;$Txt_buffer;$Txt_format;$Txt_type)

If (False:C215)
	C_TEXT:C284(QR_Get_column_format ;$0)
	C_LONGINT:C283(QR_Get_column_format ;$1)
	C_LONGINT:C283(QR_Get_column_format ;$2)
	C_LONGINT:C283(QR_Get_column_format ;$3)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=2;"Missing parameter"))
	
	$Lon_area:=$1
	$Lon_column:=$2
	
	If ($Lon_parameters>=3)
		
		$Lon_type:=$3
		
	End if 
	
	$kLon_mixed:=-1
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
If ($Lon_column=0)  //compute the columns to find a common value
	
	$Lon_columnNumber:=QR Count columns:C764($Lon_area)
	
	If ($Lon_columnNumber>0)
		
		  //get type & format of the first column
		QR GET INFO COLUMN:C766($Lon_area;1;$Txt_;$Txt_;$Lon_;$Lon_;$Lon_;$Txt_format)
		$Lon_type:=QR_Get_column_type ($Lon_area;1;True:C214)
		
		  //the parse all columns
		For ($Lon_column;2;$Lon_columnNumber;1)
			
			QR GET INFO COLUMN:C766($Lon_area;$Lon_column;$Txt_;$Txt_;$Lon_;$Lon_;$Lon_;$Txt_buffer)
			
			If ($Txt_buffer#$Txt_format)\
				 | ($Lon_type#QR_Get_column_type ($Lon_area;$Lon_column;True:C214))
				
				  //not the same: stop
				$Lon_column:=MAXLONG:K35:2-1
				
			End if 
		End for 
		
		$Txt_format:=Choose:C955($Lon_column#MAXLONG:K35:2;$Txt_format;"")
		$Lon_type:=Choose:C955($Lon_column#MAXLONG:K35:2;$Lon_type;$kLon_mixed)
		
	End if 
	
Else 
	
	QR GET INFO COLUMN:C766($Lon_area;$Lon_column;$Txt_;$Txt_;$Lon_;$Lon_;$Lon_;$Txt_format)
	
	If ($Lon_type=0)
		
		$Lon_type:=QR_Get_column_type ($Lon_area;$Lon_column)
		
	End if 
End if 

If ($Lon_type=Is picture:K8:10)\
 | ($Lon_type=Is date:K8:7)\
 | ($Lon_type=Is time:K8:8)\
 | ($Lon_type=Is boolean:K8:9)
	
	$Txt_type:=Choose:C955($Lon_type=Is picture:K8:10;"pict_";\
		Choose:C955($Lon_type=Is date:K8:7;"date_";\
		Choose:C955($Lon_type=Is time:K8:8;"time_";\
		Choose:C955($Lon_type=Is boolean:K8:9;"bolean_";""))))
	
	$Txt_format:=Get localized string:C991($Txt_type+String:C10(Character code:C91($Txt_format)))
	
End if 

$0:=$Txt_format

  // ----------------------------------------------------
  // End