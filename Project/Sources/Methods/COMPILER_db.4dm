//%attributes = {"invisible":true}
If (Structure file:C489=Structure file:C489(*))
	
	ARRAY TEXT:C222(report_structureDefinition;0;0)
	
	ARRAY TEXT:C222(tTxt_tableNames;0)
	ARRAY LONGINT:C221(tLon_tableIDs;0)
	
	ARRAY TEXT:C222(tTxt_fieldNames;0;0)
	ARRAY LONGINT:C221(tLon_fieldIDs;0;0)
	
End if 

If (False:C215)
	
	// =======================================
	C_PICTURE:C286(db_Get_field_icon;$0)
	C_LONGINT:C283(db_Get_field_icon;$1)
	
	// =======================================
	C_LONGINT:C283(db_Get_field_list;$0)
	C_LONGINT:C283(db_Get_field_list;$1)
	C_TEXT:C284(db_Get_field_list;$2)
	C_BOOLEAN:C305(db_Get_field_list;$3)
	
	// =======================================
	C_POINTER:C301(_o_db_Get_field_pointer;$0)
	C_TEXT:C284(_o_db_Get_field_pointer;$1)
	
	// =======================================
	C_TEXT:C284(db_designFieldName;$0)
	C_LONGINT:C283(db_designFieldName;$1)
	C_LONGINT:C283(db_designFieldName;$2)
	
	// =======================================
	C_TEXT:C284(db_virtualFieldName;$0)
	C_TEXT:C284(db_virtualFieldName;$1)
	
	// =======================================
	
	
	C_TEXT:C284(db_virtualTableName;$0)
	C_LONGINT:C283(db_virtualTableName;$1)
	
	// =======================================
	
	C_TEXT:C284(db_virtualFormulaName;$0)
	C_TEXT:C284(db_virtualFormulaName;$1)
	
	
End if 