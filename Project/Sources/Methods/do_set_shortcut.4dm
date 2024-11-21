//%attributes = {"invisible":true,"preemptive":"incapable"}
#DECLARE($name : Text; $shortcut : Text; $modifiers : Integer)


$shortcut:=Count parameters:C259>1 ? $shortcut : ""
$modifiers:=Count parameters:C259>2 ? $modifiers : 0

OBJECT SET SHORTCUT:C1185(*; $name; $shortcut; $modifiers)
