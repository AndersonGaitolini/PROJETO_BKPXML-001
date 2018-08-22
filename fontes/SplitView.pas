unit SplitView;

interface

Uses
     Vcl.ExtCtrls, Vcl.Controls, Forms;

type
    TSVCloseStyle = (svColapse, svCompact);
    TSVPlacement = (svLeft, svRight);
    TSVViewState = (Colapsado, Expandido);

    TSplitView = class
    Private
       panel : TPanel;

       fSplitViewState     : TSVViewState; // Estado do SplitView
       fSaveWidthSplitView : Integer;      // Tamanho do painel antes de estar colapsado
       fImageVisibleWidth  : Integer;      // Tamanho das impagens visiveis quando o closeStyle = Compact
       fUseAnimation       : Boolean;      // Anima o recolhimento/Expansão ou não
       fPlacement          : TSVPlacement; // Local do Split View
       fCloseStyle         : TSVCloseStyle; // Modo de Fechamento (Compact ou Colapse)

       procedure SetCloseStyle (CloseStyle : TSVCloseStyle);
       procedure SetPlacement (aPlacement : TSVPlacement);
       procedure SetAnimation (Animation : Boolean);
       procedure SetViewState (aViewState : TSVViewState);
//       procedure Colapse;
//       procedure Expand;
    Public
       property SplitViewState     : TSVViewState read fSplitViewState write SetViewState;
       property SaveWidthSplitView : Integer read fSaveWidthSplitView write fSaveWidthSplitView;
       property ImageVisibleWidth  : Integer read fImageVisibleWidth write fImageVisibleWidth;
       property UseAnimation       : Boolean read fUseAnimation write SetAnimation;
       property Placement          : TSVPlacement read fPlacement write SetPlacement;
       property CloseStyle         : TSVCloseStyle read fCloseStyle write SetCloseStyle;

       constructor  Create (aPanel : TPanel); overload;
       destructor Destroy; override;
       procedure  MoveSplitView;
       procedure Colapse;
       procedure Expand;
    end;


implementation

Constructor TSplitView.Create (aPanel : TPanel);
Begin
     inherited Create;
     panel := aPanel;

     SetViewState (Expandido);
     SetAnimation (True);
     SetCloseStyle (svColapse);
End;

Destructor TSplitView.Destroy;
Begin
     inherited;
End;

procedure TSplitView.SetCloseStyle (CloseStyle : TSVCloseStyle);
begin
     if CloseStyle = svCompact Then
        ImageVisibleWidth := 50
     else
        ImageVisibleWidth := 0;
End;

procedure TSplitView.SetPlacement (aPlacement : TSVPlacement);
begin
     fPlacement := aPlacement;
     if aPlacement = svLeft then
        panel.Align := alLeft
     else
        panel.Align := alRight;
end;

procedure TSplitView.SetAnimation (Animation : Boolean);
begin
     fUseAnimation := Animation;
end;

procedure TSplitView.SetViewState (aViewState : TSVViewState);
begin
     fSplitViewState := aViewState;
end;

procedure TSplitView.Colapse;
Var
     Cont : Integer;
Begin
     SaveWidthSplitView := panel.Width;
     if UseAnimation then
     Begin
        for Cont := 1 to Panel.Width - ImageVisibleWidth do
        begin
            panel.Width := panel.Width - 1;
            Application.ProcessMessages;
        end;
     End
     else
     begin
        Panel.Width := ImageVisibleWidth;
     end;
     SplitViewState := Colapsado;
End;

procedure TSplitView.Expand;
Var
     Cont : Integer;
Begin
     if UseAnimation then
     Begin
        for Cont := 1 to SaveWidthSplitView - ImageVisibleWidth do
        begin
            panel.Width := panel.Width + 1;
            Application.ProcessMessages;
        end;
     End
     ELse
     Begin
        SetPlacement(fPlacement);
        Panel.Width := SaveWidthSplitView;
     End;
     SplitViewState := Expandido;
End;


procedure TSplitView.MoveSplitView;
begin
     if SplitViewState = Expandido then
        Colapse
     else
        Expand;
end;

end.
