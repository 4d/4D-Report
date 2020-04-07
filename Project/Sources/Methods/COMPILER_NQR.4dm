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
C_BOOLEAN:C305(<>Boo_debug)

  // ===============================================
  // DON'T RENAME THESE VARIABLES LINKED TO C++ CODE
  // ===============================================
C_LONGINT:C283(C_QR_MASTERTABLE)
C_BLOB:C604(C_QR_INITBLOB)
C_TEXT:C284(C_QR_INITPATH)
C_LONGINT:C283(QR_area)
C_OBJECT:C1216(C_QR_ONCOMMANDFORMULA)

  // ===============================================

C_OBJECT:C1216(ob_dialog)

  // ----------------------------------------------------
  // Initialisations
QR_area:=0

<>Boo_debug:=Not:C34(Is compiled mode:C492)

  //
C_BOOLEAN:C305(<>withFeature102041)
<>withFeature102041:=True:C214


  //Assertions are enabled in dev mode
SET ASSERT ENABLED:C1131(<>Boo_debug;*)

  // ----------------------------------------------------
  // Methods
If (False:C215)
	
	  // =======================================
	C_OBJECT:C1216(NQR_AREA_HANDLE ;$1)
	
	  // =======================================
	C_POINTER:C301(NQR_DIGEST ;$1)
	C_BOOLEAN:C305(NQR_DIGEST ;$2)
	
	  // =======================================
	C_OBJECT:C1216(NQR_DO_IT ;$1)
	
	  // =======================================
	C_TEXT:C284(NQR_DRAW_TABS ;${1})
	
	  // =======================================
	C_POINTER:C301(NQR_MENU_CELLS ;$1)
	
	  // =======================================
	C_POINTER:C301(NQR_MENU_COLUMN ;$1)
	
	  // =======================================
	C_LONGINT:C283(NQR_NEW ;$1)
	
	  // =======================================
	C_OBJECT:C1216(NQR_OPEN ;$1)
	
	  // =======================================
	C_TEXT:C284(NQR_OPTIONS_ACTION ;$1)
	
	  // =======================================
	C_BOOLEAN:C305(NQR_Save ;$0)
	C_BOOLEAN:C305(NQR_SaveAs ;$0)
	
	  // =======================================
	C_LONGINT:C283(NQR_SET_DESTINATION ;$1)
	
	  // =======================================
	C_TEXT:C284(NQR_HEADER_AND_FOOTER_ACTION ;$1)
	
	  // =======================================
	C_TEXT:C284(NQR_SET_SELECTION ;$1)
	
	  // =======================================
	C_LONGINT:C283(NQR_GET_HEADER_AND_FOOTER ;$1)
	
	  // =======================================
	C_TEXT:C284(NQR_STATUS_BAR ;$1)
	
	  // =======================================
	C_TEXT:C284(NQR_TOOLBAR ;$1)
	C_BOOLEAN:C305(NQR_TOOLBAR ;$2)
	
	  // =======================================
	
	C_LONGINT:C283(NQR_doAction ;$1)
	
	  // =======================================
	
	C_LONGINT:C283(NQR_GET_BORDER;$1)
	
	  // =======================================
	
	
	
End if 

  // ----------------------------------------------------
  // End