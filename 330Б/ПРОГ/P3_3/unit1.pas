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

    TArrayHuman = class
        public
            arrHuman: array of THuman;

            constructor Create();
            destructor Destroy; override;

            procedure manualInputHuman;
            procedure addHuman(fN, lN, pn, g, d, id: ansistring; c: array of ansistring);
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
    writeln('ФИО: ', H.firstName, ' ', H.lastName, ' ', H.patromynic);
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
            writeln('; ФИО: ', arrHuman[k].firstName, ' ', arrHuman[k].lastName, ' ', arrHuman[k].patromynic)
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
    for j := 0 to length(arrHuman[i].child) - 1 do
        arrHuman[i].child[j] := copy(c[j], 0, length(c[j]));
end;

procedure TArrayHuman.manualInputHuman;
var name, t, fN, lN, pn, g, d, id: ansistring;
    c: array of ansistring;
    i: integer;
begin
    write('ФИО: '); readln(name);
    fN := copy(name, 0, pos(' ', name) - 1);
    t := copy(name, pos(' ', name) + 1, length(name) - pos(' ', name));
    lN := copy(t, 0, pos(' ', t) - 1);
    pn := copy(t, pos(' ', t) + 1, length(t) - pos(' ', name));
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
    addHuman(fN, lN, pn, g, d, id, c);
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
        Stream.WriteAnsiString(arrHuman[i].firstName);
        Stream.WriteAnsiString(arrHuman[i].lastName);
        Stream.WriteAnsiString(arrHuman[i].patromynic);
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
        arrHuman[i].firstName   := Stream.ReadAnsiString;
        arrHuman[i].lastName    := Stream.ReadAnsiString;
        arrHuman[i].patromynic  := Stream.ReadAnsiString;
        arrHuman[i].gender      := Stream.ReadAnsiString;
        arrHuman[i].date        := Stream.ReadAnsiString;
        arrHuman[i].id          := Stream.ReadAnsiString;

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
            Writer.WriteString(arrHuman[i].firstName);
            Writer.WriteString(arrHuman[i].lastName);
            Writer.WriteString(arrHuman[i].patromynic);
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
            arrHuman[i].firstName  := Reader.ReadString;
            arrHuman[i].lastName   := Reader.ReadString;
            arrHuman[i].patromynic := Reader.ReadString;
            arrHuman[i].gender     := Reader.ReadString;
            arrHuman[i].date       := Reader.ReadString;
            arrHuman[i].id         := Reader.ReadString;

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

