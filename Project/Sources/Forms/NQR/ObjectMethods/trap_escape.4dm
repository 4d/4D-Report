
//GOTO OBJECT(*; "myQR")
//GOTO OBJECT(*; "")

//SET TIMER(-1)

//EXECUTE METHOD IN SUBFORM("myQR"; "do_goto_object"; *; "nqr")

//report_AFTER_EDIT

//var $cell : Pointer

//$cell:=OBJECT Get pointer(Object with focus)
//$name:=OBJECT Get name(Object with focus)

//FORM GET OBJECTS($_ob; $_var; $_page; Form current page)


//OBJECT SET ENTERABLE($cell->; False)
//ob_area.cellEdition:=False