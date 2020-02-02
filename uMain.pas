unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  System.UITypes,
  JD.CmdLine;

const
  DEF_FINE_AMOUNT = 75000.00;
  DEF_PRISON_TIME = 10;

type
  TfrmMain = class(TForm)
    Panel1: TPanel;
    btnPrison: TBitBtn;
    btnPay: TBitBtn;
    lblMain: TLabel;
    procedure btnPrisonClick(Sender: TObject);
    procedure btnPayClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;
  _FineAmount: Currency;
  _PrisonTime: Integer;

implementation

{$R *.dfm}

uses uCreditCard;

procedure TfrmMain.btnPrisonClick(Sender: TObject);
begin
  case MessageDlg('Are you sure you would like to go to prison for '+IntToStr(_PrisonTime)+' years?',
    mtWarning, [mbYes, mbNo], 0)
  of
    mrYes: begin
      MessageDlg('Good luck, and don''t drop the soap!', mtInformation, [mbOK], 0);
      Close;
    end;
  end;
end;

procedure TfrmMain.btnPayClick(Sender: TObject);
begin
  frmCreditCard.ShowModal;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  _PrisonTime:= DEF_PRISON_TIME;
  _FineAmount:= DEF_FINE_AMOUNT;
  if CommandLine.Exists('prison') then
    _PrisonTime:= StrToIntDef(CommandLine.S('prison'), DEF_PRISON_TIME);
  if CommandLine.Exists('fine') then
    _FineAmount:= StrToCurrDef(CommandLine.S('fine'), DEF_FINE_AMOUNT);
  btnPay.Caption:= 'Pay Fine ('+FormatFloat('$#,##0.00', _FineAmount) + ')';
  btnPrison.Caption:= 'Prison ('+IntToStr(_PrisonTime)+' Years)';
end;

end.
