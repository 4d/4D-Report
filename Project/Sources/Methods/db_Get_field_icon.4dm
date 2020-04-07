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
C_PICTURE:C286($0)
C_LONGINT:C283($1)

C_LONGINT:C283($Lon_fieldType;$Lon_parameters)
C_PICTURE:C286($Pic_icon)
C_TEXT:C284($File_path;$Txt_imageFile;$Txt_root)

If (False:C215)
	C_PICTURE:C286(db_Get_field_icon ;$0)
	C_LONGINT:C283(db_Get_field_icon ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	  //Required parameters
	$Lon_fieldType:=$1
	
	  //Optional parameters
	If ($Lon_parameters>=2)
		
		  // <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
Case of 
		
		  //________________________________________
	: ($Lon_fieldType=Is alpha field:K8:1)  //0
		
		$Txt_imageFile:="Field_1.png"
		
		  //________________________________________
	: ($Lon_fieldType=Is text:K8:3)  //2
		
		$Txt_imageFile:="Field_2.png"
		
		  //________________________________________
	: ($Lon_fieldType=Is date:K8:7)  //4
		
		$Txt_imageFile:="Field_3.png"
		
		  //________________________________________
	: ($Lon_fieldType=Is time:K8:8)  //11
		
		$Txt_imageFile:="Field_4.png"
		
		  //________________________________________
	: ($Lon_fieldType=Is boolean:K8:9)  //6
		
		$Txt_imageFile:="Field_5.png"
		
		  //________________________________________
	: ($Lon_fieldType=Is integer:K8:5)  //8
		
		$Txt_imageFile:="Field_6.png"
		
		  //________________________________________
	: ($Lon_fieldType=Is longint:K8:6)  //9
		
		$Txt_imageFile:="Field_7.png"
		
		  //________________________________________
	: ($Lon_fieldType=Is integer 64 bits:K8:25)  //25
		
		$Txt_imageFile:="Field_8.png"
		
		  //________________________________________
	: ($Lon_fieldType=Is real:K8:4)  //1
		
		$Txt_imageFile:="Field_9.png"
		
		  //________________________________________
	: ($Lon_fieldType=Is float:K8:26)  //35
		
		$Txt_imageFile:="Field_10.png"
		
		  //________________________________________
	: ($Lon_fieldType=Is BLOB:K8:12)  //30
		
		$Txt_imageFile:="Field_11.png"
		
		  //________________________________________
	: ($Lon_fieldType=Is picture:K8:10)  //3
		
		$Txt_imageFile:="Field_12.png"
		
		  //________________________________________
	: ($Lon_fieldType=Is subtable:K8:11)  //7
		
		$Txt_imageFile:="Field_13.png"
		
		  //________________________________________
	: ($Lon_fieldType=Is object:K8:27)  //38
		
		$Txt_imageFile:="Field_14.png"
		
		  //________________________________________
End case 

  //get the 4D resource
$Txt_root:=env_4D_Resources_folder_path +"images"+Folder separator:K24:12+"StructureEditor"+Folder separator:K24:12

$File_path:=$Txt_root+$Txt_imageFile

If (Test path name:C476($File_path)=Is a document:K24:1)
	
	READ PICTURE FILE:C678($File_path;$Pic_icon)
	
End if 

  // ----------------------------------------------------
  // Return
$0:=$Pic_icon

  // ----------------------------------------------------
  // End