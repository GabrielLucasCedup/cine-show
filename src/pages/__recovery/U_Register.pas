unit U_Register;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, U_BaseForm;

type
  TF_register = class(TBaseForm)
    txt_usuario: TEdit;
    txt_email: TEdit;
    txt_senha: TEdit;
    background: TImage;
    txt_confirme: TEdit;
    btn_criar: TImage;
    lb_conta: TImage;
    Image1: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lb_contaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_register: TF_register;

implementation

{$R *.dfm}

uses U_Login;



procedure TF_register.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  fecha;
end;

procedure TF_register.lb_contaClick(Sender: TObject);
begin
  inherited;
  change(Tf_login,f_login);
end;

end.
