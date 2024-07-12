unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ZAbstractTable, ZDataset, DB, ZAbstractRODataset,
  ZAbstractDataset, ZAbstractConnection, ZConnection;

type
  Tkoneksi = class(TForm)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  koneksi: Tkoneksi;

implementation

{$R *.dfm}

end.
