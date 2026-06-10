unit uMain1;

{$mode ObjFPC}{$H+}

interface

uses Classes, SysUtils, Forms, Controls, SQLDB, Graphics, Dialogs, DBGrids,
    Grids, StdCtrls, DBCtrls, Buttons, Types;

type

    { TMain1 }

    TMain1 = class(TForm)
        BitBtn1: TBitBtn;
        BitBtn2: TBitBtn;
        DBEdit1: TDBEdit;
        DBEdit2: TDBEdit;
        DBGrid1: TDBGrid;
        DBLookupComboBox1: TDBLookupComboBox;
        Label1: TLabel;
        Label2: TLabel;
        Label3: TLabel;
        procedure BitBtn1Click(Sender: TObject);
        procedure BitBtn2Click(Sender: TObject);
        procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    private

    public

    end;

var Main1: TMain1;

implementation
{$R *.lfm}
uses udm;

procedure TMain1.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var grid: TDBGrid absolute Sender; dest: TSQLQuery; x, y: Integer; s: String; cnv: TCanvas; csize: TSize;
begin
    cnv := grid.Canvas; dest := grid.DataSource.DataSet as TSQLQuery;
    x := Rect.Left; y := Rect.Top; s := 'Логин: ' + dest['name'];
    if gdSelected in State then
    begin
        cnv.Font.Style := [fsBold];
        cnv.Brush.Color := clBlue;
        cnv.Rectangle(Rect);
    end;
    cnv.TextOut(x, y, s);
    csize := cnv.TextExtent(s);
    y += csize.cy;
    s := 'ФИО: ' + dest['name1'];
    cnv.TextOut(x, y, s);
end;

procedure TMain1.BitBtn2Click(Sender: TObject);
begin
    dm.Users_Admin.CancelUpdates();
end;

procedure TMain1.BitBtn1Click(Sender: TObject);
begin
    dm.Users_Admin.ApplyUpdates();
    dm.Transaction.CommitRetaining();
end;

end.

