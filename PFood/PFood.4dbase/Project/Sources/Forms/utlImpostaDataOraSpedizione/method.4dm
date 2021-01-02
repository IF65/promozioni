Case of 
	: (Form event code:C388=On Load:K2:1)
		SET WINDOW TITLE:C213("Pianificazione Invio")
		
		vDataInvio:=Current date:C33
		vOraInvio:=Current time:C178
		
		vInvioImmediato:=True:C214
		OBJECT SET ENTERABLE:C238(*;"@";False:C215)
		OBJECT SET ENTERABLE:C238(vInvioImmediato;True:C214)
End case 
