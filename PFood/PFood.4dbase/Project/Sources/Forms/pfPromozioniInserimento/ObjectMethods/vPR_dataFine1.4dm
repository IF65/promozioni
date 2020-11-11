  //PopupDate sample code

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		  // the let's customise the datepicker if needed;
		  //  All exemples below are inactivated (if false)
		C_BOOLEAN:C305($Customise)
		$Customise:=False:C215
		
		C_TEXT:C284($FormName)
		$FormName:=OBJECT Get name:C1087(Object current:K67:2)
		
		  // the line below is useless until you use "DatePicker SET DEFAULT…" commands
		
		  // DatePicker RESET DEFAULT VALUES 
		
		
		  // the exemple below shows how to set days off of a week
		  // just define a 7 rows boolean array and set days that are off to "true"
		  // Tip : use 4D constants for code lisibility
		
		If ($Customise)
			ARRAY BOOLEAN:C223($_WeekDaysOff;7)  //lets say wednesday and sunday are days off
			$_WeekDaysOff{Sunday:K10:19}:=True:C214
			DatePicker SET DAYS OFF ($FormName;0;->$_WeekDaysOff)  //0 means weekly days off
		End if 
		
		  // the exemple below show how to define a min and a max enterable date
		  // days before min and days after max will be dimmed
		  // tip : use "Add to date" to avoid conflicts like 02/03 and 03/02 
		  // to set the 3rd feb 2009 as min date use "Add to date(!00/00/00!;2009;02;03) rather than 02/03/09 or 03/02/09
		
		If ($Customise)
			DatePicker SET MIN DATE ($FormName;Add to date:C393(Current date:C33;-3;0;0))  //min date is current date minus 15 days
			DatePicker SET MAX DATE ($FormName;Add to date:C393(Current date:C33;0;0;0))  //max date is current date plus 1 year
		End if 
		
		  //vDataCompetenza1:=vDataCompetenza
	: (Form event code:C388=On Data Change:K2:15)
		  //vDataCompetenza:=vDataCompetenza1
End case 
