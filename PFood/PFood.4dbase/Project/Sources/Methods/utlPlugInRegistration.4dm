//%attributes = {}
  //Project Method: PlugInRegistration
  //Call On Startup to get the key that matches the current 4D environment
  //And register the plugin with the returned key

  //Syntax:
  //C_TEXT($key)
  //C_LONGINT($result)
  //$key:=PlugInRegistration ("My key 1";"My key 2"; … ; "My key n")
  //$result:=$XX_Register($key)

C_TEXT:C284($1)  //All your license keys for the plugin
C_TEXT:C284($0)  //The key that matches the current setup

C_LONGINT:C283($serialKey;$connectedUsers;$maxUsers;$loop)
C_TEXT:C284($currentUser)
C_TEXT:C284($companyName)

GET SERIAL INFORMATION:C696($serialKey;$currentUser;$companyName;$connectedUsers;$maxUsers)  //only the serial key matters here

$0:="No key received for "+String:C10($serialKey)  //return an error message with the current 4D Serial

ARRAY TEXT:C222($ar_licence;0)
$all_licences:=$1
$p:=Position:C15(";";$all_licences)
While ($p>0)
	APPEND TO ARRAY:C911($ar_licence;Substring:C12($all_licences;1;$p-1))
	$all_licences:=Substring:C12($all_licences;$p+1)
	$p:=Position:C15(";";$all_licences)
End while 
If ($all_licences#"")
	APPEND TO ARRAY:C911($ar_licence;$all_licences)
End if 

For ($i;1;Size of array:C274($ar_licence))  //test all keys until we get the good one
	If (Position:C15(String:C10($serialKey);$ar_licence{$i})>0)  //the 4D serial number is part of the plugin registration key
		$result:=AL_Register ($ar_licence{$i};0;"")
	End if 
End for 