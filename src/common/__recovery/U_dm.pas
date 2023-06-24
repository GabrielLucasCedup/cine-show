unit U_dm;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Phys.MySQLDef, Data.DB, FireDAC.Phys.MySQL, FireDAC.Comp.Client;

type
  Tdm = class(TDataModule)
    conexao: TFDConnection;
    driver: TFDPhysMySQLDriverLink;
    DataSource: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
    const path:string='../../../';
    const templates:string='../../../src/templates/';
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
