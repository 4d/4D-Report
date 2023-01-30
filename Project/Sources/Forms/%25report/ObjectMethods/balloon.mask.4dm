// ----------------------------------------------------
// Nom utilisateur (OS) : 4D
// Date et heure : 24/01/23, 17:56:55
// ----------------------------------------------------
// Méthode : %report.balloon.mask
// Description
// 
//
// Paramètres
// ----------------------------------------------------

var \
$parameter : Object


$parameter:=New object:C1471(\
"action"; "hide"; \
"postClick"; True:C214)

report_BALLOON_HDL($parameter)

CLEAR VARIABLE:C89($parameter)