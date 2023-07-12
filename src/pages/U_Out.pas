unit U_Out;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage;

type
  TF_Out = class(TForm)
    desc: TLabel;
    logo: TImage;
    btnS: TImage;
    btnN: TImage;
    procedure FormActivate(Sender: TObject);
    procedure btnSMouseEnter(Sender: TObject);
    procedure btnSMouseLeave(Sender: TObject);
    procedure btnNMouseEnter(Sender: TObject);
    procedure btnNMouseLeave(Sender: TObject);
    procedure btnNClick(Sender: TObject);
    procedure btnSClick(Sender: TObject);
  private
    { Private declarations }
    procedure CriaOut;
  public
    { Public declarations }
  end;

var
  F_Out: TF_Out;

implementation

{$R *.dfm}

uses U_dm, U_HomePage, U_player;

procedure TF_Out.btnNClick(Sender: TObject);
begin
 F_player.FAction:=1;
 Close;
end;

procedure TF_Out.btnNMouseEnter(Sender: TObject);
begin
   btnN.Picture.LoadFromFile(dm.hover + 'btn_nao.png');
end;

procedure TF_Out.btnNMouseLeave(Sender: TObject);
begin
   btnN.Picture.LoadFromFile(dm.templates + 'btn_nao.png');
end;

procedure TF_Out.btnSClick(Sender: TObject);
begin
  if dm.OutOption = 1 then
  begin
    Halt
  end else
  if dm.OutOption = 2 then
  begin
    self.Hide;
    F_Player.Close;
    F_HomePage.show;
    Close;
  end else
  if dm.OutOption = 3 then
  begin
    F_player.finalize;
    halt
  end;
end;

procedure TF_Out.btnSMouseEnter(Sender: TObject);
begin
  btnS.Picture.LoadFromFile(dm.hover + 'btn_sim.png');
end;

procedure TF_Out.btnSMouseLeave(Sender: TObject);
begin
  btnS.Picture.LoadFromFile(dm.templates + 'btn_sim.png');
end;

procedure TF_Out.CriaOut;
begin
  if dm.OutOption = 1 then
  begin

    desc.Caption:='Deseja sair do CineShow?';

  end else
  if dm.OutOption >= 2 then
  begin

    desc.Caption:='Voltar para a Tela Principal?';

  end;
end;

procedure TF_Out.FormActivate(Sender: TObject);
begin
  CLIENTHEIGHT:=300;
  CLIENTWIDTH:=400;

  CriaOut;

  desc.Left:=(width div 2)-(desc.Width div 2);
  desc.top:=(height div 2)-(desc.height div 2)-(height div 5);

  logo.Top:=255;
  logo.Left:=(width div 2)-(logo.Width div 2);
end;



end.
