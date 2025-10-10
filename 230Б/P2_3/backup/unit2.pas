unit Unit2;

{$mode ObjFPC}

interface

uses
  Classes, SysUtils, Unit1;

type
    TIntMemStorage = class(TMemStorage)
        protected
	    function getIData(position: qword): integer;

            procedure setIData(position: qword; value: integer);

        public
	    property dataI[position:qword]: integer read getIData write setIData; default;
    end;

    TFloatMemStorage = class(TMemStorage)
        protected
	    function getfData(position: qword): extended;

            procedure setfData(position: qword; value: extended);
        public
            destructor Destroy; override;
        public
	    property dataF[position: qword]: extended read getfData write setfData; default;
    end;

implementation

function TIntMemStorage.getIData(position: qword): integer;
begin
    Result := integer(getData(position));
end;
procedure TIntMemStorage.setIData(position: qword; value: integer);
begin
    setData(position, Pointer(value));
end;


function TFloatMemStorage.getfData(position: qword): extended;
var p: pointer;
begin
    p := data[position];
    if (p = nil) then exit(0);
    Result := extended(p^);
end;
procedure TFloatMemStorage.setfData(position: qword; value: extended);
var p: ^extended;
begin
    if (getData(position) = nil) then
    begin
        p := getmem(sizeof(extended));
        data[position] := p;
    end;
    p := data[position];
    p^ := value;
end;

destructor TFloatMemStorage.Destroy;
var i: integer;
begin
    for i := 0 to getCount-1 do
    begin
        if (data[i] <> nil) then
        begin
            freemem(data[i]);
        end;
    end;
end;

end.

