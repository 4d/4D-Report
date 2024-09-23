//%attributes = {"invisible":true}
//If (False)  //shared

//If (False)  //setters

////pathPicker SET DIRECTORY
//_O_C_TEXT(pathPicker SET DIRECTORY; $1)
//_O_C_TEXT(pathPicker SET DIRECTORY; $2)

////pathPicker SET FILE TYPES
//_O_C_TEXT(pathPicker SET FILE TYPES; $1)
//_O_C_TEXT(pathPicker SET FILE TYPES; $2)
//_O_C_TEXT(pathPicker SET FILE TYPES; ${3})

////pathPicker SET MESSAGE
//_O_C_TEXT(pathPicker SET MESSAGE; $1)
//_O_C_TEXT(pathPicker SET MESSAGE; $2)

////PathPicker SET OPTIONS
//_O_C_TEXT(PathPicker SET OPTIONS; $1)
//_O_C_BOOLEAN(PathPicker SET OPTIONS; $2)
//_O_C_LONGINT(PathPicker SET OPTIONS; $3)
//_O_C_LONGINT(PathPicker SET OPTIONS; ${4})

////PathPicker SET PLACEHOLDER
//_O_C_TEXT(PathPicker SET PLACEHOLDER; $1)
//_O_C_TEXT(PathPicker SET PLACEHOLDER; $2)

////PathPicker SET SELECTION OPTION
//_O_C_TEXT(PathPicker SET SELECTION OPTION; $1)
//_O_C_LONGINT(PathPicker SET SELECTION OPTION; $2)

////PathPicker SET TYPE
//_O_C_TEXT(PathPicker SET TYPE; $1)
//_O_C_LONGINT(PathPicker SET TYPE; $2)
//End if 

//If (False)  //getters

////PathPicker Get message
//_O_C_TEXT(PathPicker Get message; $0)
//_O_C_TEXT(PathPicker Get message; $1)

////PathPicker Get option
//_O_C_BOOLEAN(PathPicker Get option; $0)
//_O_C_TEXT(PathPicker Get option; $1)
//_O_C_LONGINT(PathPicker Get option; $2)

////PathPicker Get placeholder
//_O_C_TEXT(PathPicker Get placeholder; $0)
//_O_C_TEXT(PathPicker Get placeholder; $1)

////PathPicker Get Type
//_O_C_LONGINT(PathPicker Get type; $0)
//_O_C_TEXT(PathPicker Get type; $1)
//End if 
//End if 

//If (False)  //private

////path_picker_Get_object
//_O_C_POINTER(path_picker_Get_object; $0)
//_O_C_TEXT(path_picker_Get_object; $1)
//_O_C_POINTER(path_picker_Get_object; $2)

////PathPicker INIT
//_O_C_OBJECT(path_picker_INIT; $0)

////pathPicker_SET_LABEL
//_O_C_POINTER(path_picker_SET_LABEL; $1)

////path_picker_SET_TEXT_ATTRIBUTE
//_O_C_TEXT(path_picker_SET_TEXT_ATTRIBUTE; $1)
//_O_C_TEXT(path_picker_SET_TEXT_ATTRIBUTE; $2)
//_O_C_TEXT(path_picker_SET_TEXT_ATTRIBUTE; $3)

////HDI_PATH_PICKER
//_O_C_TEXT(HDI_PATH_PICKER; $1)

//End if 