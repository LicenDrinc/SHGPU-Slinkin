unit Unit1;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Unit2;

type
    TLineFinder = class(TAbstractFinder)
        public
            function isCorrect(): boolean; override;
            function findOne(): integer; override;
            function findAll(): TIntArray; override;
    end;
    TBinFinder = class(TAbstractFinder)
        public
            function isCorrect(): boolean; override;
            function findOne(): integer; override;
            function findAll(): TIntArray; override;
    end;

implementation

function TLineFinder.isCorrect(): boolean;
begin
    Result := true;
end;
function TBinFinder.isCorrect(): boolean;
var i: integer;
begin
    Result := true;
    if (Length(arr) = 0) then exit;
    for i := 1 to Length(arr) do
    begin
        if (comp(arr[i]) < comp(arr[i - 1])) then
        begin
            Result := false;
            exit;
        end;
    end;
end;

function TLineFinder.findOne(): integer;
var i: integer;
begin
    Result := -1;
    for i:=0 to Length(arr) do
    begin
        if (comp(arr[i]) = 0) then
        begin
            Result := i;
            exit;
        end;
    end;
end;
function TBinFinder.findOne(): integer;
var l, r, m: integer;
begin
    l := 0; r := Length(arr) - 1;
    while (l <= r) do
    begin
        m := l + Trunc((r - l) / 2);
        if (comp(arr[m]) = 0) then
        begin
            Result := m;
            exit;
        end
        else if (comp(arr[m]) < 0) then
            l := m + 1
        else
            r := m - 1;
    end;
    Result := -1;
end;

function TLineFinder.findAll(): TIntArray;
var count, i: integer;
begin
    count := 0;
    for i:=0 to Length(arr) do
    begin
        if (comp(arr[i]) = 0) then
        begin
            SetLength(Result, count+1);
            Result[count] := arr[i];
            count := count + 1;
        end;
    end;
end;
function TBinFinder.findAll(): TIntArray;
var end_, start_, pos, i: integer;
begin
    pos := findOne();
    SetLength(Result, 0);

    if (pos < 0) then
        exit;

    end_ := pos; start_ := pos;
    while (start_ > 0) and (comp(arr[start_ - 1]) = 0) do
        start_ := start_ - 1;
    while (end_ > 0) and (comp(arr[end_ + 1]) = 0) do
        end_ := end_ + 1;

    SetLength(Result, end_ - start_ + 1);
    for i:= 0 to Length(Result) - 1 do
        Result[i] := arr[start_ + i];
end;

end.

