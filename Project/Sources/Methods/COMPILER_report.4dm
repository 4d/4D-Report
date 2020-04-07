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
C_OBJECT:C1216(<>report_params)
C_BOOLEAN:C305(<>Boo_debug)

If (False:C215)
	ARRAY TEXT:C222(<>tTxt_nqr_data_styled;0x0000)
	ARRAY TEXT:C222(<>tTxt_nqr_data_tag;0x0000)
End if 

  // ===============================================
  // DON'T RENAME THESE VARIABLES LINKED TO C++ CODE
  // ===============================================
C_LONGINT:C283(Form_C_UseVirtualStructure)

  // ===============================================
C_OBJECT:C1216(ob_dialog;ob_area;object_selection)

ARRAY LONGINT:C221(tLon_rowHeights;0)

  // ----------------------------------------------------
  // Initialisations
C_BOOLEAN:C305(<>withFeature105739)
<>withFeature105739:=True:C214

C_BOOLEAN:C305(<>withFeature92478)
<>withFeature92478:=True:C214

C_BOOLEAN:C305(<>withFeature110931)  // border managment
<>withFeature110931:=False:C215



<>Boo_debug:=Not:C34(Is compiled mode:C492)

  //Assertions are enabled in dev mode
SET ASSERT ENABLED:C1131(<>Boo_debug;*)

report_INIT 

  // ----------------------------------------------------
  // Methods
If (False:C215)
	
	  //----------------------------------
	C_TEXT:C284(report_ADD_COLUMN ;$1)
	C_OBJECT:C1216(report_ADD_COLUMN ;$2)
	
	  //----------------------------------
	C_OBJECT:C1216(report_BALLOON_HDL ;$1)
	
	  //----------------------------------
	C_TEXT:C284(report_catchErrors ;$0)
	C_TEXT:C284(report_catchErrors ;$1)
	C_TEXT:C284(report_catchErrors ;$2)
	
	  //----------------------------------
	C_TEXT:C284(report_cell_content ;$0)
	C_TEXT:C284(report_cell_content ;$1)
	C_LONGINT:C283(report_cell_content ;$2)
	C_BOOLEAN:C305(report_cell_content ;$3)
	C_BOOLEAN:C305(report_cell_content ;$4)
	
	  //----------------------------------
	C_TEXT:C284(report_cell_styled_content ;$0)
	C_LONGINT:C283(report_cell_styled_content ;$1)
	C_TEXT:C284(report_cell_styled_content ;$2)
	C_LONGINT:C283(report_cell_styled_content ;$3)
	C_LONGINT:C283(report_cell_styled_content ;$4)
	C_TEXT:C284(report_cell_styled_content ;$5)
	
	  //----------------------------------
	C_TEXT:C284(report_cell_tips ;$0)
	C_TEXT:C284(report_cell_tips ;$1)
	
	  //----------------------------------
	C_LONGINT:C283(report_CONTEXTUAL_MENUS ;$1)
	C_LONGINT:C283(report_CONTEXTUAL_MENUS ;$2)
	C_LONGINT:C283(report_CONTEXTUAL_MENUS ;$3)
	
	  //----------------------------------
	C_LONGINT:C283(report_EDIT_COLUMN_FORMULA ;$1)
	C_LONGINT:C283(report_EDIT_COLUMN_FORMULA ;$2)
	
	  //----------------------------------
	C_LONGINT:C283(report_Get_table ;$0)
	C_LONGINT:C283(report_Get_table ;$1)
	
	  //----------------------------------
	C_LONGINT:C283(report_Get_target ;$0)
	C_OBJECT:C1216(report_Get_target ;$1)
	C_POINTER:C301(report_Get_target ;$2)
	C_POINTER:C301(report_Get_target ;$3)
	C_BOOLEAN:C305(report_Get_target ;$4)
	
	  //----------------------------------
	C_POINTER:C301(report_CREATE_AREA ;$1)
	
	  //----------------------------------
	C_LONGINT:C283(report_DISPLAY_AREA ;$1)
	
	  //----------------------------------
	C_LONGINT:C283(report_DISPLAY_CROSS ;$1)
	
	  //----------------------------------
	C_OBJECT:C1216(report_DISPLAY_COMMON ;$1)
	
	  //----------------------------------
	C_LONGINT:C283(report_DISPLAY_LIST ;$1)
	
	  //----------------------------------
	C_LONGINT:C283(report_SET_CELL_FORMAT ;$1)
	C_TEXT:C284(report_SET_CELL_FORMAT ;$2)
	C_LONGINT:C283(report_SET_CELL_FORMAT ;$3)
	C_LONGINT:C283(report_SET_CELL_FORMAT ;$4)
	C_LONGINT:C283(report_SET_CELL_FORMAT ;$5)
	C_TEXT:C284(report_SET_CELL_FORMAT ;$6)
	C_POINTER:C301(report_SET_CELL_FORMAT ;$7)
	C_LONGINT:C283(report_SET_CELL_FORMAT ;$8)
	
	  //----------------------------------
	C_TEXT:C284(report_SELECTION ;$1)
	C_LONGINT:C283(report_SELECTION ;$2)
	C_LONGINT:C283(report_SELECTION ;$3)
	
	  //----------------------------------
	C_LONGINT:C283(report_SET_CELL_BACKGROUND ;$1)
	C_TEXT:C284(report_SET_CELL_BACKGROUND ;$2)
	C_LONGINT:C283(report_SET_CELL_BACKGROUND ;$3)
	C_LONGINT:C283(report_SET_CELL_BACKGROUND ;$4)
	C_LONGINT:C283(report_SET_CELL_BACKGROUND ;$5)
	
	  //----------------------------------
	C_TEXT:C284(report_SET_COLUMN_WIDTH ;$1)
	C_LONGINT:C283(report_SET_COLUMN_WIDTH ;$2)
	
	  //----------------------------------
	C_TEXT:C284(report_SET_EVENTS ;$1)
	C_TEXT:C284(report_SET_EVENTS ;$2)
	
	  //----------------------------------
End if 

  // ----------------------------------------------------
  // End