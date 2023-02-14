//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : db_Get_field_icon
// Database: 4D Labels
// ID[9F0A61180A124453B4BADD6790E89677]
// Created #15-12-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations

#DECLARE($type : Integer)->$icon : Picture



var \
$count_parameters : Integer


var \
$file_path; \
$file_name; \
$folder_path : Text


If (False:C215)
	C_PICTURE:C286(db_Get_field_icon; $0)
	C_LONGINT:C283(db_Get_field_icon; $1)
End if 

// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=1; "Missing parameter"))
	
	//Required parameters
	//$type:=$1
	
	//Optional parameters
	If ($count_parameters>=2)
		
		// <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
Case of 
		
		//________________________________________
	: ($type=Is alpha field:K8:1)  //0
		
		$file_name:="Field_1.png"
		
		//________________________________________
	: ($type=Is text:K8:3)  //2
		
		$file_name:="Field_2.png"
		
		//________________________________________
	: ($type=Is date:K8:7)  //4
		
		$file_name:="Field_3.png"
		
		//________________________________________
	: ($type=Is time:K8:8)  //11
		
		$file_name:="Field_4.png"
		
		//________________________________________
	: ($type=Is boolean:K8:9)  //6
		
		$file_name:="Field_5.png"
		
		//________________________________________
	: ($type=Is integer:K8:5)  //8
		
		$file_name:="Field_6.png"
		
		//________________________________________
	: ($type=Is longint:K8:6)  //9
		
		$file_name:="Field_7.png"
		
		//________________________________________
	: ($type=Is integer 64 bits:K8:25)  //25
		
		$file_name:="Field_8.png"
		
		//________________________________________
	: ($type=Is real:K8:4)  //1
		
		$file_name:="Field_9.png"
		
		//________________________________________
	: ($type=_o_Is float:K8:26)  //35
		
		$file_name:="Field_10.png"
		
		//________________________________________
	: ($type=Is BLOB:K8:12)  //30
		
		$file_name:="Field_11.png"
		
		//________________________________________
	: ($type=Is picture:K8:10)  //3
		
		$file_name:="Field_12.png"
		
		//________________________________________
	: ($type=Is subtable:K8:11)  //7
		
		$file_name:="Field_13.png"
		
		//________________________________________
	: ($type=Is object:K8:27)  //38
		
		$file_name:="Field_14.png"
		
		//________________________________________
End case 

//get the 4D resource
$folder_path:=env_4D_Resources_folder_path+"images"+Folder separator:K24:12+"StructureEditor"+Folder separator:K24:12

$file_name:=Replace string:C233($file_name; ".png"; Choose:C955(FORM Get color scheme:C1761="light"; ".png"; "_dark.png"))

$file_path:=$folder_path+$file_name

If (Test path name:C476($file_path)=Is a document:K24:1)
	
	READ PICTURE FILE:C678($file_path; $icon)
	
End if 

// ----------------------------------------------------
// Return
//$0:=$icon

// ----------------------------------------------------
// End