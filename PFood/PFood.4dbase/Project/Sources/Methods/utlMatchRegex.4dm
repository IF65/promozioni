//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): if65
  // Date and time: 26/09/17, 09:16:36
  // ----------------------------------------------------
  // Method: matchRegex
  // Description
  // 
  //
  // Parameters
  // ----------------------------------------------------


C_BOOLEAN:C305($0)

C_TEXT:C284($1)  //regex
C_TEXT:C284($2)  //text to be matched
C_POINTER:C301($3)  //return values (groups) ; must be an array text

ARRAY LONGINT:C221($ar_p;0)
ARRAY LONGINT:C221($ar_l;0)

$0:=False:C215

If (Match regex:C1019($1;$2;1;$ar_p;$ar_l))
	$0:=True:C214
	
	If (Count parameters:C259=3)
		ARRAY TEXT:C222($3->;0)
		For ($i;1;Size of array:C274($ar_p))
			APPEND TO ARRAY:C911($3->;Substring:C12($2;$ar_p{$i};$ar_l{$i}))
		End for 
	End if 
End if 