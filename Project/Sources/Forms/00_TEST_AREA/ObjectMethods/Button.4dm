var $ptr : Pointer
var $left; $right : Integer

$ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "subform")

// User selects col 1
QR GET SELECTION:C793($ptr->; $left; $right)  // Returns that col 1 is selected

QR SET SELECTION:C794($ptr->; 2; 0)  // Select col 2 by code

QR GET SELECTION:C793($ptr->; $left; $right)  // Returns that col 2 is selected
// BUT: in the form still col 1 is selected

REDRAW:C174($ptr->)  // Dopes not help
// Also manual redraw does not help