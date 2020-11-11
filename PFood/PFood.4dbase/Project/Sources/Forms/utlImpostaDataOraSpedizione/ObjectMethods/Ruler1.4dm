$segno:=1
If (vOraInvioStepper=0)
	$segno:=-1
End if 
vOraInvio:=vOraInvio+Time:C179($segno*60)


