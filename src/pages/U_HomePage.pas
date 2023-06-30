unit U_HomePage;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, U_BaseForm, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, System.ImageList, Vcl.ImgList, Vcl.StdCtrls,System.Generics.Collections;

type
  TF_HomePage = class(TBaseForm)
    Scroll: TScrollBox;
    menu: TImage;
    footer: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    function CountColumn:integer;

  public
    { Public declarations }
    function Alinha(isLabel:boolean):integer;
    procedure CriaLabel(texto:string;OLabel:TLabel);
    procedure CriaImagem(arquivo:string;OImage:TImage);
  end;

var
  F_HomePage: TF_HomePage;
  coluna:integer=0;
  lengthLabel:integer=0;
  lengthImagem:integer=0;
  elementoIsLabel:boolean;

implementation

{$R *.dfm}

uses U_dm, U_MediaClass;


procedure TF_HomePage.FormActivate(Sender: TObject);
var
List:TObjectList<TMedia>;
item:Tmedia;
filme:TImage;
titulo:TLabel;
i,counts:integer;
begin
  inherited;

// ----------- MONTANDO TELA -------------
  counts:=DM.RetomarCount;

  for I := 1 to counts do
  begin
    if i = 1 then
    begin
      CriaLabel('Continuar Assistindo',titulo);
    end;
    CriaImagem('',filme);
  end;

  try
  List := dm.MediaSelectRecentes;
  except
    on E: Exception do
      ShowMessage('Erro: ' + E.Message);
  end;
  //ShowMessage(inttostr(List.Count));
  for item in List do
  showmessage(item.GetNome);



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

end; //fecha onCreate

// ----------- FUN��ES DE CRIA��O ------

procedure TF_HomePage.CriaImagem(arquivo: string;OImage:TImage);
begin
  OImage:=TImage.Create(Scroll);
  OImage.Parent:=Scroll;
  OImage.Width:=299;
  OImage.Height:=155;
  OImage.Picture.LoadFromFile(dm.capa+arquivo);
  OImage.Stretch:=true;
  OImage.top:= Alinha(false);
  OImage.Left:= 16+(((lengthImagem mod 3))*344);
  lengthImagem:=lengthImagem+1;
  elementoIsLabel:=false;
end;

procedure TF_HomePage.CriaLabel(texto: string; OLabel: TLabel);
begin
  Olabel:=TLabel.Create(Scroll);
  Olabel.Parent:=Scroll;
  Olabel.Caption:=texto;
  Olabel.Font.Size:=16;
  Olabel.top:=alinha(true);
  Olabel.left:=(scroll.Width div 2)-(Olabel.Width div 2);
  lengthLabel:=lengthLabel+1;
  elementoIsLabel:=true;
  showmessage(inttostr(OLabel.Top));
end;

// ----------- FUN��ES EXTRAS -----------

function TF_HomePage.Alinha(isLabel: boolean): integer;
var
i,topo:integer;
begin
  topo:=40;
  if isLabel then
  begin
    topo:=topo+(LengthLabel*220);
  end else begin
    topo:=40+(lengthLabel*52);
    if ElementoIsLabel then
    topo:=topo+(countColumn*184);
  end;

  result:=topo;
end;

function TF_HomePage.CountColumn: integer;
var
i,count:integer;
begin
  count:=lengthImagem div 3;
  if (count > 0) then
  begin
    count:=count+1;
  end;
  result:=count ;
end;

end.
