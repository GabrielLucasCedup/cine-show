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
    procedure timerTimer(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);

    //------------------EVENTOS---------------------------

    //PLAY

    procedure EventPlayClick(sender:TObject);
    procedure EventPlayEnter(sender:TObject);
    procedure EventPlayLeave(sender:TObject);

    function imageChange(IsHover:boolean;imgs:Timage):string;
    procedure PlayerControls;
    procedure showPlayerControls;
    procedure hidePlayerControls;
    procedure PlayAction(IsHover:boolean;imgs:TImage);
    function getPlayerControls(nome:string):TImage;


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
  IsMute:boolean=false;
  player:IWMPCore;
  FAction: integer;

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
    FAction:=1;

    painel.Caption:=dm.FilmeOption.GetNome;
    Constraints.MaxHeight :=  0;
    Constraints.MinHeight := 574;
    Constraints.MaxWidth := 0;
    Constraints.MinWidth := 1020;

    self.clientwidth:=1020;
    self.ClientHeight:=574;

    player.settings.volume:=100;
    mediaplayer.Width:=clientWidth;
    mediaplayer.Height:=clientHeight;
    borderIcons:=[biSystemMenu,biMinimize];
    mediaplayer.left:=0;
    playercontrols;
end;
procedure TF_player.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if FAction = 1 then
  begin
    dm.OutOption:=1;
    Action:=TCloseAction.caNone;
    Application.CreateForm(TF_Out,F_Out);
    F_Out.ShowModal;
  end else
    Action:=TCloseAction.caFree;

end;

function TF_player.getPlayerControls(nome: string): TImage;
var
i:integer;
begin
  for i:=0 to painel.ComponentCount-1 do
  begin
    if painel.Components[i] is TImage then
    begin
      if (painel.Components[i] as TImage).Name = nome then
      begin
        result:=(painel.Components[i] as TImage);
        exit
      end;
    end;
  end;
end;

procedure TF_player.PlayAction(IsHover: boolean; imgs: TImage);
begin
  if imgs.name = 'FPlay' then   // PLAY
  begin
    if IsPause then
      begin
        IsPause:=false;
        player.controls.pause;
        imgs.Picture.LoadFromFile(dm.templates + F_Player.imageChange(IsHover,imgs));
      end else begin
        IsPause:=true;
        player.controls.play;
        imgs.Picture.LoadFromFile(dm.templates + F_Player.imageChange(IsHover,imgs));
      end;
  end else
  if imgs.name = 'FAvancar' then   // AVANCAR
  begin
     player.controls.currentPosition:=player.controls.currentPosition+20;
      imgs.Picture.LoadFromFile(dm.templates+imageChange(IsHover,imgs));
  end else
  if imgs.name = 'FRetroceder' then   // RETROCEDER
  begin
     player.controls.currentPosition:=player.controls.currentPosition-20;
      imgs.Picture.LoadFromFile(dm.templates+imageChange(IsHover,imgs));
  end else
  if imgs.Name = 'FfullScreen' then       //FULL SCREEN
  begin
    if IsFull then
    begin
      IsFull:=false;
      mediaplayer.fullScreen:=true;
      imgs.Picture.LoadFromFile(dm.templates+imageChange(IsHover,imgs));
    end else begin
      IsFull:=true;
      mediaplayer.fullScreen:=false;
      imgs.Picture.LoadFromFile(dm.templates+imageChange(IsHover,imgs));
    end;
  end else
  if imgs.Name = 'FVolume' then       //FULL SCREEN
  begin
    if IsMute then
    begin
      IsMute:=false;
      player.settings.mute:=false;
      imgs.Picture.LoadFromFile(dm.templates+imageChange(IsHover,imgs));
    end else begin
      IsMute:=true;
      player.settings.mute:=true;
      imgs.Picture.LoadFromFile(dm.templates+imageChange(IsHover,imgs));
    end;
  end else
  if imgs.Name = 'FVoltar' then
  begin
    dm.OutOption:=2;
    FAction:=2;
    Application.CreateForm(TF_Out,F_Out);
    F_Out.ShowModal;
  end;

end;

procedure TF_player.PlayerControls;
var
imgs:TImage;
Fleft,FRight:integer;
begin
  painel.Width:=clientwidth;
  painel.Height:=60;
  painel.Align:=alBottom;

  FRight:=painel.Width-60;
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

  FRight:=FRight-60;
  //volume
  imgs:=TImage.Create(Painel);
  imgs.Parent:=painel;
  imgs.Name:='FVolume';
  imgs.Stretch:=true;
  imgs.Width:=32;
  imgs.Height:=32;
  imgs.Top:=(painel.Height div 2)-(imgs.Height div 2);
  imgs.Left:=FRight;
  imgs.Picture.LoadFromFile(dm.templates+imageChange(false,imgs));
  imgs.OnClick:=EventPlayClick;
  imgs.OnMouseEnter:=EventPlayEnter;
  imgs.OnMouseLeave:=EventPlayLeave;

  FRight:=FRight-60;
  //voltar
  imgs:=TImage.Create(Painel);
  imgs.Parent:=painel;
  imgs.Name:='FVoltar';
  imgs.Stretch:=true;
  imgs.Width:=32;
  imgs.Height:=32;
  imgs.Top:=(painel.Height div 2)-(imgs.Height div 2);
  imgs.Left:=FRight;
  imgs.Picture.LoadFromFile(dm.templates+imageChange(false,imgs));
  imgs.OnClick:=EventPlayClick;
  imgs.OnMouseEnter:=EventPlayEnter;
  imgs.OnMouseLeave:=EventPlayLeave;

  FLeft:=30;
  // retroceder
  imgs:=TImage.Create(Painel);
  imgs.Parent:=painel;
  imgs.Name:='FRetroceder';
  imgs.Stretch:=true;
  imgs.Width:=32;
  imgs.Height:=32;
  imgs.Top:=(painel.Height div 2)-(imgs.Height div 2);
  imgs.Left:=FLeft;
  imgs.Picture.LoadFromFile(dm.templates+imageChange(false,imgs));
  imgs.OnClick:=EventPlayClick;
  imgs.OnMouseEnter:=EventPlayEnter;
  imgs.OnMouseLeave:=EventPlayLeave;

  FLeft:=FLeft+60;
  // play
  imgs:=TImage.Create(Painel);
  imgs.Parent:=painel;
  imgs.Name:='FPlay';
  imgs.Stretch:=true;
  imgs.Width:=32;
  imgs.Height:=32;
  imgs.Top:=(painel.Height div 2)-(imgs.Height div 2);
  imgs.Left:=FLeft;
  imgs.Picture.LoadFromFile(dm.templates+imageChange(false,imgs));
  imgs.OnClick:=EventPlayClick;
  imgs.OnMouseEnter:=EventPlayEnter;
  imgs.OnMouseLeave:=EventPlayLeave;

  FLeft:=FLeft+60;
  // avancar
  imgs:=TImage.Create(Painel);
  imgs.Parent:=painel;
  imgs.Name:='FAvancar';
  imgs.Stretch:=true;
  imgs.Width:=32;
  imgs.Height:=32;
  imgs.Top:=(painel.Height div 2)-(imgs.Height div 2);
  imgs.Left:=FLeft;
  imgs.Picture.LoadFromFile(dm.templates+imageChange(false,imgs));
  imgs.OnClick:=EventPlayClick;
  imgs.OnMouseEnter:=EventPlayEnter;
  imgs.OnMouseLeave:=EventPlayLeave;


end;

procedure TF_player.showPlayerControls;
begin
  painel.Visible:=true;
end;

procedure TF_player.hidePlayerControls;
begin
  painel.Visible:=false;
end;

procedure TF_player.timerTimer(Sender: TObject);
begin
  inherited;
  if player.playState = wmppsPlaying then
  begin
    j:=j+1;
  end;
end;

//---------------------------  EVENTOS  --------------------------------------

//--------------------------- CLICK ------------------------------------------

procedure TF_player.EventPlayClick(sender: TObject);
begin
  PlayAction(true,sender as TImage);
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
  if imgs.Name = 'FPlay' then            //PLAY
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
  if imgs.Name = 'FAvancar' then        //AVANCAR
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
  if imgs.Name = 'FfullScreen' then     //FULL SCREEN
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
  end else
  if imgs.Name = 'FVolume' then
  begin
    if IsMute then
    begin
      if IsHover then
         result:='painelPlayer\hover\mudo.png'
        else
          result:='painelPlayer\mudo.png';
    end else begin
      if IsHover then
        result:='painelPlayer\hover\volume.png'
      else
        result:='painelPlayer\volume.png';
    end;
  end else
  if imgs.Name = 'FVoltar' then
  begin
    if IsHover then
         result:='painelPlayer\hover\voltar.png'
        else
          result:='painelPlayer\voltar.png';
  end;

end;

procedure TF_player.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  ShowMessage(key.ToString);
  if key in [32,75] then
  begin
    PlayAction(false,getPlayerControls('FPlay'));
  end;
end;

//------------------------------------------------------------------------------

end.


{
mediaplayer.settings.volume  // +- volume
mediaplayer.settings.mute:=true; // deixa sem som
}
