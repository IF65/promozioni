//%attributes = {}
  //%W-518.5
C_TEXT:C284($1;$source_t)
C_POINTER:C301($2;$array_p)
C_TEXT:C284($3;$delimiter_s)

C_LONGINT:C283($source_length)
C_LONGINT:C283($element_index)
C_LONGINT:C283($source_index)
C_LONGINT:C283($delimiterCharacter_index)
C_LONGINT:C283($delimiter_length)
C_LONGINT:C283($source_index)
C_LONGINT:C283($lastSourceCharacterToCheck_max)
C_LONGINT:C283($lineStart_index)
C_LONGINT:C283($line_length)
C_LONGINT:C283($lastCharacterCopied_index)

C_TEXT:C284($remainder_t)

C_BOOLEAN:C305($match_b)

$source_t:=$1
$array_p:=$2
ARRAY TEXT:C222($array_p->;0)
$delimiter_s:=Char:C90(Carriage return:K15:38)
If (Count parameters:C259>=3)
	$delimiter_s:=$3
End if 
If (Substring:C12($source_t;Length:C16($source_t);1)=$delimiter_s)
	$source_t:=Substring:C12($source_t;1;Length:C16($source_t)-1)
End if 

$lineStart_index:=1
$line_length:=0

$source_length:=Length:C16($source_t)
$delimiter_length:=Length:C16($delimiter_s)
$source_index:=1
$lastSourceCharacterToCheck_max:=$source_length-$delimiter_length+1
$element_index:=Size of array:C274($array_p->)+1
$lastCharacterCopied_index:=0

While ($source_index<=$lastSourceCharacterToCheck_max)
	
	$match_b:=True:C214
	
	For ($delimiterCharacter_index;1;$delimiter_length)
		If ($source_t[[$source_index+$delimiterCharacter_index-1]]#$delimiter_s[[$delimiterCharacter_index]])
			$match_b:=False:C215
		End if 
	End for 
	
	If ($match_b)
		
		$line_length:=$source_index-$lineStart_index
		
		INSERT IN ARRAY:C227($array_p->;$element_index;1)
		
		$array_p->{$element_index}:=Substring:C12($source_t;$lineStart_index;$line_length)
		
		$lastCharacterCopied_index:=$lineStart_index+$line_length-1
		$element_index:=$element_index+1
		$source_index:=$source_index+$delimiter_length
		$lineStart_index:=$source_index
		
	Else 
		$source_index:=$source_index+1
	End if 
	
End while 

$remainder_t:=""
If ($source_length>$lastCharacterCopied_index)
	$remainder_t:=Substring:C12($source_t;$lastCharacterCopied_index+1)
	$remainder_t:=Replace string:C233($remainder_t;$delimiter_s;"")
	INSERT IN ARRAY:C227($array_p->;$element_index;1)
	$array_p->{$element_index}:=$remainder_t
End if 