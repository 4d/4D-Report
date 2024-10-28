//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : COMPILER_report
// ID[1BEDEF93EC794EA5807CD96FB84DDB19]
// Created #13-3-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
// Compiler directives
// ----------------------------------------------------
// Declarations

// ===============================================
// DON'T RENAME THESE VARIABLES LINKED TO C++ CODE
// ===============================================
var Form_C_UseVirtualStructure : Integer


// ===============================================
var ob_dialog; ob_area : Object


ob_area:=ob_area || {}

ARRAY LONGINT:C221(tLon_rowHeights; 0)

var boo_useVirtualStructure : Boolean



// ----------------------------------------------------
// Initialisations

var <>withFeature110931 : Boolean  // border managment

<>withFeature110931:=False:C215


//Assertions are enabled in dev mode
SET ASSERT ENABLED:C1131(Not:C34(Is compiled mode:C492); *)


boo_useVirtualStructure:=True:C214  //// By default we use the Virtual structure. (Form_C_UseVirtualStructure=1)


report_INIT

// ----------------------------------------------------
// Methods
If (False:C215)
	
	////----------------------------------
	//_O_C_TEXT(report_ADD_COLUMN; $1)
	//_O_C_OBJECT(report_ADD_COLUMN; $2)
	
	////----------------------------------
	//_O_C_TEXT(report_catchErrors; $0)
	//_O_C_TEXT(report_catchErrors; $1)
	//_O_C_TEXT(report_catchErrors; $2)
	
	////----------------------------------
	//_O_C_TEXT(report_cell_content; $0)
	//_O_C_TEXT(report_cell_content; $1)
	//_O_C_LONGINT(report_cell_content; $2)
	//_O_C_BOOLEAN(report_cell_content; $3)
	//_O_C_BOOLEAN(report_cell_content; $4)
	
	////----------------------------------
	//_O_C_TEXT(report_cell_styled_content; $0)
	//_O_C_LONGINT(report_cell_styled_content; $1)
	//_O_C_TEXT(report_cell_styled_content; $2)
	//_O_C_LONGINT(report_cell_styled_content; $3)
	//_O_C_LONGINT(report_cell_styled_content; $4)
	//_O_C_TEXT(report_cell_styled_content; $5)
	
	////----------------------------------
	//_O_C_TEXT(report_cell_tips; $0)
	//_O_C_TEXT(report_cell_tips; $1)
	
	////----------------------------------
	//_O_C_LONGINT(report_CONTEXTUAL_MENUS; $1)
	//_O_C_LONGINT(report_CONTEXTUAL_MENUS; $2)
	//_O_C_LONGINT(report_CONTEXTUAL_MENUS; $3)
	
	////----------------------------------
	//_O_C_LONGINT(report_EDIT_COLUMN_FORMULA; $1)
	//_O_C_LONGINT(report_EDIT_COLUMN_FORMULA; $2)
	
	////----------------------------------
	//_O_C_LONGINT(report_Get_table; $0)
	//_O_C_LONGINT(report_Get_table; $1)
	
	////----------------------------------
	//_O_C_LONGINT(report_Get_target; $0)
	//_O_C_OBJECT(report_Get_target; $1)
	//_O_C_POINTER(report_Get_target; $2)
	//_O_C_POINTER(report_Get_target; $3)
	//_O_C_BOOLEAN(report_Get_target; $4)
	
	////----------------------------------
	//_O_C_POINTER(report_CREATE_AREA; $1)
	
	////----------------------------------
	//_O_C_LONGINT(report_DISPLAY_AREA; $1)
	
	////----------------------------------
	//_O_C_LONGINT(report_DISPLAY_CROSS; $1)
	
	////----------------------------------
	//_O_C_OBJECT(report_DISPLAY_COMMON; $1)
	
	////----------------------------------
	//_O_C_LONGINT(report_DISPLAY_LIST; $1)
	
	////----------------------------------
	//_O_C_LONGINT(report_SET_CELL_FORMAT; $1)
	//_O_C_TEXT(report_SET_CELL_FORMAT; $2)
	//_O_C_LONGINT(report_SET_CELL_FORMAT; $3)
	//_O_C_LONGINT(report_SET_CELL_FORMAT; $4)
	//_O_C_LONGINT(report_SET_CELL_FORMAT; $5)
	//_O_C_TEXT(report_SET_CELL_FORMAT; $6)
	//_O_C_POINTER(report_SET_CELL_FORMAT; $7)
	//_O_C_LONGINT(report_SET_CELL_FORMAT; $8)
	
	////----------------------------------
	//_O_C_TEXT(report_SELECTION; $1)
	//_O_C_LONGINT(report_SELECTION; $2)
	//_O_C_LONGINT(report_SELECTION; $3)
	
	////----------------------------------
	//_O_C_LONGINT(report_SET_CELL_BACKGROUND; $1)
	//_O_C_TEXT(report_SET_CELL_BACKGROUND; $2)
	//_O_C_LONGINT(report_SET_CELL_BACKGROUND; $3)
	//_O_C_LONGINT(report_SET_CELL_BACKGROUND; $4)
	//_O_C_LONGINT(report_SET_CELL_BACKGROUND; $5)
	
	////----------------------------------
	//_O_C_TEXT(report_SET_COLUMN_WIDTH; $1)
	//_O_C_LONGINT(report_SET_COLUMN_WIDTH; $2)
	
	////----------------------------------
	//_O_C_TEXT(report_SET_EVENTS; $1)
	//_O_C_TEXT(report_SET_EVENTS; $2)
	
	////----------------------------------
End if 

// ----------------------------------------------------
// End