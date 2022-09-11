// ----------------------------------------------------
// Object method : %report.headers - (4D Report)
// ID[139FFA0B8A63469A9D135D0147C6414F]
// Created #7-7-2016 by Vincent de Lachaux
// ----------------------------------------------------
// Declarations
var $e : Object

// ----------------------------------------------------
// Initialisations
$e:=FORM Event:C1606

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($e.code=On Losing Focus:K2:8)
		
		report_AFTER_EDIT
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Form event activated unnecessary ("+$e.description+")")
		
		//______________________________________________________
End case 