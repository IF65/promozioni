//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): Italmark
  // Date and time: 18-03-12, 07:42:16
  // ----------------------------------------------------
  // Method: ssQC_AL_Setup
  // Description
  // General settings for all the areas
  // This should be the last setting
  // Parameters
  // ----------------------------------------------------

C_LONGINT:C283($1)

$row_height:=13

$font:="Arial"
$font_size:=11
$font_bold:=0
$font_header:="Arial"
$font_header_size:=10
$font_header_bold:=1
$font_footer:="Arial"
$font_footer_size:=10
$font_footer_bold:=1

AL_SetAreaLongProperty ($1;ALP_Area_AutoSnapLastColumn;1)
AL_SetAreaLongProperty ($1;ALP_Area_ShowColDividers;1)
AL_SetAreaLongProperty ($1;ALP_Area_ColDivColor;(255 << 24)+(212 << 16)+(212 << 8)+212)
AL_SetAreaLongProperty ($1;ALP_Area_ShowRowDividers;0)
AL_SetAreaLongProperty ($1;ALP_Area_RowDivColor;(255 << 24)+(212 << 16)+(212 << 8)+212)
AL_SetAreaLongProperty ($1;ALP_Area_AltRowOptions;5)
AL_SetAreaLongProperty ($1;ALP_Area_AltRowColor;(255 << 24)+<>AlternateTableBackground)
AL_SetAreaLongProperty ($1;ALP_Area_DrawFrame;0)  //no frame
AL_SetAreaLongProperty ($1;ALP_Area_ShowFocus;0)  //no frame
AL_SetAreaLongProperty ($1;ALP_Area_ColumnResize;0)
AL_SetAreaRealProperty ($1;ALP_Area_MinRowHeight;$row_height)
AL_SetAreaRealProperty ($1;ALP_Area_MinHdrHeight;$row_height)
AL_SetAreaRealProperty ($1;ALP_Area_MinFtrHeight;$row_height)
AL_SetAreaLongProperty ($1;ALP_Area_SmallScrollbar;1)
AL_SetAreaLongProperty ($1;ALP_Area_RowHeightFixed;1)
AL_SetAreaRealProperty ($1;ALP_Area_RowIndentV;4)
AL_SetAreaLongProperty ($1;ALP_Area_NumRowLines;1)
AL_SetAreaLongProperty ($1;ALP_Area_SelPreserve;1)
AL_SetAreaLongProperty ($1;ALP_Area_SelNone;1)
AL_SetAreaRealProperty ($1;ALP_Area_HierIndent;10)

AL_SetColumnTextProperty ($1;-2;ALP_Column_FontName;$font;1)
AL_SetColumnRealProperty ($1;-2;ALP_Column_Size;$font_size;1)
AL_SetColumnLongProperty ($1;-2;ALP_Column_StyleB;$font_bold;1)
AL_SetColumnLongProperty ($1;-2;ALP_Column_VertAlign;1;1)  //top
AL_SetColumnLongProperty ($1;-2;ALP_Column_Wrap;0;1)
AL_SetColumnTextProperty ($1;-2;ALP_Column_HdrFontName;$font_header;1)
AL_SetColumnRealProperty ($1;-2;ALP_Column_HdrSize;$font_header_size;1)
AL_SetColumnLongProperty ($1;-2;ALP_Column_HdrStyleB;$font_header_bold;1)
AL_SetColumnTextProperty ($1;-2;ALP_Column_HdrFontName;$font_footer;1)
AL_SetColumnLongProperty ($1;-2;ALP_Column_HdrHorAlign;2;1)  //center
AL_SetColumnLongProperty ($1;-2;ALP_Column_HdrVertAlign;2;1)  //center
AL_SetColumnLongProperty ($1;-2;ALP_Column_HdrWrap;0;1)
AL_SetColumnRealProperty ($1;-2;ALP_Column_FtrSize;$font_footer_size;1)
AL_SetColumnLongProperty ($1;-2;ALP_Column_FtrStyleB;$font_footer_bold;1)
AL_SetColumnLongProperty ($1;-2;ALP_Column_FtrVertAlign;1;1)

AL_SetAreaLongProperty ($1;ALP_Area_Appearance;0)
