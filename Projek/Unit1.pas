unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, frxClass, frxDBSet;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    eNIK: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    eNAMA: TEdit;
    eTELP: TEdit;
    eEMAIL: TEdit;
    eALAMAT: TEdit;
    Label7: TLabel;
    ldiskon: TLabel;
    cMember: TComboBox;
    bBARU: TButton;
    bEDIT: TButton;
    bHAPUS: TButton;
    bbatal: TButton;
    Label9: TLabel;
    eCARI: TEdit;
    DBGrid1: TDBGrid;
    bSIMPAN: TButton;
    bKELUAR: TButton;
    frxdbdtst1: TfrxDBDataset;
    frLAPOR_KUSTOMER: TfrxReport;
    bCETAK: TButton;
    procedure cMemberClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bbatalClick(Sender: TObject);
    procedure bHAPUSClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure bEDITClick(Sender: TObject);
    procedure bSIMPANClick(Sender: TObject);
    procedure bKELUARClick(Sender: TObject);
    procedure bCETAKClick(Sender: TObject);
    procedure eCARIChange(Sender: TObject);
    procedure posisiawal;
    procedure bersih;
    procedure delay;
    procedure bBARUClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  a: String;
  nik: Integer;

implementation

uses
  Unit3, DB, ZDataset;

{$R *.dfm}



procedure TForm1.cMemberClick(Sender: TObject);
begin
  if cMember.text = 'YES' then
     ldiskon.Caption := '10%'
     else

  if cMember.Text = 'TIDAK' then
      ldiskon.Caption := '5%'
     else
      ldiskon.Caption:= '0'
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Position := poScreenCenter;
  posisiawal;
  cMember.Items.Add('YES');
  cMember.Items.Add('TIDAK');
end;

procedure TForm1.bbatalClick(Sender: TObject);
begin
  eNIK.Text:= '';
  eNAMA.Text:= '';
  eTELP.Text:= '';
  eEMAIL.Text:= '';
  eALAMAT.Text:= '';
  cMember.Text:= 'Pilih';
  ldiskon.Caption:= 'Terisi Otomatis';
  eCARI.Text:= '';

  bSIMPAN.Enabled:=False;
  bBARU.Enabled:=True;
  bKELUAR.Enabled:=True;
  bEDIT.Enabled:=True;
  bHAPUS.Enabled:=True;
  bCETAK.Enabled:=True;

  with DataModule3.Zkustomer do
 begin
    SQL.Clear;
    SQL.Add('select * from kustomer');
    Open;
 end;
end;

procedure TForm1.bHAPUSClick(Sender: TObject);
begin
  bersih;
with DataModule3.Zkustomer do
begin
  SQL.Clear;
  SQL.Add('delete from kustomer where id="'+a+'"');
  ExecSQL;

  SQL.Clear;
  SQL.Add('select * from kustomer');
  Open;
end;
    ShowMessage('Data Berhasil Dihapus');
end;
procedure TForm1.DBGrid1CellClick(Column: TColumn);
begin
  a:= DataModule3.Zkustomer.Fields[0].AsString;
  eNIK.Text:= DataModule3.Zkustomer.Fields[1].AsString;
  eNAMA.Text:= DataModule3.Zkustomer.Fields[2].AsString;
  eTELP.Text:= DataModule3.Zkustomer.Fields[3].AsString;
  eEMAIL.Text:= DataModule3.Zkustomer.Fields[4].AsString;
  eALAMAT.Text:= DataModule3.Zkustomer.Fields[5].AsString;
  cMember.Text:= DataModule3.Zkustomer.Fields[6].AsString;
end;

procedure TForm1.bEDITClick(Sender: TObject);
begin
if eNIK.Text= '' then
  begin
    ShowMessage('NIK Tidak boleh kosong');
  end else
with DataModule3.Zkustomer do
  begin
    SQL.Clear;
    SQL.Add('update kustomer set nik="'+eNIK.text+'", nama="'+eNAMA.Text+'", telp="'+eTELP.Text+'", email="'+eEMAIL.Text+'",alamat="'+eALAMAT.Text+'", member="'+cMember.Text+'" where id= "'+a+'"');
    ExecSQL ;

    SQL.Clear;
    SQL.Add('select * from kustomer');
    Open;
  end;
    ShowMessage('Data Berhasil Diupdate!');
    delay;
    bersih;
end;

procedure TForm1.bSIMPANClick(Sender: TObject);
begin
  bBARU.Enabled:=True;
  bEDIT.Enabled:=True;
  bHAPUS.Enabled:=True;
  bKELUAR.Enabled:=True;
  bCETAK.Enabled:=True;
  bSIMPAN.Enabled:=False;

if eNIK.Text = '' then
begin
    ShowMessage('NIK Tidak Boleh Kosong!');
end else
if DataModule3.Zkustomer.Locate('nik',eNIK.Text,[]) then
  begin
    ShowMessage('NIK '+eNIK.Text+' Sudah Ada Didalam Sistem');
end else
if eNAMA.Text = '' then
  begin
    ShowMessage('Nama Tidak boleh kosong');
  end else
if cMember.Text = 'Pilih' then
  begin
    ShowMessage('Member Tidak Boleh Kosong!');
  end else
Begin // simpan
 nik:= StrToInt(eNIK.Text);
with DataModule3.Zkustomer do
begin
SQL.Clear; 
SQL.Add('INSERT INTO kustomer (nik, nama, telp, email, alamat, member) VALUES (:nik, :nama, :telp, :email, :alamat, :member)');
DataModule3.Zkustomer.ParamByName('nik').Value := StrToInt(eNIK.Text);
DataModule3.Zkustomer.ParamByName('nama').Value := eNAMA.Text;
DataModule3.Zkustomer.ParamByName('telp').Value := eTELP.Text;
DataModule3.Zkustomer.ParamByName('email').Value := eEMAIL.Text;
DataModule3.Zkustomer.ParamByName('alamat').Value := eALAMAT.Text;
DataModule3.Zkustomer.ParamByName('member').Value := cMember.Text;

ExecSQL;
SQL.Clear;
SQL.Add('select * from kustomer');
Open;
end;
ShowMessage('Data Berhasil Disimpan!');
end;
delay;
bersih;

end;

procedure TForm1.bKELUARClick(Sender: TObject);
begin
  if (Application.MessageBox('And Yakin ingin keluar?','Informasi',MB_YESNO)=IDYES) then
  close
end;

procedure TForm1.bCETAKClick(Sender: TObject);
begin
  frLAPOR_KUSTOMER.ShowReport();
end;

procedure TForm1.eCARIChange(Sender: TObject);
begin
with DataModule3.Zkustomer do
begin
SQL.Clear;
SQL.Add('select * from kustomer where nama like "%'+eCARI.Text+'%"');
Open;
end;
end;

procedure TForm1.posisiawal;
begin
 bSIMPAN.Enabled:=False;
end;

procedure TForm1.bersih;
begin
  eNIK.Text:= '';
  eNAMA.Text:= '';
  eTELP.Text:= '';
  eEMAIL.Text:= '';
  eALAMAT.Text:= '';
  cMember.Text:= 'Pilih';
  ldiskon.Caption:= 'Terisi Otomatis';
  eCARI.Text:= '';
end;

procedure TForm1.bBARUClick(Sender: TObject);
begin
 bersih;
  bSIMPAN.Enabled:= True;
  bBARU.Enabled:= False;
  bKELUAR.Enabled:= False;
  bEDIT.Enabled:=False;
  bHAPUS.Enabled:=False;
  bCETAK.Enabled:=False;
end;

procedure TForm1.delay;
begin
 Sleep(500);
end;

end.
