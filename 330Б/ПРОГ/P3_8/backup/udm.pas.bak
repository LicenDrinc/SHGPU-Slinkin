unit udm;

{$mode ObjFPC}{$H+}

interface

uses Classes, SysUtils, SQLDB, DB, PQConnection;

type

    { Tdm }

    Tdm = class(TDataModule)
        Connector: TSQLConnector;
        DS_Users_Admin: TDataSource;
        human: TSQLQuery;
        Users_Admin: TSQLQuery;
        Transaction: TSQLTransaction;
        Users_Adminid: TLongintField;
        Users_Adminid_admin: TLongintField;
        Users_Adminname: TStringField;
        Users_Adminpassword: TStringField;
        procedure DataModuleCreate(Sender: TObject);
    private

    public

    end;

var
    dm: Tdm;

implementation

{$R *.lfm}

{ Tdm }

procedure Tdm.DataModuleCreate(Sender: TObject);
begin
    //Connector.Open;
    //Transaction.Action := True;
    //Users_Admin.Open;
end;

end.

