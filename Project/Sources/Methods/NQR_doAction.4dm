//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : NQR_DoAction
  // Created #26-4-2019 by Adrien Cagniant
  // ----------------------------------------------------
  // Declarations

C_LONGINT:C283($1;$lon_command)
C_OBJECT:C1216($Obj_param)

If (False:C215)
	C_LONGINT:C283(NQR_doAction ;$1)
End if 

$lon_command:=$1


Case of 
	: ($lon_command=qr cmd save:K14900:20)
		
		NQR_Save 
		OB SET:C1220($Obj_param;\
			"action";"update")
		NQR_AREA_HANDLE ($Obj_param)
		
	: ($lon_command=qr cmd save as:K14900:21)
		
		NQR_SaveAs 
		OB SET:C1220($Obj_param;\
			"action";"update")
		NQR_AREA_HANDLE ($Obj_param)
		
	: ($lon_command=qr cmd open:K14900:19)
		
		NQR_OPEN 
		OB SET:C1220($Obj_param;\
			"action";"update")
		NQR_AREA_HANDLE ($Obj_param)
		
	: ($lon_command=qr cmd print preview:K14900:25)
		
		NQR_PREVIEW 
		OB SET:C1220($Obj_param;\
			"action";"update")
		NQR_AREA_HANDLE ($Obj_param)
		
	: ($lon_command=qr cmd page setup:K14900:24)
		
		NQR_PAGESETUP 
		OB SET:C1220($Obj_param;\
			"action";"update")
		NQR_AREA_HANDLE ($Obj_param)
		
		
	: ($lon_command=qr cmd generate:K14900:26)
		
		NQR_GENERATE 
		OB SET:C1220($Obj_param;\
			"action";"update")
		NQR_AREA_HANDLE ($Obj_param)
		
		
End case 
