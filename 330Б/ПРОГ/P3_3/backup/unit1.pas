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

            procedure saveToStream(Stream: TStream);
            procedure loadFromStream(Stream: TStream);

            procedure saveWithWriter(Stream: TStream);
            procedure loadWithReader(Stream: TStream);
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
        System.write(i + 1,' ребёнка: ', H.child[i]);
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
var n, g, d, id: ansistring;
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

procedure TArrayHuman.saveToStream(Stream: TStream);
var i, j, count: Integer;
begin
    Stream.Size := 0;
    Stream.Seek(0, soBeginning);
    count := Length(arrHuman);
    Stream.WriteBuffer(count, SizeOf(count));

    for i := 0 to count - 1 do
    begin
        Stream.WriteAnsiString(arrHuman[i].name);
        Stream.WriteAnsiString(arrHuman[i].gender);
        Stream.WriteAnsiString(arrHuman[i].date);
        Stream.WriteAnsiString(arrHuman[i].id);

        count := Length(arrHuman[i].child);
        Stream.WriteBuffer(count, SizeOf(count));
        for j := 0 to count - 1 do
            Stream.WriteAnsiString(arrHuman[i].child[j]);
    end;
end;
procedure TArrayHuman.loadFromStream(Stream: TStream);
var i, j, count, childCount: Integer;
begin
    if (Stream.Size = 0) then exit;
    Stream.ReadBuffer(count, SizeOf(count));
    SetLength(arrHuman, count);

    for i := 0 to count - 1 do
    begin
        arrHuman[i].name := Stream.ReadAnsiString;
        arrHuman[i].gender := Stream.ReadAnsiString;
        arrHuman[i].date := Stream.ReadAnsiString;
        arrHuman[i].id := Stream.ReadAnsiString;

        Stream.ReadBuffer(childCount, SizeOf(childCount));
        SetLength(arrHuman[i].child, childCount);
        for j := 0 to childCount - 1 do
            arrHuman[i].child[j] := Stream.ReadAnsiString;
    end;
end;

procedure TArrayHuman.saveWithWriter(Stream: TStream);
var Writer: TWriter;
    i, j: Integer;
begin
    Writer := TWriter.Create(Stream, 4096);
    try
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
    finally
        Writer.free;
    end;
end;
procedure TArrayHuman.loadWithReader(Stream: TStream);
var Reader: TReader;
    i, j, count, childCount: Integer;
begin
    if (Stream.Size = 0) then exit;
    Reader := TReader.Create(Stream, 4096);
    try
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
    finally
        Reader.free;
    end;
end;

end.

