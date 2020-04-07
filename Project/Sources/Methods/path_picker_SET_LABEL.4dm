//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : path_picker_SET_LABEL
  // ID[F366056285464A5390A355AA354BA923]
  // Created #10-9-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_POINTER:C301($1)

C_LONGINT:C283($Lon_parameters;$Lon_platform;$Lon_size)
C_POINTER:C301($Ptr_widget)
C_TEXT:C284($kTxt_Separator;$Txt_Buffer;$Txt_File;$Txt_lastPath;$Txt_path;$Txt_Volume)
C_OBJECT:C1216($Obj_widget)

If (False:C215)
	C_POINTER:C301(path_picker_SET_LABEL ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	  //Required parameters
	$Ptr_widget:=$1
	
	$Obj_widget:=JSON Parse:C1218($Ptr_widget->)
	
	  //Optional parameters
	If ($Lon_parameters>=2)
		
		  // <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
$Txt_path:=OB Get:C1224($Obj_widget;"accessPath";Is text:K8:3)
$Txt_lastPath:=OB Get:C1224($Obj_widget;"_lastPath";Is text:K8:3)

If ($Txt_path#$Txt_lastPath)
	
	$Lon_size:=Length:C16($Txt_path)
	
	If ($Lon_size>0)
		
		  // C/S mode on Mac the path could be in Windows mode if server run on PC
		  // E:\Backup Base Rezs v11\Ressources_4D_v11[0373].4BK
		_O_PLATFORM PROPERTIES:C365($Lon_platform)
		
		Case of 
				
				  //……………………………………………………………………………………………………………………
			: (Application type:C494=4D Remote mode:K5:5)\
				 & ($Lon_platform=Mac OS:K25:2)\
				 & (Position:C15("\\";$Txt_path)>0)
				
				$kTxt_Separator:="\\"
				
				  //……………………………………………………………………………………………………………………
			: (Application type:C494=4D Remote mode:K5:5)\
				 & ($Lon_platform=Windows:K25:3)\
				 & (Position:C15(":";Replace string:C233($Txt_path;":";"";1))>0)
				
				$kTxt_Separator:=":"
				
				  //……………………………………………………………………………………………………………………
			Else 
				
				$kTxt_Separator:=Folder separator:K24:12
				
				  //……………………………………………………………………………………………………………………
		End case 
		
		$Txt_Volume:=Replace string:C233(doc_volumeName ($Txt_path);$kTxt_Separator;"")
		$Txt_File:=Replace string:C233(doc_getFromPath ("fullName";$Txt_path;$kTxt_Separator);$kTxt_Separator;"")
		
		If ($Txt_File#$Txt_Volume)
			
			$Txt_Buffer:=Replace string:C233(Get localized string:C991("FileInVolume");"{file}";$Txt_File)
			$Txt_Buffer:=Replace string:C233($Txt_Buffer;"{volume}";$Txt_Volume)
			
		Else 
			
			$Txt_Buffer:="\""+$Txt_File+"\""
			
		End if 
		
		OBJECT SET VISIBLE:C603(*;"plus";True:C214)
		
	Else 
		
		CLEAR VARIABLE:C89($Txt_buffer)
		OBJECT SET VISIBLE:C603(*;"plus";False:C215)
		
	End if 
	
	  //store the current path value
	OB SET:C1220($Obj_widget;\
		"_lastPath";$Txt_path)
	
	$Ptr_widget->:=JSON Stringify:C1217($Obj_widget)
	
	(OBJECT Get pointer:C1124(Object named:K67:5;"accessPath"))->:=$Txt_buffer
	
End if 

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End