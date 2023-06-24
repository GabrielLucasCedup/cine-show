program sistema_streaming;

uses
  Vcl.Forms,
  U_Login in 'pages\U_Login.pas' {F_Login},
  U_BaseForm in 'common\U_BaseForm.pas' {BaseForm},
  U_Register in 'pages\U_Register.pas' {F_register},
  U_dm in 'common\U_dm.pas' {dm: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TF_Login, F_Login);
  Application.CreateForm(Tdm, dm);
  Application.Run;
end.
