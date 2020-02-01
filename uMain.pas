unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  System.UITypes;

const
  FINE_AMOUNT = 75000.00;
  PRISON_TIME = 10;

type
  TfrmMain = class(TForm)
    Panel1: TPanel;
    btnPrison: TBitBtn;
    btnPay: TBitBtn;
    Label1: TLabel;
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

implementation

{$R *.dfm}

uses uCreditCard;

procedure TfrmMain.btnPrisonClick(Sender: TObject);
begin
  case MessageDlg('Are you sure you would like to go to prison for '+IntToStr(PRISON_TIME)+' years?',
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
  btnPay.Caption:= 'Pay Fine ('+FormatFloat('$#,##0.00', FINE_AMOUNT) + ')';
  btnPrison.Caption:= 'Prison ('+IntToStr(PRISON_TIME)+' Years)';
end;

end.
