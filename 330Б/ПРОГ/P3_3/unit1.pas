unit Unit1;

{$mode ObjFPC}{$H+}

interface

uses Classes, SysUtils;

type
    THuman = record
        name, gender, date, id: ansistring;
        child: array of ansistring;
    end;

    TArrayHuman = class
        public
            arrHuman: array of THuman;

            constructor Create();
            destructor Destroy; override;

            procedure manualInputHuman;
            procedure addHuman(n, g, d, id: ansistring; c: array of ansistring);
            procedure writeHuman(H: THuman);
            procedure writeArrHuman(str: string = '');

            procedure saveTStream(Stream: TStream);
            procedure loadTStream(Stream: TStream);

            procedure saveTWriter(Stream: TStream);
            procedure loadTReader(Stream: TStream);
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
    writeln('ФИО: ', H.name);
    writeln('пол: ', H.gender ,'; д.р.: ', H.date);
    writeln('id: ', H.id);
    if (length(H.child) = 0) then exit;
    for i := 0 to length(H.child) - 1 do
    begin
        k := -1;
        System.write(i + 1,' ребёнка: id ', H.child[i]);
        for j := 0 to length(arrHuman) - 1 do
            if (H.child[i] = arrHuman[j].id) then
                k := j;
        if (k <> -1) then
            writeln('; ФИО: ', arrHuman[k].name)
        else writeln('; ---');
    end;
end;
procedure TArrayHuman.writeArrHuman(str: string);
var i: integer;
begin
    if (str <> '') then writeln(str);
    for i := 0 to length(arrHuman) - 1 do
    begin
        writeHuman(arrHuman[i]); writeln;
    end;
    if (str <> '') then writeln(str);
end;

procedure TArrayHuman.addHuman(n, g, d, id: ansistring; c: array of ansistring);
var i, j: integer;
begin
    i := length(arrHuman);
    setLength(arrHuman, i + 1);
    arrHuman[i].name := n;
    arrHuman[i].gender := g;
    arrHuman[i].date := d;
    arrHuman[i].id := id;
    setLength(arrHuman[i].child, length(c));
    if (length(arrHuman[i].child) = 0) then exit;
    for j := 0 to length(arrHuman[i].child) - 1 do
        arrHuman[i].child[j] := copy(c[j], 0, length(c[j]));
end;

procedure TArrayHuman.manualInputHuman;
var t, n, g, d, id: ansistring;
    c: array of ansistring;
    i: integer;
begin
    write('ФИО: '); readln(n);
    write('пол: '); readln(g);
    write('д.р.: '); readln(d);
    write('id: '); readln(id);
    i := 0;
    while (t <> '') or (i = 0) do
    begin
        setLength(c, i);
        if (i <> 0) then c[i - 1] := copy(t, 0, length(t));
        write('id ', i + 1, ' ребёнка: '); readln(t);
        i := i + 1;
    end;
    addHuman(n, g, d, id, c);
end;

procedure TArrayHuman.saveTStream(Stream: TStream);
var i, j, count, countChild: Integer;
begin
    count := Length(arrHuman);
    for i := 0 to count - 1 do
    begin
        Stream.WriteAnsiString(arrHuman[i].name);
        Stream.WriteAnsiString(arrHuman[i].gender);
        Stream.WriteAnsiString(arrHuman[i].date);
        Stream.WriteAnsiString(arrHuman[i].id);

        countChild := Length(arrHuman[i].child);
        for j := 0 to countChild - 1 do
            Stream.WriteAnsiString(arrHuman[i].child[j]);
    end;
end;
procedure TArrayHuman.loadTStream(Stream: TStream);
var i, j: Integer;
    name, c: ansistring;
begin
    if (Stream.Size = 0) then exit;
    Stream.seek(0, soBeginning);
    SetLength(arrHuman, 0);
    i := 0;
    while True do
    begin
        name := Stream.ReadAnsiString;
        if (name = '') then exit;
        SetLength(arrHuman, i + 1);
        arrHuman[i].name := name;
        arrHuman[i].gender := Stream.ReadAnsiString;
        arrHuman[i].date := Stream.ReadAnsiString;
        arrHuman[i].id := Stream.ReadAnsiString;

        SetLength(arrHuman[i].child, 0);
        j := 0;
        while True do
        begin
            c := Stream.ReadAnsiString;
            if (c = '') then break;
            arrHuman[i].child[j] := c;
            j := j + 1;
        end;
        i := i + 1;
    end;
end;

procedure TArrayHuman.saveTWriter(Stream: TStream);
var Writer: TWriter;
    i, j: Integer;
begin
    Writer := TWriter.Create(Stream, 4096);
    Writer.WriteInteger(Length(arrHuman));
    for i := 0 to Length(arrHuman) - 1 do
    begin
        Writer.WriteString(arrHuman[i].name);
        Writer.WriteString(arrHuman[i].gender);
        Writer.WriteString(arrHuman[i].date);
        Writer.WriteString(arrHuman[i].id);

        Writer.WriteInteger(Length(arrHuman[i].child));
        for j := 0 to Length(arrHuman[i].child) - 1 do
            Writer.WriteString(arrHuman[i].child[j]);
    end;
    Writer.free;
end;
procedure TArrayHuman.loadTReader(Stream: TStream);
var Reader: TReader;
    i, j, count, childCount: Integer;
begin
    if (Stream.Size = 0) then exit;
    Reader := TReader.Create(Stream, 4096);
    count := Reader.ReadInteger;
    SetLength(arrHuman, count);

    for i := 0 to count - 1 do
    begin
        arrHuman[i].name := Reader.ReadString;
        arrHuman[i].gender := Reader.ReadString;
        arrHuman[i].date := Reader.ReadString;
        arrHuman[i].id := Reader.ReadString;

        childCount := Reader.ReadInteger;
        SetLength(arrHuman[i].child, childCount);
        for j := 0 to childCount - 1 do
            arrHuman[i].child[j] := Reader.ReadString;
    end;
    Reader.free;
end;

end.

