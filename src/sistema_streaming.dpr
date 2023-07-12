program sistema_streaming;
uses
  Vcl.Forms,
  U_Login in 'pages\U_Login.pas' {F_Login},
  U_BaseForm in 'common\U_BaseForm.pas' {BaseForm},
  U_Register in 'pages\U_Register.pas' {F_register},
  U_dm in 'common\U_dm.pas' {dm: TDataModule},
  U_player in 'pages\U_player.pas' {F_player},
  U_HomePage in 'pages\U_HomePage.pas' {F_HomePage},
  U_MediaClass in 'common\U_MediaClass.pas',
  U_Load in 'pages\U_Load.pas' {F_Load},
  U_Out in 'pages\U_Out.pas' {F_Out},
  U_SaibaMais in 'pages\U_SaibaMais.pas' {F_SaibaMais};

{$R *.res}
begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TF_Login, F_Login);
  Application.CreateForm(Tdm, dm);
  Application.Run;
end.
