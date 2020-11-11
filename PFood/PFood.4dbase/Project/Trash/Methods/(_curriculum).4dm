//%attributes = {"invisible":true}
C_TIME:C306($f)
$f:=Open document:C264("";"TEXT";Read mode:K24:5)
If (ok=1)
	CLOSE DOCUMENT:C267($f)
	
	$text:=Document to text:C1236(document;$file)
	
	ARRAY TEXT:C222($righe;0)
	utlExplode (Replace string:C233($text;Char:C90(Line feed:K15:40);"");->$righe)
	
	$operazione:=""
	$corrette:=""
	$errate:=""
	For ($i;1;Size of array:C274($righe))
		If (utlMatchRegex ("^1)";$righe{$i}))
			If (utlMatchRegex ("^1\\t([^\\t]*)\\t([^\\t]*)\\t([^\\t]*)\\t([^\\t]*)\\t([^\\t]*)\\t([^\\t]*)";$righe{$i}))
				
			Else 
				TRACE:C157
			End if 
		End if 
		
	End for 
End if 
