unit U_player;
interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, U_BaseForm, Vcl.Imaging.jpeg,
  Vcl.ExtCtrls, Vcl.OleCtrls, WMPLib_TLB, Vcl.StdCtrls, Vcl.Imaging.pngimage;
type
  TF_player = class(TBaseForm)
    MediaPlayer: TWindowsMediaPlayer;
    timer: TTimer;
    painel: TPanel;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PlayerControls;

    //------------------EVENTOS---------------------------

    //PLAY
     function imageChange(IsHover:boolean;imgs:Timage):string;
    procedure EventPlayClick(sender:TObject);
    procedure EventPlayEnter(sender:TObject);
    procedure EventPlayLeave(sender:TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;
var
  F_player: TF_player;
  j:integer=0;
  IsPause:boolean=true;
  IsFull:boolean=true;
  player:IWMPCore;

implementation
{$R *.dfm}
uses U_dm, U_Out;

//------------------------------------------------------------------------------

procedure TF_player.FormActivate(Sender: TObject);
begin
    inherited;
    mediaplayer.URL:= dm.media + dm.FilmeOption.getMP4;
    player:=mediaplayer.ControlInterface;
    timer.Enabled:=true;

    Constraints.MaxHeight :=  0;
    Constraints.MinHeight := 574;
    Constraints.MaxWidth := 0;
    Constraints.MinWidth := 1020;

    self.clientwidth:=1020;
    self.ClientHeight:=574;

    mediaplayer.Width:=clientWidth;
    mediaplayer.Height:=clientHeight;
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
Fleft,FRight:integer;
begin
  painel.Width:=clientwidth;
  painel.Height:=60;
  painel.Align:=alBottom;

  FRight:=painel.Width-50;
  // play
  imgs:=TImage.Create(Painel);
  imgs.Parent:=painel;
  imgs.Name:='FPlay';
  imgs.Stretch:=true;
  imgs.Width:=32;
  imgs.Height:=32;
  imgs.Top:=(painel.Height div 2)-(imgs.Height div 2);
  imgs.Left:=FRight;
  imgs.Picture.LoadFromFile(dm.templates+imageChange(false,imgs));
  imgs.OnClick:=EventPlayClick;
  imgs.OnMouseEnter:=EventPlayEnter;
  imgs.OnMouseLeave:=EventPlayLeave;

  FRight:=FRight-50;
  // avancar
  imgs:=TImage.Create(Painel);
  imgs.Parent:=painel;
  imgs.Name:='FAvancar';
  imgs.Stretch:=true;
  imgs.Width:=32;
  imgs.Height:=32;
  imgs.Top:=(painel.Height div 2)-(imgs.Height div 2);
  imgs.Left:=FRight;
  imgs.Picture.LoadFromFile(dm.templates+imageChange(false,imgs));
  imgs.OnClick:=EventPlayClick;
  imgs.OnMouseEnter:=EventPlayEnter;
  imgs.OnMouseLeave:=EventPlayLeave;

  FRight:=FRight-50;
  // retroceder
  imgs:=TImage.Create(Painel);
  imgs.Parent:=painel;
  imgs.Name:='FRetroceder';
  imgs.Stretch:=true;
  imgs.Width:=32;
  imgs.Height:=32;
  imgs.Top:=(painel.Height div 2)-(imgs.Height div 2);
  imgs.Left:=FRight;
  imgs.Picture.LoadFromFile(dm.templates+imageChange(false,imgs));
  imgs.OnClick:=EventPlayClick;
  imgs.OnMouseEnter:=EventPlayEnter;
  imgs.OnMouseLeave:=EventPlayLeave;

  FRight:=FRight-50;
  // full Screen
  imgs:=TImage.Create(Painel);
  imgs.Parent:=painel;
  imgs.Name:='FfullScreen';
  imgs.Stretch:=true;
  imgs.Width:=37;
  imgs.Height:=37;
  imgs.Top:=(painel.Height div 2)-(imgs.Height div 2);
  imgs.Left:=FRight;
  imgs.Picture.LoadFromFile(dm.templates+imageChange(false,imgs));
  imgs.OnClick:=EventPlayClick;
  imgs.OnMouseEnter:=EventPlayEnter;
  imgs.OnMouseLeave:=EventPlayLeave;

  FRight:=FRight-50;

end;

//---------------------------  EVENTOS  --------------------------------------

//--------------------------- CLICK ------------------------------------------

procedure TF_player.EventPlayClick(sender: TObject);
begin
  if (sender as TImage).Name = 'FPlay' then      // PLAY
  begin
    if IsPause then
    begin
      IsPause:=false;
      player.controls.pause;
      (sender as TImage).Picture.LoadFromFile(dm.templates+imageChange(true,sender as TImage));
    end else begin
      IsPause:=true;
      player.controls.play;
      (sender as TImage).Picture.LoadFromFile(dm.templates+imageChange(true,sender as TImage));
    end;
  end else
  if (sender as TImage).Name = 'FAvancar' then       //AVANCAR
  begin
      player.controls.currentPosition:=player.controls.currentPosition+20;
      (sender as TImage).Picture.LoadFromFile(dm.templates+imageChange(true,sender as TImage));
  end else
  if (sender as TImage).Name = 'FRetroceder' then   //RETROCEDER
  begin
    player.controls.currentPosition:=player.controls.currentPosition-20;
    (sender as TImage).Picture.LoadFromFile(dm.templates+imageChange(true,sender as TImage));
  end else
  if (sender as TImage).Name = 'FfullScreen' then       //FULL SCREEN
  begin
    if IsFull then
    begin
      IsFull:=false;
      mediaplayer.fullScreen:=true;
      (sender as TImage).Picture.LoadFromFile(dm.templates+imageChange(true,sender as TImage));
    end else begin
      IsFull:=true;
      mediaplayer.fullScreen:=false;
      (sender as TImage).Picture.LoadFromFile(dm.templates+imageChange(true,sender as TImage));
    end;
  end;

end;

//-------------------------- ENTER ----------------------------------------

procedure TF_player.EventPlayEnter(sender: TObject);
begin
  (sender as TImage).Picture.LoadFromFile(dm.templates+imageChange(true,sender as TImage));
end;

//-------------------------- LEAVE ----------------------------------------

procedure TF_player.EventPlayLeave(sender: TObject);
begin
  (sender as TImage).Picture.LoadFromFile(dm.templates+imageChange(false,sender as TImage));
end;

//-------------------------- TROCA IMAGENS ----------------------------------------

function TF_player.imageChange(IsHover:boolean;imgs:TImage): string;
var
 nome:string;
begin
  if imgs.Name = 'FPlay' then    //PLAY
  begin
      if IsPause then
    begin
      if IsHover then
        result:='painelPlayer\hover\pause.png'
      else
        result:='painelPlayer\pause.png';
    end else
    begin
      if IsHover then
        result:='painelPlayer\hover\play.png'
      else
        result:='painelPlayer\play.png';
    end;
  end else
  if imgs.Name = 'FAvancar' then     //AVANCAR
  begin
     if IsHover then
       result:='painelPlayer\hover\avancar.png'
     else
       result:='painelPlayer\avancar.png';
  end else
  if imgs.Name = 'FRetroceder' then     //RETROCEDER
  begin
     if IsHover then
       result:='painelPlayer\hover\retroceder.png'
     else
       result:='painelPlayer\retroceder.png';
  end else
  if imgs.Name = 'FfullScreen' then    //FULL SCREEN
  begin
    if IsFull then
    begin
      if IsHover then
        result:='painelPlayer\hover\fullScreen.png'
      else
        result:='painelPlayer\fullScreen.png';
    end else
    begin
      if IsHover then
        result:='painelPlayer\hover\normalScreen.png'
      else
        result:='painelPlayer\normalScreen.png';
    end;
  end;
end;


//------------------------------------------------------------------------------

end.


{
mediaplayer.settings.volume  // +- volume
mediaplayer.settings.mute:=true; // deixa sem som
}
