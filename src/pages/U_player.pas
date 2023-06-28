unit U_player;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, U_BaseForm, Vcl.Imaging.jpeg,
  Vcl.ExtCtrls, Vcl.OleCtrls, WMPLib_TLB;

type
  TF_player = class(TBaseForm) //class(TBaseForm)
    mediaPlayer: TWindowsMediaPlayer;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_player: TF_player;

implementation

{$R *.dfm}

uses U_dm;

procedure TF_player.FormActivate(Sender: TObject);
begin
    inherited;
    mediaplayer.URL:= dm.media + 'avatar.mp4';
    Constraints.MaxHeight :=  0;
    Constraints.MinHeight := 807;
    Constraints.MaxWidth := 0;
    Constraints.MinWidth := 1040;
    borderIcons:=[biSystemMenu,biMinimize,biMaximize];
end;

end.
