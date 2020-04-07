C_POINTER:C301($Ptr_subformContainer)

$Ptr_subformContainer:=OBJECT Get pointer:C1124(Object subform container:K67:4)

If (Is nil pointer:C315($Ptr_subformContainer))
	
	CANCEL:C270
	
Else 
	
	CALL SUBFORM CONTAINER:C1086(-2)  //close
	
End if 