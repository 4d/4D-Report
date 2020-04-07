//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : QR_DUPLICATE_COLUMN
  // Database: 4D Report
  // ID[2A929CB9006C4F7297791680B44FB15B]
  // Created #14-1-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)
C_LONGINT:C283($4)

C_LONGINT:C283($Lon_area;$Lon_column;$Lon_hidden;$Lon_i;$Lon_operator;$Lon_parameters)
C_LONGINT:C283($Lon_repeated;$Lon_size;$Lon_sort;$Lon_target)
C_TEXT:C284($Txt_data;$Txt_format;$Txt_object;$Txt_title)

If (False:C215)
	C_LONGINT:C283(QR_DUPLICATE_COLUMN ;$1)
	C_LONGINT:C283(QR_DUPLICATE_COLUMN ;$2)
	C_LONGINT:C283(QR_DUPLICATE_COLUMN ;$3)
	C_LONGINT:C283(QR_DUPLICATE_COLUMN ;$4)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=2;"Missing parameter"))
	
	  //Required parameters
	$Lon_area:=$1
	$Lon_column:=$2
	
	  //Default values
	$Lon_sort:=-1
	$Lon_target:=$Lon_column+1
	
	  //Optional parameters
	If ($Lon_parameters>=3)
		
		$Lon_sort:=$3
		
		If ($Lon_parameters>=4)
			
			$Lon_target:=$4
			
		End if 
		
	End if 
	
	If ($Lon_sort=-1)
		
		ARRAY LONGINT:C221($tLon_sortedColumns;0x0000)
		ARRAY LONGINT:C221($tLon_sortOrder;0x0000)
		QR GET SORTS:C753($Lon_area;$tLon_sortedColumns;$tLon_sortOrder)
		
		$Lon_sort:=Size of array:C274($tLon_sortedColumns)
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
QR GET INFO COLUMN:C766($Lon_area;$Lon_column;\
$Txt_title;\
$Txt_object;\
$Lon_hidden;\
$Lon_size;\
$Lon_repeated;\
$Txt_format)

QR INSERT COLUMN:C748($Lon_area;$Lon_target;$Txt_object)

QR SET INFO COLUMN:C765($Lon_area;$Lon_target;\
$Txt_title;\
$Txt_object;\
$Lon_hidden;\
$Lon_size;\
$Lon_repeated;\
$Txt_format)

QR SET TEXT PROPERTY:C759($Lon_area;$Lon_target;qr title:K14906:1;qr alternate background color:K14904:9;\
QR Get text property:C760($Lon_area;$Lon_column;qr title:K14906:1;qr alternate background color:K14904:9))
QR SET TEXT PROPERTY:C759($Lon_area;$Lon_target;qr title:K14906:1;qr background color:K14904:8;\
QR Get text property:C760($Lon_area;$Lon_column;qr title:K14906:1;qr background color:K14904:8))
QR SET TEXT PROPERTY:C759($Lon_area;$Lon_target;qr title:K14906:1;qr bold:K14904:3;\
QR Get text property:C760($Lon_area;$Lon_column;qr title:K14906:1;qr bold:K14904:3))
QR SET TEXT PROPERTY:C759($Lon_area;$Lon_target;qr title:K14906:1;qr font name:K14904:10;\
QR Get text property:C760($Lon_area;$Lon_column;qr title:K14906:1;qr font name:K14904:10))
QR SET TEXT PROPERTY:C759($Lon_area;$Lon_target;qr title:K14906:1;qr font size:K14904:2;\
QR Get text property:C760($Lon_area;$Lon_column;qr title:K14906:1;qr font size:K14904:2))
QR SET TEXT PROPERTY:C759($Lon_area;$Lon_target;qr title:K14906:1;qr italic:K14904:4;\
QR Get text property:C760($Lon_area;$Lon_column;qr title:K14906:1;qr italic:K14904:4))
QR SET TEXT PROPERTY:C759($Lon_area;$Lon_target;qr title:K14906:1;qr justification:K14904:7;\
QR Get text property:C760($Lon_area;$Lon_column;qr title:K14906:1;qr justification:K14904:7))
QR SET TEXT PROPERTY:C759($Lon_area;$Lon_target;qr title:K14906:1;qr text color:K14904:6;\
QR Get text property:C760($Lon_area;$Lon_column;qr title:K14906:1;qr text color:K14904:6))
QR SET TEXT PROPERTY:C759($Lon_area;$Lon_target;qr title:K14906:1;qr underline:K14904:5;\
QR Get text property:C760($Lon_area;$Lon_column;qr title:K14906:1;qr underline:K14904:5))

QR SET TEXT PROPERTY:C759($Lon_area;$Lon_target;qr detail:K14906:2;qr alternate background color:K14904:9;\
QR Get text property:C760($Lon_area;$Lon_column;qr detail:K14906:2;qr alternate background color:K14904:9))
QR SET TEXT PROPERTY:C759($Lon_area;$Lon_target;qr detail:K14906:2;qr background color:K14904:8;\
QR Get text property:C760($Lon_area;$Lon_column;qr detail:K14906:2;qr background color:K14904:8))
QR SET TEXT PROPERTY:C759($Lon_area;$Lon_target;qr detail:K14906:2;qr bold:K14904:3;\
QR Get text property:C760($Lon_area;$Lon_column;qr detail:K14906:2;qr bold:K14904:3))
QR SET TEXT PROPERTY:C759($Lon_area;$Lon_target;qr detail:K14906:2;qr font name:K14904:10;\
QR Get text property:C760($Lon_area;$Lon_column;qr detail:K14906:2;qr font name:K14904:10))
QR SET TEXT PROPERTY:C759($Lon_area;$Lon_target;qr detail:K14906:2;qr font size:K14904:2;\
QR Get text property:C760($Lon_area;$Lon_column;qr detail:K14906:2;qr font size:K14904:2))
QR SET TEXT PROPERTY:C759($Lon_area;$Lon_target;qr detail:K14906:2;qr italic:K14904:4;\
QR Get text property:C760($Lon_area;$Lon_column;qr detail:K14906:2;qr italic:K14904:4))
QR SET TEXT PROPERTY:C759($Lon_area;$Lon_target;qr detail:K14906:2;qr justification:K14904:7;\
QR Get text property:C760($Lon_area;$Lon_column;qr detail:K14906:2;qr justification:K14904:7))
QR SET TEXT PROPERTY:C759($Lon_area;$Lon_target;qr detail:K14906:2;qr text color:K14904:6;\
QR Get text property:C760($Lon_area;$Lon_column;qr detail:K14906:2;qr text color:K14904:6))
QR SET TEXT PROPERTY:C759($Lon_area;$Lon_target;qr detail:K14906:2;qr underline:K14904:5;\
QR Get text property:C760($Lon_area;$Lon_column;qr detail:K14906:2;qr underline:K14904:5))

For ($Lon_i;1;$Lon_sort;1)
	
	QR GET TOTALS DATA:C768($Lon_area;$Lon_column;$Lon_i;$Lon_operator;$Txt_data)
	QR SET TOTALS DATA:C767($Lon_area;$Lon_target;$Lon_i;$Lon_operator)
	QR SET TOTALS DATA:C767($Lon_area;$Lon_target;$Lon_i;$Txt_data)
	
	QR SET TEXT PROPERTY:C759($Lon_area;$Lon_target;$Lon_i;qr alternate background color:K14904:9;\
		QR Get text property:C760($Lon_area;$Lon_column;$Lon_i;qr alternate background color:K14904:9))
	QR SET TEXT PROPERTY:C759($Lon_area;$Lon_target;$Lon_i;qr background color:K14904:8;\
		QR Get text property:C760($Lon_area;$Lon_column;$Lon_i;qr background color:K14904:8))
	QR SET TEXT PROPERTY:C759($Lon_area;$Lon_target;$Lon_i;qr bold:K14904:3;\
		QR Get text property:C760($Lon_area;$Lon_column;$Lon_i;qr bold:K14904:3))
	QR SET TEXT PROPERTY:C759($Lon_area;$Lon_target;$Lon_i;qr font name:K14904:10;\
		QR Get text property:C760($Lon_area;$Lon_column;$Lon_i;qr font name:K14904:10))
	QR SET TEXT PROPERTY:C759($Lon_area;$Lon_target;$Lon_i;qr font size:K14904:2;\
		QR Get text property:C760($Lon_area;$Lon_column;$Lon_i;qr font size:K14904:2))
	QR SET TEXT PROPERTY:C759($Lon_area;$Lon_target;$Lon_i;qr italic:K14904:4;\
		QR Get text property:C760($Lon_area;$Lon_column;$Lon_i;qr italic:K14904:4))
	QR SET TEXT PROPERTY:C759($Lon_area;$Lon_target;$Lon_i;qr justification:K14904:7;\
		QR Get text property:C760($Lon_area;$Lon_column;$Lon_i;qr justification:K14904:7))
	QR SET TEXT PROPERTY:C759($Lon_area;$Lon_target;$Lon_i;qr text color:K14904:6;\
		QR Get text property:C760($Lon_area;$Lon_column;$Lon_i;qr text color:K14904:6))
	QR SET TEXT PROPERTY:C759($Lon_area;$Lon_target;$Lon_i;qr underline:K14904:5;\
		QR Get text property:C760($Lon_area;$Lon_column;$Lon_i;qr underline:K14904:5))
	
End for 

QR GET TOTALS DATA:C768($Lon_area;$Lon_column;qr grand total:K14906:3;$Lon_operator;$Txt_data)
QR SET TOTALS DATA:C767($Lon_area;$Lon_target;qr grand total:K14906:3;$Lon_operator)
QR SET TOTALS DATA:C767($Lon_area;$Lon_target;qr grand total:K14906:3;$Txt_data)
QR SET TEXT PROPERTY:C759($Lon_area;$Lon_target;qr grand total:K14906:3;qr alternate background color:K14904:9;\
QR Get text property:C760($Lon_area;$Lon_column;qr grand total:K14906:3;qr alternate background color:K14904:9))
QR SET TEXT PROPERTY:C759($Lon_area;$Lon_target;qr grand total:K14906:3;qr background color:K14904:8;\
QR Get text property:C760($Lon_area;$Lon_column;qr grand total:K14906:3;qr background color:K14904:8))
QR SET TEXT PROPERTY:C759($Lon_area;$Lon_target;qr grand total:K14906:3;qr bold:K14904:3;\
QR Get text property:C760($Lon_area;$Lon_column;qr grand total:K14906:3;qr bold:K14904:3))
QR SET TEXT PROPERTY:C759($Lon_area;$Lon_target;qr grand total:K14906:3;qr font name:K14904:10;\
QR Get text property:C760($Lon_area;$Lon_column;qr grand total:K14906:3;qr font name:K14904:10))
QR SET TEXT PROPERTY:C759($Lon_area;$Lon_target;qr grand total:K14906:3;qr font size:K14904:2;\
QR Get text property:C760($Lon_area;$Lon_column;qr grand total:K14906:3;qr font size:K14904:2))
QR SET TEXT PROPERTY:C759($Lon_area;$Lon_target;qr grand total:K14906:3;qr italic:K14904:4;\
QR Get text property:C760($Lon_area;$Lon_column;qr grand total:K14906:3;qr italic:K14904:4))
QR SET TEXT PROPERTY:C759($Lon_area;$Lon_target;qr grand total:K14906:3;qr justification:K14904:7;\
QR Get text property:C760($Lon_area;$Lon_column;qr grand total:K14906:3;qr justification:K14904:7))
QR SET TEXT PROPERTY:C759($Lon_area;$Lon_target;qr grand total:K14906:3;qr text color:K14904:6;\
QR Get text property:C760($Lon_area;$Lon_column;qr grand total:K14906:3;qr text color:K14904:6))
QR SET TEXT PROPERTY:C759($Lon_area;$Lon_target;qr grand total:K14906:3;qr underline:K14904:5;\
QR Get text property:C760($Lon_area;$Lon_column;qr grand total:K14906:3;qr underline:K14904:5))

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End