unit U_Login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, U_BaseForm;

type
  TF_Login = class(TBaseForm)
    background: TImage;
    Edit1: TEdit;
    Edit2: TEdit;
    btn_entrar: TImage;
    lb_naoPossui: TImage;
    procedure btn_entrarMouseEnter(Sender: TObject);
    procedure btn_entrarMouseLeave(Sender: TObject);
    procedure lb_naoPossuiMouseLeave(Sender: TObject);
    procedure lb_naoPossuiMouseEnter(Sender: TObject);
    procedure lb_naoPossuiClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_Login: TF_Login;

implementation

{$R *.dfm}

uses U_dm, U_Register;

procedure TF_Login.btn_entrarMouseEnter(Sender: TObject);
begin
  inherited;
  btn_entrar.Picture.LoadFromFile(dm.templates + 'entrarHover.png');
end;

procedure TF_Login.btn_entrarMouseLeave(Sender: TObject);
begin
  inherited;
  btn_entrar.Picture.LoadFromFile(dm.templates + 'btn_entrar.png');
end;

procedure TF_Login.lb_naoPossuiClick(Sender: TObject);
begin
  inherited;
  change(Tf_register,f_register);
end;

procedure TF_Login.lb_naoPossuiMouseEnter(Sender: TObject);
begin
  inherited;
  lb_naoPossui.Picture.LoadFromFile(dm.templates + 'naoPossuiHover.png');
end;

procedure TF_Login.lb_naoPossuiMouseLeave(Sender: TObject);
begin
  inherited;
  lb_naoPossui.Picture.LoadFromFile(dm.templates + 'lb_naoPossuiConta.png');
end;

end.
