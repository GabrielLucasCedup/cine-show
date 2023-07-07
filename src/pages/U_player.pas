unit U_player;
interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, U_BaseForm, Vcl.Imaging.jpeg,
  Vcl.ExtCtrls, Vcl.OleCtrls, WMPLib_TLB, Vcl.StdCtrls;
type
  TF_player = class(TBaseForm)
    MediaPlayer: TWindowsMediaPlayer;
    timer: TTimer;
    painel: TPanel;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PlayerControls;

    //EVENTOS
    procedure EventPlayClick(sender:TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;
var
  F_player: TF_player;
  j:integer=0;
  IsResize:boolean=false;
  oldHeight,oldWidth:integer;
  player:IWMPCore;

implementation
{$R *.dfm}
uses U_dm, U_Out;

////---------------------------  EVENTOS  --------------------------------------

procedure TF_player.EventPlayClick(sender: TObject);
begin
  player.controls.pause;
  mediaplayer.fullScreen:=true;
end;

//------------------------------------------------------------------------------
procedure TF_player.FormActivate(Sender: TObject);
begin
    inherited;
    mediaplayer.URL:= dm.media + dm.FilmeOption.getMP4;
    player:=mediaplayer.ControlInterface;
    //mediaplayer.stretchToFit:=true;
    timer.Enabled:=true;

    Constraints.MaxHeight :=  0;
    Constraints.MinHeight := 574;
    Constraints.MaxWidth := 0;
    Constraints.MinWidth := 1020;

    self.clientwidth:=1020;
    self.ClientHeight:=574;

    mediaplayer.Width:=clientWidth;
    mediaplayer.Height:=clientHeight-60;
    borderIcons:=[biSystemMenu,biMinimize];
    mediaplayer.left:=0;
    playercontrols;
end;
procedure TF_player.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  dm.OutOption:=1;
  Action:=TCloseAction.caNone;
  Application.CreateForm(TF_Out,F_Out);
  F_Out.ShowModal;
end;


procedure TF_player.PlayerControls;
var
imgs:TImage;
begin
  painel.Width:=clientwidth;
  painel.Height:=60;
  painel.Align:=alBottom;

  imgs:=TImage.Create(painel);
  imgs.Parent:=painel;
  imgs.Stretch:=true;
  imgs.Width:=60;
  imgs.Height:=60;
  imgs.Picture.LoadFromFile(dm.templates+'btn_player.png');
  imgs.OnClick:=EventPlayClick;
end;

end.


{
mediaplayer.settings.volume  // +- volume
mediaplayer.settings.mute:=true; // deixa sem som
}
