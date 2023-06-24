unit U_BaseForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TBaseForm = class(TForm)
  protected
    procedure SetDefaultProperties; virtual;
    procedure CreateParams(var Params: TCreateParams); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure change(tform:TformClass;form: Tform);
    procedure fecha;
  end;

implementation

uses U_Login;

procedure TBaseForm.change(tform:TformClass;form: Tform);
begin
 hide;
 application.CreateForm(tform,form);
 form.showModal;
 close;
end;

constructor TBaseForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  SetDefaultProperties;
end;

procedure TBaseForm.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);

  Params.Style := Params.Style and not WS_MAXIMIZEBOX;

end;

procedure TBaseForm.fecha;
begin
 hide;
 f_login.close;
 close;

end;

procedure TBaseForm.SetDefaultProperties;
begin

  ClientWidth := 1024;
  ClientHeight := 768;

  Constraints.MaxHeight :=  807;
  Constraints.MinHeight := 807;
  Constraints.MaxWidth := 1040;
  Constraints.MinWidth := 1040;

  Font.Name := 'Noto Sans';
  Font.Size := 12;

  position := poScreenCenter;


end;


end.
