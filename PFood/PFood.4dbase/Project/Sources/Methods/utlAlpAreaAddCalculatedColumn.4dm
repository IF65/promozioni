//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): if65
  // Date and time: 07/09/17, 17:22:02
  // ----------------------------------------------------
  // Method: alpAddCalculatedColumn
  // Description
  // 
  //
  // Parameters
  // ----------------------------------------------------

C_LONGINT:C283($0)  //codice d'errore

C_POINTER:C301($1)  //puntatore all'area ALP
C_LONGINT:C283($2)  //nr. colonna

C_LONGINT:C283($3)  //tipo colonna
C_TEXT:C284($4)  //metodo di callback
C_TEXT:C284($5)  //header
C_LONGINT:C283($6)  //visible
C_LONGINT:C283($7)  //column width
C_LONGINT:C283($8)  //horizontal alignment
C_TEXT:C284($9)  //column format
C_LONGINT:C283($10)  //enterable

$0:=AL_AddCalculatedColumn ($1->;$2;$4;$2)
If ($0=0)
	AL_SetColumnTextProperty ($1->;$2;ALP_Column_HeaderText;$5;1)
	AL_SetColumnLongProperty ($1->;$2;ALP_Column_Visible;$6;1)
	If ($2#0)
		AL_SetColumnRealProperty ($1->;$2;ALP_Column_Width;$7;1)
	End if 
	AL_SetColumnLongProperty ($1->;$2;ALP_Column_HorAlign;$8;1)  //center
	AL_SetColumnLongProperty ($1->;$2;ALP_Column_Attributed;1;1)  //multistyle
	AL_SetColumnTextProperty ($1->;$2;ALP_Column_Format;$9;1)
	AL_SetColumnLongProperty ($1->;$2;ALP_Column_Enterable;$10;1)
End if 

