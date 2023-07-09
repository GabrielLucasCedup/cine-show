unit U_HomePage;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, U_BaseForm, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, System.ImageList, Vcl.ImgList, Vcl.StdCtrls,System.Generics.Collections,U_MediaClass;

type
  TF_HomePage = class(TBaseForm)
    Scroll: TScrollBox;
    menu: TImage;
    footer: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
     procedure ScrollMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure ScrollMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure ScrollMouseEnter(Sender: TObject);
  private
    { Private declarations }

    //------------------------------------------

    // CAPA DO FILME
    procedure EventCapaEnter(sender:TObject);
    // PLAYER DA CAPA
    procedure EventPlayerEnter(sender: TObject);
    procedure EventPlayerLeave(sender: TObject);
    procedure EventPlayerClick(sender: TObject);
    // SAIBA MAIS DA CAPA
    procedure EventSaibaEnter(sender: TObject);
    procedure EventSaibaLeave(sender: TObject);
    procedure EventSaibaClick(sender: TObject);

    //------------------------------------------
    procedure CriaTela;
    procedure LimpaTela;
    procedure TerminaTela;
    procedure Dinamiza(n: integer);
    procedure adicionaTopo(IsImage:boolean);
    procedure encerraImg;

  public
    { Public declarations }
    procedure CriaLabel(texto:string);
    procedure CriaImagem();
  end;

var
  F_HomePage: TF_HomePage;
  topo:integer=40;
  colunaImg:integer=-1;
  filme:TImage;
  titulo:TLabel;
  item:TMedia;
  margin:integer=18;
  IsEnter:boolean=true;

implementation

{$R *.dfm}

uses U_dm, U_Out, U_Login, U_player;


procedure TF_HomePage.FormActivate(Sender: TObject);
begin
  inherited;
// ----------- MONTANDO TELA -------------

  CriaTela;

end;

procedure TF_HomePage.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  dm.OutOption:=1;
  Action:=TCloseAction.caNone;
  Application.CreateForm(TF_Out,F_Out);
  F_Out.ShowModal;
end;

procedure TF_HomePage.FormCreate(Sender: TObject);
begin

  menu.Top:=0;
  menu.Left:=0;
  footer.top:=702;
  footer.Left:=0;
  scroll.Top:=71;
  scroll.left:=0;

  scroll.Parent:=F_homepage;

end;

procedure TF_HomePage.ScrollMouseEnter(Sender: TObject);
var
i:integer;
listRM:Tlist<integer>;
begin
  inherited;
  IsEnter:=true;
  listRM:=Tlist<integer>.Create;
  for I := (scroll.ComponentCount-1) downto 0 do
  begin
  if scroll.Components[i] is TImage then
    begin
      if TImage(scroll.Components[i]).Width = (299+margin) then
      begin
        with Timage(scroll.Components[i]) do
        begin
          Width:=Width-margin;
          Height:=Height-margin;
          Top:= Top+(margin div 2);
          Left:=Left+(margin div 2);
        end;
      end else
      if (TImage(scroll.Components[i]).Width <> 299) then
      begin
          listRM.Add(i);
      end;
    end;
  end;

  for i in ListRM do
  begin
    scroll.Components[i].Free;

  end;

  ListRM.Free;
end;

procedure TF_HomePage.ScrollMouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  inherited;
  Scroll.VertScrollBar.Position:=Scroll.VertScrollBar.ScrollPos + 30;
end;

procedure TF_HomePage.ScrollMouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  inherited;
  Scroll.VertScrollBar.Position:=Scroll.VertScrollBar.ScrollPos - 30;
end;

procedure TF_HomePage.TerminaTela;
var
  EmptyPanel: TPanel;
begin
  EmptyPanel := TPanel.Create(Scroll);
  EmptyPanel.Parent := Scroll;
  EmptyPanel.top := topo-5;
  EmptyPanel.Width:=scroll.Width-25;
  EmptyPanel.Height := 0;
end;




// ----------- FUN��ES DE CRIA��O ------

procedure TF_HomePage.CriaTela;
var
List:TObjectList<TMedia>;
begin
    if dm.RetomarCount > 0  then
    begin
      List := dm.RetomarSelectAll;
      CriaLabel('Continuar Assistindo');
      for item in list do
      begin
        CriaImagem();
      end;
      encerraImg;
    end;

  dinamiza(2);
  dinamiza(3);

  TerminaTela;

end;


procedure TF_HomePage.LimpaTela;
var
i:integer;
begin
  for i := Scroll.ComponentCount-1 downto 0 do
  begin
    if Scroll.Components[i] is TImage then
      (Scroll.Components[i] as TImage).Free
    else if  Scroll.Components[i] is TLabel then
      (Scroll.Components[i] as TLabel).Free
    else if Scroll.Components[i] is TPanel then
      (Scroll.Components[i] as TPanel).Free
  end;
  topo:=40;

end;



procedure TF_HomePage.CriaImagem();
begin
  colunaImg:=colunaImg+1;
  filme:=TImage.Create(Scroll);
  filme.Parent:=Scroll;
  filme.HelpKeyword:=item.GetId;
  filme.Width:=299;
  filme.Height:=155;
  filme.Picture.LoadFromFile(dm.capa+item.GetCapa);
  filme.Stretch:=true;
  filme.top:= topo;
  filme.Left:= 14+((colunaImg)*340);
  if colunaImg = 2 then
  begin
    adicionaTopo(true);
    colunaImg:=-1;
  end;
  filme.OnMouseEnter:=EventCapaEnter;
end;

procedure TF_HomePage.CriaLabel(texto: string);
begin
  titulo:=TLabel.Create(Scroll);
  titulo.Parent:=Scroll;
  titulo.Caption:=texto;
  titulo.Font.Name:='Segoe UI';
  titulo.Font.Size:=19;
  titulo.top:=TOPO;
  titulo.left:=(scroll.Width div 2)-(titulo.Width div 2);
  adicionaTopo(false);
end;

procedure TF_HomePage.Dinamiza(n: integer);
var
i:integer;
List:TObjectList<TMedia>;
begin

  if n = 1 then
  begin
     //favoritos
  end else
  if n = 2 then
  begin //lancamentos desse ano
  // --------------------------------------------------

    List := dm.MediaSelectRecentes;
    CriaLabel('Lan�amentos desse ano');
    for item in list do
    begin
      CriaImagem();
    end;
    encerraImg;

  // --------------------------------------------------
  end else
  if n = 3 then
  begin//populares
  // --------------------------------------------------

    List := dm.MediaSelectPopulares;
    CriaLabel('Populares no CineShow');
    for item in list do
    begin
      CriaImagem();
    end;
    encerraImg;


  // --------------------------------------------------
  end else
  if n = 4 then
  begin
    //nostalgia
  end;

end;

procedure TF_HomePage.encerraImg;
begin
  if colunaImg > 0 then
  begin
    adicionaTopo(true);
    colunaImg:=-1;
  end;
end;

// EVENTOS IMAGES DINAMICAS

procedure TF_HomePage.EventCapaEnter(sender: TObject);
var
imgs:TImage;
begin
  if IsEnter then
  begin
    with Timage(sender) do
    begin
      Width:=299+margin;
      Height:=155+margin;
      Top:= Top-(margin div 2);
      Left:=Left-(margin div 2);
      //-------------------------------------------------------

      imgs:=TImage.Create(scroll);
      imgs.Parent:=scroll;
      imgs.HelpKeyword:=HelpKeyword;
      imgs.Width:=60;
      imgs.Height:=60;
      imgs.Picture.LoadFromFile(dm.templates+'btn_player.png');
      imgs.Left:=left+((Width div 2)-(imgs.Width div 2));
      imgs.Top:=top+((Height div 2)-(imgs.Height div 2));

      imgs.OnMouseEnter:=EventPlayerEnter;
      imgs.OnMouseLeave:=EventPlayerLeave;
      imgs.OnClick:=EventPlayerClick;

      //-------------------------------------------------------

      imgs:=TImage.Create(scroll);
      imgs.Parent:=scroll;
       imgs.HelpKeyword:=HelpKeyword;
      imgs.Width:=95;
      imgs.Height:=25;
      imgs.Picture.LoadFromFile(dm.templates+'btn_saiba.png');
      imgs.Left:=left+(Width-(Width div 3));
      imgs.Top:=top+(Height-(height div 5));

      imgs.OnMouseEnter:=EventSaibaEnter;
      imgs.OnMouseLeave:=EventSaibaLeave;
      imgs.OnClick:=EventSaibaClick;

    end;
    IsEnter:=false;
  end;
end;

procedure TF_HomePage.EventPlayerClick(sender: TObject);
begin
  dm.FilmeOption:=TMedia.create((sender as TImage).HelpKeyword);
  self.hide;
  application.CreateForm(TF_Player,F_Player);
  limpaTela;
  F_Player.showModal;

end;

procedure TF_HomePage.EventPlayerEnter(sender: TObject);
begin
  (sender as TImage).Picture.LoadFromFile(dm.hover+'btn_player.png');
end;

procedure TF_HomePage.EventPlayerLeave(sender: TObject);
begin
  (sender as TImage).Picture.LoadFromFile(dm.templates+'btn_player.png');
end;

procedure TF_HomePage.EventSaibaClick(sender: TObject);
begin
  Showmessage((sender as TImage).GetNamePath);
end;

procedure TF_HomePage.EventSaibaEnter(sender: TObject);
begin
  (sender as TImage).Picture.LoadFromFile(dm.hover+'btn_saiba.png');
end;

procedure TF_HomePage.EventSaibaLeave(sender: TObject);
begin
  (sender as TImage).Picture.LoadFromFile(dm.templates+'btn_saiba.png');
end;

// ----------- FUN��ES EXTRAS -----------



procedure TF_HomePage.adicionaTopo(IsImage:Boolean);
begin
  if IsImage then
  TOPO:=TOPO+180
  else
  TOPO:=TOPO+60;

end;

end.
