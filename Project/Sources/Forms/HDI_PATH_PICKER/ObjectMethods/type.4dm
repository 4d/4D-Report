var $type : Integer


$type:=Self:C308->-1

PathPicker SET TYPE("widget_path"; $type)
pathPicker SET MESSAGE("widget_path"; Choose:C955($type=Is a document:K24:1; "Select file:"; "Select folder:"))
PathPicker SET PLACEHOLDER("widget_path"; Choose:C955($type=Is a document:K24:1; "Please select a file"; "Please select a folder"))

//update UI
SET TIMER:C645(-1)