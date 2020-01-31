program PirateScan;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {frmMain},
  uCreditCard in 'uCreditCard.pas' {frmCreditCard};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Pirate Scan';
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmCreditCard, frmCreditCard);
  Application.Run;
end.
