unit U_Load;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage,
  Vcl.StdCtrls;

type
  TF_Load = class(TForm)
    loader: TImage;
    timer: TTimer;
    desc: TLabel;
    logo: TImage;
    procedure FormActivate(Sender: TObject);
    procedure timerTimer(Sender: TObject);

  private
    { Private declarations }
    procedure changeLoader;
    procedure Descreve;
    procedure alinhaLabel(titulo:string);
  public
    { Public declarations }
  end;

var
  F_Load: TF_Load;
  i:integer=2;
  j:integer=0;
  timer2:Ttimer;

implementation

{$R *.dfm}

uses U_dm, U_HomePage;

procedure TF_Load.alinhaLabel(titulo: string);
begin
  desc.Caption:=titulo;
  desc.Left:=(width div 2)-(desc.Width div 2);
  desc.top:=(height div 2)-(desc.height div 2)-(height div 5);
end;

procedure TF_Load.changeLoader;
begin
  loader.Picture.LoadFromFile(dm.templates + '\loader\' + inttostr(i) + '.png');
  if i = 21 then
  i:=1;
  i:=i+1;
end;


procedure TF_Load.FormActivate(Sender: TObject);
begin
  CLIENTHEIGHT:=300;
  CLIENTWIDTH:=400;


  loader.height:=55;
  loader.Width:=55;
  loader.left:=(width div 2)-(loader.Width div 2);
  loader.Top:=(height div 2)-(loader.Height div 2);

  logo.Top:=255;
  logo.Left:=(width div 2)-(logo.Width div 2);

end;



procedure TF_Load.Descreve;
begin
  if dm.LoadOption = 1 then
  begin
    if J = 1 then
    begin
      application.CreateForm(TF_HomePage,F_HomePage);
      alinhaLabel('Carregando os dados...');
    end;

    if J = 10 then
    begin
      alinhaLabel('Carregamento concluído!');
    end;

    if J = 12 then
    begin
      alinhaLabel('Entrando...');
    end;

    if J = 20 then
    begin
      alinhaLabel('Bem Vindo '+dm.UserExibe);
    end;

    if J = 26 then
    begin
      hide;
      F_HomePage.showModal;
      Close;
    end;

  end else
  if dm.LoadOption = 2 then
  begin
    if J = 1 then
    begin
      application.CreateForm(TF_HomePage,F_HomePage);
      alinhaLabel('Criando conta...');
    end;

    if J = 10 then
    begin
      alinhaLabel('Sua conta está pronta!');
    end;

    if J = 12 then
    begin
      alinhaLabel('Entrando...');
    end;

    if J = 20 then
    begin
      alinhaLabel('Bem Vindo '+dm.UserExibe);
    end;

    if J = 26 then
    begin
      hide;
      F_HomePage.showModal;
      Close;
    end;
  end;

end;

procedure TF_Load.timerTimer(Sender: TObject);
begin
  j:=j+1;
  Descreve;
  changeLoader;

end;

end.
