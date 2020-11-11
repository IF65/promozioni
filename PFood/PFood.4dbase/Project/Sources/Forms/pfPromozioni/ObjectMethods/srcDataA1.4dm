  //PopupDate sample code

  //Case of 

  //: (Form event=On Load)

  //C_TEXT($FormName)
  //$FormName:=OBJECT Get name(Object current)

  //ARRAY BOOLEAN($_WeekDaysOff;7)  //lets say wednesday and sunday are days off
  //$_WeekDaysOff{Sunday}:=True
  //DatePicker SET DAYS OFF ($FormName;0;->$_WeekDaysOff)  //0 means weekly days off
  //  //DatePicker SET MIN DATE ($FormName;!1901-01-01!)
  //  //DatePicker SET MAX DATE ($FormName;Current date)

  //: (Form event=On Data Change)
  //If (srcDataDa>srcDataA) & (srcDataA#!00-00-00!)
  //srcDataA:=srcDataDa
  //End if 

  //If (srcDataA=!00-00-00!) | (srcDataDa=!00-00-00!)
  //srcPeriodi:=1
  //srcPeriodi{0}:="1"
  //Else 
  //$periodoTrovato:=False
  //For ($i;1;Size of array(srcPeriodi))
  //If (srcPeriodiDa{$i}=srcDataDa) & (srcPeriodiA{$i}=srcDataA)
  //srcPeriodi:=$i
  //srcPeriodi{0}:=String($i)
  //$periodoTrovato:=True
  //End if 
  //If (Not($periodoTrovato))
  //srcPeriodi:=1
  //srcPeriodi{0}:="1"
  //End if 
  //End for 
  //End if 
  //End case 
