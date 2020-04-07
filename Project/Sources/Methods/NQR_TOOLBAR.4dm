//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : NQR_TOOLBAR
  // Database: 4D Report
  // ID[2AD5122EB5D84B14BD34986AEE5502F2]
  // Created #10-6-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($1)

C_BOOLEAN:C305($Boo_enabled;$Boo_modified;$Boo_visible)
C_LONGINT:C283($kLon_offset;$Lon_;$Lon_bottom;$Lon_columnNumber;$Lon_destination;$Lon_height)
C_LONGINT:C283($Lon_left;$Lon_parameters;$Lon_right;$Lon_top;$Lon_value;$Lon_width)
C_TEXT:C284($Dir_report;$File_path;$Txt_action;$Txt_currentTool;$Txt_object;$Txt_specific;$buttonOption)
C_OBJECT:C1216($Obj_param;$Obj_toolbar)

If (False:C215)
	C_TEXT:C284(NQR_TOOLBAR ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
	  //Optional parameters
	If ($Lon_parameters>=1)
		
		$Txt_action:=$1
		
	End if 
	
	$kLon_offset:=70  //height of the opened toolbar
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
Case of 
		
		  //______________________________________________________
	: (Length:C16($Txt_action)=0)
		
		  //NOTHING MORE TO DO
		
		  //______________________________________________________
	: ($Txt_action="init")
		
		ARRAY OBJECT:C1221($tObj_objects;0x0000)
		
		OB SET:C1220($Obj_toolbar;\
			"object";"toolbar.opened.new";\
			"type";"button";\
			"visible";True:C214)
		
		If (True:C214)
			
			  //display separated opup-menu
			OBJECT SET FORMAT:C236(*;"toolbar.opened.new";";;;;;;;;;;2;;")
			OB SET:C1220($Obj_toolbar;\
				"offset";10)
			
		End if 
		
		APPEND TO ARRAY:C911($tObj_objects;$Obj_toolbar)
		CLEAR VARIABLE:C89($Obj_toolbar)
		
		OB SET:C1220($Obj_toolbar;\
			"object";"toolbar.opened.open";\
			"type";"button";\
			"visible";True:C214)
		
		  // #28-6-2016
		$Dir_report:=Get 4D folder:C485(Current resources folder:K5:16;*)\
			+"reports"+Folder separator:K24:12
		
		If (Test path name:C476($Dir_report)=Is a folder:K24:2)
			
			  //display separated opup-menu
			OBJECT SET FORMAT:C236(*;"toolbar.opened.open";";;;;;;;;;;2;;")
			OB SET:C1220($Obj_toolbar;\
				"offset";30)
			
		End if 
		
		APPEND TO ARRAY:C911($tObj_objects;$Obj_toolbar)
		CLEAR VARIABLE:C89($Obj_toolbar)
		
		OB SET:C1220($Obj_toolbar;\
			"object";"toolbar.opened.save";\
			"type";"button";\
			"offset";30;\
			"visible";True:C214)
		
		
		  // button save is different according the report loaded/saved or created
		If ((Length:C16(C_QR_INITPATH)>0) & (Test path name:C476(C_QR_INITPATH)=Is a document:K24:1))
			$buttonOption:=";;;;;;;;;;2;;"
		Else 
			$buttonOption:=";;;;;;;;;;0;;"
		End if 
		OBJECT SET FORMAT:C236(*;"toolbar.opened.save";$buttonOption)
		
		
		APPEND TO ARRAY:C911($tObj_objects;$Obj_toolbar)
		CLEAR VARIABLE:C89($Obj_toolbar)
		
		OB SET:C1220($Obj_toolbar;\
			"object";"toolbar.opened.destination";\
			"type";"button";\
			"visible";True:C214)
		APPEND TO ARRAY:C911($tObj_objects;$Obj_toolbar)
		CLEAR VARIABLE:C89($Obj_toolbar)
		
		OB SET:C1220($Obj_toolbar;\
			"object";"toolbar.opened.preview";\
			"type";"button";\
			"visible";True:C214)
		APPEND TO ARRAY:C911($tObj_objects;$Obj_toolbar)
		CLEAR VARIABLE:C89($Obj_toolbar)
		
		OB SET:C1220($Obj_toolbar;\
			"object";"toolbar.opened.run";\
			"type";"button";\
			"visible";True:C214)
		APPEND TO ARRAY:C911($tObj_objects;$Obj_toolbar)
		CLEAR VARIABLE:C89($Obj_toolbar)
		
		OB SET:C1220($Obj_toolbar;\
			"object";"toolbar.opened.sep.1";\
			"type";"separator";\
			"visible";True:C214)
		APPEND TO ARRAY:C911($tObj_objects;$Obj_toolbar)
		CLEAR VARIABLE:C89($Obj_toolbar)
		
		  //OB SET($Obj_toolbar;"object";"toolbar.opened.type";"type";"widget")
		  //APPEND TO ARRAY($tObj_objects;$Obj_buffer)
		  //CLEAR VARIABLE($Obj_toolbar)
		
		OB SET:C1220($Obj_toolbar;\
			"object";"toolbar.opened.data";\
			"type";"widget";\
			"visible";True:C214)
		APPEND TO ARRAY:C911($tObj_objects;$Obj_toolbar)
		CLEAR VARIABLE:C89($Obj_toolbar)
		
		OB SET:C1220($Obj_toolbar;\
			"object";"toolbar.opened.sep.2";\
			"type";"separator";\
			"visible";True:C214)
		APPEND TO ARRAY:C911($tObj_objects;$Obj_toolbar)
		CLEAR VARIABLE:C89($Obj_toolbar)
		
		OB SET:C1220($Obj_toolbar;\
			"object";"toolbar.opened.h&f";\
			"type";"widget";\
			"visible";True:C214)
		APPEND TO ARRAY:C911($tObj_objects;$Obj_toolbar)
		CLEAR VARIABLE:C89($Obj_toolbar)
		
		OB SET:C1220($Obj_toolbar;\
			"object";"toolbar.opened.sep.3";\
			"type";"separator";\
			"visible";True:C214)
		APPEND TO ARRAY:C911($tObj_objects;$Obj_toolbar)
		CLEAR VARIABLE:C89($Obj_toolbar)
		
		OB SET:C1220($Obj_toolbar;\
			"object";"toolbar.opened.graphic";\
			"type";"widget";\
			"visible";<>Boo_debug)
		APPEND TO ARRAY:C911($tObj_objects;$Obj_toolbar)
		CLEAR VARIABLE:C89($Obj_toolbar)
		
		OB SET:C1220($Obj_toolbar;\
			"object";"toolbar.opened.sep.4";\
			"type";"separator";\
			"visible";<>Boo_debug)
		APPEND TO ARRAY:C911($tObj_objects;$Obj_toolbar)
		CLEAR VARIABLE:C89($Obj_toolbar)
		
		OB SET:C1220($Obj_toolbar;\
			"object";"toolbar.opened.options";\
			"type";"button";\
			"visible";True:C214)
		APPEND TO ARRAY:C911($tObj_objects;$Obj_toolbar)
		CLEAR VARIABLE:C89($Obj_toolbar)
		
		  // #3-12-2015
		OB SET:C1220($Obj_toolbar;\
			"object";"toolbar.opened.fields";\
			"type";"button";\
			"visible";True:C214;\
			"align";On the right:K39:3)
		APPEND TO ARRAY:C911($tObj_objects;$Obj_toolbar)
		CLEAR VARIABLE:C89($Obj_toolbar)
		
		OB SET ARRAY:C1227($Obj_toolbar;"toolbar";$tObj_objects)
		CLEAR VARIABLE:C89($tObj_objects)
		
		  //available width
		OBJECT GET COORDINATES:C663(*;"toolbar.background";$Lon_left;$Lon_top;$Lon_right;$Lon_bottom)
		$Lon_width:=$Lon_right-$Lon_left
		OBJECT GET COORDINATES:C663(*;"toolbar.opened";$Lon_left;$Lon_top;$Lon_right;$Lon_bottom)
		$Lon_width:=$Lon_width-($Lon_right-$Lon_left)
		
		OB SET:C1220($Obj_toolbar;\
			"width";$Lon_width)
		
		ALIGN_OBJECTS ($Obj_toolbar)
		
		
		
		
		  //______________________________________________________
	: ($Txt_action="field.list")  //show/hide field list
		
		OBJECT GET COORDINATES:C663(*;"fieldList";$Lon_;$Lon_;$Lon_right;$Lon_)
		
		If (OBJECT Get visible:C1075(*;"fieldList"))  //hide
			
			OBJECT MOVE:C664(*;"myQR";-$Lon_right;0;$Lon_right)
			
			OBJECT SET VISIBLE:C603(*;"fieldList";False:C215)
			
			(OBJECT Get pointer:C1124(Object named:K67:5;"fields"))->:=0
			
		Else   //show
			
			OBJECT MOVE:C664(*;"myQR";$Lon_right;0;-$Lon_right)
			
			OBJECT SET VISIBLE:C603(*;"fieldList";True:C214)
			
			(OBJECT Get pointer:C1124(Object named:K67:5;"fields"))->:=1
			
		End if 
		
		OB SET:C1220($Obj_param;\
			"action";"update")
		NQR_AREA_HANDLE ($Obj_param)
		
		EXECUTE METHOD IN SUBFORM:C1085("myQR";"area_ADJUST")
		
		  //______________________________________________________
	: ($Txt_action="open")  //show toolbar
		
		OBJECT MOVE:C664(*;"QR_Line";0;$kLon_offset)
		OBJECT MOVE:C664(*;"fields";0;$kLon_offset)
		OBJECT MOVE:C664(*;"myQR";0;$kLon_offset;0;-$kLon_offset)
		OBJECT MOVE:C664(*;"fieldList";0;$kLon_offset;0;-$kLon_offset)
		OBJECT SET VISIBLE:C603(*;"toolbar.closed";False:C215)
		OBJECT SET VISIBLE:C603(*;"toolbar.opened@";True:C214)
		
		If (OBJECT Get visible:C1075(*;"plus.button"))
			
			OBJECT MOVE:C664(*;"plus.button";0;$kLon_offset)
			OBJECT MOVE:C664(*;"plus.line";0;$kLon_offset;0;-$kLon_offset)
			
		End if 
		
		OBJECT SET VISIBLE:C603(*;"toolbar.opened.tab.list";OBJECT Get visible:C1075(*;"fieldList"))
		
		EXECUTE METHOD IN SUBFORM:C1085("myQR";"area_ADJUST")
		
		
		
		  //______________________________________________________
	: ($Txt_action="close")  //hide toolbar
		
		OBJECT MOVE:C664(*;"QR_Line";0;-$kLon_offset)
		OBJECT MOVE:C664(*;"fields";0;-$kLon_offset)
		OBJECT MOVE:C664(*;"myQR";0;-$kLon_offset;0;$kLon_offset)
		OBJECT MOVE:C664(*;"fieldList";0;-$kLon_offset;0;$kLon_offset)
		OBJECT SET VISIBLE:C603(*;"toolbar.closed";True:C214)
		OBJECT SET VISIBLE:C603(*;"toolbar.opened@";False:C215)
		
		OBJECT SET VISIBLE:C603(*;"tool.@";False:C215)
		
		If (OBJECT Get visible:C1075(*;"plus.button"))
			
			OBJECT MOVE:C664(*;"plus.button";0;-$kLon_offset)
			OBJECT MOVE:C664(*;"plus.line";0;-$kLon_offset;0;$kLon_offset)
			
		End if 
		
		  //update geometry of the area
		EXECUTE METHOD IN SUBFORM:C1085("myQR";"area_ADJUST")
		
		  //release the panel's flag
		OB SET:C1220(ob_area;\
			"currentTool";"";\
			"stop";False:C215)
		
		  //______________________________________________________
	: ($Txt_action="unselect")
		
		OBJECT SET VISIBLE:C603(*;"tool.selected";False:C215)
		
		  //______________________________________________________
	: ($Txt_action="tool.@")  //opens/closes the additional panel
		
		If (OB Is defined:C1231(ob_area;"currentTool"))
			
			$Txt_currentTool:=OB Get:C1224(ob_area;"currentTool";Is text:K8:3)
			
		End if 
		
		If ($Txt_action="tool.header")\
			 | ($Txt_action="tool.footer")
			
			$Txt_object:="tool.headerAndFooter"
			$Boo_visible:=($Txt_action=$Txt_currentTool)
			
			If (OBJECT Get visible:C1075(*;$Txt_object)) & Not:C34($Boo_visible)
				
				(OBJECT Get pointer:C1124(Object named:K67:5;"tool.headerAndFooter"))->:=On Deactivate:K2:10
				
			End if 
			
		Else 
			
			$Txt_object:=$Txt_action
			$Boo_visible:=OBJECT Get visible:C1075(*;$Txt_object)
			
		End if 
		
		  //hide all tools
		OBJECT SET VISIBLE:C603(*;"tool.@";False:C215)
		
		  //show the plus objects if any
		OBJECT SET VISIBLE:C603(*;"plus@";(QR Count columns:C764(QR_area)=0) & $Boo_visible)
		
		QR GET DESTINATION:C756(QR_area;$Lon_destination)
		
		If ($Boo_visible)
			
			  //release the panel's flag
			OB SET:C1220(ob_area;\
				"currentTool";"";\
				"stop";False:C215)
			
			(OBJECT Get pointer:C1124(Object named:K67:5;"toolbar.opened.h&f"))->:=Choose:C955($Lon_destination=qr printer:K14903:1;0;-1)
			
			  //display activated UI
			OBJECT SET ENABLED:C1123(*;"toolbar.@.new";True:C214)
			OBJECT SET ENABLED:C1123(*;"toolbar.@.open";True:C214)
			OBJECT SET ENABLED:C1123(*;"toolbar.@.run";True:C214)
			OBJECT SET ENABLED:C1123(*;"toolbar.@.fields";True:C214)
			OBJECT SET ENABLED:C1123(*;"toolbar.@.preview";True:C214)
			
			OBJECT SET ENABLED:C1123(*;"toolbar.@.options";$Lon_destination#qr 4D View area:K14903:3)
			
			If ($Txt_object="tool.templates")\
				 | ($Txt_object="tool.borders")
				
				EXECUTE METHOD IN SUBFORM:C1085("toolbar.opened.graphic";"NQR_TOOLBAR";*;"unselect")
				
			End if 
			
		Else 
			
			  //set the panel's flag
			OB SET:C1220(ob_area;\
				"currentTool";$Txt_action;\
				"stop";True:C214)
			
			$Boo_visible:=(OBJECT Get visible:C1075(*;$Txt_object))
			
			OBJECT SET VISIBLE:C603(*;$Txt_object;True:C214)
			
			If ($Txt_object#"tool.headerAndFooter")\
				 & ($Txt_object#"tool.templates")
				
				OBJECT GET COORDINATES:C663(*;OBJECT Get name:C1087(Object current:K67:2);$Lon_left;$Lon_top;$Lon_right;$Lon_bottom)
				$Lon_height:=$Lon_bottom-$Lon_top
				
				If ($Lon_height<40)
					
					OBJECT SET COORDINATES:C1248(*;"tool.selected";$Lon_left-20;$Lon_top-5;$Lon_right+20;$Lon_bottom+5)
					
				Else 
					
					OBJECT SET COORDINATES:C1248(*;"tool.selected";$Lon_left-2;$Lon_top-10;$Lon_right+2;$Lon_bottom)
					
				End if 
				
				OBJECT SET VISIBLE:C603(*;"tool.selected";True:C214)
				
			End if 
			
			Case of 
					
					  //………………………………………………………………………………………
				: ($Txt_action="tool.destination")
					
					(OBJECT Get pointer:C1124(Object named:K67:5;"toolbar.opened.h&f"))->:=Choose:C955($Lon_destination=qr printer:K14903:1;0;-1)
					EXECUTE METHOD IN SUBFORM:C1085($Txt_object;"NQR_TOOLBAR";*;"set destination")
					
					  //………………………………………………………………………………………
				: ($Txt_action="tool.header")
					
					(OBJECT Get pointer:C1124(Object named:K67:5;"toolbar.opened.h&f"))->:=1
					EXECUTE METHOD IN SUBFORM:C1085($Txt_object;"NQR_GET_HEADER_AND_FOOTER";*;1)
					
					  //………………………………………………………………………………………
				: ($Txt_action="tool.footer")
					
					(OBJECT Get pointer:C1124(Object named:K67:5;"toolbar.opened.h&f"))->:=2
					EXECUTE METHOD IN SUBFORM:C1085($Txt_object;"NQR_GET_HEADER_AND_FOOTER";*;2)
					
					  //………………………………………………………………………………………
				: ($Txt_action="tool.options")
					
					(OBJECT Get pointer:C1124(Object named:K67:5;"toolbar.opened.h&f"))->:=Choose:C955($Lon_destination=qr printer:K14903:1;0;-1)
					EXECUTE METHOD IN SUBFORM:C1085($Txt_object;"NQR_TOOLBAR";*;"display options")
					
					  //Offsets of the widget
					subform_SET_OFFSET ("tool.options")
					
					  //………………………………………………………………………………………
			End case 
			
			  //display inactivated UI
			OBJECT SET VISIBLE:C603(*;"tool.mask.@";True:C214)
			OBJECT SET ENABLED:C1123(*;"toolbar.@.new";False:C215)
			OBJECT SET ENABLED:C1123(*;"toolbar.@.open";False:C215)
			OBJECT SET ENABLED:C1123(*;"toolbar.@.run";False:C215)
			OBJECT SET ENABLED:C1123(*;"toolbar.@.preview";False:C215)
			OBJECT SET ENABLED:C1123(*;"toolbar.@.fields";False:C215)
			
			If ($Txt_object#"tool.templates")\
				 & ($Txt_object#"tool.borders")
				
				EXECUTE METHOD IN SUBFORM:C1085("toolbar.opened.graphic";"NQR_TOOLBAR";*;"unselect")
				
			End if 
			
			GOTO OBJECT:C206(*;$Txt_object)
			
		End if 
		
		NQR_TOOLBAR ("update")
		
		  //______________________________________________________
	: ($Txt_action="display options")
		
		If (QR_area#0)
			
			QR GET DESTINATION:C756(QR_area;$Lon_destination;$Txt_specific)
			
		Else 
			
			$Lon_destination:=1
			
		End if 
		
		  //update will done during the On page change event
		FORM GOTO PAGE:C247($Lon_destination;*)
		
		  //______________________________________________________
	: ($Txt_action="set destination")
		
		If (QR_area#0)
			
			QR GET DESTINATION:C756(QR_area;$Lon_destination;$File_path)
			
		End if 
		
		  //printer is selected by default or for the obsolete destination to 4D Chart
		$Txt_object:=Choose:C955($Lon_destination;"printer";"printer";"file";"4Dview";"printer";"html")
		
		OBJECT GET COORDINATES:C663(*;$Txt_object;$Lon_left;$Lon_top;$Lon_right;$Lon_bottom)
		OBJECT SET COORDINATES:C1248(*;"select";$Lon_left-4;$Lon_top-4;$Lon_right+4;$Lon_bottom+4)
		
		  //______________________________________________________
	: (QR_area=0)
		
		  //NOTHING MORE TO DO
		
		  //______________________________________________________
	: ($Txt_action="update")
		
		  // button save is different according the report loaded/saved or created
		NQR_TOOLBAR ("init")
		
		
		
		  //run
		If (OB Is defined:C1231(ob_area;"qrColumnNumber"))
			
			$Lon_columnNumber:=OB Get:C1224(ob_area;"qrColumnNumber";Is longint:K8:6)
			
		End if 
		
		$Boo_enabled:=(C_QR_MASTERTABLE#0)
		
		  //test if there is at least
		  //    - one record in the selection
		  //    - and one column
		
		
		
		If ($Boo_enabled)
			
			$Boo_enabled:=(Records in selection:C76(Table:C252(C_QR_MASTERTABLE)->)>0)\
				 & ($Lon_columnNumber>0)
			
		End if 
		
		OBJECT SET ENABLED:C1123(*;"toolbar.opened.run";$Boo_enabled)
		
		  //disable preview for all.
		  //will be enabled if any
		OBJECT SET ENABLED:C1123(*;"toolbar.opened.preview";False:C215)
		
		  //header & footer
		QR GET DESTINATION:C756(QR_area;$Lon_destination)
		
		Case of 
				
				  //-----------------------------
			: ($Lon_destination=qr text file:K14903:2)
				
				  //disable header and footer
				(OBJECT Get pointer:C1124(Object named:K67:5;"toolbar.opened.h&f"))->:=-1
				
				  //-----------------------------
			: ($Lon_destination=qr printer:K14903:1)
				
				  //enable header and footer
				(OBJECT Get pointer:C1124(Object named:K67:5;"toolbar.opened.h&f"))->:=0
				
				  //not available if no printer
				If ($Boo_enabled)
					
					ARRAY TEXT:C222($tTxt_printers;0x0000)
					PRINTERS LIST:C789($tTxt_printers)
					
					$Boo_enabled:=(Size of array:C274($tTxt_printers)>0)
					
				End if 
				
				  //enable preview if any
				OBJECT SET ENABLED:C1123(*;"toolbar.opened.preview";$Boo_enabled)
				
				  //-----------------------------
			: ($Lon_destination=qr HTML file:K14903:5)
				
				  //disable header and footer
				(OBJECT Get pointer:C1124(Object named:K67:5;"toolbar.opened.h&f"))->:=-1
				
				  //-----------------------------
			: ($Lon_destination=qr 4D View area:K14903:3)
				
				  //disable header and footer
				(OBJECT Get pointer:C1124(Object named:K67:5;"toolbar.opened.h&f"))->:=-1
				
				  //-----------------------------
		End case 
		
		  //clear & reload
		If (OB Is defined:C1231(ob_area;"modified"))
			
			$Boo_modified:=OB Get:C1224(ob_area;"modified";Is boolean:K8:9)
			
		End if 
		
		  //clear
		If ($Lon_columnNumber>0)
			
			$Lon_value:=$Lon_value ?+ 1  //2
			
		End if 
		
		  //reload
		$Boo_enabled:=(Length:C16(C_QR_INITPATH)>0)\
			 & (Test path name:C476(C_QR_INITPATH)=Is a document:K24:1)
		
		If ($Boo_enabled)
			
			$Lon_value:=$Lon_value ?+ 2  //6
			
		End if 
		
		(OBJECT Get pointer:C1124(Object named:K67:5;"toolbar.opened.data"))->:=$Lon_value
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Unknown entry point: \""+$Txt_action+"\"")
		
		  //______________________________________________________
End case 

  //always visible objects
If ($Txt_action#"close")
	
	OBJECT SET VISIBLE:C603(*;"toolbar.opened.tab.list";OBJECT Get visible:C1075(*;"fieldList"))
	
End if 

  //*******************************************************
  //UNAVALAIBLE FEATURES
OBJECT SET VISIBLE:C603(*;"toolbar.opened.sep.4";<>Boo_debug & OBJECT Get visible:C1075(*;"toolbar.opened.new"))

  //*******************************************************

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End