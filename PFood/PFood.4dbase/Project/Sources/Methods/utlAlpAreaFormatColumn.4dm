//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): if65
  // Date and time: 04/04/18, 09:13:09
  // ----------------------------------------------------
  // Method: utlAlpAreaFormatColumn
  // Description
  // 
  //
  // Parameters
  // ----------------------------------------------------


C_LONGINT:C283($0)  //codice d'errore

C_POINTER:C301($1)  //puntatore all'area ALP
C_LONGINT:C283($2)  //nr. colonna
C_TEXT:C284($3)  //header
C_LONGINT:C283($4)  //visible
C_LONGINT:C283($5)  //column width
C_LONGINT:C283($6)  //horizontal alignment
C_TEXT:C284($7)  //column format
C_LONGINT:C283($8)  //enterable

AL_SetColumnTextProperty ($1->;$2;ALP_Column_HeaderText;$3;1)
AL_SetColumnLongProperty ($1->;$2;ALP_Column_Visible;$4;1)
AL_SetColumnRealProperty ($1->;$2;ALP_Column_Width;$5;1)
AL_SetColumnLongProperty ($1->;$2;ALP_Column_HorAlign;$6;1)  //center
AL_SetColumnLongProperty ($1->;$2;ALP_Column_Attributed;1;1)  //multistyle
AL_SetColumnTextProperty ($1->;$2;ALP_Column_Format;$7;1)
AL_SetColumnLongProperty ($1->;$2;ALP_Column_Enterable;$8;1)
