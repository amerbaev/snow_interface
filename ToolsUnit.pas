unit ToolsUnit;

interface

uses
  Messages, SysUtils, Variants, Classes, Dialogs;

type
  TTools = class(TObject)
  private
    {private declarations}
  public
    function ReplaceSpaces(WorkString:string; numofvar: Integer): String;
    procedure ReplacePoint(M: TStrings; numofvar: Integer);
    function SingleString(const filename:string; stringnum: Integer):string;
    procedure FileCopy(Const SourceFileName, TargetFileName: String);
    procedure FileStringReplace(FileName: string; StringNum: Integer; Prase: string);
  end;

implementation

//Delete uneceessary spaces
function TTools.ReplaceSpaces(WorkString:string; numofvar: Integer): String;
var
  i, k, space, tab: Integer;
begin
  //Delete all spaces and tabs on start of line
  while( (WorkString[1]=' ') or (WorkString[1]=#9) ) do
    Delete(WorkString, 1, 1);

  for i:=1 to numofvar-1 do
  begin
    //Find first space or tab position
    space := Pos(' ', WorkString);
    tab := Pos(#9, WorkString);

    if ( ( (space < tab) and (space > 0) ) or ( tab = 0 ) )then
      k:=space
    else
      k:=tab;

    //Delete all tabs and spaces after found
    while( (WorkString[k+1]=' ') or (WorkString[k+1]=#9) ) do
      Delete(WorkString, k+1, 1);
    WorkString[k]:='_'; {Replace found to underscore for find next space or tab on next iteration}
  end;
  Result:=WorkString;
end;

//Right fraction divider
procedure TTools.ReplacePoint(M: TStrings; numofvar: Integer);
var
  i, pointpos: Integer;
begin
  for i:=0 to numofvar-1 do
  { Replace divider from point to comma}
  begin
    pointpos:=pos('.',M.Strings[i]);
    //If point in start then replace it to "0,"
    if(pointpos=1) then
      M.Strings[i]:= StringReplace(M.Strings[i],'.','0,',[rfReplaceAll])
    else
      //If point in end then just delete it
      if((pointpos>0) and (Length(M.Strings[i])=pointpos)) then
         M.Strings[i]:=StringReplace(M.Strings[i],'.','',[rfReplaceAll]);
    //Replace all remaining points to commas
    M.Strings[i]:=StringReplace(M.Strings[i],'.',',',[rfReplaceAll]);
  end;
end;

//Get the required line
function TTools.SingleString(const filename:string; stringnum: Integer):string;
var
  M:TStrings;
begin
  M:=TStringList.Create; //Create array of strings
  M.LoadFromFile(filename); //Read file to array
  Result:=M.Strings[stringnum]; //Get string
  M.Free;
end;

//Copy file
procedure TTools.FileCopy(Const SourceFileName, TargetFileName: String);
var
  A,F : TFileStream;
begin
  A := TFileStream.Create(sourcefilename, fmOpenRead );
  try
    F := TFileStream.Create(targetfilename, fmOpenWrite or fmCreate);
    try
      F.CopyFrom(A, A.Size ) ;
      FileSetDate(F.Handle, FileGetDate(A.Handle));
    finally
      F.Free;
    end;
  finally
    A.Free;
  end;
end;

procedure TTools.FileStringReplace(FileName: string; StringNum: Integer; Prase: string);
var
  M:TStrings;
begin
  M:=TStringList.Create;

  M.LoadFromFile(FileName);
  M.Strings[StringNum]:=Prase;
  M.SaveToFile(FileName);

  M.Free;
end;

end.
