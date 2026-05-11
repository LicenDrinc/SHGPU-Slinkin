unit uMain;

{$mode objfpc}{$H+}

interface

uses Classes, SysUtils, Forms, Controls, Graphics, Dialogs, DBGrids, DBCtrls, SQLDB, StdCtrls;

type
    TMain = class(TForm)
        InDB: TButton;
        DBGrid1: TDBGrid;
        DBNavigator1: TDBNavigator;
        procedure InDBClick(Sender: TObject);
    private

    public

    end;

var Main: TMain;

implementation
{$R *.lfm}
uses udm;

procedure TMain.InDBClick(Sender: TObject);
begin
    //(DBGrid1.DataSource.DataSet as TSQLQuery).ApplyUpdates();

    dm.Users_Admin.ApplyUpdates();
    dm.Transaction.CommitRetaining();
end;

end.

