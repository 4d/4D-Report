//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : COMPILER_NQR
// Database: 4D report
// ID[AD938B73660647E5AE942097D7FC4557]
// Created #8-4-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
// Compiler directives
// ----------------------------------------------------
// Declarations

var <>Boo_debug : Boolean

//_O_C_BOOLEAN(<>Boo_debug)

// ===============================================
// DON'T RENAME THESE VARIABLES LINKED TO C++ CODE
// ===============================================
var C_QR_MASTERTABLE : Integer
var C_QR_INITBLOB : Blob
var C_QR_INITPATH : Text
var QR_area : Integer
var C_QR_ONCOMMANDFORMULA : Object

//_O_C_LONGINT(C_QR_MASTERTABLE)
//_O_C_BLOB(C_QR_INITBLOB)
//_O_C_TEXT(C_QR_INITPATH)
//_O_C_LONGINT(QR_area)
//_O_C_OBJECT(C_QR_ONCOMMANDFORMULA)

// ===============================================

var ob_dialog : Object

//_O_C_OBJECT(ob_dialog)

// ----------------------------------------------------
// Initialisations
QR_area:=0

<>Boo_debug:=Not:C34(Is compiled mode:C492)

//
//_O_C_BOOLEAN(<>withFeature102041)
//<>withFeature102041:=True


//Assertions are enabled in dev mode
SET ASSERT ENABLED:C1131(<>Boo_debug; *)

// ----------------------------------------------------
// Methods
If (False:C215)
	
	//// =======================================
	//_O_C_OBJECT(NQR_AREA_HANDLE; $1)
	
	//// =======================================
	//_O_C_POINTER(NQR_DIGEST; $1)
	//_O_C_BOOLEAN(NQR_DIGEST; $2)
	
	//// =======================================
	//_O_C_OBJECT(NQR_DO_IT; $1)
	
	//// =======================================
	//_O_C_TEXT(NQR_DRAW_TABS; ${1})
	
	//// =======================================
	//_O_C_POINTER(NQR_MENU_CELLS; $1)
	
	//// =======================================
	//_O_C_POINTER(NQR_MENU_COLUMN; $1)
	
	//// =======================================
	//_O_C_LONGINT(NQR_NEW; $1)
	
	//// =======================================
	//_O_C_OBJECT(NQR_OPEN; $1)
	
	//// =======================================
	//_O_C_TEXT(NQR_OPTIONS_ACTION; $1)
	
	//// =======================================
	//_O_C_BOOLEAN(NQR_Save; $0)
	//_O_C_BOOLEAN(NQR_SaveAs; $0)
	
	//// =======================================
	//_O_C_LONGINT(NQR_SET_DESTINATION; $1)
	
	//// =======================================
	//_O_C_TEXT(NQR_HEADER_AND_FOOTER_ACTION; $1)
	
	//// =======================================
	//_O_C_TEXT(NQR_SET_SELECTION; $1)
	
	//// =======================================
	//_O_C_LONGINT(NQR_GET_HEADER_AND_FOOTER; $1)
	
	//// =======================================
	//_O_C_TEXT(NQR_STATUS_BAR; $1)
	
	//// =======================================
	//_O_C_TEXT(NQR_TOOLBAR; $1)
	//_O_C_BOOLEAN(NQR_TOOLBAR; $2)
	
	//// =======================================
	
	//_O_C_LONGINT(NQR_doAction; $1)
	
	//// =======================================
	
	//_O_C_LONGINT(NQR_GET_BORDER; $1)
	
	//// =======================================
	
	
	
End if 

// ----------------------------------------------------
// End