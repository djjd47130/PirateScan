unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  System.UITypes;

const
  FINE_AMOUNT = 75000.00;

type
  TfrmMain = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
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

procedure TfrmMain.BitBtn1Click(Sender: TObject);
begin
  case MessageDlg('Are you sure you would like to go to prison?',
    mtWarning, [mbYes, mbNo], 0)
  of
    mrYes: begin
      MessageDlg('Good luck, and don''t drop the soap!', mtInformation, [mbOK], 0);
      Close;
    end;
  end;
end;

procedure TfrmMain.BitBtn2Click(Sender: TObject);
begin
  frmCreditCard.ShowModal;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  BitBtn2.Caption:= 'Pay Fine ('+FormatFloat('$#,##0.00', FINE_AMOUNT) + ')';
end;

end.
