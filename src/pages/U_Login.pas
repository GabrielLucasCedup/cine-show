unit U_Login;
interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, U_BaseForm, Vcl.Mask;
type
  TF_Login = class(TBaseForm)  //class(TBaseForm)
    background: TImage;
    txt_email: TEdit;
    btn_entrar: TImage;
    lb_naoPossui: TImage;
    lock: TImage;
    txt_senha: TMaskEdit;
    Label5: TLabel;
    Label2: TLabel;
    check: TCheckBox;
    Timer1: TTimer;
    procedure btn_entrarMouseEnter(Sender: TObject);
    procedure btn_entrarMouseLeave(Sender: TObject);
    procedure lb_naoPossuiMouseLeave(Sender: TObject);
    procedure lb_naoPossuiMouseEnter(Sender: TObject);
    procedure lb_naoPossuiClick(Sender: TObject);
    procedure btn_entrarClick(Sender: TObject);
    procedure lockClick(Sender: TObject);
    procedure lockMouseEnter(Sender: TObject);
    procedure lockMouseLeave(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }

  end;
var
  F_Login: TF_Login;
  lockImagem:boolean=true;

implementation
{$R *.dfm}
uses U_dm, U_Register, U_HomePage, U_Load;



procedure TF_Login.btn_entrarClick(Sender: TObject);
begin
  inherited;
  if (length(txt_email.text) < 6) or (length(txt_senha.text) < 6) then
    showmessage('Preencha os Campos Corretamente')
  else begin
     if (dm.Authentication(txt_email.Text,txt_senha.Text)) then
     begin
        if check.State = cbChecked then
        dm.Remember;
        dm.LoadOption:=1;
        change(TF_Load,F_Load);
     end else
     showmessage('Email e/ou Senha está incorreta');
  end;
end;
procedure TF_Login.btn_entrarMouseEnter(Sender: TObject);
begin
  inherited;
  btn_entrar.Picture.LoadFromFile(dm.hover + 'btn_entrar.png');
end;
procedure TF_Login.btn_entrarMouseLeave(Sender: TObject);
begin
  inherited;
  btn_entrar.Picture.LoadFromFile(dm.templates + 'btn_entrar.png');
end;



procedure TF_Login.FormActivate(Sender: TObject);
begin
  inherited;
  if dm.PodeRemember then
  begin
    if dm.IsRemember then
    begin
      Timer1.Enabled:=true;
    end;
  end;
end;

procedure TF_Login.lb_naoPossuiClick(Sender: TObject);
begin
  inherited;
  change(TF_Register,F_Register);
end;
procedure TF_Login.lb_naoPossuiMouseEnter(Sender: TObject);
begin
  inherited;
  lb_naoPossui.Picture.LoadFromFile(dm.hover + 'lb_naoPossuiConta.png');
end;
procedure TF_Login.lb_naoPossuiMouseLeave(Sender: TObject);
begin
  inherited;
  lb_naoPossui.Picture.LoadFromFile(dm.templates + 'lb_naoPossuiConta.png');
end;
procedure TF_Login.lockClick(Sender: TObject);
begin
  inherited;
  if lockImagem then
  begin
    lockImagem:=false;
    lock.Picture.LoadFromFile(dm.templates+ dm.LockKey(lockImagem));
    txt_senha.PasswordChar:=#0;
  end else begin
     lockImagem:=true;
    lock.Picture.LoadFromFile(dm.templates+ dm.LockKey(lockImagem));
     txt_senha.PasswordChar:='*';
  end;
end;
procedure TF_Login.lockMouseEnter(Sender: TObject);
begin
  inherited;
  lock.Picture.LoadFromFile(dm.hover+ dm.LockKey(lockImagem));
end;
procedure TF_Login.lockMouseLeave(Sender: TObject);
begin
  inherited;
  lock.Picture.LoadFromFile(dm.templates+ dm.LockKey(lockImagem));
end;



procedure TF_Login.Timer1Timer(Sender: TObject);
begin
  inherited;

  Timer1.Enabled:=false;
  dm.LoadOption:=3;
  change(TF_Load,F_Load);

end;

end.
