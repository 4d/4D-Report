// User selects col 1
QR GET SELECTION:C793(qrsub; left; right)  // Returns that col 1 is selected

QR SET SELECTION:C794(qrsub; 2; 0)  // Select col 2 by code

QR GET SELECTION:C793(qrsub; left; right)  // Returns that col 2 is selected
// BUT: in the form still col 1 is selected

//REDRAW(qrsub)  // Dopes not help
// Also manual redraw does not help

//GOTO OBJECT(*; "")
//SET TIMER(10)