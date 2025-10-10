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
    i12: specialize TDataInfo<real>;
    str: string;
begin
    readln(str);
    if (str = 'Shortint') then
    begin
        i1 := specialize TDataInfo<Shortint>.Create(); i1.writeInfo(); i1.free;
    end
    else if (str = 'SmallInt') then
    begin
        i2 := specialize TDataInfo<SmallInt>.Create(); i2.writeInfo(); i2.free;
    end
    else if (str = 'Longint') then
    begin
        i3 := specialize TDataInfo<Longint>.Create(); i3.writeInfo(); i3.free;
    end
    else if (str = 'Longword') then
    begin
        i4 := specialize TDataInfo<Longword>.Create(); i4.writeInfo(); i4.free;
    end
    else if (str = 'Int64') then
    begin
        i5 := specialize TDataInfo<Int64>.Create(); i5.writeInfo(); i5.free;
    end
    else if (str = 'Byte') then
    begin
        i6 := specialize TDataInfo<Byte>.Create(); i6.writeInfo(); i6.free;
    end
    else if (str = 'Word') then
    begin
        i7 := specialize TDataInfo<Word>.Create(); i7.writeInfo(); i7.free;
    end
    else if (str = 'Cardinal') then
    begin
        i8 := specialize TDataInfo<Cardinal>.Create(); i8.writeInfo(); i8.free;
    end
    else if (str = 'QWord') then
    begin
        i9 := specialize TDataInfo<QWord>.Create(); i9.writeInfo(); i9.free;
    end
    else if (str = 'Char') then
    begin
        i10 := specialize TDataInfo<Char>.Create(); i10.writeInfo(); i10.free;
    end
    else if (str = 'Boolean') then
    begin
        i11 := specialize TDataInfo<Boolean>.Create(); i11.writeInfo(); i11.free;
    end
    else
    begin
        writeln('ERROR');
    end;
    writeln;
    i12 := specialize TDataInfo<real>.Create(); i12.writeInfo(); i12.free;
    readln;
end.

