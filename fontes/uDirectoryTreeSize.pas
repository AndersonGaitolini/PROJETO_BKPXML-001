unit uDirectoryTreeSize;

interface

uses
  UProgressThread;

type
  TDirectoryTreeSize = class (TProgressThread)
  private
    FInitialDir: String;
    FResult: Int64;
    function DirectoryTreeSize(PInitialDir: String): Int64;
    function DirectoryTreeFileCount(PInitialDir: String): Cardinal;
  public
    procedure Execute; override;
    property InitialDir: String write FInitialDir;
    property Result: Int64 read FResult;
  end;

implementation

uses
  Windows, SysUtils;

function FileSize(PFileName: TFileName): Cardinal;
var
  FileHandle: THandle;
begin
  FileHandle := CreateFile(PChar(PFileName), GENERIC_READ, FILE_SHARE_READ, nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
  try
    Result := GetFileSize(FileHandle, nil);
  finally
    CloseHandle(FileHandle);
  end;
end;

{ TDirectoryTreeSize }

function TDirectoryTreeSize.DirectoryTreeFileCount(PInitialDir: String): Cardinal;
var
  SearchRecord: TSearchRec;
begin
  Result := 0;

  if FindFirst(PInitialDir + '*.*', faAnyFile, SearchRecord) = 0 then
    try
      repeat
        if ((SearchRecord.Attr and faDirectory) = faDirectory) then
        begin
          if (SearchRecord.Name <> '.') and (SearchRecord.Name <> '..') then
            Inc(Result,DirectoryTreeFileCount(PInitialDir + SearchRecord.Name + '\' + ExtractFileName(PInitialDir)));
        end
        else
          Inc(Result);
      until FindNext(SearchRecord) <> 0;
    finally
      FindClose(SearchRecord)
    end;
end;

function TDirectoryTreeSize.DirectoryTreeSize(PInitialDir: String): Int64;
var
  SearchRecord: TSearchRec;
begin
  Result := 0;

  if FindFirst(PInitialDir + '*.*', faAnyFile, SearchRecord) = 0 then
    try
      repeat
        if ((SearchRecord.Attr and faDirectory) = faDirectory) then
        begin
          if (SearchRecord.Name <> '.') and (SearchRecord.Name <> '..') then
            Inc(Result,DirectoryTreeSize(PInitialDir + SearchRecord.Name + '\' + ExtractFileName(PInitialDir)));
        end
        else
        begin
          Text := SearchRecord.Name;
          Number := FileSize(PInitialDir + Text);
          DoProgress;
          Inc(Result,Number);
        end;
      until FindNext(SearchRecord) <> 0;
    finally
      FindClose(SearchRecord)
    end;
end;

procedure TDirectoryTreeSize.Execute;
begin
  inherited;
  Max := DirectoryTreeFileCount(FInitialDir);
  DoMax;
  FResult := DirectoryTreeSize(FInitialDir);
end;

end.
