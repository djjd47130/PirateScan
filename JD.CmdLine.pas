unit JD.CmdLine;

interface

uses
  System.Classes, System.SysUtils, System.Generics.Collections;

type
  TCommandLineParam = class;
  TCommandLine = class;

  TCommandLineParamType = (ptSwitch, ptBoolean, ptString, ptInteger);

  TCommandLine = class(TObject)
  private
    FCmdLine: String;
    FParams: TStringList;
    FDefs: TObjectList<TCommandLineParam>;
    FAppDescription: String;
    procedure SetAppDescription(const Value: String);
    function UsageStr: String;
  public
    constructor Create(ACmdLine: String);
    destructor Destroy; override;
    function Count: Integer;
    function Item(const Index: Integer): String;
    function Name(const Index: Integer): String;
    function Value(const Name: String): String; overload;
    function Value(const Index: Integer): String; overload;
    function Exists(const N: String): Boolean;
    function DirAndFilename: String;
    function Directory: String;
    function Filename: String;
    function Extension: String;
    function Module: String;

    function S(const N: String): String;
    function I(const N: String): Integer;
    function B(const N: String): Boolean;
    function F(const N: String): Single;

    procedure DoParse;
    function DefaultHandler: Boolean; reintroduce;
    function DefineParam(const AName, AAlias: String;
      const AType: TCommandLineParamType; const ARequired: Boolean = False;
      const ADescription: String = ''; const ADefValue: String = '';
      const AHint: String = ''): TCommandLineParam;
  public
    property AppDescription: String read FAppDescription write SetAppDescription;
  end;

  TCommandLineParam = class(TObject)
  private
    FOwner: TCommandLine;
    FParamType: TCommandLineParamType;
    FName: String;
    FAlias: String;
    FHint: String;
    FRequired: Boolean;
    FValue: String;
    FDescription: String;
    procedure SetDescription(const Value: String);
  public
    constructor Create(AOwner: TCommandLine);
    destructor Destroy; override;
    property Name: String read FName;
    property Alias: String read FAlias;
    property Hint: String read FHint;
    property Value: String read FValue;
    property Description: String read FDescription write SetDescription;
  end;

function CommandLine: TCommandLine;

procedure PadStrL(var S: String; Count: Integer);

implementation

uses
  System.IOUtils;

var
  _CommandLine: TCommandLine;

function CommandLine: TCommandLine;
begin
  Result:= _CommandLine;
end;

const
  DEF_BOOL_TRUE = 'true';

procedure PadStrL(var S: String; Count: Integer);
begin
  while Length(S) < Count do
    S:= S + ' ';
end;

{ TCommandLine }

constructor TCommandLine.Create(ACmdLine: String);
begin
  FCmdLine:= ACmdLine;
  FDefs:= TObjectList<TCommandLineParam>.Create(True);
  FParams:= TStringList.Create;
  DoParse;
end;

destructor TCommandLine.Destroy;
begin
  FreeAndNil(FParams);
  FreeAndNil(FDefs);
  inherited;
end;

procedure TCommandLine.DoParse;
var
  S: String;
  //X: Integer;
  P: Integer;
  //T: String;
  C: Char;
  N, V: String;
begin
  S:= FCmdLine + ' ';
  while Length(Trim(S)) > 0 do begin
    C:= S[1];
    case C of
      ' ': begin
        Delete(S, 1, 1);
        //Disregard
      end;
      '-','/': begin
        //Switch name found
        Delete(S, 1, 1);
        P:= Pos(' ', S);
        if P = 0 then begin
          //Space is immediately after - character, no name, not valid entry
          //Just disregard...
          Delete(S, 1, 1);
        end else
        if P > 0 then begin
          //Copy content up to space - switch name
          N:= Copy(S, 1, P-1);
          Delete(S, 1, P);
          //Check if next parameter might carry a switch value...
          if Length(Trim(S)) > 0 then begin
            C:= S[1];
            case C of
              '-', '/': begin
                //Next param is another param switch, just add now
                //FParams.Append(N); // --- ADD NEW VALUE ---
                FParams.Values[N]:= DEF_BOOL_TRUE;
              end;
              '"': begin
                Delete(S, 1, 1);
                //Next param is actually an explicit string, which may contain spaces...
                P:= Pos('"', S);
                if P >= 0 then begin
                  V:= Copy(S, 1, P-1);
                  Delete(S, 1, P);
                  FParams.Values[N]:= V; // --- ADD NEW VALUE ---
                end else begin
                  //No string closing quotes found!!!
                  //Just copy up to space...
                  P:= Pos(' ', S);
                  if P >= 0 then begin
                    V:= Copy(S, 1, P-1);
                    Delete(S, 1, P);
                    FParams.Values[N]:= V; // --- ADD NEW VALUE ---
                  end else begin
                    //Oh, what? No space either? Well then, just add the rest as a switch name.
                    //FParams.Append(S);
                    FParams.Values[S]:= DEF_BOOL_TRUE;
                    S:= '';
                    Break;
                  end;
                end;
              end;
              else begin
                //Next param is a value for this switch...
                P:= Pos(' ', S);
                V:= Copy(S, 1, P-1);
                Delete(S, 1, P);
                FParams.Values[N]:= V; // --- ADD NEW VALUE ---
              end;
            end;
          end else begin
            //There is nothing left in the string...
            S:= '';
            //FParams.Append(N); // --- ADD NEW VALUE ---
            FParams.Values[N]:= DEF_BOOL_TRUE;
            Break;
          end;
        end else begin
          //No space was found...
          if Length(S) > 0 then begin
            //The rest of the command line is a switch
            //FParams.Append(S); // --- ADD NEW VALUE ---
            FParams.Values[S]:= DEF_BOOL_TRUE;
            S:= '';
          end;
          Break;
        end;
      end;
      '"': begin
        Delete(S, 1, 1);
        P:= Pos('"', S);
        V:= Copy(S, 1, P-1);
        Delete(S, 1, P);
        FParams.Append(V); // --- ADD NEW VALUE ---
      end;
      else begin
        P:= Pos(' ', S);
        if P >= 0 then begin
          V:= Copy(S, 1, P-1);
          Delete(S, 1, P);
          FParams.Append(V); // --- ADD NEW VALUE ---
        end else begin
          FParams.Append(S); // --- ADD NEW VALUE ---
          S:= '';
        end;
      end;
    end;
  end;
end;

function TCommandLine.UsageStr: String;
//var
  //X: Integer;
  //P: TCommandLineParam;
begin
  Result:= Module + ' ';

end;

function TCommandLine.DefaultHandler: Boolean;
var
  L: TStringList;
  X: Integer;
  P: TCommandLineParam;
  N: String;
  W, MW: Integer;
begin
  Result:= B('?');
  if Result then begin
    L:= TStringList.Create;
    try
      WriteLn(FAppDescription);
      WriteLn('');
      WriteLn('Usage: '+UsageStr);
      WriteLn('');
      WriteLn('Options:');
      for X := 0 to FDefs.Count-1 do begin
        P:= FDefs[X];
        if P.Alias <> '' then begin
          N:= P.Alias+' / '+P.Name;
        end else begin
          N:= P.Name;
        end;
        if P.Hint <> '' then
          N:= N + '  ' + P.Hint;
        L.AddPair(N, P.Description);
      end;
      MW:= 1;
      for X := 0 to L.Count-1 do begin
        W:= Length(L.Names[X]);
        if W > MW then
            MW:= W;
      end;
      for X := 0 to L.Count-1 do begin
        N:= L.Names[X];
        PadStrL(N, MW+2);
        WriteLn('  -',N, L.ValueFromIndex[X]);
      end;
      WriteLn('');
    finally
      L.Free;
    end;
    ReadLn;
  end;
end;

function TCommandLine.DefineParam(const AName, AAlias: String;
  const AType: TCommandLineParamType; const ARequired: Boolean = False;
  const ADescription: String = ''; const ADefValue: String = '';
  const AHint: String = ''): TCommandLineParam;
begin
  Result:= TCommandLineParam.Create(Self);
  try
    Result.FName:= AName;
    Result.FAlias:= AAlias;
    Result.FHint:= AHint;
    Result.FParamType:= AType;
    Result.FRequired:= ARequired;
    Result.FValue:= ADefValue;
    Result.FDescription:= ADescription;
  finally
    FDefs.Add(Result);
  end;
end;

function TCommandLine.DirAndFilename: String;
begin
  Result:= FParams[0];
end;

function TCommandLine.Directory: String;
begin
  Result:= ExtractFilePath(DirAndFilename);
end;

function TCommandLine.Count: Integer;
begin
  Result:= FParams.Count;
end;

function TCommandLine.Name(const Index: Integer): String;
begin
  Result:= FParams.Names[Index];
  if Result = '' then
    Result:= FParams[Index];
end;

function TCommandLine.Value(const Name: String): String;
begin
  Result:= FParams.Values[Name];
end;

function TCommandLine.Value(const Index: Integer): String;
begin
  Result:= FParams.ValueFromIndex[Index];
end;

function TCommandLine.Exists(const N: String): Boolean;
begin
  Result:= FParams.IndexOf(N) >= 0;
  if not Result then
    Result:= FParams.IndexOfName(N) >= 0;
end;

function TCommandLine.Extension: String;
begin
  Result:= ExtractFileExt(DirAndFilename);
end;

function TCommandLine.Filename: String;
begin
  Result:= ExtractFileName(DirAndFilename);
end;

function TCommandLine.Item(const Index: Integer): String;
begin
  Result:= FParams[Index];
end;

function TCommandLine.Module: String;
begin
  Result:= TPath.GetFileNameWithoutExtension(Filename);
end;

function TCommandLine.S(const N: String): String;
begin
  Result:= FParams.Values[N];
end;

function TCommandLine.I(const N: String): Integer;
begin
  Result:= StrToIntDef(FParams.Values[N], 0);
end;

function TCommandLine.B(const N: String): Boolean;
var
  T: String;
begin
  T:= LowerCase(FParams.Values[N]);
  Result:= (T = '1') or (T = 'true') or (T = 'y') or (T = 'yes');
end;

function TCommandLine.F(const N: String): Single;
begin
  Result:= StrToFloatDef(FParams.Values[N], 10);
end;

procedure TCommandLine.SetAppDescription(const Value: String);
begin
  FAppDescription := Value;
end;

{ TCommandLineParam }

constructor TCommandLineParam.Create(AOwner: TCommandLine);
begin
  FOwner:= AOwner;
  FParamType:= ptSwitch;
end;

destructor TCommandLineParam.Destroy;
begin

  inherited;
end;

procedure TCommandLineParam.SetDescription(const Value: String);
begin
  FDescription := Value;
end;

initialization
  {$WARN SYMBOL_PLATFORM OFF}
  _CommandLine:= TCommandLine.Create(System.CmdLine);
  {$WARN SYMBOL_PLATFORM ON}
finalization
  FreeAndNil(_CommandLine);
end.
