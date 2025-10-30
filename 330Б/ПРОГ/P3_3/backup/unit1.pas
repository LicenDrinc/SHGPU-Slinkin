unit Unit1;

{$mode ObjFPC}{$H+}

interface

uses Classes, SysUtils;

type
    PHuman = ^THuman;
    THuman = record
        firstName, lastName, patromynic: ansistring;
        gender, date, id: ansistring;
        child: array of ansistring;
    end;

    TArrayHuman = class
        private
            arrHuman: array of PHuman;
        public
            constructor Create;
            destructor Destroy; override;

            function createHuman(fN, lN, pn, g, d, id: ansistring; c: array of ansistring): PHuman;

            procedure pressureHuman(H: PHuman);
            procedure writeHuman(H: PHuman);
            procedure writeArrHuman;
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

