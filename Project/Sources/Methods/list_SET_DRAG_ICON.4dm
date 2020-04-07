//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : list_SET_DRAG_ICON
  // Database: 4D Report
  // ID[0A275F729D114C94BB7F3036E2C569E0]
  // Created #9-12-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_POINTER:C301($1)

C_BLOB:C604($Blb_buffer)
C_BOOLEAN:C305($Boo_;$Boo_vertical)
C_LONGINT:C283($Lon_;$Lon_height;$Lon_hOffset;$Lon_left;$Lon_mouseX;$Lon_mouseY)
C_LONGINT:C283($Lon_parameters;$Lon_ref;$Lon_right;$Lon_vOffset;$Lon_width)
C_PICTURE:C286($Pic_drag;$Pic_icon)
C_POINTER:C301($Ptr_list)
C_TEXT:C284($Dom_svg;$Txt_buffer;$Txt_label;$Txt_SVG)

If (False:C215)
	C_POINTER:C301(list_SET_DRAG_ICON ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	  //Required parameters
	$Ptr_list:=$1
	
	  //Optional parameters
	If ($Lon_parameters>=2)
		
		  //<NONE>
		
	End if 
	
	GET MOUSE:C468($Lon_mouseX;$Lon_mouseY;$Lon_)
	CONVERT COORDINATES:C1365($Lon_mouseX;$Lon_mouseY;XY Current window:K27:6;XY Current form:K27:5)
	
	GET LIST ITEM:C378($Ptr_list->;*;$Lon_ref;$Txt_label)
	GET LIST ITEM ICON:C951($Ptr_list->;$Lon_ref;$Pic_icon)
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
$Txt_SVG:="<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\" ?>"\
+"<svg xmlns=\"http://www.w3.org/2000/svg\" viewport-fill=\"lightskyblue\" viewport-fill-opacity=\"1\" xmlns:xlink=\"http://www.w3.org/1999/xlink\">"\
+"<image height=\"16\" width=\"16\" x=\"2\" xlink:href=\"data:;base64,{icon}\" y=\"2\"/>"\
+"<text fill=\"black\" font-family=\"'Lucida Grande','Segoe UI'\" font-size=\"12\" x=\"20\" y=\"14\">{label}</text>"\
+"</svg>\r"

  //set the label
$Txt_SVG:=Replace string:C233($Txt_SVG;"{label}";$Txt_label)

  //set the icon
PICTURE TO BLOB:C692($Pic_icon;$Blb_buffer;".png")
BASE64 ENCODE:C895($Blb_buffer;$Txt_buffer)
CLEAR VARIABLE:C89($Blb_buffer)

$Txt_SVG:=Replace string:C233($Txt_SVG;"{icon}";$Txt_buffer)

$Dom_svg:=DOM Parse XML variable:C720($Txt_SVG)
CLEAR VARIABLE:C89($Txt_SVG)

If (OK=1)
	
	  //set the viewbox dimensions…
	If (False:C215)
		
		  //…according to the content
		SVG EXPORT TO PICTURE:C1017($Dom_svg;$Pic_drag;Get XML data source:K45:16)
		
		PICTURE PROPERTIES:C457($Pic_drag;$Lon_width;$Lon_height)
		$Lon_width:=$Lon_width+4
		$Lon_height:=$Lon_height+2
		
	Else 
		
		  //…according to the source list
		OBJECT GET COORDINATES:C663($Ptr_list->;$Lon_left;$Lon_;$Lon_right;$Lon_)
		$Lon_hOffset:=$Lon_mouseX-$Lon_left
		
		OBJECT GET SCROLLBAR:C1076($Ptr_list->;$Boo_;$Boo_vertical)
		$Lon_width:=$Lon_right-$Lon_left-(19*Num:C11($Boo_vertical))
		
		GET LIST PROPERTIES:C632($Ptr_list->;$Lon_;$Lon_;$Lon_height)
		$Lon_height:=$Lon_height+2
		$Lon_vOffset:=$Lon_height\2
	End if 
	
	DOM SET XML ATTRIBUTE:C866($Dom_svg;\
		"viewBox";"0 0 "+String:C10($Lon_width)+" "+String:C10($Lon_height))
	
	SVG EXPORT TO PICTURE:C1017($Dom_svg;$Pic_drag;Own XML data source:K45:18)
	
End if 

SET DRAG ICON:C1272($Pic_drag;$Lon_hOffset;$Lon_vOffset)

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End