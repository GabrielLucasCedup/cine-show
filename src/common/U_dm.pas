unit U_dm;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Phys.MySQLDef, Data.DB, FireDAC.Phys.MySQL, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, U_MediaClass,System.Generics.Collections,vcl.Dialogs;

type
  Tdm = class(TDataModule)
    conexao: TFDConnection;
    driver: TFDPhysMySQLDriverLink;
    QUser: TFDQuery;
    QMedia: TFDQuery;
    QRetomar: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }

    // tabela USUARIO
    procedure UserActive;
    procedure UserDesactive;
    function IdGeneration:string;

    // tabela MIDIA
    procedure MediaActive;
    procedure MediaDesactive;

    // tabela RETOMAR
    procedure RetomarActive;
    procedure RetomarDesactive;

  public
    { Public declarations }
    var
    UserID:string;
    UserExibe:string;

    //LOAD
    LoadOption:integer;

    // PATH
    templates:string;
    media:string;
    capa:string;
    hover:string;


    // CONTAS
    function Authentication(email:string;senha:string):boolean;
    procedure CreateUser(usuario,email,senha,nasc:string);
    function TransformExibe(nome:string):string;

    // tabela USUARIO
    function UserFindByEmail(pesq:string):boolean;
    function UserFindById(pesq:string):boolean;

    // tabela MIDIA
    function MediaFindByName(pesq:string):boolean;
    function MediaSelectRecentes:TObjectList<TMedia>;

    // tabela RETOMAR
    function RetomarCount(idUsuario:string):integer;
    function RetomarSelectAll(idUsuario:string):TObjectList<TMedia>;

  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

// ------------- EVENT CREATE -------------------------------------------



procedure Tdm.DataModuleCreate(Sender: TObject);
begin
  templates :=  getCurrentDir + '\src\templates\';
  hover:=templates+'hover\';
  media := getCurrentDir + '\midia\mp4\';
  capa := getCurrentDir + '\midia\capa\';
  driver.VendorLib:= getCurrentDir + '\libs\libmySQL.dll';
  conexao.Connected:=true;
  conexao.Params.Database:='sistema_cineshow';
  conexao.Params.username:='root';
  conexao.Params.password:='3307';
end;



// -------------- CONTAS -------------------------------------------------



function Tdm.Authentication(email, senha: string): boolean;
begin
  UserActive;
  with QUser do
  begin
    SQL.Text := ('SELECT id,nome_exibido from usuario where email = :email and senha = :senha');
    ParamByName('email').AsString := lowercase(email);
    ParamByName('senha').AsString := lowercase(senha);
    OPEN;
    FIRST;
    if not IsEmpty then
    begin
      UserID:=Fields[0].AsString;
      UserExibe:=transformExibe(Fields[1].AsString);
    end;
    result:= not IsEmpty;
  end;
  UserDesactive;
end;

procedure Tdm.CreateUser(usuario, email, senha, nasc: string);
var
id:string;
begin
  UserActive;
  UserID:=IdGeneration;
  UserExibe:=TransformExibe(usuario);
    with QUser do
    begin
      SQL.Text:= 'INSERT INTO USUARIO VALUES (:id,:usuario,:usuario,:email,:senha,:nasc,:reg)';
      ParamByName('id').AsString:=UserID;
      ParamByName('usuario').AsString:=lowercase(UserExibe);
      ParamByName('email').AsString:=lowercase(email);
      ParamByName('senha').AsString:=lowercase(senha);
      ParamByName('nasc').AsDate:=StrToDate(nasc);
      ParamByName('reg').AsDate:=Date;
      execute;
    end;

  UserDesactive;
end;

function Tdm.TransformExibe(nome: string): string;
var
i:integer;
str:string;
begin
  str:='';
  for i:=1 to length(nome) do
  begin
    if i = 1 then
    str:=str+Uppercase(nome[i])
    else
    if nome[i-1] = ' ' then
    str:=str+Uppercase(nome[i])
    else
    str:=str+lowercase(nome[i]);
  end;
  result:=str;
end;


// -------------- USUARIO ------------------------------------------------



procedure Tdm.UserActive;
begin
   QUser.Active:=TRUE;
end;

procedure Tdm.UserDesactive;
begin
   QUser.sql.Text := ('SELECT NOME FROM USUARIO');
   QUser.Open;
   QUser.Active:=False;
   QUser.Close;
end;

function Tdm.UserFindByEmail(pesq: string): boolean;
begin
    UserActive;
     with QUser do
     begin
       SQL.Text:= ('SELECT EMAIL FROM USUARIO WHERE EMAIL = :pesq');
       ParamByName('pesq').AsString:=lowercase(pesq);
       Open;
       result:= not IsEmpty;
     end;
     UserDesactive;
end;

function Tdm.UserFindById(pesq: string): boolean;
begin

  if length(pesq) <> 6  then
    result:=false
  else begin
     UserActive;
     with QUser do
     begin
       SQL.Text:= ('SELECT ID FROM USUARIO WHERE ID = :pesq');
       ParamByName('pesq').AsString:=pesq;
       Open;
       result:= not IsEmpty;
     end;
     UserDesactive;
  end;

end;

function Tdm.IdGeneration: string;
var
i:integer;
cadeia,newId:string;
condicional:boolean;
begin
   randomize;
   cadeia:='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
   condicional:=true;
   newId:='';
   repeat

      for i:=1 to 6 do
      begin
         newId:=newId+ cadeia[ random(length(cadeia)) + 1];
      end;

   until not UserFindById(newId);

   result:=newId;
end;



// ----------- MEDIA ---------------------------------------------------



procedure Tdm.MediaActive;
begin
 QMedia.Active:=true;
end;

procedure Tdm.MediaDesactive;
begin
   QMedia.sql.Text := ('SELECT nome_midia FROM midia');
   QMedia.Open;
   QMedia.Active:=False;
   QMedia.Close;
end;

function Tdm.MediaFindByName(pesq: string): boolean;
begin
  MediaActive;
  with QMEDIA do
  begin
    SQL.Text:='SELECT NOME_MEDIA FROM MIDIA WHERE ID = :pesq';
    ParamByName('pesq').AsString:=pesq;
    open;
    result:= not IsEmpty;         //TRUE se encontrou FALSE se nao encontrou
  end;
end;

function Tdm.MediaSelectRecentes: TObjectList<TMedia>;
var
OList:TObjectList<TMedia>;
begin
  Olist:= TObjectList<TMedia>.Create;
  MediaActive;
  with QMedia do
  begin
    SQL.Text:= 'SELECT id FROM MIDIA WHERE YEAR(DATA_LANCAMENTO) = YEAR(CURDATE())';
    OPEN;
    if IsEmpty then
    begin
      Result:=Olist;
      exit
    end;

    First;
    while not EOF do
    begin
      Olist.Add(TMedia.create(fieldByName('id').AsString));
      next;
    end;

  end;
  MediaDesactive;
  result:=Olist;
end;



// ---------- RETOMAR -----------------------------------------------------



procedure Tdm.RetomarActive;
begin
 QRetomar.Active:=true;
end;

function Tdm.RetomarCount(idUsuario:String): integer;
begin
  RetomarActive;
  with QRetomar do
  begin
     Active:=true;
     SQL.Text:= 'SELECT COUNT(MIDIA_ID) FROM RETOMAR WHERE USUARIO_ID = :pesq';
     ParamByName('pesq').AsString:=idUsuario;
     OPEN;
     if not IsEmpty then
     result:=Fields[0].AsInteger
     else
     result:=0;
  end;
  RetomarDesactive;
end;

procedure Tdm.RetomarDesactive;
begin
   QUser.sql.Text := ('SELECT midia_id FROM retomar');
   QUser.Open;
   QUser.Active:=False;
   QUser.Close;
end;

function Tdm.RetomarSelectAll(idUsuario: string): TObjectList<TMedia>;
begin
 //sexo
end;


end.
