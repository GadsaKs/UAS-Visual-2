unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids;

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
    Button1: TButton;
    Button3: TButton;
    bHAPUS: TButton;
    bbatal: TButton;
    Label9: TLabel;
    Edit5: TEdit;
    DBGrid1: TDBGrid;
    bSIMPAN: TButton;
    bKELUAR: TButton;
    bCETAK: TButton;
    procedure cMemberClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bbatalClick(Sender: TObject);
    procedure bHAPUSClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure Button3Click(Sender: TObject);
    procedure bSIMPANClick(Sender: TObject);
    procedure bKELUARClick(Sender: TObject);
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
  ldiskon.Caption:= 'Terisi Otomatis'
end;

procedure TForm1.bHAPUSClick(Sender: TObject);
begin
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
  eNIK.Text:= DataModule3.Zkustomer.Fields[1].AsString;
a:= DataModule3.Zkustomer.Fields[0].AsString;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
if eNIK.Text= '' then
  begin
    ShowMessage('NIK Tidak boleh kosong');
  end else
if eNIK.Text= DataModule3.Zkustomer.Fields[1].AsString then
  begin
    ShowMessage('NIK '+eNIK.Text+ 'tidak ada perubahan');
  end else
with DataModule3.Zkustomer do
  begin
    SQL.Clear;
    SQL.Add('update kustomer set nik="'+eNIK.text+'" where id= "'+a+'"');
    ExecSQL ;

    SQL.Clear;
    SQL.Add('select * from kustomer');
    Open;
  end;
    ShowMessage('Data Berhasil Diupdate!');
end;

procedure TForm1.bSIMPANClick(Sender: TObject);
begin
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

end;
procedure TForm1.bKELUARClick(Sender: TObject);
begin
  if (Application.MessageBox('And Yakin ingin keluar?','Informasi',MB_YESNO)=IDYES) then
  close
end;

end.
