//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : NQR_DO_IT
// Database: 4D Report
// ID[05A26E50F85D4B9098F89FF325582196]
// Created #20-1-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_OBJECT:C1216($1)

C_BOOLEAN:C305($Boo_OK)
C_LONGINT:C283($Lon_hidden; $Lon_i; $Lon_parameters; $Lon_repeated; $Lon_sortNumber; $Lon_width)
C_TEXT:C284($Txt_backup; $Txt_format; $Txt_object; $Txt_title)
C_OBJECT:C1216($Obj_in)

If (False:C215)
	C_OBJECT:C1216(NQR_DO_IT; $1)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1; "Missing parameter"))
	
	// Required parameters
	$Obj_in:=$1
	
	// Optional parameters
	If ($Lon_parameters>=2)
		
		// <NONE>
		
	End if 
	
	// Remove message's flag
	OB REMOVE:C1226(ob_area; "message")
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------


Case of 
		
		//______________________________________________________
	: ($Obj_in.action="cancel")
		
		// NOTHING MORE TO DO
		
		//______________________________________________________
	: ($Obj_in.src="new")
		
		Case of 
				
				//______________________________________________________
			: ($Obj_in.action="none")\
				 | ($Obj_in.action="forget")
				
				$Boo_OK:=True:C214
				
				//……………………………………………………………
			: ($Obj_in.action="ok")
				
				If (Bool:C1537($Obj_in.checkbox))
					
					// Option: Save in a new document
					$Txt_backup:=C_QR_INITPATH
					CLEAR VARIABLE:C89(C_QR_INITPATH)
					
					If (C_QR_ONCOMMANDFORMULA#Null:C1517)
						
						C_QR_ONCOMMANDFORMULA.call(Null:C1517; QR_area; qr cmd save as:K14900:21)
						$Boo_OK:=True:C214
						
					Else 
						
						$Boo_OK:=NQR_SaveAs
						
					End if 
					
					If (Not:C34($Boo_OK))  // The user cancelled
						
						C_QR_INITPATH:=$Txt_backup
						
					End if 
					
				Else 
					
					If (C_QR_ONCOMMANDFORMULA#Null:C1517)
						
						C_QR_ONCOMMANDFORMULA.call(Null:C1517; QR_area; qr cmd save:K14900:20)
						$Boo_OK:=True:C214
						
					Else 
						
						$Boo_OK:=NQR_Save
						
					End if 
				End if 
				
				//……………………………………………………………
		End case 
		
		// Create a new report if any
		If ($Boo_OK)
			
			NQR_NEW(Choose:C955(Num:C11($Obj_in.type)=0; qr list report:K14902:1; $Obj_in.type))
			
		End if 
		
		//______________________________________________________
	: ($Obj_in.src="open")
		
		Case of 
				
				//______________________________________________________
			: ($Obj_in.action="none")\
				 | ($Obj_in.action="forget")
				
				$Boo_OK:=True:C214
				
				//……………………………………………………………
			: ($Obj_in.action="ok")
				
				
				If (Bool:C1537($Obj_in.checkbox))
					
					// Option: Save in a new document
					$Txt_backup:=C_QR_INITPATH
					CLEAR VARIABLE:C89(C_QR_INITPATH)
					
					If (C_QR_ONCOMMANDFORMULA#Null:C1517)
						
						
						C_QR_ONCOMMANDFORMULA.call(Null:C1517; QR_area; qr cmd save as:K14900:21)
						
					Else 
						
						$Boo_OK:=NQR_SaveAs
						
					End if 
					
					If (Not:C34($Boo_OK))  // The user cancelled
						
						C_QR_INITPATH:=$Txt_backup
						
					End if 
					
				Else 
					// Option: Save in opened document
					
					If (C_QR_ONCOMMANDFORMULA#Null:C1517)
						
						C_QR_ONCOMMANDFORMULA.call(Null:C1517; QR_area; qr cmd save:K14900:20)
						
					Else 
						
						$Boo_OK:=NQR_Save
						
					End if 
				End if 
				
				//……………………………………………………………
		End case 
		
		// Open a report if any
		If ($Boo_OK)
			
			If (C_QR_ONCOMMANDFORMULA#Null:C1517)
				
				C_QR_ONCOMMANDFORMULA.call(Null:C1517; QR_area; qr cmd open:K14900:19)
				
			Else 
				
				NQR_OPEN($Obj_in)
				
			End if 
		End if 
		
		//______________________________________________________
	: ($Obj_in.src="clear")
		
		Case of 
				
				//……………………………………………………………
			: ($Obj_in.action="ok")
				
				NQR_CLEAR
				
				//……………………………………………………………
		End case 
		
		//______________________________________________________
	: ($Obj_in.src="reload")
		
		Case of 
				
				//……………………………………………………………
			: ($Obj_in.action="ok")
				
				NQR_RELOAD
				
				//……………………………………………………………
		End case 
		
		//______________________________________________________
	: ($Obj_in.src="quit")
		
		Case of 
				
				//______________________________________________________
			: ($Obj_in.action="none")
				
				$Boo_OK:=True:C214
				
				//______________________________________________________
			: ($Obj_in.action="forget")
				
				NQR_RELOAD
				
				$Boo_OK:=True:C214
				
				//……………………………………………………………
			: ($Obj_in.action="ok")
				
				If (Bool:C1537($Obj_in.checkbox))
					
					// Option: Save in a new document
					$Txt_backup:=C_QR_INITPATH
					CLEAR VARIABLE:C89(C_QR_INITPATH)
					
					If (C_QR_ONCOMMANDFORMULA#Null:C1517)
						
						C_QR_ONCOMMANDFORMULA.call(Null:C1517; QR_area; qr cmd save as:K14900:21)
						$Boo_OK:=True:C214
						
					Else 
						
						$Boo_OK:=NQR_SaveAs
						
					End if 
					
					If (Not:C34($Boo_OK))  // The user cancelled
						
						C_QR_INITPATH:=$Txt_backup
						
					End if 
					
				Else 
					
					If (C_QR_ONCOMMANDFORMULA#Null:C1517)
						
						C_QR_ONCOMMANDFORMULA.call(Null:C1517; QR_area; qr cmd save:K14900:20)
						$Boo_OK:=True:C214
						
					Else 
						
						$Boo_OK:=NQR_Save
						
					End if 
				End if 
				
				//……………………………………………………………
		End case 
		
		// Close the dialog if any
		If ($Boo_OK)
			
			CANCEL:C270
			
		End if 
		
		//______________________________________________________
	: ($Obj_in.src="delete-breakline")
		
		Case of 
				
				//……………………………………………………………
			: ($Obj_in.action="forget")  // Hide
				
				QR SET INFO ROW:C763(ob_area.area; ob_area.qrRow; 1)
				
				//……………………………………………………………
			: ($Obj_in.action="ok")  // Delete
				
				ARRAY LONGINT:C221($tLon_sortedColumns; 0x0000)
				ARRAY LONGINT:C221($tLon_sortOrder; 0x0000)
				QR GET SORTS:C753(ob_area.area; $tLon_sortedColumns; $tLon_sortOrder)
				
				$Lon_sortNumber:=Size of array:C274($tLon_sortedColumns)
				
				// The sort order is inverted !
				ARRAY LONGINT:C221($tLon_order; $Lon_sortNumber)
				
				For ($Lon_i; 1; $Lon_sortNumber; 1)
					
					$tLon_order{$Lon_i}:=$Lon_i
					
				End for 
				
				SORT ARRAY:C229($tLon_order; $tLon_sortOrder; $tLon_sortedColumns; <)
				
				DELETE FROM ARRAY:C228($tLon_sortedColumns; ob_area.qrRow; 1)
				DELETE FROM ARRAY:C228($tLon_sortOrder; ob_area.qrRow; 1)
				
				// Restore the order
				SORT ARRAY:C229($tLon_order; $tLon_sortOrder; $tLon_sortedColumns; >)
				
				QR SET SORTS:C752(ob_area.area; $tLon_sortedColumns; $tLon_sortOrder)
				
				//……………………………………………………………
		End case 
		
		ob_area.modified:=True:C214
		
		//______________________________________________________
	: ($Obj_in.src="delete-column")
		
		Case of 
				
				//……………………………………………………………
			: ($Obj_in.action="forget")  // Hide
				
				QR GET INFO COLUMN:C766(ob_area.area; ob_area.qrColumn; $Txt_title; $Txt_object; $Lon_hidden; $Lon_width; $Lon_repeated; $Txt_format)
				QR SET INFO COLUMN:C765(ob_area.area; ob_area.qrColumn; $Txt_title; $Txt_object; 1; $Lon_width; $Lon_repeated; $Txt_format)
				
				//……………………………………………………………
			: ($Obj_in.action="ok")  // Delete
				
				QR DELETE COLUMN:C749(ob_area.area; ob_area.qrColumn)
				
				//……………………………………………………………
		End case 
		
		ob_area.modified:=True:C214
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Unknown entry point: \""+String:C10($Obj_in.src)+"\"")
		
		//______________________________________________________
End case 

// Store "do not ask again" preference if any
If (Bool:C1537($Obj_in.checkbox))\
 & ($Obj_in.action="ok")
	
	// Save user's preference
	mess_Preferences($Obj_in.src; "SET")
	
End if 

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End

