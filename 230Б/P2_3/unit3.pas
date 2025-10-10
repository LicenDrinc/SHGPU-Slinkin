unit Unit3;

{$mode ObjFPC}

interface

uses
  Classes, SysUtils, unit1;

type
    TFileStorage = class(TAbstractStorage)
        public
            constructor Create(filename: string);
            destructor Destroy(); override;
        protected
            function getData(position: qword): TData; override;
            function getCount: qword; override;

            procedure setCount(value: qword); override;
            procedure setData(position: qword; value: TData); override;
        private
            fd: file;
    end;

    TIntFileStorage = class(TFileStorage)
        protected
            function getIData(position: qword): integer;

            procedure setIData(position: qword; value: integer);

        public
            property dataI[position: qword]: integer read getIData write setIData; default;
    end;

implementation

constructor TFileStorage.Create(filename: string);
begin
    inherited Create;
    if (not fileExists(filename)) then
    begin
        assign(fd, filename);
        rewrite(fd);
        close(fd);
    end;
    assign(fd, filename);
    reset(fd, sizeof(TData));
end;
destructor TFileStorage.Destroy();
begin
    close(fd);
end;

function TFileStorage.getData(position: qword): TData;
begin
    if (position < filesize(fd)) then
    begin
        seek(fd, position);
        BlockRead(fd, Result, 1);
    end
    else
        exit(nil);
end;
procedure TFileStorage.setData(position: qword; value: TData);
begin
    if (position >= getCount) then
        setCount(position + 1);
    seek(fd, position);
    BlockWrite(fd, value, 1);
end;

function TFileStorage.getCount: qword;
begin
    Result := filesize(fd);
end;
procedure TFileStorage.setCount(value: qword);
var i: qword; p: TData;
begin
    p := nil;
    for i := getCount to value - 1 do
    begin
        seek(fd, i);
        BlockWrite(fd, p, 1);
    end;
end;


function TIntFileStorage.getIData(position: qword): integer;
begin
    Result := integer(getData(position));
end;
procedure TIntFileStorage.setIData(position: qword; value: integer);
begin
    setData(position, Pointer(value));
end;

end.

