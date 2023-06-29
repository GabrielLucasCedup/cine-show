unit U_MediaClass;

interface
uses
  FireDAC.Comp.Client;
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

// **************** DATABASE METHODS ********************************








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