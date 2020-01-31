unit uCreditCard;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  System.UITypes;

type
  TfrmCreditCard = class(TForm)
    txtNameOnCard: TEdit;
    txtAddress: TEdit;
    txtCity: TEdit;
    txtState: TEdit;
    txtZip: TEdit;
    Panel1: TPanel;
    BitBtn2: TBitBtn;
    BitBtn1: TBitBtn;
    lblTotal: TLabel;
    txtCardNumber: TEdit;
    txtExpirationDate: TEdit;
    txtSecurityCode: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCreditCard: TfrmCreditCard;

implementation

{$R *.dfm}

uses uMain;

procedure TfrmCreditCard.BitBtn1Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmCreditCard.BitBtn2Click(Sender: TObject);
const
  EXPIRY_DIV = '\';
var
  C: Bool;
  Z: Integer;
  T: String;
  function NormalizeCard(const S: String): String;
  begin
    Result:= StringReplace(S, ' ', '', [rfReplaceAll]);
    Result:= StringReplace(Result, '-', '', [rfReplaceAll]);
  end;
  function NormalizeExpiry(const S: String): String;
  var
    S1, S2: String;
    D1, D2: Integer;
  begin
    Result:= Trim(S);
    Result:= StringReplace(Result, ' ', EXPIRY_DIV, [rfReplaceAll]);
    Result:= StringReplace(Result, '-', EXPIRY_DIV, [rfReplaceAll]);
    Result:= StringReplace(Result, '\', EXPIRY_DIV, [rfReplaceAll]);
    if StrToIntDef(Result, 0) > 0 then begin
      if Length(Result) = 3 then begin
        S1:= Copy(Result, 1, 1);
        S2:= Copy(Result, 2, 2);
        Result:= S1 + EXPIRY_DIV + S2;
      end else
      if Length(Result) = 4 then begin
        S1:= Copy(Result, 1, 2);
        S2:= Copy(Result, 3, 2);
        Result:= S1 + EXPIRY_DIV + S2;
      end;
    end;
    if Pos(EXPIRY_DIV, Result) > 1 then begin
      S1:= Copy(Result, 1, Pos(EXPIRY_DIV, Result)-1);
      Delete(Result, 1, Pos(EXPIRY_DIV, Result));
      D1:= StrToIntDef(S1, 0);
      S2:= Copy(Result, 1, Length(Result));
      Delete(Result, 1, Length(Result));
      D2:= StrToIntDef(S2, 0);
      if (D1 > 0) and (D1 < 13) and (D2 > 1900) and (D2 < 10000) then begin
        Result:= IntToStr(D1) + EXPIRY_DIV + IntToStr(D2);
      end;
    end;
  end;
begin
  C:= True;
  Z:= 0;
  if C then C:= Length(txtNameOnCard.Text) > 5;
  if C then C:= Length(txtAddress.Text) > 4;
  if C then C:= Length(txtCity.Text) = 2;
  if C then Z:= StrToIntDef(txtZip.Text, 0);
  if C then C:= (Z > 9999) and (Z < 10000);
  if C then T:= NormalizeCard(txtCardNumber.Text);
  if C then txtCardNumber.Text:= T;
  if C then Z:= StrToIntDef(T, 0);
  if C then C:= (Z > 1000000000000000) and (Z < 10000000000000000);
  if C then T:= NormalizeExpiry(txtExpirationDate.Text);
  if C then txtExpirationDate.Text:= T;
  if C then Z:= StrToIntDef(txtSecurityCode.Text, 0);
  if C then C:= Z > 99;
  if C then begin
    if MessageDlg('You are about to pay a '+FormatFloat('$#,##0.00', FINE_AMOUNT)+' fine. Continue?',
      mtInformation, [mbYes, mbNo], 0) = mrYes then
    begin
      Sleep(4000);
      MessageDlg('Failed to charge your card!', mtError, [mbOk], 0);

    end else begin

    end;
  end else begin
    MessageDlg('Please enter correct card information.', mtError, [mbOk], 0);
  end;
end;

procedure TfrmCreditCard.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  case MessageDlg('Are you sure you would like to go to prison instead?',
    mtWarning, [mbYes, mbNo], 0)
  of
    mrNo: begin
      Action:= caNone;
    end;
  end;
end;

procedure TfrmCreditCard.FormCreate(Sender: TObject);
begin
  lblTotal.Caption:= FormatFloat('$#,##0.00', FINE_AMOUNT);
end;

procedure TfrmCreditCard.FormShow(Sender: TObject);
begin
  Show;
  Application.ProcessMessages;
  BitBtn2.SetFocus;
end;

end.
