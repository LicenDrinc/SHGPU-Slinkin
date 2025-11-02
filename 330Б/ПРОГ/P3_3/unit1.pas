unit Unit1;

{$mode ObjFPC}{$H+}

interface

uses Classes, SysUtils;

type
    THuman = record
        firstName, lastName, patromynic: ansistring;
        gender, date, id: ansistring;
        child: array of ansistring;
    end;

    TArrayHuman = class(TStream)
        public
            arrHuman: array of THuman;

            constructor Create;
            destructor Destroy; override;

            procedure manualInputHuman;
            procedure addHuman(fN, lN, pn, g, d, id: ansistring; c: array of ansistring);
            procedure writeHuman(H: THuman);
            procedure writeArrHuman(str: string = '');
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

procedure TArrayHuman.writeHuman(H: THuman);
var i, j, k: integer;
begin
    writeln('ФИО: ', H.firstName, ' ', H.lastName, ' ', H.patromynic);
    writeln('пол: ', H.gender ,'; д.р.: ', H.date);
    writeln('id: ', H.id);
    if (length(H.child) = 0) then exit;
    for i:=0 to length(H.child) - 1 do
    begin
        k := -1;
        System.write(i + 1,' ребёнка: ', H.child[i]);
        for j:=0 to length(arrHuman) - 1 do
            if (H.child[i] = arrHuman[j].id) then
                k := j;
        if (k <> -1) then
            writeln('; ФИО: ', arrHuman[k].firstName, ' ', arrHuman[k].lastName, ' ', arrHuman[k].patromynic)
        else writeln('; ---');
    end;
end;
procedure TArrayHuman.writeArrHuman(str: string);
var i: integer;
begin
    if (str <> '') then writeln(str);
    for i:=0 to length(arrHuman) - 1 do
    begin
        writeHuman(arrHuman[i]); writeln;
    end;
    if (str <> '') then writeln(str);
end;

procedure TArrayHuman.addHuman(fN, lN, pn, g, d, id: ansistring; c: array of ansistring);
var i, j: integer;
begin
    i := length(arrHuman);
    setLength(arrHuman, i + 1);
    arrHuman[i].firstName := fN;
    arrHuman[i].lastName := lN;
    arrHuman[i].patromynic := pn;
    arrHuman[i].gender := g;
    arrHuman[i].date := d;
    arrHuman[i].id := id;
    setLength(arrHuman[i].child, length(c));
    if (length(arrHuman[i].child) = 0) then exit;
    for j:=0 to length(arrHuman[i].child) - 1 do
        arrHuman[i].child[j] := copy(c[j], 0, length(c[j]));
end;

procedure TArrayHuman.manualInputHuman;
var name, t, fN, lN, pn, g, d, id: ansistring;
    c: array of ansistring;
    i: integer;
begin
    System.write('ФИО: '); readln(name);
    fN := copy(name, 0, pos(' ', name) - 1);
    t := copy(name, pos(' ', name) + 1, length(name) - pos(' ', name));
    lN := copy(t, 0, pos(' ', t) - 1);
    pn := copy(t, pos(' ', t) + 1, length(t) - pos(' ', name));
    System.write('пол: '); readln(g);
    System.write('д.р.: '); readln(d);
    System.write('id: '); readln(id);
    i := 0;
    while (t <> '') or (i = 0) do
    begin
        setLength(c, i);
        if (i <> 0) then c[i - 1] := copy(t, 0, length(t));
        System.write('id ', i + 1, ' ребёнка: '); readln(t);
        i := i + 1;
    end;
    addHuman(fN, lN, pn, g, d, id, c);
end;



end.

