unit U_MediaClass;

interface
uses
  FireDAC.Comp.Client,vcl.Dialogs,System.SysUtils;
type
  TMedia = class
    private

      FQuery      : TFDQuery;
      FId         : string;
      FNome       : string;
      FDirMP4     : string;
      FDirCapa    : string;
      FDuracao    : string;
      FLancamento : string;
      FGeneroid   : string;

    public
      procedure Desactive;

      constructor create(id:string='null');
      // SETTER
      procedure SetId(arg:string);
      procedure SetNome(arg:string);
      procedure SetMP4(arg:string);
      procedure SetCapa(arg:string);
      procedure SetDuracao(arg:string);
      procedure SetLancamento(arg:string);
      procedure SetGeneroId(arg:string);
      // GETTER
      function GetId:string;
      function GetNome:string;
      function GetMP4:string;
      function GetCapa:string;
      function GetDuracao:string;
      function GetLancamento:string;
      function GetGeneroId:string;

  end;


implementation

{ TMedia }

uses U_dm;

// *************** BASIC METHODS *****************************

//--------- SETTER ------------

procedure TMedia.SetCapa(arg: string);
begin
  FDirCapa := arg;
end;

procedure TMedia.SetDuracao(arg: string);
begin
  FDuracao := arg;
end;

procedure TMedia.SetGeneroId(arg: string);
begin
  FGeneroId := arg;
end;

procedure TMedia.SetId(arg: string);
begin
  FID := arg;
end;

procedure TMedia.SetLancamento(arg: string);
begin
  FLancamento := arg;
end;

procedure TMedia.SetMP4(arg: string);
begin
  FDirMP4 := arg;
end;

procedure TMedia.SetNome(arg: string);
begin
  FNome := arg;
end;

// --------- GETTER ----------------

constructor TMedia.create(id: string);
var
i:integer;
begin

  FQuery:= TFDQuery.Create(dm);
  FQuery.Connection:= dm.conexao;
  FQuery.SQL.Text:= 'SELECT id FROM MIDIA';

  if id <> 'null' then
  begin
    with FQuery do
    begin
      Active:=true;

      SQL.Text:= 'SELECT nome_midia,dir_midia,dir_capa,duracao,' +
      'data_lancamento,genero_id FROM MIDIA WHERE ID = :pesq';
      parambyname('pesq').AsString:=id;

      OPEN;
      FIRST;
      if not IsEmpty then
      begin
        FNome:=fieldByName('nome_midia').AsString;
        FDirMP4:=fieldByName('dir_midia').AsString;
        FDirCapa:=fieldByName('dir_capa').AsString;
        FDuracao:=fieldByName('duracao').AsString;
        FLancamento:=fieldByName('data_lancamento').AsString;
        FGeneroId:=fieldByName('genero_id').AsString;
      end;

    end;
  end;
  Desactive;
end;

procedure TMedia.Desactive;
begin
  FQuery.SQL.Text:='SELECT id FROM MIDIA';
  FQuery.Open;
  FQuery.Active:=false;
  FQuery.Close;
end;

function TMedia.GetCapa: string;
begin
   result:=FDirCapa;
end;

function TMedia.GetDuracao: string;
begin
  result:=FDuracao;
end;

function TMedia.GetGeneroId: string;
begin
  result:=FGeneroId;
end;

function TMedia.GetId: string;
begin
   result:=FId;
end;

function TMedia.GetLancamento: string;
begin
  result:=FLancamento;
end;

function TMedia.GetMP4: string;
begin
   result:=FDirMP4;
end;

function TMedia.GetNome: string;
begin
  result:=FNome;
end;

end.
