Case of 
	: (Form event code:C388=On Load:K2:1)
		notePiePagina:=""
		
		SET WINDOW TITLE:C213("Aderenti")
		
	: (Form event code:C388=On Unload:K2:2)
		<>aderentiWinRef:=0
		
	: (Form event code:C388=On Resize:K2:27)
		GET WINDOW RECT:C443($left;$top;$right;$bottom)
		$width:=$right-$left
		$button_width_new:=Int:C8(($width-26)/5)
		OBJECT GET COORDINATES:C663(Button5;$b_left;$b_top;$b_right;$b_bottom)
		$button_width_old:=$b_right-$b_left
		
		$delta:=$button_width_new-$button_width_old
		For ($i;1;5)
			OBJECT MOVE:C664(*;"Button"+String:C10($i);($i-1)*$delta;0;$delta;0)
		End for 
		
End case 
