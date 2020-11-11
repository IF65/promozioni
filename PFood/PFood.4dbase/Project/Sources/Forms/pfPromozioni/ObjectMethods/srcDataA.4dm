  //Case of 
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

