//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): if65
  // Date and time: 21/08/19, 09:01:11
  // ----------------------------------------------------
  // Method: utlConfrontoArray
  // Description
  // 
  //
  // Parameters
  // ----------------------------------------------------
C_BOOLEAN:C305($0)
C_POINTER:C301($1;$2)

$0:=True:C214

If (Size of array:C274($1->)=Size of array:C274($2->))
	For ($i;1;Size of array:C274($1->))
		If (Find in array:C230($2->;$1->{$i})<0)
			$0:=False:C215
		End if 
	End for 
Else 
	$0:=False:C215
End if 