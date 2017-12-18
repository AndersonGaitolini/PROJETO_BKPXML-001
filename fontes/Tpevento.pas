unit Tpevento;

interface

uses
  Base, System.SysUtils, Atributos, System.Classes,Data.DB,
  uDMnfebkp,FireDAC.Comp.Client,Vcl.DBGrids,
  Datasnap.DBClient, Datasnap.Provider,Vcl.Forms,Vcl.Dialogs,Vcl.Controls;

type
  [attTabela('TPEVENTO')]
  TTpevento = class(TTabela)
  private
    FId: Integer;
    FCodevento: Integer;
    FDescricao: string;
  public
    [attPK]
    property Id: Integer read FId write FId;
    property Codevento: Integer read FCodevento write FCodevento;
    property Descricao: string read FDescricao write FDescricao;
  end;

implementation

end.
