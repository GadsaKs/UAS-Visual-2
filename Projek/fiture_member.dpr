program fiture_member;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Unit2 in 'Unit2.pas' {koneksi},
  Unit3 in '..\..\..\..\Softwares\Delphi 7\LIbrary\libmysql\Unit3.pas' {DataModule3: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(Tkoneksi, koneksi);
  Application.CreateForm(TDataModule3, DataModule3);
  Application.Run;
end.
