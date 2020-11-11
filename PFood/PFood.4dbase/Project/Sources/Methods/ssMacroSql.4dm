//%attributes = {}
  //  // ----------------------------------------------------
  //  // Nome Utente (OS): marco
  //  // Data ed Ora: 31-03-07, 23:27:12
  //  // ----------------------------------------------------
  //  // Metodo: ssMacroSQL
  //  // Descrizione
  //  // 
  //  //
  //  // Parametri
  //  // ----------------------------------------------------
  //C_LONGINT($1)

  //  //1 = SELECT semplice
  //  //2 = SELECT ed ESPORTAZIONE file txt sul Desktop
  //  //3 = SELECT ed ESPORTAZIONE file xml sul Desktop
  //  //4 = INSERT in blocco
  //  //5 = INSERT per record singolo

  //  // Variabili
  //  // ----------------------------------------------------
  //C_TEXT($macro_input_text)
  //C_TEXT($macro_output_text)

  //C_LONGINT($selected_table_number)
  //C_LONGINT($selected_field_number)
  //C_LONGINT($selected_field_type)
  //C_LONGINT($selected_field_length)

  //C_TEXT($array_prefix)
  //C_TEXT($array_name)

  //C_TEXT($field_name)

  //  //prelevo il testo eventualmente selezionato nella procedura chiamante
  //GET MACRO PARAMETER(Highlighted method text;$macro_input_text)

  //If ($1=5)
  //ARRAY TEXT($ar_tabella;0)
  //nx_riempiArray($macro_input_text;->$ar_tabella;Char(Carriage return))

  //$macro_output_text:="C_TEXT($SQL_Stmt)"+Char(Carriage return)+Char(Carriage return)

  //For ($j;1;Size of array($ar_tabella))

  //  //scopro se la selezione è una table e, in caso affermativo, ne determino il numero.
  //$selected_table_number:=0
  //For ($i;1;Get last table number)
  //If (("["+Table name(Table($i))+"]")=$ar_tabella{$j})
  //$selected_table_number:=$i
  //End if 
  //End for 
  //  //Login
  //$macro_output_text:=$macro_output_text+"$negozio:="+Char(Double quote)+"SM0"+Char(Double quote)+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"SQL Login("+Char(Double quote)+"IP:"+Char(Double quote)+"+ssGet_DatiSede ($negozio;"+Char(Double quote)+"IP"+Char(Double quote)+");"+Char(Double quote)+"Direttore"+Char(Double quote)+";"+Char(Double quote)+"Dir"+Char(Double quote)+";*)"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"If (ok=1)"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"nx_termometro ("+Char(Double quote)+"Init"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"nx_termometro ("+Char(Double quote)+"Display"+Char(Double quote)+";"+Char(Double quote)+Table name($selected_table_number)+Char(Double quote)+")"+Char(Carriage return)+Char(Carriage return)

  //$variable_prefix:="$v"+String($selected_table_number)

  //$macro_output_text:=$macro_output_text+Char(96)+"Table: "+Table name($selected_table_number)+"("+String($selected_table_number)+")"+Char(Carriage return)
  //For ($selected_field_number;1;Get last field number($selected_table_number))
  //$field_name:=Replace string(Replace string(Field name($selected_table_number;$selected_field_number);" ";"_");"à";"a")
  //$variable_name:=Substring($variable_prefix+$field_name;1;31)
  //GET FIELD PROPERTIES($selected_table_number;$selected_field_number;$selected_field_type;$selected_field_length)
  //Case of 
  //: ($selected_field_type=Is alpha field)
  //$macro_output_text:=$macro_output_text+"C_TEXT("+$variable_name+")"+Char(96)+String($selected_field_number)+Char(Carriage return)
  //: ($selected_field_type=Is text)
  //$macro_output_text:=$macro_output_text+"C_TEXT("+$variable_name+")"+Char(96)+String($selected_field_number)+Char(Carriage return)
  //: (($selected_field_type=Is real) | ($selected_field_type=Is float))
  //$macro_output_text:=$macro_output_text+"C_REAL("+$variable_name+")"+Char(96)+String($selected_field_number)+Char(Carriage return)
  //: ($selected_field_type=Is integer)
  //$macro_output_text:=$macro_output_text+"C_INTEGER("+$variable_name+")"+Char(96)+String($selected_field_number)+Char(Carriage return)
  //: (($selected_field_type=Is longint) | ($selected_field_type=Is integer 64 bits))
  //$macro_output_text:=$macro_output_text+"C_LONGINT("+$variable_name+")"+Char(96)+String($selected_field_number)+Char(Carriage return)
  //: ($selected_field_type=Is date)
  //$macro_output_text:=$macro_output_text+"C_DATE("+$variable_name+")"+Char(96)+String($selected_field_number)+Char(Carriage return)
  //: ($selected_field_type=Is time)
  //$macro_output_text:=$macro_output_text+"C_LONGINT("+$variable_name+")"+Char(96)+String($selected_field_number)+Char(Carriage return)
  //: ($selected_field_type=Is boolean)
  //$macro_output_text:=$macro_output_text+"C_BOOLEAN("+$variable_name+")"+Char(96)+String($selected_field_number)+Char(Carriage return)
  //: ($selected_field_type=Is picture)
  //$macro_output_text:=$macro_output_text+"C_PICTURE("+$variable_name+")"+Char(96)+String($selected_field_number)+Char(Carriage return)
  //: ($selected_field_type=Is BLOB)
  //$macro_output_text:=$macro_output_text+"C_BLOB("+$variable_name+")"+Char(96)+String($selected_field_number)+Char(Carriage return)+Char(Carriage return)
  //Else 
  //  //Subtable
  //End case 
  //End for 

  //$macro_output_text:=$macro_output_text+"READ WRITE(["+Table name($selected_table_number)+"])"+Char(Carriage return)

  //  //SQL statement
  //$macro_output_text:=$macro_output_text+"$SQL_Stmt:="+Char(Double quote)+"SELECT "
  //For ($selected_field_number;1;Get last field number($selected_table_number))
  //$field_name:=Replace string(Replace string(Field name($selected_table_number;$selected_field_number);" ";"_");"à";"a")
  //$macro_output_text:=$macro_output_text+$field_name
  //If ($selected_field_number#Get last field number($selected_table_number))
  //$macro_output_text:=$macro_output_text+","
  //Else 
  //$macro_output_text:=$macro_output_text+Char(Double quote)+"+Char(Carriage return )"+Char(Carriage return)
  //End if 
  //End for 
  //$macro_output_text:=$macro_output_text+"$SQL_Stmt:=$SQL_Stmt+"+Char(Double quote)+"FROM "+Table name($selected_table_number)+Char(Double quote)+"+Char(Carriage return )"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"SQL EXECUTE($SQL_Stmt;"
  //For ($selected_field_number;1;Get last field number($selected_table_number))
  //$field_name:=Replace string(Replace string(Field name($selected_table_number;$selected_field_number);" ";"_");"à";"a")
  //$macro_output_text:=$macro_output_text+Substring($variable_prefix+$field_name;1;31)
  //If ($selected_field_number#Get last field number($selected_table_number))
  //$macro_output_text:=$macro_output_text+";"
  //Else 
  //$macro_output_text:=$macro_output_text+")"+Char(Carriage return)
  //End if 
  //End for 
  //$macro_output_text:=$macro_output_text+"While (Not(SQL End selection))"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"SQL LOAD RECORD"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"QUERY(["+Table name($selected_table_number)+"];["+Table name($selected_table_number)+"]=)"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"If (Records in selection(["+Table name($selected_table_number)+"])=0)"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"CREATE RECORD(["+Table name($selected_table_number)+"])"+Char(Carriage return)
  //For ($selected_field_number;1;Get last field number($selected_table_number))
  //$field_name:=Replace string(Replace string(Field name($selected_table_number;$selected_field_number);" ";"_");"à";"a")
  //$macro_output_text:=$macro_output_text+"["+Table name($selected_table_number)+"]"+$field_name+":="+Substring($variable_prefix+$field_name;1;31)+Char(96)+String($selected_field_number)+Char(Carriage return)
  //End for 
  //$macro_output_text:=$macro_output_text+"SAVE RECORD(["+Table name($selected_table_number)+"])"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"End if"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"End While"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"READ ONLY(["+Table name($selected_table_number)+"])"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"SQL LOGOUT"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"nx_termometro ("+Char(Double quote)+"Chiudi"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"End if"+Char(Carriage return)+Char(Carriage return)
  //End for 
  //Else 
  //$array_prefix:="$arXX_"

  //  //scopro se la selezione è una table e, in caso affermativo, ne determino il numero.
  //$selected_table_number:=0
  //For ($i;1;Get last table number)
  //If (("["+Table name(Table($i))+"]")=$macro_input_text)
  //$selected_table_number:=$i
  //End if 
  //End for 

  //  //Dichiarazione arrays
  //$macro_output_text:=Char(96)+"Table: "+Table name($selected_table_number)+"("+String($selected_table_number)+")"+Char(Carriage return)
  //For ($selected_field_number;1;Get last field number($selected_table_number))
  //$field_name:=Replace string(Replace string(Field name($selected_table_number;$selected_field_number);" ";"_");"à";"a")
  //$array_name:=Substring($array_prefix+$field_name;1;31)
  //GET FIELD PROPERTIES($selected_table_number;$selected_field_number;$selected_field_type;$selected_field_length)
  //Case of 
  //: ($selected_field_type=Is alpha field)
  //$macro_output_text:=$macro_output_text+"ARRAY STRING("+String($selected_field_length)+";"+$array_name+";0)"+Char(96)+String($selected_field_number)+Char(Carriage return)
  //: ($selected_field_type=Is text)
  //$macro_output_text:=$macro_output_text+"ARRAY TEXT("+$array_name+";0)"+Char(96)+String($selected_field_number)+Char(Carriage return)
  //: (($selected_field_type=Is real) | ($selected_field_type=Is float))
  //$macro_output_text:=$macro_output_text+"ARRAY REAL("+$array_name+";0)"+Char(96)+String($selected_field_number)+Char(Carriage return)
  //: ($selected_field_type=Is integer)
  //$macro_output_text:=$macro_output_text+"ARRAY INTEGER("+$array_name+";0)"+Char(96)+String($selected_field_number)+Char(Carriage return)
  //: (($selected_field_type=Is longint) | ($selected_field_type=Is integer 64 bits))
  //$macro_output_text:=$macro_output_text+"ARRAY LONGINT("+$array_name+";0)"+Char(96)+String($selected_field_number)+Char(Carriage return)
  //: ($selected_field_type=Is date)
  //$macro_output_text:=$macro_output_text+"ARRAY DATE("+$array_name+";0)"+Char(96)+String($selected_field_number)+Char(Carriage return)
  //: ($selected_field_type=Is time)
  //$macro_output_text:=$macro_output_text+"ARRAY LONGINT("+$array_name+";0)"+Char(96)+String($selected_field_number)+Char(Carriage return)
  //: ($selected_field_type=Is boolean)
  //$macro_output_text:=$macro_output_text+"ARRAY BOOLEAN("+$array_name+";0)"+Char(96)+String($selected_field_number)+Char(Carriage return)
  //: ($selected_field_type=Is picture)
  //$macro_output_text:=$macro_output_text+"ARRAY PICTURE("+$array_name+";0)"+Char(96)+String($selected_field_number)+Char(Carriage return)
  //: ($selected_field_type=Is BLOB)
  //$macro_output_text:=$macro_output_text+"ARRAY BLOB("+$array_name+";0)"+Char(96)+String($selected_field_number)+Char(Carriage return)+Char(Carriage return)
  //Else 
  //  //Subtable
  //End case 
  //End for 

  //If ($1=4)  //INSERT
  //$macro_output_text:=$macro_output_text+"SELECTION TO ARRAY("
  //For ($selected_field_number;1;Get last field number($selected_table_number))
  //$table_name:="["+Table name($selected_table_number)+"]"
  //$field_name:=Replace string(Replace string(Field name($selected_table_number;$selected_field_number);" ";"_");"à";"a")
  //$array_name:=Substring($array_prefix+$field_name;1;31)
  //$macro_output_text:=$macro_output_text+$table_name+$field_name+";"+$array_name
  //If ($selected_field_number#Get last field number($selected_table_number))
  //$macro_output_text:=$macro_output_text+";"
  //Else 
  //$macro_output_text:=$macro_output_text+")"+Char(Carriage return)+Char(Carriage return)
  //End if 
  //End for 
  //End if 

  //  //Login
  //$macro_output_text:=$macro_output_text+"$negozio:="+Char(Double quote)+Char(Double quote)+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"SQL Login("+Char(Double quote)+"IP:"+Char(Double quote)+"+ssGet_DatiSede ($negozio;"+Char(Double quote)+"IP"+Char(Double quote)+");"+Char(Double quote)+"Utente"+Char(Double quote)+";"+Char(Double quote)+"Password"+Char(Double quote)+";*)"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"If (ok=1)"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"Begin SQL"+Char(Carriage return)

  //If (($1=1) | ($1=2) | ($1=3))  //SELECT
  //$macro_output_text:=$macro_output_text+"SELECT "
  //For ($selected_field_number;1;Get last field number($selected_table_number))
  //$field_name:=Replace string(Replace string(Field name($selected_table_number;$selected_field_number);" ";"_");"à";"a")
  //$macro_output_text:=$macro_output_text+$field_name
  //If ($selected_field_number#Get last field number($selected_table_number))
  //$macro_output_text:=$macro_output_text+","
  //Else 
  //$macro_output_text:=$macro_output_text+Char(Carriage return)
  //End if 
  //End for 
  //$macro_output_text:=$macro_output_text+"FROM "+Table name($selected_table_number)+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"WHERE"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"INTO "
  //For ($selected_field_number;1;Get last field number($selected_table_number))
  //$field_name:=Replace string(Replace string(Field name($selected_table_number;$selected_field_number);" ";"_");"à";"a")
  //$macro_output_text:=$macro_output_text+":"+Substring($array_prefix+$field_name;1;31)
  //If ($selected_field_number#Get last field number($selected_table_number))
  //$macro_output_text:=$macro_output_text+","
  //Else 
  //$macro_output_text:=$macro_output_text+";"+Char(Carriage return)
  //End if 
  //End for 
  //End if 

  //If ($1=4)  //INSERT
  //$macro_output_text:=$macro_output_text+"INSERT INTO "+Table name($selected_table_number)+" ("
  //For ($selected_field_number;1;Get last field number($selected_table_number))
  //$field_name:=Replace string(Replace string(Field name($selected_table_number;$selected_field_number);" ";"_");"à";"a")
  //$macro_output_text:=$macro_output_text+$field_name
  //If ($selected_field_number#Get last field number($selected_table_number))
  //$macro_output_text:=$macro_output_text+","
  //Else 
  //$macro_output_text:=$macro_output_text+")"+Char(Carriage return)
  //End if 
  //End for 
  //$macro_output_text:=$macro_output_text+"VALUES ("
  //For ($selected_field_number;1;Get last field number($selected_table_number))
  //$field_name:=Replace string(Replace string(Field name($selected_table_number;$selected_field_number);" ";"_");"à";"a")
  //$macro_output_text:=$macro_output_text+":"+Substring($array_prefix+$field_name;1;31)
  //If ($selected_field_number#Get last field number($selected_table_number))
  //$macro_output_text:=$macro_output_text+","
  //Else 
  //$macro_output_text:=$macro_output_text+");"+Char(Carriage return)
  //End if 
  //End for 
  //End if 

  //  //Logout
  //$macro_output_text:=$macro_output_text+"End SQL"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"SQL LOGOUT"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"End if"+Char(Carriage return)+Char(Carriage return)

  //If ($1=2)  //Esportazione in un file di testo
  //$macro_output_text:=$macro_output_text+"C_TIME($f)"+Char(Carriage return)+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$Folder:=System folder(Desktop )"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$FileName:="+Char(Double quote)+Table name($selected_table_number)+"_"+Char(Double quote)+"+String(((Current date(*)-!01-01-1970!)*86400)+Current time(*))"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$f:=Create document($Folder+$FileName;"+Char(Double quote)+"TEXT"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"If (ok=1)"+Char(Carriage return)
  //For ($selected_field_number;1;Get last field number($selected_table_number))
  //$field_name:=Replace string(Replace string(Field name($selected_table_number;$selected_field_number);" ";"_");"à";"a")
  //$macro_output_text:=$macro_output_text+"SEND PACKET($f;"+Char(Double quote)+$field_name+Char(Double quote)
  //If ($selected_field_number#Get last field number($selected_table_number))
  //$macro_output_text:=$macro_output_text+"+Char(Tab))"+Char(96)+String($selected_field_number)+Char(Carriage return)
  //Else 
  //$macro_output_text:=$macro_output_text+"+Char(Carriage return ))"+Char(96)+String($selected_field_number)+Char(Carriage return)
  //End if 
  //End for 
  //$field_name:=Replace string(Replace string(Field name($selected_table_number;1);" ";"_");"à";"a")
  //$macro_output_text:=$macro_output_text+"For ($i;1;Size of array("+Substring($array_prefix+$field_name;1;31)+"))"+Char(Carriage return)
  //For ($selected_field_number;1;Get last field number($selected_table_number))
  //$field_name:=Replace string(Replace string(Field name($selected_table_number;$selected_field_number);" ";"_");"à";"a")
  //GET FIELD PROPERTIES($selected_table_number;$selected_field_number;$selected_field_type;$selected_field_length)
  //Case of 
  //: (($selected_field_type=Is alpha field) | ($selected_field_type=Is text))
  //$macro_output_text:=$macro_output_text+"SEND PACKET($f;"+Substring($array_prefix+$field_name;1;31)+"{$i}"
  //: (($selected_field_type=Is real) | ($selected_field_type=Is float) | ($selected_field_type=Is integer) | ($selected_field_type=Is longint) | ($selected_field_type=Is integer 64 bits) | ($selected_field_type=Is date) | ($selected_field_type=Is time) | ($selected_field_type=Is boolean))
  //$macro_output_text:=$macro_output_text+"SEND PACKET($f;String("+Substring($array_prefix+$field_name;1;31)+"{$i})"
  //: ($selected_field_type=Is picture)
  //$macro_output_text:=$macro_output_text+"SEND PACKET($f;"+Char(Double quote)+"PICTURE"+Char(Double quote)
  //: ($selected_field_type=Is BLOB)
  //$macro_output_text:=$macro_output_text+"SEND PACKET($f;"+Char(Double quote)+"BLOB"+Char(Double quote)
  //Else 
  //$macro_output_text:=$macro_output_text+"SEND PACKET($f;"+Char(Double quote)+"UNDEFINED"+Char(Double quote)
  //End case 
  //If ($selected_field_number#Get last field number($selected_table_number))
  //$macro_output_text:=$macro_output_text+"+Char(Tab))"+Char(96)+String($selected_field_number)+Char(Carriage return)
  //Else 
  //$macro_output_text:=$macro_output_text+"+Char(Carriage return ))"+Char(96)+String($selected_field_number)+Char(Carriage return)
  //End if 
  //End for 
  //$macro_output_text:=$macro_output_text+"End for"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"CLOSE DOCUMENT($f)"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"End if"+Char(Carriage return)
  //End if 

  //If ($1=3)  //Esportazione in un file excel
  //$macro_output_text:=$macro_output_text+"C_STRING(36;$el_root)"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$nm_root:="+Char(Double quote)+"ss:Workbook"+Char(Double quote)+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$namespace:="+Char(Double quote)+"urn:schemas-microsoft-com:office:spreadsheet"+Char(Double quote)+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_root:=DOM Create XML Ref($nm_root;$namespace;"+Char(Double quote)+"xmlns"+Char(Double quote)+";"+Char(Double quote)+"urn:schemas-microsoft-com:office:spreadsheet"+Char(Double quote)+";"+Char(Double quote)+"xmlns:o"+Char(Double quote)+";"+Char(Double quote)+"urn:schemas-microsoft-com:office:office"+Char(Double quote)+";"+Char(Double quote)+"xmlns:x"+Char(Double quote)+";"+Char(Double quote)+"urn:schemas-microsoft-com:office:excel"+Char(Double quote)+";"+Char(Double quote)+"xmlns:html"+Char(Double quote)+";"+Char(Double quote)+"http://www.w3.org/TR/REC-html40"+Char(Double quote)+")"+Char(Carriage return)+Char(Carriage return)

  //$macro_output_text:=$macro_output_text+Char(96)+"Impostazioni di standard documento xml"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+Char(96)+"_______________________________________________________________________________________"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"C_STRING(255;$encoding)"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"C_BOOLEAN($standalone;$indentation)"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"ARRAY STRING(255;$arrNames;0)"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"ARRAY STRING(255;$arrValues;0)"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$encoding:="+Char(Double quote)+"UTF-8"+Char(Double quote)+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$standalone:=True"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$indentation:=True"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"DOM SET XML OPTIONS($el_root;$encoding;$standalone;$indentation)"+Char(Carriage return)+Char(Carriage return)

  //$macro_output_text:=$macro_output_text+Char(96)+"Proprietà Documento"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+Char(96)+"_______________________________________________________________________________________"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"C_STRING(80;$Author)"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"C_STRING(80;$LastAuthor)"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"C_STRING(80;$Company)"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"C_STRING(20;$Version)"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"C_STRING(30;$Created)"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$Author:="+Char(Double quote)+"Supermedia S.r.l."+Char(Double quote)+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$LastAuthor:="+Char(Double quote)+"Supermedia S.r.l."+Char(Double quote)+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$Company:="+Char(Double quote)+"Supermedia S.r.l."+Char(Double quote)+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$Version:="+Char(Double quote)+"2.00"+Char(Double quote)+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$Created:=String(Year of(Current date(*));"+Char(Double quote)+"0000"+Char(Double quote)+")+"+Char(Double quote)+"-"+Char(Double quote)+"+String(Month of(Current date(*));"+Char(Double quote)+"00"+Char(Double quote)+")+"+Char(Double quote)+"-"+Char(Double quote)+"+String(Day of(Current date(*));"+Char(Double quote)+"00"+Char(Double quote)+")+"+Char(Double quote)+"T"+Char(Double quote)+"+String(Current time(*);HH MM SS )+"+Char(Double quote)+"Z"+Char(Double quote)+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$nm_document_properties:="+Char(Double quote)+"o:DocumentProperties"+Char(Double quote)+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_document_properties:=DOM Create XML element($el_root;$nm_root+"+Char(Double quote)+"/"+Char(Double quote)+"+$nm_document_properties)"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"DOM SET XML ELEMENT VALUE(DOM Create XML element($el_document_properties;$nm_document_properties+"+Char(Double quote)+"/o:Author"+Char(Double quote)+");$Author)"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"DOM SET XML ELEMENT VALUE(DOM Create XML element($el_document_properties;$nm_document_properties+"+Char(Double quote)+"/o:LastAuthor"+Char(Double quote)+");$LastAuthor)"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"DOM SET XML ELEMENT VALUE(DOM Create XML element($el_document_properties;$nm_document_properties+"+Char(Double quote)+"/o:Company"+Char(Double quote)+");$Company)"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"DOM SET XML ELEMENT VALUE(DOM Create XML element($el_document_properties;$nm_document_properties+"+Char(Double quote)+"/o:Version"+Char(Double quote)+");$Version)"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"DOM SET XML ELEMENT VALUE(DOM Create XML element($el_document_properties;$nm_document_properties+"+Char(Double quote)+"/o:Created"+Char(Double quote)+");$Created)"+Char(Carriage return)+Char(Carriage return)

  //$macro_output_text:=$macro_output_text+Char(96)+"Proprietà ExcelWorkBook"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+Char(96)+"_______________________________________________________________________________________"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"C_REAL($WindowHeight)"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"C_REAL($WindowWidth)"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"C_REAL($WindowTopX)"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"C_REAL($WindowTopY)"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"C_BOOLEAN($ProtectStructure;$ProtectWindows)"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$WindowHeight:=Int(Screen height(*)*19700/1050)-5"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$WindowWidth:=Int(Screen width(*)*33280/1680)-5"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$WindowTopX:=80"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$WindowTopY:=-20"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$ProtectStructure:=False"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$ProtectWindows:=False"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$nm_excelworkbook:="+Char(Double quote)+"x:ExcelWorkbook"+Char(Double quote)+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_excelworkbook:=DOM Create XML element($el_root;$nm_root+"+Char(Double quote)+"/"+Char(Double quote)+"+$nm_excelworkbook)"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"DOM SET XML ELEMENT VALUE(DOM Create XML element($el_excelworkbook;$nm_excelworkbook+"+Char(Double quote)+"/x:WindowHeight"+Char(Double quote)+");$WindowHeight)"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"DOM SET XML ELEMENT VALUE(DOM Create XML element($el_excelworkbook;$nm_excelworkbook+"+Char(Double quote)+"/x:WindowWidth"+Char(Double quote)+");$WindowWidth)"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"DOM SET XML ELEMENT VALUE(DOM Create XML element($el_excelworkbook;$nm_excelworkbook+"+Char(Double quote)+"/x:WindowTopX"+Char(Double quote)+");$WindowTopX)"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"DOM SET XML ELEMENT VALUE(DOM Create XML element($el_excelworkbook;$nm_excelworkbook+"+Char(Double quote)+"/x:WindowTopY"+Char(Double quote)+");$WindowTopY)"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"DOM SET XML ELEMENT VALUE(DOM Create XML element($el_excelworkbook;$nm_excelworkbook+"+Char(Double quote)+"/x:Date1904"+Char(Double quote)+");"+Char(Double quote)+""+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"DOM SET XML ELEMENT VALUE(DOM Create XML element($el_excelworkbook;$nm_excelworkbook+"+Char(Double quote)+"/x:RefModeR1C1"+Char(Double quote)+");"+Char(Double quote)+""+Char(Double quote)+")"+Char(Carriage return)+Char(Carriage return)

  //$macro_output_text:=$macro_output_text+Char(96)+"Stili"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+Char(96)+"_______________________________________________________________________________________"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$nm_styles:="+Char(Double quote)+"ss:Styles"+Char(Double quote)+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_styles:=DOM Create XML element($el_root;$nm_root+"+Char(Double quote)+"/"+Char(Double quote)+"+$nm_styles)"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_style:=DOM Create XML element($el_styles;$nm_styles+"+Char(Double quote)+"/ss:Style"+Char(Double quote)+";"+Char(Double quote)+"ss:ID"+Char(Double quote)+";"+Char(Double quote)+"Default"+Char(Double quote)+";"+Char(Double quote)+"ss:Name"+Char(Double quote)+";"+Char(Double quote)+"Normal"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_temp:=DOM Create XML element($el_style;"+Char(Double quote)+"ss:Style/ss:Alignment"+Char(Double quote)+";"+Char(Double quote)+"ss:Vertical"+Char(Double quote)+";"+Char(Double quote)+"Center"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_temp:=DOM Create XML element($el_style;"+Char(Double quote)+"ss:Style/ss:Font"+Char(Double quote)+";"+Char(Double quote)+"ss:FontName"+Char(Double quote)+";"+Char(Double quote)+"Verdana"+Char(Double quote)+";"+Char(Double quote)+"ss:Size"+Char(Double quote)+";"+Char(Double quote)+"9.00"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_temp:=DOM Create XML element($el_style;"+Char(Double quote)+"ss:Style/ss:Borders"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_temp:=DOM Create XML element($el_style;"+Char(Double quote)+"ss:Style/ss:Interior"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_temp:=DOM Create XML element($el_style;"+Char(Double quote)+"ss:Style/ss:NumberFormat"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_temp:=DOM Create XML element($el_style;"+Char(Double quote)+"ss:Style/ss:Protection"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_style:=DOM Create XML element($el_styles;$nm_styles+"+Char(Double quote)+"/ss:Style"+Char(Double quote)+";"+Char(Double quote)+"ss:ID"+Char(Double quote)+";"+Char(Double quote)+"Date"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_temp:=DOM Create XML element($el_style;"+Char(Double quote)+"ss:Style/ss:Alignment"+Char(Double quote)+";"+Char(Double quote)+"ss:Horizontal"+Char(Double quote)+";"+Char(Double quote)+"Center"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_temp:=DOM Create XML element($el_style;"+Char(Double quote)+"ss:Style/ss:NumberFormat"+Char(Double quote)+";"+Char(Double quote)+"ss:Format"+Char(Double quote)+";"+Char(Double quote)+"dd/mm/yy"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_style:=DOM Create XML element($el_styles;$nm_styles+"+Char(Double quote)+"/ss:Style"+Char(Double quote)+";"+Char(Double quote)+"ss:ID"+Char(Double quote)+";"+Char(Double quote)+"Ore"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_temp:=DOM Create XML element($el_style;"+Char(Double quote)+"ss:Style/ss:Alignment"+Char(Double quote)+";"+Char(Double quote)+"ss:Horizontal"+Char(Double quote)+";"+Char(Double quote)+"Center"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_temp:=DOM Create XML element($el_style;"+Char(Double quote)+"ss:Style/ss:NumberFormat"+Char(Double quote)+";"+Char(Double quote)+"ss:Format"+Char(Double quote)+";"+Char(Double quote)+"hh:mm:ss"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_style:=DOM Create XML element($el_styles;$nm_styles+"+Char(Double quote)+"/ss:Style"+Char(Double quote)+";"+Char(Double quote)+"ss:ID"+Char(Double quote)+";"+Char(Double quote)+"Integer"+Char(Double quote)+")  "+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_temp:=DOM Create XML element($el_style;"+Char(Double quote)+"ss:Style/ss:NumberFormat"+Char(Double quote)+";"+Char(Double quote)+"ss:Format"+Char(Double quote)+";"+Char(Double quote)+"#,##0_ ;[Red]\\-#,##0\\ "+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_style:=DOM Create XML element($el_styles;$nm_styles+"+Char(Double quote)+"/ss:Style"+Char(Double quote)+";"+Char(Double quote)+"ss:ID"+Char(Double quote)+";"+Char(Double quote)+"Integer_bold"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_temp:=DOM Create XML element($el_style;"+Char(Double quote)+"ss:Style/ss:NumberFormat"+Char(Double quote)+";"+Char(Double quote)+"ss:Format"+Char(Double quote)+";"+Char(Double quote)+"#,##0_ ;[Red]\\-#,##0\\ "+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_temp:=DOM Create XML element($el_style;"+Char(Double quote)+"ss:Style/ss:Font"+Char(Double quote)+";"+Char(Double quote)+"ss:Bold"+Char(Double quote)+";"+Char(Double quote)+"1"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_style:=DOM Create XML element($el_styles;$nm_styles+"+Char(Double quote)+"/ss:Style"+Char(Double quote)+";"+Char(Double quote)+"ss:ID"+Char(Double quote)+";"+Char(Double quote)+"Integer_centered"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_temp:=DOM Create XML element($el_style;"+Char(Double quote)+"ss:Style/ss:Alignment"+Char(Double quote)+";"+Char(Double quote)+"ss:Horizontal"+Char(Double quote)+";"+Char(Double quote)+"Center"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_temp:=DOM Create XML element($el_style;"+Char(Double quote)+"ss:Style/ss:NumberFormat"+Char(Double quote)+";"+Char(Double quote)+"ss:Format"+Char(Double quote)+";"+Char(Double quote)+"#,##0_ ;[Red]\\-#,##0\\ "+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_style:=DOM Create XML element($el_styles;$nm_styles+"+Char(Double quote)+"/ss:Style"+Char(Double quote)+";"+Char(Double quote)+"ss:ID"+Char(Double quote)+";"+Char(Double quote)+"Integer_centered_bold"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_temp:=DOM Create XML element($el_style;"+Char(Double quote)+"ss:Style/ss:Alignment"+Char(Double quote)+";"+Char(Double quote)+"ss:Horizontal"+Char(Double quote)+";"+Char(Double quote)+"Center"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_temp:=DOM Create XML element($el_style;"+Char(Double quote)+"ss:Style/ss:Font"+Char(Double quote)+";"+Char(Double quote)+"ss:Bold"+Char(Double quote)+";"+Char(Double quote)+"1"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_temp:=DOM Create XML element($el_style;"+Char(Double quote)+"ss:Style/ss:NumberFormat"+Char(Double quote)+";"+Char(Double quote)+"ss:Format"+Char(Double quote)+";"+Char(Double quote)+"#,##0_ ;[Red]\\-#,##0\\ "+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_style:=DOM Create XML element($el_styles;$nm_styles+"+Char(Double quote)+"/ss:Style"+Char(Double quote)+";"+Char(Double quote)+"ss:ID"+Char(Double quote)+";"+Char(Double quote)+"String_Centered"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_temp:=DOM Create XML element($el_style;"+Char(Double quote)+"ss:Style/ss:Alignment"+Char(Double quote)+";"+Char(Double quote)+"ss:Horizontal"+Char(Double quote)+";"+Char(Double quote)+"Center"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_style:=DOM Create XML element($el_styles;$nm_styles+"+Char(Double quote)+"/ss:Style"+Char(Double quote)+";"+Char(Double quote)+"ss:ID"+Char(Double quote)+";"+Char(Double quote)+"String_Left"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_temp:=DOM Create XML element($el_style;"+Char(Double quote)+"ss:Style/ss:Alignment"+Char(Double quote)+";"+Char(Double quote)+"ss:Horizontal"+Char(Double quote)+";"+Char(Double quote)+"Left"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_style:=DOM Create XML element($el_styles;$nm_styles+"+Char(Double quote)+"/ss:Style"+Char(Double quote)+";"+Char(Double quote)+"ss:ID"+Char(Double quote)+";"+Char(Double quote)+"String_Right"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_temp:=DOM Create XML element($el_style;"+Char(Double quote)+"ss:Style/ss:Alignment"+Char(Double quote)+";"+Char(Double quote)+"ss:Horizontal"+Char(Double quote)+";"+Char(Double quote)+"Right"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_style:=DOM Create XML element($el_styles;$nm_styles+"+Char(Double quote)+"/ss:Style"+Char(Double quote)+";"+Char(Double quote)+"ss:ID"+Char(Double quote)+";"+Char(Double quote)+"String_Right_Bold"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_temp:=DOM Create XML element($el_style;"+Char(Double quote)+"ss:Style/ss:Alignment"+Char(Double quote)+";"+Char(Double quote)+"ss:Horizontal"+Char(Double quote)+";"+Char(Double quote)+"Right"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_temp:=DOM Create XML element($el_style;"+Char(Double quote)+"ss:Style/ss:Font"+Char(Double quote)+";"+Char(Double quote)+"ss:Bold"+Char(Double quote)+";"+Char(Double quote)+"1"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_style:=DOM Create XML element($el_styles;$nm_styles+"+Char(Double quote)+"/ss:Style"+Char(Double quote)+";"+Char(Double quote)+"ss:ID"+Char(Double quote)+";"+Char(Double quote)+"Titles"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_temp:=DOM Create XML element($el_style;"+Char(Double quote)+"ss:Style/ss:Alignment"+Char(Double quote)+";"+Char(Double quote)+"ss:Vertical"+Char(Double quote)+";"+Char(Double quote)+"Center"+Char(Double quote)+";"+Char(Double quote)+"ss:Horizontal"+Char(Double quote)+";"+Char(Double quote)+"Center"+Char(Double quote)+";"+Char(Double quote)+"ss:WrapText"+Char(Double quote)+";"+Char(Double quote)+"0"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_temp:=DOM Create XML element($el_style;"+Char(Double quote)+"ss:Style/ss:Font"+Char(Double quote)+";"+Char(Double quote)+"ss:FontName"+Char(Double quote)+";"+Char(Double quote)+"Verdana"+Char(Double quote)+";"+Char(Double quote)+"ss:Size"+Char(Double quote)+";"+Char(Double quote)+"9.00"+Char(Double quote)+";"+Char(Double quote)+"ss:Bold"+Char(Double quote)+";"+Char(Double quote)+"1"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_style:=DOM Create XML element($el_styles;$nm_styles+"+Char(Double quote)+"/ss:Style"+Char(Double quote)+";"+Char(Double quote)+"ss:ID"+Char(Double quote)+";"+Char(Double quote)+"Currency"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_temp:=DOM Create XML element($el_style;"+Char(Double quote)+"ss:Style/ss:NumberFormat"+Char(Double quote)+";"+Char(Double quote)+"ss:Format"+Char(Double quote)+";"+Char(Double quote)+"#,##0.00_ ;[Red]\\-#,##0.00\\ "+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_style:=DOM Create XML element($el_styles;$nm_styles+"+Char(Double quote)+"/ss:Style"+Char(Double quote)+";"+Char(Double quote)+"ss:ID"+Char(Double quote)+";"+Char(Double quote)+"Currency_bold"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_temp:=DOM Create XML element($el_style;"+Char(Double quote)+"ss:Style/ss:NumberFormat"+Char(Double quote)+";"+Char(Double quote)+"ss:Format"+Char(Double quote)+";"+Char(Double quote)+"#,##0.00_ ;[Red]\\-#,##0.00\\ "+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_temp:=DOM Create XML element($el_style;"+Char(Double quote)+"ss:Style/ss:Font"+Char(Double quote)+";"+Char(Double quote)+"ss:Bold"+Char(Double quote)+";"+Char(Double quote)+"1"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_style:=DOM Create XML element($el_styles;$nm_styles+"+Char(Double quote)+"/ss:Style"+Char(Double quote)+";"+Char(Double quote)+"ss:ID"+Char(Double quote)+";"+Char(Double quote)+"Percent"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_temp:=DOM Create XML element($el_style;"+Char(Double quote)+"ss:Style/ss:NumberFormat"+Char(Double quote)+";"+Char(Double quote)+"ss:Format"+Char(Double quote)+";"+Char(Double quote)+"#,##0.0% ;[Red]-#,##0.0%"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_style:=DOM Create XML element($el_styles;$nm_styles+"+Char(Double quote)+"/ss:Style"+Char(Double quote)+";"+Char(Double quote)+"ss:ID"+Char(Double quote)+";"+Char(Double quote)+"Percent_bold"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_temp:=DOM Create XML element($el_style;"+Char(Double quote)+"ss:Style/ss:NumberFormat"+Char(Double quote)+";"+Char(Double quote)+"ss:Format"+Char(Double quote)+";"+Char(Double quote)+"#,##0.0% ;[Red]-#,##0.0%"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_temp:=DOM Create XML element($el_style;"+Char(Double quote)+"ss:Style/ss:Font"+Char(Double quote)+";"+Char(Double quote)+"ss:Bold"+Char(Double quote)+";"+Char(Double quote)+"1"+Char(Double quote)+")"+Char(Carriage return)+Char(Carriage return)

  //$macro_output_text:=$macro_output_text+Char(96)+"Worksheet"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+Char(96)+"_______________________________________________________________________________________"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$nm_worksheet:="+Char(Double quote)+"ss:Worksheet"+Char(Double quote)+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_worksheet:=DOM Create XML element($el_root;$nm_root+"+Char(Double quote)+"/"+Char(Double quote)+"+$nm_worksheet;"+Char(Double quote)+"ss:Name"+Char(Double quote)+";"+Char(Double quote)+Table name($selected_table_number)+Char(Double quote)+")"+Char(Carriage return)+Char(Carriage return)

  //$macro_output_text:=$macro_output_text+Char(96)+"Table"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+Char(96)+"_______________________________________________________________________________________"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$nm_table:="+Char(Double quote)+"ss:Table"+Char(Double quote)+Char(Carriage return)
  //$field_name:=Replace string(Replace string(Field name($selected_table_number;1);" ";"_");"à";"a")
  //$macro_output_text:=$macro_output_text+"$el_table:=DOM Create XML element($el_root;$nm_root+"+Char(Double quote)+"/"+Char(Double quote)+"+$nm_worksheet+"+Char(Double quote)+"/"+Char(Double quote)+"+$nm_table;"+Char(Double quote)+"ss:ExpandedColumnCount"+Char(Double quote)+";"+Char(Double quote)+String(Get last field number($selected_table_number))+Char(Double quote)+";"+Char(Double quote)+"ss:ExpandedRowCount"+Char(Double quote)+";String(Size of array("+Substring($array_prefix+$field_name;1;31)+")+1);"+Char(Double quote)+"x:FullColumns"+Char(Double quote)+";"+Char(Double quote)+"1"+Char(Double quote)+";"+Char(Double quote)+"x:FullRows"+Char(Double quote)+";"+Char(Double quote)+"1"+Char(Double quote)+")"+Char(Carriage return)+Char(Carriage return)

  //$macro_output_text:=$macro_output_text+Char(96)+"Larghezza Colonne"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+Char(96)+"_______________________________________________________________________________________"+Char(Carriage return)
  //For ($selected_field_number;1;Get last field number($selected_table_number))
  //$macro_output_text:=$macro_output_text+"$el_temp:=DOM Create XML element($el_table;$nm_table+"+Char(Double quote)+"/ss:Column"+Char(Double quote)+";"+Char(Double quote)+"ss:Index"+Char(Double quote)+";"+Char(Double quote)+String($selected_field_number)+Char(Double quote)+";"+Char(Double quote)+"ss:Width"+Char(Double quote)+";"+Char(Double quote)+"100.0"+Char(Double quote)+")"+Char(96)+String($selected_field_number)+Char(Carriage return)
  //If ($selected_field_number=Get last field number($selected_table_number))
  //$macro_output_text:=$macro_output_text+Char(Carriage return)
  //End if 
  //End for 
  //$macro_output_text:=$macro_output_text+Char(96)+"Prima Riga Titoli"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+Char(96)+"_______________________________________________________________________________________"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_row:=DOM Create XML element($el_table;$nm_table+"+Char(Double quote)+"/ss:Row"+Char(Double quote)+";"+Char(Double quote)+"ss:AutoFitHeight"+Char(Double quote)+";"+Char(Double quote)+"0"+Char(Double quote)+";"+Char(Double quote)+"ss:Height"+Char(Double quote)+";"+Char(Double quote)+"40.0"+Char(Double quote)+")"+Char(Carriage return)
  //For ($selected_field_number;1;Get last field number($selected_table_number))
  //$field_name:=Replace string(Replace string(Field name($selected_table_number;$selected_field_number);" ";"_");"à";"a")
  //$macro_output_text:=$macro_output_text+"$el_cell:=DOM Create XML element($el_row;"+Char(Double quote)+"ss:Row/ss:Cell"+Char(Double quote)+";"+Char(Double quote)+"ss:StyleID"+Char(Double quote)+";"+Char(Double quote)+"Titles"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_data:=DOM Create XML element($el_cell;"+Char(Double quote)+"ss:Cell/ss:Data"+Char(Double quote)+";"+Char(Double quote)+"ss:Type"+Char(Double quote)+";"+Char(Double quote)+"String"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"DOM SET XML ELEMENT VALUE($el_data;"+Char(Double quote)+$field_name+Char(Double quote)+")"+Char(96)+String($selected_field_number)+Char(Carriage return)
  //If ($selected_field_number=Get last field number($selected_table_number))
  //$macro_output_text:=$macro_output_text+Char(Carriage return)
  //End if 
  //End for 

  //$macro_output_text:=$macro_output_text+Char(96)+"Righe Dati"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+Char(96)+"_______________________________________________________________________________________"+Char(Carriage return)
  //$field_name:=Replace string(Replace string(Field name($selected_table_number;1);" ";"_");"à";"a")
  //$macro_output_text:=$macro_output_text+"For ($i;1;Size of array("+Substring($array_prefix+$field_name;1;31)+"))"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_row:=DOM Create XML element($el_table;$nm_table+"+Char(Double quote)+"/ss:Row"+Char(Double quote)+")"+Char(Carriage return)
  //For ($selected_field_number;1;Get last field number($selected_table_number))
  //$field_name:=Replace string(Replace string(Field name($selected_table_number;$selected_field_number);" ";"_");"à";"a")
  //$array_name:=Substring($array_prefix+$field_name;1;31)
  //GET FIELD PROPERTIES($selected_table_number;$selected_field_number;$selected_field_type;$selected_field_length)
  //Case of 
  //: ($selected_field_type=Is alpha field)
  //$macro_output_text:=$macro_output_text+"$el_cell:=DOM Create XML element($el_row;"+Char(Double quote)+"ss:Row/ss:Cell"+Char(Double quote)+";"+Char(Double quote)+"ss:StyleID"+Char(Double quote)+";"+Char(Double quote)+"String_Left"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_data:=DOM Create XML element($el_cell;"+Char(Double quote)+"ss:Cell/ss:Data"+Char(Double quote)+";"+Char(Double quote)+"ss:Type"+Char(Double quote)+";"+Char(Double quote)+"String"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"DOM SET XML ELEMENT VALUE($el_data;"+$array_name+"{$i})"+Char(96)+String($selected_field_number)+Char(Carriage return)
  //: ($selected_field_type=Is text)
  //$macro_output_text:=$macro_output_text+"$el_cell:=DOM Create XML element($el_row;"+Char(Double quote)+"ss:Row/ss:Cell"+Char(Double quote)+";"+Char(Double quote)+"ss:StyleID"+Char(Double quote)+";"+Char(Double quote)+"String_Left"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_data:=DOM Create XML element($el_cell;"+Char(Double quote)+"ss:Cell/ss:Data"+Char(Double quote)+";"+Char(Double quote)+"ss:Type"+Char(Double quote)+";"+Char(Double quote)+"String"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"DOM SET XML ELEMENT VALUE($el_data;"+$array_name+"{$i})"+Char(96)+String($selected_field_number)+Char(Carriage return)
  //: (($selected_field_type=Is real) | ($selected_field_type=Is float))
  //$macro_output_text:=$macro_output_text+"$el_cell:=DOM Create XML element($el_row;"+Char(Double quote)+"ss:Row/ss:Cell"+Char(Double quote)+";"+Char(Double quote)+"ss:StyleID"+Char(Double quote)+";"+Char(Double quote)+"Currency"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_data:=DOM Create XML element($el_cell;"+Char(Double quote)+"ss:Cell/ss:Data"+Char(Double quote)+";"+Char(Double quote)+"ss:Type"+Char(Double quote)+";"+Char(Double quote)+"Number"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"DOM SET XML ELEMENT VALUE($el_data;ssXML_SetValue (->"+$array_name+"{$i}))"+Char(96)+String($selected_field_number)+Char(Carriage return)
  //: (($selected_field_type=Is longint) | ($selected_field_type=Is integer 64 bits) | ($selected_field_type=Is integer))
  //$macro_output_text:=$macro_output_text+"$el_cell:=DOM Create XML element($el_row;"+Char(Double quote)+"ss:Row/ss:Cell"+Char(Double quote)+";"+Char(Double quote)+"ss:StyleID"+Char(Double quote)+";"+Char(Double quote)+"Integer"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_data:=DOM Create XML element($el_cell;"+Char(Double quote)+"ss:Cell/ss:Data"+Char(Double quote)+";"+Char(Double quote)+"ss:Type"+Char(Double quote)+";"+Char(Double quote)+"Number"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"DOM SET XML ELEMENT VALUE($el_data;ssXML_SetValue (->"+$array_name+"{$i}))"+Char(96)+String($selected_field_number)+Char(Carriage return)
  //: ($selected_field_type=Is date)
  //$macro_output_text:=$macro_output_text+"If ("+$array_name+"{$i}#!00-00-00!)"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_cell:=DOM Create XML element($el_row;"+Char(Double quote)+"ss:Row/ss:Cell"+Char(Double quote)+";"+Char(Double quote)+"ss:StyleID"+Char(Double quote)+";"+Char(Double quote)+"Date"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_data:=DOM Create XML element($el_cell;"+Char(Double quote)+"ss:Cell/ss:Data"+Char(Double quote)+";"+Char(Double quote)+"ss:Type"+Char(Double quote)+";"+Char(Double quote)+"DateTime"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"DOM SET XML ELEMENT VALUE($el_data;String ("+$array_name+"{$i};ISO Date))"+Char(96)+String($selected_field_number)+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"Else"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_cell:=DOM Create XML element($el_row;"+Char(Double quote)+"ss:Row/ss:Cell"+Char(Double quote)+";"+Char(Double quote)+"ss:StyleID"+Char(Double quote)+";"+Char(Double quote)+"String_Left"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_data:=DOM Create XML element($el_cell;"+Char(Double quote)+"ss:Cell/ss:Data"+Char(Double quote)+";"+Char(Double quote)+"ss:Type"+Char(Double quote)+";"+Char(Double quote)+"String"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"DOM SET XML ELEMENT VALUE($el_data;"+Char(Double quote)+"00/00/00"+Char(Double quote)+")"+Char(96)+String($selected_field_number)+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"End if"+Char(Carriage return)
  //: ($selected_field_type=Is time)
  //$macro_output_text:=$macro_output_text+"$el_cell:=DOM Create XML element($el_row;"+Char(Double quote)+"ss:Row/ss:Cell"+Char(Double quote)+";"+Char(Double quote)+"ss:StyleID"+Char(Double quote)+";"+Char(Double quote)+"String_Left"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_data:=DOM Create XML element($el_cell;"+Char(Double quote)+"ss:Cell/ss:Data"+Char(Double quote)+";"+Char(Double quote)+"ss:Type"+Char(Double quote)+";"+Char(Double quote)+"String"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"DOM SET XML ELEMENT VALUE($el_data;Time string ("+$array_name+"{$i}))"+Char(96)+String($selected_field_number)+Char(Carriage return)
  //: ($selected_field_type=Is boolean)
  //$macro_output_text:=$macro_output_text+"$el_cell:=DOM Create XML element($el_row;"+Char(Double quote)+"ss:Row/ss:Cell"+Char(Double quote)+";"+Char(Double quote)+"ss:StyleID"+Char(Double quote)+";"+Char(Double quote)+"String_Left"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_data:=DOM Create XML element($el_cell;"+Char(Double quote)+"ss:Cell/ss:Data"+Char(Double quote)+";"+Char(Double quote)+"ss:Type"+Char(Double quote)+";"+Char(Double quote)+"String"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"DOM SET XML ELEMENT VALUE($el_data;Choose("+$array_name+"{$i};"+Char(Double quote)+"True"+Char(Double quote)+";"+Char(Double quote)+"False"+Char(Double quote)+"))"+Char(96)+String($selected_field_number)+Char(Carriage return)
  //: ($selected_field_type=Is picture)
  //$macro_output_text:=$macro_output_text+"$el_cell:=DOM Create XML element($el_row;"+Char(Double quote)+"ss:Row/ss:Cell"+Char(Double quote)+";"+Char(Double quote)+"ss:StyleID"+Char(Double quote)+";"+Char(Double quote)+"String_Left"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_data:=DOM Create XML element($el_cell;"+Char(Double quote)+"ss:Cell/ss:Data"+Char(Double quote)+";"+Char(Double quote)+"ss:Type"+Char(Double quote)+";"+Char(Double quote)+"String"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"DOM SET XML ELEMENT VALUE($el_data;"+Char(Double quote)+"PICTURE"+Char(Double quote)+")"+Char(96)+String($selected_field_number)+Char(Carriage return)
  //: ($selected_field_type=Is BLOB)
  //$macro_output_text:=$macro_output_text+"$el_cell:=DOM Create XML element($el_row;"+Char(Double quote)+"ss:Row/ss:Cell"+Char(Double quote)+";"+Char(Double quote)+"ss:StyleID"+Char(Double quote)+";"+Char(Double quote)+"String_Left"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_data:=DOM Create XML element($el_cell;"+Char(Double quote)+"ss:Cell/ss:Data"+Char(Double quote)+";"+Char(Double quote)+"ss:Type"+Char(Double quote)+";"+Char(Double quote)+"String"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"DOM SET XML ELEMENT VALUE($el_data;"+Char(Double quote)+"BLOB"+Char(Double quote)+")"+Char(96)+String($selected_field_number)+Char(Carriage return)
  //Else 
  //$macro_output_text:=$macro_output_text+"$el_cell:=DOM Create XML element($el_row;"+Char(Double quote)+"ss:Row/ss:Cell"+Char(Double quote)+";"+Char(Double quote)+"ss:StyleID"+Char(Double quote)+";"+Char(Double quote)+"String_Left"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_data:=DOM Create XML element($el_cell;"+Char(Double quote)+"ss:Cell/ss:Data"+Char(Double quote)+";"+Char(Double quote)+"ss:Type"+Char(Double quote)+";"+Char(Double quote)+"String"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"DOM SET XML ELEMENT VALUE($el_data;"+Char(Double quote)+"SUBTABLE"+Char(Double quote)+")"+Char(96)+String($selected_field_number)+Char(Carriage return)
  //End case 
  //End for 
  //$macro_output_text:=$macro_output_text+"End for"+Char(Carriage return)+Char(Carriage return)

  //$macro_output_text:=$macro_output_text+Char(96)+"Proprietà WorksheetOptions"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+Char(96)+"_______________________________________________________________________________________"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$nm_worksheetoptions:="+Char(Double quote)+"x:WorksheetOptions"+Char(Double quote)+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_worksheetoptions:=DOM Create XML element($el_worksheet;$nm_worksheet+"+Char(Double quote)+"/"+Char(Double quote)+"+$nm_worksheetoptions)"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"DOM SET XML ELEMENT VALUE(DOM Create XML element($el_worksheetoptions;$nm_worksheetoptions+"+Char(Double quote)+"/x:PageLayoutZoom"+Char(Double quote)+");"+Char(Double quote)+"0"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"DOM SET XML ELEMENT VALUE(DOM Create XML element($el_worksheetoptions;$nm_worksheetoptions+"+Char(Double quote)+"/x:Selected"+Char(Double quote)+");"+Char(Double quote)+""+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"DOM SET XML ELEMENT VALUE(DOM Create XML element($el_worksheetoptions;$nm_worksheetoptions+"+Char(Double quote)+"/x:FreezePanes"+Char(Double quote)+");"+Char(Double quote)+""+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"DOM SET XML ELEMENT VALUE(DOM Create XML element($el_worksheetoptions;$nm_worksheetoptions+"+Char(Double quote)+"/x:SplitHorizontal"+Char(Double quote)+");"+Char(Double quote)+"1"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"DOM SET XML ELEMENT VALUE(DOM Create XML element($el_worksheetoptions;$nm_worksheetoptions+"+Char(Double quote)+"/x:TopRowBottomPane"+Char(Double quote)+");"+Char(Double quote)+"1"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"DOM SET XML ELEMENT VALUE(DOM Create XML element($el_worksheetoptions;$nm_worksheetoptions+"+Char(Double quote)+"/x:ActivePane"+Char(Double quote)+");"+Char(Double quote)+"2"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$nm_panes:="+Char(Double quote)+"x:Panes"+Char(Double quote)+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_panes:=DOM Create XML element($el_worksheetoptions;$nm_worksheetoptions+"+Char(Double quote)+"/"+Char(Double quote)+"+$nm_panes)"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_pane:=DOM Create XML element($el_panes;$nm_panes+"+Char(Double quote)+"/x:Pane"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"DOM SET XML ELEMENT VALUE(DOM Create XML element($el_pane;"+Char(Double quote)+"x:Pane/x:Number"+Char(Double quote)+");"+Char(Double quote)+"3"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$el_pane:=DOM Create XML element($el_panes;$nm_panes+"+Char(Double quote)+"/x:Pane"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"DOM SET XML ELEMENT VALUE(DOM Create XML element($el_pane;"+Char(Double quote)+"x:Pane/x:Number"+Char(Double quote)+");"+Char(Double quote)+"2"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"DOM SET XML ELEMENT VALUE(DOM Create XML element($el_pane;"+Char(Double quote)+"x:Pane/x:ActiveRow"+Char(Double quote)+");"+Char(Double quote)+"0"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"DOM SET XML ELEMENT VALUE(DOM Create XML element($el_worksheetoptions;$nm_worksheetoptions+"+Char(Double quote)+"/x:ProtectObjects"+Char(Double quote)+");"+Char(Double quote)+"False"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"DOM SET XML ELEMENT VALUE(DOM Create XML element($el_worksheetoptions;$nm_worksheetoptions+"+Char(Double quote)+"/x:ProtectScenarios"+Char(Double quote)+");"+Char(Double quote)+"False"+Char(Double quote)+")"+Char(Carriage return)

  //$macro_output_text:=$macro_output_text+"$Folder:=System folder(Desktop )"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"$FileName:="+Char(Double quote)+Table name($selected_table_number)+"_"+Char(Double quote)+"+String(((Current date(*)-!01-01-1970!)*86400)+Current time(*))"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"DOM EXPORT TO FILE($el_root;$Folder+$FileName)"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"SET DOCUMENT CREATOR($Folder+$FileName;"+Char(Double quote)+"XCEL"+Char(Double quote)+")"+Char(Carriage return)
  //$macro_output_text:=$macro_output_text+"SET DOCUMENT TYPE($Folder+$FileName;"+Char(Double quote)+"XMLS"+Char(Double quote)+")"+Char(Carriage return)
  //End if 
  //End if 
  //SET MACRO PARAMETER(Highlighted method text;$macro_output_text)

