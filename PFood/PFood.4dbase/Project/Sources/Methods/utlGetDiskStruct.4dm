//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): if65
  // Date and time: 05/10/18, 13:04:22
  // ----------------------------------------------------
  // Method: utlGetDiskStruct
  // Description
  // 
  //
  // Parameters
  // ----------------------------------------------------
C_TEXT:C284($1)
C_TEXT:C284($2)
C_POINTER:C301($3)
C_LONGINT:C283($4)

$azione:=""
If (Count parameters:C259>0)
	$azione:=$1
End if 

$maxDepth:=3
If (Count parameters:C259>=4)
	$maxDepth:=$4
End if 

If (Not:C34(utlMatchRegex ("\\/$";$2)))
	$2:=$2+"/"
End if 

Case of 
	: ($azione="")
		$0:=""
	: ($azione="getTree")
		C_COLLECTION:C1488($col)
		$collection:=Split string:C1554($2;"/")
		
		utlGetDiskStruct ("createTree";$2;$3;$collection.count()+$maxDepth)
	: ($azione="createTree")
		C_COLLECTION:C1488($col)
		$collection:=Split string:C1554($2;"/")
		
		ON ERR CALL:C155("utlOnErrCall")
		
		If ($collection.count()<=$maxDepth)
			ARRAY TEXT:C222($arDocuments;0)
			DOCUMENT LIST:C474(Convert path POSIX to system:C1107($2);$arDocuments;Absolute path:K24:14+Ignore invisible:K24:16+Posix path:K24:15)
			OB SET ARRAY:C1227($3->;$2;$arDocuments)
			
			FOLDER LIST:C473(Convert path POSIX to system:C1107($2);$arDirectories)
			For ($i;1;Size of array:C274($arDirectories))
				If (Not:C34(utlMatchRegex ("(\\.|\\~|\\$)";$arDirectories{$i})))
					utlGetDiskStruct ("createTree";$2+$arDirectories{$i};$3;$maxDepth)
				End if 
			End for 
		End if 
		
		ON ERR CALL:C155("")
	: ($azione="getList")
		C_COLLECTION:C1488($col)
		$collection:=Split string:C1554($2;"/")
		
		utlGetDiskStruct ("createList";$2;$3;$collection.count()+$maxDepth)
	: ($azione="createList")
		C_COLLECTION:C1488($col)
		$collection:=Split string:C1554($2;"/")
		
		ON ERR CALL:C155("utlOnErrCall")
		
		If ($collection.count()<=$maxDepth)
			ARRAY TEXT:C222($arDocuments;0)
			DOCUMENT LIST:C474(Convert path POSIX to system:C1107($2);$arDocuments;Absolute path:K24:14+Ignore invisible:K24:16+Posix path:K24:15)
			For ($i;1;Size of array:C274($arDocuments))
				APPEND TO ARRAY:C911($3->;$arDocuments{$i})
			End for 
			
			FOLDER LIST:C473(Convert path POSIX to system:C1107($2);$arDirectories)
			For ($i;1;Size of array:C274($arDirectories))
				If (Not:C34(utlMatchRegex ("(\\.|\\~|\\$)";$arDirectories{$i})))
					utlGetDiskStruct ("createList";$2+$arDirectories{$i};$3;$maxDepth)
				End if 
			End for 
		End if 
		
		ON ERR CALL:C155("")
	: ($azione="recuperaNomeFile")
		$0:=""
		ARRAY TEXT:C222($arGroups;0)
		If (utlMatchRegex ("\\/([^\\/]*)$";$2;->$arGroups))
			$0:=$arGroups{1}
		End if 
End case 

  //// chiamata per ricevere la struttura remota
  //$root:="/Users"
  //C_OBJECT(tree)
  //tree:=New object
  //utlGetDiskStruct ("getTree";$root;->tree;5)
  //$text:=JSON Stringify(tree;*)

  //// chiamata per ricevere la lista file remota
  //$root:="/Users/if65/Desktop"
  //ARRAY TEXT(list;0)
  //utlGetDiskStruct ("getList";$root;->list;1)
  //$text:=JSON Stringify array(list;*)
