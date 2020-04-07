  // ----------------------------------------------------
  // Object method : %report.header_action - (4D Report)
  // ID[6D926711A24240BB82AD70122992B8C3]
  // Created #4-6-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_BOOLEAN:C305($Boo_opened)
C_LONGINT:C283($Lon_area;$Lon_columnIndex;$Lon_formEvent;$Lon_hOffset;$Lon_qrColumn;$Lon_qrRow)
C_LONGINT:C283($Lon_rowIndex;$Lon_vOffset)
C_POINTER:C301($Ptr_me)
C_TEXT:C284($Txt_form;$Txt_me)
C_OBJECT:C1216($Obj_param)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388
$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)
$Ptr_me:=OBJECT Get pointer:C1124(Object current:K67:2)

  // ----------------------------------------------------
Case of 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Mouse Enter:K2:33)\
		 | ($Lon_formEvent=On Mouse Move:K2:35)
		
		OBJECT SET VISIBLE:C603(*;"header_action";True:C214)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Clicked:K2:4)
		
		If (OB Is defined:C1231(ob_area;"balloon"))
			
			$Boo_opened:=OB Get:C1224(ob_area;"balloon";Is boolean:K8:9)
			
		End if 
		
		If ($Boo_opened)
			
			OB SET:C1220($Obj_param;\
				"action";"hide")
			
		Else 
			
			$Lon_area:=OB Get:C1224(ob_area;"area";Is longint:K8:6)
			$Lon_columnIndex:=OB Get:C1224(ob_area;"columnIndex";Is longint:K8:6)
			$Lon_rowIndex:=OB Get:C1224(ob_area;"rowIndex";Is longint:K8:6)
			$Lon_qrColumn:=OB Get:C1224(ob_area;"qrColumn";Is longint:K8:6)
			$Lon_qrRow:=OB Get:C1224(ob_area;"qrRow";Is longint:K8:6)
			
			If (QR Get report kind:C755($Lon_area)=qr cross report:K14902:2)
				
				Case of 
						
						  //……………………………………………………
					: ($Lon_rowIndex=1)  //headers
						
						Case of 
								
								  //_______________________________
							: ($Lon_columnIndex=1)  //area
								
								$Txt_form:="BALLOON_FONT"
								
								QR SET SELECTION:C794($Lon_area;0;0;0;0)
								report_SELECTION ("select_all")
								
								  //_______________________________
							: ($Lon_columnIndex=2)  //columns data-source
								
								$Txt_form:="BALLOON_COLUMN"
								$Lon_vOffset:=-25  //hide "Repeated Value"
								QR SET SELECTION:C794($Lon_area;$Lon_columnIndex;$Lon_rowIndex;$Lon_columnIndex;3)
								report_SELECTION ("select_cell";$Lon_columnIndex;$Lon_rowIndex)
								
								  //_______________________________
							: ($Lon_columnIndex=3)  //last column title
								
								$Txt_form:="BALLOON_FONT"
								
								QR SET SELECTION:C794($Lon_area;$Lon_columnIndex;$Lon_rowIndex;$Lon_columnIndex;3)
								report_SELECTION ("select_cell";$Lon_columnIndex;$Lon_rowIndex)
								
								  //_______________________________
						End case 
						
						  //……………………………………………………
					: ($Lon_rowIndex=2)  //report
						
						Case of 
								
								  //_______________________________
							: ($Lon_columnIndex=1)  //rows data-source
								
								$Txt_form:="BALLOON_COLUMN"
								$Lon_hOffset:=38  //show alternate background color
								$Lon_vOffset:=-25  //hide "Repeated Value"
								QR SET SELECTION:C794($Lon_area;$Lon_columnIndex;$Lon_rowIndex;$Lon_columnIndex;3)
								report_SELECTION ("select_cell";$Lon_columnIndex;$Lon_rowIndex)
								
								  //_______________________________
							: ($Lon_columnIndex=2)  //cells data-source
								
								$Txt_form:="BALLOON_CROSS_DATA"
								$Lon_hOffset:=38  //show alternate background color
								
								QR SET SELECTION:C794($Lon_area;$Lon_columnIndex;$Lon_rowIndex;$Lon_columnIndex;3)
								report_SELECTION ("select_cell";$Lon_columnIndex;$Lon_rowIndex)
								
								  //_______________________________
							: ($Lon_columnIndex=3)  //cells total
								
								$Txt_form:="BALLOON_CROSS_DATA"
								$Lon_hOffset:=38  //show alternate background color
								
								QR SET SELECTION:C794($Lon_area;$Lon_columnIndex;$Lon_rowIndex;$Lon_columnIndex;3)
								report_SELECTION ("select_cell";$Lon_columnIndex;$Lon_rowIndex)
								
								  //_______________________________
						End case 
						
						  //……………………………………………………
					: ($Lon_rowIndex=3)  //total line
						
						Case of 
								
								  //_______________________________
							: ($Lon_columnIndex=1)  //last row title
								
								$Txt_form:="BALLOON_FONT"
								
								QR SET SELECTION:C794($Lon_area;$Lon_columnIndex;$Lon_rowIndex;$Lon_columnIndex;3)
								report_SELECTION ("select_cell";$Lon_columnIndex;$Lon_rowIndex)
								
								  //_______________________________
							: ($Lon_columnIndex=2)\
								 | ($Lon_columnIndex=3)  //row total | total total
								
								$Txt_form:="BALLOON_LINE"
								
								QR SET SELECTION:C794($Lon_area;$Lon_columnIndex;$Lon_rowIndex;$Lon_columnIndex;3)
								report_SELECTION ("select_cell";$Lon_columnIndex;$Lon_rowIndex)
								
								  //_______________________________
						End case 
						
						  //……………………………………………………
				End case 
				
			Else 
				
				Case of 
						
						  //……………………………………………………
					: ($Lon_columnIndex=1)\
						 & ($Lon_rowIndex=-1)  //area
						
						$Txt_form:="BALLOON_FONT"
						
						QR SET SELECTION:C794($Lon_area;0;0;0;0)
						report_SELECTION ("select_all")
						
						  //……………………………………………………
					: ($Lon_columnIndex=1)\
						 & ($Lon_rowIndex>0)  //header line
						
						  //format (Detail) & computation (only for Subtotal rows and Grand total)
						Case of 
								
								  //______________________________________________________
							: ($Lon_qrRow=qr title:K14906:1)  //Title
								
								$Txt_form:="BALLOON_FONT"
								
								  //______________________________________________________
							: ($Lon_qrRow=qr detail:K14906:2)  //Detail
								
								$Txt_form:="BALLOON_LINE"
								$Lon_hOffset:=38  //show alternate background color
								
								  //______________________________________________________
							: ($Lon_qrRow=qr grand total:K14906:3)  //Grand Total 
								  // | ($Lon_qrRow>0)  //| Sub Totals
								
								$Txt_form:="BALLOON_LINE"
								
							: ($Lon_qrRow>0)
								  // subtotal line
								
								If (<>withFeature92478)
									
									$Txt_form:="BALLOON_SUBTOTALLINE"
									
								Else 
									
									$Txt_form:="BALLOON_LINE"
									
								End if 
								
								  //______________________________________________________
						End case 
						
						QR SET SELECTION:C794($Lon_area;0;$Lon_rowIndex;0;$Lon_rowIndex)
						report_SELECTION ("select_line";$Lon_rowIndex)
						
						  //______________________________________________________
					: ($Lon_columnIndex>0)\
						 & ($Lon_rowIndex=-1)  //header column
						
						$Txt_form:="BALLOON_COLUMN"
						
						QR SET SELECTION:C794($Lon_area;$Lon_qrColumn;0;$Lon_qrColumn;0)
						report_SELECTION ("select_column";$Lon_columnIndex)
						
						  //______________________________________________________
					Else   //cell
						
						
						Case of 
								
								  //______________________________________________________
							: ($Lon_qrRow=qr title:K14906:1)  //Title
								
								$Txt_form:="BALLOON_FONT"
								
								  //______________________________________________________
							: ($Lon_qrRow=qr detail:K14906:2)  //Detail
								
								$Txt_form:="BALLOON_LINE"
								$Lon_hOffset:=38  //show alternate background color
								
								  //______________________________________________________
							: ($Lon_qrRow=qr grand total:K14906:3)\
								  //Grand Total
								
								  // | ($Lon_qrRow>0)  //Grand Total | Sub Totals
								
								$Txt_form:="BALLOON_LINE"
								
								
							: ($Lon_qrRow>0)
								  // subtotal line
								
								
								If (<>withFeature92478)
									
									$Txt_form:="BALLOON_SUBTOTALLINE"
									
								Else 
									
									$Txt_form:="BALLOON_LINE"
									
								End if 
								
								
								  //______________________________________________________
						End case 
						
						QR SET SELECTION:C794($Lon_area;$Lon_qrColumn;$Lon_rowIndex;$Lon_qrColumn;$Lon_rowIndex)
						report_SELECTION ("select_cell";$Lon_columnIndex;$Lon_rowIndex)
						
						  //______________________________________________________
				End case 
			End if 
			
			If (Length:C16($Txt_form)>0)
				
				OB SET:C1220($Obj_param;\
					"action";"show";\
					"form";$Txt_form;\
					"caller";$Txt_me;\
					"hOffset";$Lon_hOffset;\
					"vOffset";$Lon_vOffset)
				
			End if 
		End if 
		
		If (OB Is defined:C1231($Obj_param))
			
			report_BALLOON_HDL ($Obj_param)
			
			CLEAR VARIABLE:C89($Obj_param)
			
		End if 
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 