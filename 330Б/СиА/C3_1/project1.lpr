program project1;

uses unit1;

var i1: specialize TDataInfo<Shortint>;
    i2: specialize TDataInfo<SmallInt>;
    i3: specialize TDataInfo<Longint>;
    i4: specialize TDataInfo<Longword>;
    i5: specialize TDataInfo<Int64>;
    i6: specialize TDataInfo<Byte>;
    i7: specialize TDataInfo<Word>;
    i8: specialize TDataInfo<Cardinal>;
    i9: specialize TDataInfo<QWord>;     
    i10: specialize TDataInfo<Char>;
    i11: specialize TDataInfo<Boolean>;
    str: string;
begin
    while true do
    begin
        readln(str);
        if (LowerCase(str) = 'shortint') then
        begin
            i1 := specialize TDataInfo<Shortint>.Create; i1.writeAllInfo; i1.free;
        end
        else if (LowerCase(str) = 'smallint') then
        begin
            i2 := specialize TDataInfo<SmallInt>.Create; i2.writeAllInfo; i2.free;
        end
        else if (LowerCase(str) = 'longint') then
        begin
            i3 := specialize TDataInfo<Longint>.Create; i3.writeAllInfo; i3.free;
        end
        else if (LowerCase(str) = 'longword') then
        begin
            i4 := specialize TDataInfo<Longword>.Create; i4.writeAllInfo; i4.free;
        end
        else if (LowerCase(str) = 'int64') then
        begin
            i5 := specialize TDataInfo<Int64>.Create; i5.writeAllInfo; i5.free;
        end
        else if (LowerCase(str) = 'byte') then
        begin
            i6 := specialize TDataInfo<Byte>.Create; i6.writeAllInfo; i6.free;
        end
        else if (LowerCase(str) = 'word') then
        begin
            i7 := specialize TDataInfo<Word>.Create; i7.writeAllInfo; i7.free;
        end
        else if (LowerCase(str) = 'cardinal') then
        begin
            i8 := specialize TDataInfo<Cardinal>.Create; i8.writeAllInfo; i8.free;
        end
        else if (LowerCase(str) = 'qword') then
        begin
            i9 := specialize TDataInfo<QWord>.Create; i9.writeAllInfo; i9.free;
        end
        else if (LowerCase(str) = 'char') then
        begin
            i10 := specialize TDataInfo<Char>.Create; i10.writeAllInfo; i10.free;
        end
        else if (LowerCase(str) = 'boolean') then
        begin
            i11 := specialize TDataInfo<Boolean>.Create; i11.writeAllInfo; i11.free;
        end
        else
        begin
            writeln('ERROR'); break;
        end;
        writeln;
    end;
end.

