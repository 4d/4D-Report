//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : COMPILER_CONTROLS
  // ID[D1D2E24E6FC541A0A8A76DDF059E1A2B]
  // Created #17-9-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_BOOLEAN:C305(<>ctrl_inited)
C_LONGINT:C283(<>ctrl_highlitColor)

  // ----------------------------------------------------
  // Initialisations
CONTROL_INIT 

  // ----------------------------------------------------
If (False:C215)  //private
	
	  //CONTROL_DRAW_SEGMENTS
	C_TEXT:C284(CONTROL_DRAW_SEGMENTS ;$1)
	C_LONGINT:C283(CONTROL_DRAW_SEGMENTS ;$2)
	C_LONGINT:C283(CONTROL_DRAW_SEGMENTS ;$3)
	C_LONGINT:C283(CONTROL_DRAW_SEGMENTS ;$4)
	C_LONGINT:C283(CONTROL_DRAW_SEGMENTS ;$5)
	C_LONGINT:C283(CONTROL_DRAW_SEGMENTS ;$6)
	C_POINTER:C301(CONTROL_DRAW_SEGMENTS ;$7)
	
	  //CONTROL_Area_hdl
	C_TEXT:C284(CONTROL_Area_hdl ;$0)
	C_OBJECT:C1216(CONTROL_Area_hdl ;$1)
	
	  //CONTROL_Form_hdl
	C_LONGINT:C283(CONTROL_Form_hdl ;$0)
	
	  //CONTROL_Get_color
	C_LONGINT:C283(CONTROL_Get_color ;$0)
	C_LONGINT:C283(CONTROL_Get_color ;$1)
	C_TEXT:C284(CONTROL_Get_color ;$2)
	
	  // border 
	C_LONGINT:C283(CONTROL_BorderHdl ;$1)
	
	
End if 

If (False:C215)  //shared
	
	  //CONTROL_SET_COLORS
	C_LONGINT:C283(CONTROL_SET_COLORS ;$1)
End if 

  // ----------------------------------------------------