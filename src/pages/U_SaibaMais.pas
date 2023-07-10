unit U_SaibaMais;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, U_BaseForm, Vcl.ExtCtrls, U_MediaClass;

type
  TF_SaibaMais = class(TBaseForm)
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_SaibaMais: TF_SaibaMais;
  filme:TMedia;

implementation

{$R *.dfm}

uses U_dm;

procedure TF_SaibaMais.FormActivate(Sender: TObject);
var
bg:TImage;
begin

   //filme:=dm.FilmeOption;
    filme:=TMedia.create('3');

    bg:=TImage.create(self);
    bg.Parent:=self;

    Constraints.MaxHeight :=  0;
    Constraints.MinHeight := 574;
    Constraints.MaxWidth := 0;
    Constraints.MinWidth := 1020;

    self.clientwidth:=1020;
    self.ClientHeight:=574;

    bg.Stretch:=true;
    bg.Width:=ClientWidth;
    bg.Height:=ClientHeight;
    bg.Top:=0;
    bg.left:=0;
    bg.Picture.LoadFromFile(dm.capa+'wallpaper\passos.png');//(dm.capa+'wallpaper\'+filme.getCapa);

end;

end.
