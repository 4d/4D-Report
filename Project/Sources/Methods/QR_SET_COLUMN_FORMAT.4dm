//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : QR_SET_COLUMN_FORMAT
// Database: 4D report
// ID[42E482B75C6D4237B0559B166DC177EB]
// Created #3-4-2014 by Vincent de Lachaux
// ----------------------------------------------------
#DECLARE($area : Integer; $column : Integer; $format : Text; $columnType : Integer)

var $buffer; $object; $title; $type : Text
var $hidden; $i; $repeated; $width : Integer

$columnType:=$columnType=0 ? QR_Get_column_type($area; $column) : $columnType

/* ACI0099675
//If ($columnType=Is picture)\
| ($columnType=Is date)\
| ($columnType=Is time)\
| ($columnType=Is boolean)
*/

If ($columnType=Is picture:K8:10)\
 | ($columnType=Is date:K8:7)\
 | ($columnType=Is time:K8:8)\
 | ($columnType=Is undefined:K8:13)\
 | ($columnType=Is boolean:K8:9)
	
	$type:=Choose:C955($columnType=Is picture:K8:10; "pict_"; \
		Choose:C955($columnType=Is date:K8:7; "date_"; \
		Choose:C955($columnType=Is time:K8:8; "time_"; \
		Choose:C955($columnType=Is boolean:K8:9; "boolean_"; ""))))
	
	$i:=1
	
	Repeat 
		
		$buffer:=Get localized string:C991($type+String:C10($i))
		
		If ($buffer=$format)
			
			$format:=Char:C90($i)
			CLEAR VARIABLE:C89($buffer)  // Stop
			
		End if 
		
		$i:=$i+1
		
	Until (Length:C16($buffer)=0)
End if 

/* ACI0099675
QR GET INFO COLUMN($area; \
$column; \
$title; \
$object; \
$hidden; \
$width; \
$repeated; \
$buffer; \
$formula)

QR SET INFO COLUMN($area;\
$column;\
$title;\
$formula;\
$object;\
$hidden;\
$width;\
$repeated;\
$format)
*/

QR GET INFO COLUMN:C766($area; \
$column; \
$title; \
$object; \
$hidden; \
$width; \
$repeated; \
$buffer)

QR SET INFO COLUMN:C765($area; \
$column; \
$title; \
$object; \
$hidden; \
$width; \
$repeated; \
$format)