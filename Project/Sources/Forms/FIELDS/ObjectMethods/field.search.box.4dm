  // ----------------------------------------------------
  // Object method : Search.SearchText - (label-editor)
  // ID[718FA24F8F1D4F6C9F2F30080676E1E8]
  // Created #11-12-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_formEvent)
C_POINTER:C301($Ptr_list;$Ptr_me)
C_TEXT:C284($Txt_buffer;$Txt_me)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388

$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)
$Ptr_me:=OBJECT Get pointer:C1124(Object current:K67:2)

  // ----------------------------------------------------
Case of 
		
		  //________________________________________
	: ($Lon_formEvent=On Getting Focus:K2:7)
		
		OBJECT SET VISIBLE:C603(*;"field.@.focus";False:C215)
		
		OBJECT SET VISIBLE:C603(*;"field.search.focus";True:C214)
		OBJECT SET VISIBLE:C603(*;"field.search.close";(Length:C16($Ptr_me->)#0))
		
		  //________________________________________
	: ($Lon_formEvent=On Losing Focus:K2:8)
		
		OBJECT SET VISIBLE:C603(*;"field.search.focus";False:C215)
		OBJECT SET VISIBLE:C603(*;"field.search.close";False:C215)
		
		  //________________________________________
	: ($Lon_formEvent=On After Edit:K2:43)
		
		$Txt_buffer:=Get edited text:C655
		
		$Ptr_list:=OBJECT Get pointer:C1124(Object named:K67:5;"field.list")
		
		CLEAR LIST:C377($Ptr_list->;*)
		
		$Ptr_list->:=db_Get_field_list (C_QR_MASTERTABLE;$Txt_buffer)
		
		OBJECT SET VISIBLE:C603(*;"field.search.close";(Length:C16($Txt_buffer)#0))
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 