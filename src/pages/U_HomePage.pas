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
  private
    { Private declarations }
    procedure EventMouseEnter(sender:TObject);
    procedure CriaTela;
    procedure TerminaTela;
    procedure Dinamiza(n: integer);
    procedure adicionaTopo(IsImage:boolean);
    procedure encerraImg;

  public
    { Public declarations }
    procedure CriaLabel(texto:string);
    procedure CriaImagem;
  end;

var
  F_HomePage: TF_HomePage;
  topo:integer=40;
  colunaImg:integer=-1;
  filme:TImage;
  titulo:TLabel;
  item:TMedia;
implementation

{$R *.dfm}

uses U_dm, U_Out, U_Login;


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




procedure TF_HomePage.ScrollMouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  inherited;
  Scroll.VertScrollBar.Position:=Scroll.VertScrollBar.ScrollPos + 30;
  //showmessage(Scroll.VertScrollBar.ScrollPos.ToString +' / '+ Scroll.VertScrollBar.Position.ToString);
end;

procedure TF_HomePage.ScrollMouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  inherited;
  Scroll.VertScrollBar.Position:=Scroll.VertScrollBar.ScrollPos - 30;
end;

procedure TF_HomePage.TerminaTela;
var
  // vari�veis utilizadas para criar os t�tulos e capas dos filmes
  // ...
  EmptyPanel: TPanel;
begin
  // Adicione os t�tulos e capas dos filmes no ScrollBox
  // ...

  // Crie um TPanel vazio como �ltimo elemento do ScrollBox
  EmptyPanel := TPanel.Create(Scroll);
  EmptyPanel.Parent := Scroll;
  EmptyPanel.top := topo-5;
  EmptyPanel.Width:=scroll.Width-25;
  EmptyPanel.Height := 0; // Define a altura desejada do espa�o adicional
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
        CriaImagem;
      end;
      encerraImg;
    end;


  dinamiza(2);
  dinamiza(3);

  TerminaTela;

end;



procedure TF_HomePage.CriaImagem;
begin

  colunaImg:=colunaImg+1;
  filme:=TImage.Create(Scroll);
  filme.Parent:=Scroll;
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
  filme.OnMouseEnter:=EventMouseEnter;
end;

procedure TF_HomePage.CriaLabel(texto: string);
begin
  titulo:=TLabel.Create(Scroll);
  titulo.Parent:=Scroll;
  titulo.Caption:=texto;
  titulo.Font.Name:='Times New Roman';
  titulo.Font.Size:=17;
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
      CriaImagem;
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
      CriaImagem;
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

procedure TF_HomePage.EventMouseEnter(sender: TObject);
begin

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
