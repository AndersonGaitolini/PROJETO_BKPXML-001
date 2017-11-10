unit uFrmListaXML;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uPadraoCons, Data.DB, System.ImageList,
  Vcl.ImgList, Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls, Vcl.ComCtrls, Vcl.ToolWin,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.CheckLst;

type
  TfrmListaXMLS = class(TfrmPadraoCons)
    CheckListBox1: TCheckListBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmListaXMLS: TfrmListaXMLS;

implementation

uses
  uDMnfebkp;

{$R *.dfm}

end.
