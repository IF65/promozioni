//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): if65
  // Date and time: 09/12/17, 17:27:24
  // ----------------------------------------------------
  // Method: alpAreaAddColumn
  // Description
  // 
  //
  // Parameters
  // ----------------------------------------------------


C_LONGINT:C283($0)  //codice d'errore

C_POINTER:C301($1)  //puntatore all'area ALP
C_LONGINT:C283($2)  //nr. colonna
C_POINTER:C301($3)  //puntatore campo/array
C_TEXT:C284($4)  //header
C_LONGINT:C283($5)  //visible
C_LONGINT:C283($6)  //column width
C_LONGINT:C283($7)  //horizontal alignment
C_TEXT:C284($8)  //column format
C_LONGINT:C283($9)  //enterable

$0:=AL_AddColumn ($1->;$3;$2)
If ($0=0)
	AL_SetColumnTextProperty ($1->;$2;ALP_Column_HeaderText;$4;1)
	AL_SetColumnLongProperty ($1->;$2;ALP_Column_Visible;$5;1)
	If ($2#0)
		AL_SetColumnRealProperty ($1->;$2;ALP_Column_Width;$6;1)
	End if 
	AL_SetColumnLongProperty ($1->;$2;ALP_Column_HorAlign;$7;1)  //center
	AL_SetColumnLongProperty ($1->;$2;ALP_Column_Attributed;1;1)  //multistyle
	AL_SetColumnTextProperty ($1->;$2;ALP_Column_Format;$8;1)
	AL_SetColumnLongProperty ($1->;$2;ALP_Column_Enterable;$9;1)
End if 