unit udm;

{$mode ObjFPC}{$H+}

interface

uses Classes, SysUtils, SQLDB, PQConnection;

type

    { Tdm }

    Tdm = class(TDataModule)
        SQLConnector: TSQLConnector;
        SQLTransaction: TSQLTransaction;
    private

    public

    end;

var
    dm: Tdm;

implementation

{$R *.lfm}

end.

