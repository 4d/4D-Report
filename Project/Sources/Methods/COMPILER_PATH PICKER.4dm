//%attributes = {"invisible":true}
If (False:C215)  //shared
	
	If (False:C215)  //setters
		
		  //pathPicker SET DIRECTORY
		C_TEXT:C284(pathPicker SET DIRECTORY ;$1)
		C_TEXT:C284(pathPicker SET DIRECTORY ;$2)
		
		  //pathPicker SET FILE TYPES
		C_TEXT:C284(pathPicker SET FILE TYPES ;$1)
		C_TEXT:C284(pathPicker SET FILE TYPES ;$2)
		C_TEXT:C284(pathPicker SET FILE TYPES ;${3})
		
		  //pathPicker SET MESSAGE
		C_TEXT:C284(pathPicker SET MESSAGE ;$1)
		C_TEXT:C284(pathPicker SET MESSAGE ;$2)
		
		  //PathPicker SET OPTIONS
		C_TEXT:C284(PathPicker SET OPTIONS ;$1)
		C_BOOLEAN:C305(PathPicker SET OPTIONS ;$2)
		C_LONGINT:C283(PathPicker SET OPTIONS ;$3)
		C_LONGINT:C283(PathPicker SET OPTIONS ;${4})
		
		  //PathPicker SET PLACEHOLDER
		C_TEXT:C284(PathPicker SET PLACEHOLDER ;$1)
		C_TEXT:C284(PathPicker SET PLACEHOLDER ;$2)
		
		  //PathPicker SET SELECTION OPTION
		C_TEXT:C284(PathPicker SET SELECTION OPTION ;$1)
		C_LONGINT:C283(PathPicker SET SELECTION OPTION ;$2)
		
		  //PathPicker SET TYPE
		C_TEXT:C284(PathPicker SET TYPE ;$1)
		C_LONGINT:C283(PathPicker SET TYPE ;$2)
	End if 
	
	If (False:C215)  //getters
		
		  //PathPicker Get message
		C_TEXT:C284(PathPicker Get message ;$0)
		C_TEXT:C284(PathPicker Get message ;$1)
		
		  //PathPicker Get option
		C_BOOLEAN:C305(PathPicker Get option ;$0)
		C_TEXT:C284(PathPicker Get option ;$1)
		C_LONGINT:C283(PathPicker Get option ;$2)
		
		  //PathPicker Get placeholder
		C_TEXT:C284(PathPicker Get placeholder ;$0)
		C_TEXT:C284(PathPicker Get placeholder ;$1)
		
		  //PathPicker Get Type
		C_LONGINT:C283(PathPicker Get type ;$0)
		C_TEXT:C284(PathPicker Get type ;$1)
	End if 
End if 

If (False:C215)  //private
	
	  //path_picker_Get_object
	C_POINTER:C301(path_picker_Get_object ;$0)
	C_TEXT:C284(path_picker_Get_object ;$1)
	C_POINTER:C301(path_picker_Get_object ;$2)
	
	  //PathPicker INIT
	C_OBJECT:C1216(path_picker_INIT ;$0)
	
	  //pathPicker_SET_LABEL
	C_POINTER:C301(path_picker_SET_LABEL ;$1)
	
	  //path_picker_SET_TEXT_ATTRIBUTE
	C_TEXT:C284(path_picker_SET_TEXT_ATTRIBUTE ;$1)
	C_TEXT:C284(path_picker_SET_TEXT_ATTRIBUTE ;$2)
	C_TEXT:C284(path_picker_SET_TEXT_ATTRIBUTE ;$3)
	
	  //HDI_PATH_PICKER
	C_TEXT:C284(HDI_PATH_PICKER ;$1)
	
End if 