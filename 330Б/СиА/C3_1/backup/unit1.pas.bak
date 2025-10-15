unit Unit1;

{$mode ObjFPC}

interface

uses Classes, SysUtils, TypInfo;

type
    generic TDataInfo<T> = class
        public
            procedure writeAllInfo();
        private
            data: T;
            function typeDataInfo(): string;
            function downBorderInfo(): T;
            function upBorderInfo(): T;
            function byteInfo(): Int64;
            function randomInfo(): T;
            function randomDownInfo():  T;
            function randomUpInfo(): T;
            function ramInfo(): string;
    end;

implementation

procedure TDataInfo.writeAllInfo();
begin
    randomInfo();
    writeln('Исследуемый тип: ',typeDataInfo);
    if (typeDataInfo = 'Char') then
    begin
        writeln('Нижняя граница: #',Int64(downBorderInfo));
        writeln('Верхняя граница: #',Int64(upBorderInfo));
    end
    else
    begin                                      
        writeln('Нижняя граница: ',downBorderInfo);
        writeln('Верхняя граница: ',upBorderInfo);
    end;
    writeln('Байт на переменную: ',byteInfo);
    if (typeDataInfo = 'Char') then
    begin
        writeln('Случайное значение: #',Int64(data));
        if (Int64(randomDownInfo) > Int64(data)) then
            writeln('Предыдущее значение: Overflow')
        else writeln('Предыдущее значение: #',Int64(randomDownInfo));
        if (Int64(randomUpInfo) < Int64(data)) then
            writeln('Предыдущее значение: Overflow')
        else writeln('Последующее значение: #',Int64(randomUpInfo));
    end
    else
    begin
        writeln('Случайное значение: ',data);
        if (randomDownInfo > data) then
            writeln('Предыдущее значение: Overflow')
        else writeln('Предыдущее значение: ',randomDownInfo);
        if (randomUpInfo < data) then
            writeln('Предыдущее значение: Overflow')
        else writeln('Последующее значение: ',randomUpInfo);
    end;
    writeln('Содержимое оперативной памяти: ',ramInfo);
end;

function TDataInfo.typeDataInfo(): string;
var pti: PTypeInfo;
begin
    pti := TypeInfo(T); result := pti^.Name;
end;

function TDataInfo.downBorderInfo(): T;
begin
    result := low(data);
end;
function TDataInfo.upBorderInfo(): T;
begin
    result := high(data);
end;

function TDataInfo.byteInfo(): Int64;
begin
    result := SizeOf(data);
end;

function TDataInfo.randomInfo(): T;
var p: ^byte;
    i, s: integer;
begin             
    Randomize; p := @data; s := 256;
    if (typeDataInfo = 'Boolean') then s := 2;
    for i:=0 to byteInfo-1 do
        (p+i)^ := random(s);
    result := data;
end;

function TDataInfo.randomDownInfo(): T;
var p: ^int64;
    j: Int64;
begin
    p := @data; j := p^ - 1;
    if (typeDataInfo = 'Boolean') then
    begin
        if (j < Int64(downBorderInfo)) then j :=  Int64(upBorderInfo);
    end;
    result := T(j);
end;
function TDataInfo.randomUpInfo(): T;
var p: ^int64;
    j: Int64;
begin
    p := @data; j := p^ + 1;
    if (typeDataInfo = 'Boolean') then
    begin
        if (j >  Int64(upBorderInfo)) then j :=  Int64(downBorderInfo);
    end;
    result := T(j);
end;

function TDataInfo.ramInfo(): string;
var str: string;
    p: ^byte;
    i: integer;
begin
    p := @data; str := '';
    for i:=0 to byteInfo-1 do
        str := str + IntToStr((p+i)^) + ' ';
    result := str;
end;

end.

