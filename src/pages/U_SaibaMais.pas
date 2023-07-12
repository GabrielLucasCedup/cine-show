unit U_SaibaMais;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, U_BaseForm, Vcl.ExtCtrls, U_MediaClass,
  Vcl.StdCtrls,system.Generics.Collections, U_HomePage;

type
  TF_SaibaMais = class(TBaseForm)
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }

    procedure EventPlayerEnter(sender: TObject);
    procedure EventPlayerLeave(sender: TObject);
    procedure EventPlayerClick(sender: TObject);
    procedure LimpaTela;

    procedure GeraTitulo(nome:string);
    procedure GeraSinopse(desc:string);
    function CriaTitulo(nome:string;titulo:tlabel;esquerda:integer=0):integer;

    function splitLabel(str,del:string):TList<string>;
  public
    { Public declarations }
    VAction:integer;
  end;

var
  F_SaibaMais: TF_SaibaMais;
  bg:TImage;
  topo,maxStr,maxTit,lado,soma:integer;


implementation

{$R *.dfm}

uses U_dm, U_player, U_Out;

procedure TF_SaibaMais.LimpaTela;
var
i:integer;
begin
  for i := ComponentCount-1 downto 0 do
  begin
    if Components[i] is TImage then
      (Components[i] as TImage).Free
    else if  Components[i] is TLabel then
      (Components[i] as TLabel).Free;
  end;
end;

function TF_SaibaMais.splitLabel(str,del: string): TList<String>;
var
i,j,pos:integer;
Olist:TList<String>;
begin

  Olist:=TList<String>.Create();
  j:=0;
  pos:=0;
  for i := 1 to str.Length do
  begin
    if (str[i] = del) then
    begin
      Olist.Add((copy(str,pos+1,(i-1)-pos)));
      j:=j+1;
      pos:=i;
    end else
    if (i = str.Length) then
    begin
      Olist.Add((copy(str,pos+1,(i)-pos)));
      j:=j+1;
      pos:=i;
    end;
  end;

  result:=Olist;
end;

procedure TF_SaibaMais.GeraSinopse(desc: string);
var
titulo:TLabel;
subdesc:string;
i: Integer;
begin
  subdesc:='';
  for i := 0 to splitLabel(desc,' ').Count-1 do
  begin
    subdesc:=subdesc+' '+splitlabel(desc,' ')[i];
    if (subdesc.Length > maxStr) or (i = splitLabel(desc,' ').Count-1) then
    begin
      // funcion
      titulo:=TLabel.Create(bg);
      titulo.Parent:=self;
      titulo.Caption:=copy(subdesc,2,subdesc.Length-1);
      titulo.Font.Name:='Segoe UI';
      titulo.Font.Size:=17;
      titulo.Font.Color:=clWhite;
      titulo.top:=TOPO;
      titulo.left:=lado;
      subdesc:='';
      topo:=topo+(soma div 2);
      // end;
    end; //if
  end;//for
end;

procedure TF_SaibaMais.GeraTitulo(nome: string);
var
titulo:tlabel;
subTit:string;
i,j:integer;
vazio:char;
begin
  subtit:='';
  i:=999;
  for j := 0 to splitLabel(nome,' ').Count-1 do
  begin
    subtit:=subtit+' '+(splitLabel(nome,' ')[j]);
    if (subtit.Length-1 > 20)or(j = splitLabel(nome,' ').Count-1) then
    begin
      subtit:= copy(subTit,2,subtit.Length-1);
      if i < 999 then
      begin
        i:=criaTitulo(subtit,titulo,2);
      end else
      i:=criaTitulo(subtit,titulo);

      Topo:=topo+soma-(soma div 2);

      subtit:='';
    end;
  end;


end;

 function TF_SaibaMais.CriaTitulo(nome: string; titulo: tlabel;esquerda:integer=0):integer;
begin
  titulo:=TLabel.Create(bg);
  titulo.Parent:=self;
  titulo.Caption:=nome;
  titulo.Font.Name:='Segoe UI';
  titulo.Font.Size:=22;
  titulo.Font.Color:=clWhite;
  titulo.Font.Style:=[fsBold];
  titulo.top:=TOPO;
  if esquerda > 0 then
  begin
  titulo.left:=lado+(lado div 3)+(titulo.Width div 4) ;
  end else
  titulo.left:=lado+(lado div 2);
  result:=titulo.ComponentIndex;
end;

procedure TF_SaibaMais.EventPlayerClick(sender: TObject);
begin
  if (sender as Timage).Width = 90 then
  begin
    dm.SaibaOption:=true;
    self.hide;
    application.CreateForm(TF_Player,F_Player);
    limpaTela;
    F_Player.showModal;
  end else begin
    VAction:=2;
    F_HomePage.show;
    Close;
  end;
end;


procedure TF_SaibaMais.EventPlayerEnter(sender: TObject);
begin
  if (sender as Timage).Width = 90 then
  (sender as TImage).Picture.LoadFromFile(dm.hover+'player.png')
  else
  (sender as TImage).Picture.LoadFromFile(dm.hover+'voltar.png')
end;

procedure TF_SaibaMais.EventPlayerLeave(sender: TObject);
begin
  if (sender as Timage).Width = 90 then
  (sender as TImage).Picture.LoadFromFile(dm.templates+'player.png')
  else
  (sender as TImage).Picture.LoadFromFile(dm.templates+'voltar.png')
end;

procedure TF_SaibaMais.FormActivate(Sender: TObject);
var
play:TImage;
lb:tlabel;
begin

    self.caption:='CineShow - Sinopse - '+dm.FilmeOption.GetNome;
    bg:=TImage.create(self);
    bg.Parent:=self;

    VAction:=1;

    Constraints.MaxHeight :=  0;
    Constraints.MinHeight := 574;
    Constraints.MaxWidth := 0;
    Constraints.MinWidth := 1020;

    self.clientwidth:=1020;
    self.ClientHeight:=574;

    TOPO:=120;
    LADO:=50;
    SOMA:=60;
    MaxStr:=30;
    MaxTit:=20;

    bg.Stretch:=true;
    bg.Width:=ClientWidth;
    bg.Height:=ClientHeight;
    bg.Top:=0;
    bg.left:=0;
    bg.Picture.LoadFromFile(dm.capa+'wallpaper\'+dm.FilmeOption.getCapa);

    play:= TImage.Create(bg);
    play.parent:=self;
    play.Width:=55;
    play.Height:=55;
    play.Picture.LoadFromFile(dm.templates+'voltar.png');
    play.top:=TOPO div 6;
    play.Left:=lado div 3;

    play.OnMouseEnter:=EventPlayerEnter;
    play.OnMouseLeave:=EventPlayerLeave;
    play.OnClick:=EventPlayerClick;

    geraTitulo(dm.FilmeOption.GetNome);

    TOPO:=TOPO+SOMA;
    geraSinopse(dm.FilmeOption.GetDescricao);

    lb:=TLabel.Create(bg);
    lb.Parent:=self;
    lb.Font.Name:='Segoe UI';
    lb.Font.Size:=13;
    lb.Font.Color:=clWhite;
    lb.Caption:='Lan�ado em '+dm.FilmeOption.GetLancamento;
    lb.Left:=lado;
    lb.Top:=TOPO+(lb.Height);

    play:= TImage.Create(bg);
    play.Parent:=self;
    play.Width:=90;
    play.Height:=90;
    play.picture.LoadFromFile(dm.templates+'player.png');
    play.Top:=(Clientheight div 2)-(play.Height div 2);
    play.Left:=((Clientwidth div 2)+(Clientwidth div 4))- (play.Width);

    play.OnMouseEnter:=EventPlayerEnter;
    play.OnMouseLeave:=EventPlayerLeave;
    play.OnClick:=EventPlayerClick;

end;

procedure TF_SaibaMais.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
   if VAction = 1 then
  begin
     dm.OutOption:=1;
     Action:=TCloseAction.caNone;
     Application.CreateForm(TF_Out,F_Out);
     F_Out.ShowModal;
  end else begin
    Action:=TCloseAction.caFree;
  end;

end;

end.
