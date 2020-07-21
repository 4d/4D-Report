//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : QR_SELECTION
// Database: sandbox_14
// ID[09AAC562C1E14454AAC5DEBC5980B44F]
// Created #30-1-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_TEXT:C284($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)

C_BOOLEAN:C305($Boo_display; $Boo_OK)
C_LONGINT:C283($Lon_; $Lon_area; $Lon_bottom; $Lon_column; $Lon_columnNumber; $Lon_headerHeight)
C_LONGINT:C283($Lon_height; $Lon_indx_1; $Lon_indx_2; $Lon_left; $Lon_line; $Lon_lockedColumns)
C_LONGINT:C283($Lon_lockedRight; $Lon_parameters; $Lon_reportType; $Lon_right; $Lon_rowNumber; $Lon_top)
C_LONGINT:C283($Lon_width)
C_TEXT:C284($kTxt_reportObject; $Txt_entrypoint)

ARRAY BOOLEAN:C223($tBoo_visible; 0)
ARRAY POINTER:C280($tPtr_columnVars; 0)
ARRAY POINTER:C280($tPtr_headerVars; 0)
ARRAY POINTER:C280($tPtr_styles; 0)
ARRAY TEXT:C222($tTxt_columnNames; 0)
ARRAY TEXT:C222($tTxt_headerNames; 0)

If (False:C215)
	C_TEXT:C284(report_SELECTION; $1)
	C_LONGINT:C283(report_SELECTION; $2)
	C_LONGINT:C283(report_SELECTION; $3)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1; "Missing parameter"))
	
	$Txt_entrypoint:=$1
	
	If ($Lon_parameters>=2)
		
		$Lon_indx_1:=$2
		
		If ($Lon_parameters>=3)
			
			$Lon_indx_2:=$3
			
		End if 
	End if 
	
	//[ISOFUNCTIONAL = THE MULTISELECTION IS NOT MANAGED]
	//$kBoo_multiSelection:=False
	
	$Boo_OK:=(OB Is defined:C1231(ob_area))
	
	If ($Boo_OK)
		
		$Lon_area:=OB Get:C1224(ob_area; "area"; Is longint:K8:6)
		$Lon_rowNumber:=OB Get:C1224(ob_area; "qrRowNumber"; Is longint:K8:6)
		$Lon_columnNumber:=OB Get:C1224(ob_area; "qrColumnNumber"; Is longint:K8:6)
		$Lon_reportType:=OB Get:C1224(ob_area; "reportType"; Is longint:K8:6)
		
	End if 
	
	$kTxt_reportObject:=OB Get:C1224(<>report_params; "form-object"; Is text:K8:3)
	
	LISTBOX GET ARRAYS:C832(*; $kTxt_reportObject; \
		$tTxt_columnNames; \
		$tTxt_headerNames; \
		$tPtr_columnVars; \
		$tPtr_headerVars; \
		$tBoo_visible; \
		$tPtr_styles)
	
	$Lon_lockedColumns:=LISTBOX Get locked columns:C1152(*; $kTxt_reportObject)
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($Lon_area=0)
		
		//NOTHING MORE TO DO
		
		//______________________________________________________
	: ($Txt_entrypoint="display")\
		 | ($Txt_entrypoint="adjust")
		
		If ($Txt_entrypoint="adjust")
			
			$Lon_column:=OB Get:C1224(ob_area; "selected-column"; Is longint:K8:6)
			$Lon_line:=OB Get:C1224(ob_area; "selected-line"; Is longint:K8:6)
			
		Else 
			
			//retrieve the coordinates of the cell that is selected.
			QR GET SELECTION:C793($Lon_area; $Lon_left; $Lon_top; $Lon_right; $Lon_bottom)
			
			Case of 
					
					//…………………………………………………………………………………………
				: ($Lon_left=-1)  //no selection
					
					$Lon_column:=0
					$Lon_line:=0
					
					//…………………………………………………………………………………………
				: (($Lon_left+$Lon_top)=0)  //All area
					
					$Lon_column:=-1
					$Lon_line:=-1
					
					//…………………………………………………………………………………………
				: ($Lon_top=0)  //entire column
					
					$Lon_column:=$Lon_left+$Lon_lockedColumns
					
					//…………………………………………………………………………………………
				: ($Lon_left=0)  //entire row
					
					$Lon_line:=$Lon_top
					
					//…………………………………………………………………………………………
				Else 
					
					$Lon_column:=$Lon_left+$Lon_lockedColumns
					$Lon_line:=$Lon_top
					
					//…………………………………………………………………………………………
			End case 
			
			OB SET:C1220(ob_area; \
				"selected-column"; $Lon_column; \
				"selected-line"; $Lon_line)
			
		End if 
		
		Case of 
				
				//…………………………………………………………………………………………
			: (($Lon_column=0)\
				 & ($Lon_line=0))
				
				//NO SELECTION
				report_SELECTION("select_none")
				
				//…………………………………………………………………………………………
			: (($Lon_column=-1)\
				 & ($Lon_line=-1))
				
				report_SELECTION("select_all")
				
				//…………………………………………………………………………………………
			: ($Lon_line=0)
				
				report_SELECTION("select_column"; $Lon_column)
				
				//…………………………………………………………………………………………
			: ($Lon_column=0)
				
				report_SELECTION("select_line"; $Lon_line)
				
				//…………………………………………………………………………………………
			Else 
				
				report_SELECTION("select_cell"; $Lon_column; $Lon_line)
				
				//…………………………………………………………………………………………
		End case 
		
		//______________________________________________________
	: ($Txt_entrypoint="select_none")
		
		OBJECT SET VISIBLE:C603(*; "sel@"; False:C215)
		
		OB SET:C1220(ob_area; \
			"selected-column"; 0; \
			"selected-line"; 0)
		
		//______________________________________________________
	: ($Txt_entrypoint="select_all")
		
		$Boo_display:=True:C214
		
		OBJECT GET COORDINATES:C663(*; $tTxt_columnNames{$Lon_lockedColumns}; $Lon_; $Lon_; $Lon_left; $Lon_)
		OBJECT GET COORDINATES:C663(*; $tTxt_headerNames{1}; $Lon_; $Lon_; $Lon_; $Lon_top)
		OBJECT GET COORDINATES:C663(*; "filler"; $Lon_right; $Lon_; $Lon_; $Lon_)
		LISTBOX GET CELL COORDINATES:C1330(*; $kTxt_reportObject; 1; LISTBOX Get number of rows:C915(*; $kTxt_reportObject); $Lon_; $Lon_; $Lon_; $Lon_bottom)
		
		OB SET:C1220(ob_area; \
			"selected-column"; -1; \
			"selected-line"; -1)
		
		//______________________________________________________
	Else 
		
		$Boo_display:=True:C214
		
		Case of 
				
				//…………………………………………………………………………………………
			: ($Txt_entrypoint="select_column")
				
				If ($Lon_indx_1<=Size of array:C274($tTxt_columnNames))
					
					OB SET:C1220(ob_area; \
						"selected-column"; $Lon_indx_1; \
						"selected-line"; 0)
					
					OBJECT GET COORDINATES:C663(*; $tTxt_columnNames{$Lon_indx_1}; $Lon_left; $Lon_top; $Lon_right; $Lon_bottom)
					
				End if 
				
				//…………………………………………………………………………………………
			: ($Txt_entrypoint="select_line")
				
				OB SET:C1220(ob_area; \
					"selected-column"; 0; \
					"selected-line"; $Lon_indx_1)
				
				OBJECT GET COORDINATES:C663(*; $tTxt_columnNames{$Lon_lockedColumns}; $Lon_; $Lon_; $Lon_left; $Lon_)
				LISTBOX GET CELL COORDINATES:C1330(*; $kTxt_reportObject; 2; $Lon_indx_1; $Lon_; $Lon_top; $Lon_; $Lon_bottom)
				OBJECT GET COORDINATES:C663(*; "filler"; $Lon_right; $Lon_; $Lon_; $Lon_)
				
				//…………………………………………………………………………………………
			: ($Txt_entrypoint="select_cell")
				
				OB SET:C1220(ob_area; \
					"selected-column"; $Lon_indx_1; \
					"selected-line"; $Lon_indx_2)
				
				LISTBOX GET CELL COORDINATES:C1330(*; $kTxt_reportObject; $Lon_indx_1; $Lon_indx_2; $Lon_left; $Lon_top; $Lon_right; $Lon_bottom)
				
				//…………………………………………………………………………………………
		End case 
		
		//________________________________________
End case 

If ($Txt_entrypoint="select_@")
	
	If ($Boo_display)
		
		//crop if any
		OBJECT GET COORDINATES:C663(*; $tTxt_columnNames{$Lon_lockedColumns}; $Lon_; $Lon_; $Lon_lockedRight; $Lon_)
		$Lon_left:=Choose:C955($Lon_left<$Lon_lockedRight; $Lon_lockedRight; $Lon_left)
		
		If (OB Get:C1224(ob_area; "reportType"; Is longint:K8:6)=qr list report:K14902:1)
			
			$Lon_headerHeight:=OB Get:C1224(<>report_params; "header-height"; Is longint:K8:6)
			$Lon_top:=Choose:C955($Lon_top<$Lon_headerHeight; $Lon_headerHeight; $Lon_top)
			
		End if 
		
		OBJECT GET SUBFORM CONTAINER SIZE:C1148($Lon_width; $Lon_height)
		
		//calculate the corrected area coordinates with the scrollbar widths
		$Lon_width:=$Lon_width-\
			(LISTBOX Get property:C917(*; $kTxt_reportObject; lk ver scrollbar width:K53:9)*LISTBOX Get property:C917(*; $kTxt_reportObject; _o_lk display ver scrollbar:K53:8))
		$Lon_right:=Choose:C955($Lon_right>$Lon_width; $Lon_width; $Lon_right)
		
		$Lon_height:=$Lon_height-\
			(LISTBOX Get property:C917(*; $kTxt_reportObject; lk hor scrollbar height:K53:7)*LISTBOX Get property:C917(*; $kTxt_reportObject; _o_lk display hor scrollbar:K53:6))
		$Lon_bottom:=Choose:C955($Lon_bottom>$Lon_height; $Lon_height+1; $Lon_bottom)
		
		$Lon_right:=$Lon_right-1
		$Lon_bottom:=$Lon_bottom-1
		
		OBJECT SET COORDINATES:C1248(*; "sel@"; $Lon_left; $Lon_top; $Lon_right; $Lon_bottom)
		
		//display if any
		OBJECT SET VISIBLE:C603(*; "sel@"; $Lon_right>=$Lon_left)
		
	Else 
		
		OBJECT SET VISIBLE:C603(*; "sel@"; False:C215)
		
	End if 
End if 

If ($Txt_entrypoint#"adjust")  //stop reentrance
	
	SET TIMER:C645(-1)
	
End if 

// ----------------------------------------------------
// End