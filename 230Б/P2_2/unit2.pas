unit Unit2;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type
    TIntArray = array of integer;
    funComp = function(a: integer): integer;
    TAbstractFinder = class
        public
            constructor Create(a: TIntArray);
            constructor Create(a: array of integer);

            procedure NewArray(a: TIntArray);
            procedure NewArray(a: array of integer);
            procedure setCompare(a: funComp);

            function isCorrect(): boolean; virtual; abstract;
            function findOne(): integer; virtual; abstract;
            function findAll(): TIntArray; virtual; abstract;

            function findOneS(a: integer): integer;
            function findOneCustomS(a: funComp): integer;
            function findAllS(a: integer): TIntArray;
            function findAllCustomS(a: funComp): TIntArray;
        protected
            arr: TIntArray;
            comp: funComp;
    end;
implementation

constructor TAbstractFinder.Create(a: TIntArray);
begin
    inherited Create();
    NewArray(a);
end;
constructor TAbstractFinder.Create(a: array of integer);
begin
    inherited Create();
    NewArray(a);
end;

procedure TAbstractFinder.NewArray(a: TIntArray);
var i: integer;
begin
    SetLength(arr, Length(a));
    for i:= 0 to Length(a) - 1 do
        arr[i] := a[i];
end;
procedure TAbstractFinder.NewArray(a: array of integer);
var i: integer;
begin
    SetLength(arr, Length(a));
    for i:= 0 to Length(a) - 1 do
        arr[i] := a[i];
end;

procedure TAbstractFinder.setCompare(a: funComp);
begin
    comp:=a;
end;

var alt: integer;
function altComp(a: integer): integer;
begin
    Result := alt - a;
end;

function TAbstractFinder.findOneS(a: integer): integer;
var f: funComp;
begin
    f := comp; alt := a;
    setCompare(@altComp);
    Result := findOne();
    comp := f;
end;
function TAbstractFinder.findOneCustomS(a: funComp): integer;
var f: funComp;
begin
    f := comp;
    setCompare(a);
    Result := findOne();
    comp := f;
end;

function TAbstractFinder.findAllS(a: integer): TIntArray;
var f: funComp;
begin
    alt := a; f := comp;
    setCompare(@altComp);
    Result := findAll();
    comp := f;
end;
function TAbstractFinder.findAllCustomS(a: funComp): TIntArray;
var f: funComp;
begin
    f := comp;
    setCompare(a);
    Result := findAll();
    comp := f;
end;

end.

