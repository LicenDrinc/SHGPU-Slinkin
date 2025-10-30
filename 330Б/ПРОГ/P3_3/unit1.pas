unit Unit1;

{$mode ObjFPC}{$H+}

interface

uses Classes, SysUtils;

type

    THuman = record
        first_name, last_name, Patromynic: ansistring;
        gender, date, id: ansistring;
        child: array to ansistring;
    end;

    TArrayHuman = class
        public
            arrHuman: array to PHuman;
            constructor Create;
            destructor Destroy; override;

            procedure pressure();
    end;

implementation

constructor TArrayHuman.Create;
begin
    inherited Create;
    setLength(arrHuman, 0);
end;
destructor TArrayHuman.Destroy;
begin
    setLength(arrHuman, 0);
end;



end.

