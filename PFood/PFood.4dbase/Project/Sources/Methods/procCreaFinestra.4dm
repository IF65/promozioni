//%attributes = {"invisible":true}
If (False:C215)
	  //$1 = larghezza
	  //$2 = altezza
	  //$3 = posizione 0 centrata; 2 centrata su; 3 alto sx in cascata; 4 alto dx
	  //$4 = tipo finestra = Spostabile, Palette, Palette Titolo, Centrata     
	  //$5 = titolo
	  //$6 = close window procedure
End if 
_O_C_INTEGER:C282($left;$top;$right;$bottom;$tipoDialog;$1;$2;$3;$LWindowWidt;$LWindowHeig;$LNumberParm)
C_TEXT:C284($LWindowType;$4;$5)
  //se $4="Spostabile" allora la finestra ha la barra Titolo
  //se $5 allora esiste un titolo
$LWindowWidt:=Screen width:C187-6  // Default whole screen
$LWindowHeig:=Screen height:C188-6  // Default whole screen
$LScreenPosi:=0  // Default Centered
$LWindowType:="Centrata"  // Default Standard modeless w size box
$sWindowTitl:=""  // Default No window title

$LNumberParm:=Count parameters:C259
If ($LNumberParm>0)
	$LWindowWidt:=$1
	If ($LNumberParm>1)
		$LWindowHeig:=$2
		If ($LNumberParm>2)
			$LScreenPosi:=$3
			If ($LNumberParm>3)
				$LWindowType:=$4
				If ($LNumberParm>4)
					$sWindowTitl:=$5
				End if 
			End if 
		End if 
	End if 
End if 

Case of 
	: ($LWindowType="Compositing")
		$tipoDialog:=_o_Compositing mode:K34:18
	: ($LWindowType="Spostabile")
		$tipoDialog:=4
	: ($LWindowType="Resizable")
		$tipoDialog:=0
	: ($LWindowType="Palette")
		$tipoDialog:=-720
	: ($LWindowType="PaletteTitolo")
		$tipoDialog:=1984  //-5
	Else   //normalmente è chiamata Centrata, cioé Fissa
		$tipoDialog:=1
End case 

Case of 
	: (Count parameters:C259>6)
		$left:=$7
		$top:=$8
	: ($LScreenPosi=1)  //centrata
		$left:=(Screen width:C187\2)-($LWindowWidt\2)
		$top:=(Screen height:C188\2)-($LWindowHeig\2)+10
	: ($LScreenPosi=2)  //centrata su
		$left:=(Screen width:C187\2)-($LWindowWidt\2)
		$top:=50
	: ($LScreenPosi=3)  //alto a sinistra
		$left:=20
		$top:=50
		$id:=Frontmost window:C447
		$title:=Get window title:C450($id)
		GET WINDOW RECT:C443($left;$top;$right;$bottom;$id)
		If (($right>Screen width:C187) | ($bottom>Screen height:C188))
			$left:=20  //44
			$top:=52
		Else 
			$left:=$left+18
			$top:=$top+25
		End if 
		
	: ($LScreenPosi=5)  //basso a destra
		$left:=(Screen width:C187-$LWindowWidt-5)
		$top:=(Screen height:C188-$LWindowHeig-5)
		
	Else   //alto a destra
		$left:=(Screen width:C187-$LWindowWidt-5)
		$top:=50-(10*Num:C11($LWindowType="Palette@"))
		  //$top:=42-(10*Num($LWindowType="Palette@"))
End case 
$right:=$left+$LWindowWidt
$bottom:=$top+$LWindowHeig

If ($LNumberParm<6)
	$0:=Open window:C153($left;$top;$right;$bottom;$tipoDialog;$sWindowTitl)
Else 
	$0:=Open window:C153($left;$top;$right;$bottom;$tipoDialog;$sWindowTitl;$6)
End if 