//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): if65
  // Date and time: 09/07/19, 16:07:40
  // ----------------------------------------------------
  // Method: pfEntryStart
  // Description
  // 
  //
  // Parameters
  // ----------------------------------------------------

C_LONGINT:C283($1)  // areaList Pro object reference
C_LONGINT:C283($2)  // entry cause
C_LONGINT:C283($3)  // record loaded?

If (Undefined:C82(alpRicompense))
	alpRicompense:=0
End if 
If (Undefined:C82(alpArticoli))
	alpArticoli:=0
End if 
If (Undefined:C82(alpGruppi))
	alpGruppi:=0
End if 

$row:=AL_GetAreaLongProperty ($1;ALP_Area_EntryRow)
$column:=AL_GetAreaLongProperty ($1;ALP_Area_EntryColumn)

If (selTipo<3)
	AL_SetAreaLongProperty ($1;ALP_Area_EntrySkip;$column)
Else 
	Case of 
		: ($1=alpRicompense)
			  //AL_SetAreaLongProperty ($1;ALP_Area_EntrySkip;$column)
			
		: ($1=alpArticoli)
			If (arAR_codiceArticolo{$row}#"") & (($column=4) | ($column=5))
				AL_SetAreaLongProperty ($1;ALP_Area_EntrySkip;$column)
			End if 
			
			If (arAR_codiceReparto{$row}#"") & (($column=3) | ($column=5))
				AL_SetAreaLongProperty ($1;ALP_Area_EntrySkip;$column)
			End if 
			
			If (arAR_barcode{$row}#"") & (($column=3) | ($column=4))
				AL_SetAreaLongProperty ($1;ALP_Area_EntrySkip;$column)
			End if 
			
	End case 
End if 

