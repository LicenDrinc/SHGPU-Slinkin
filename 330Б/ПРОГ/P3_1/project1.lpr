program project1;

uses unit1, Unit2, Unit3;

var x: TExtendedMemStorage;
    y: TInt64MemStorage;
    z: TByteFileStorage;
    s: TStringFileStorage;
begin
    writeln('TExtendedMemStorage');
    x := TExtendedMemStorage.Create;
    x[2] := 1.2;
    writeln(x[0]:0:2,' ',x[2]:0:2);
    writeln(x.count);
    x.free;

    writeln; writeln('TInt64MemStorage');
    y := TInt64MemStorage.Create;
    y[5] := 7;
    y[3] := 8;
    writeln(y[1],' ',y[3],' ',y[5],' ',y[100000]);
    y[100000] := 0;
    y[50] := 1;
    writeln(y[1],' ',y[3],' ',y[5],' ',y[100000],' ',y[50]);
    writeln(y.count);
    y.free;

    writeln; writeln('TByteFileStorage');
    z := TByteFileStorage.Create('storage.dat');
    z[2] := 1;
    z[0] := 11;
    writeln(z[3],' ',z[2],' ',z[0]);
    z[50] := 123;
    writeln(z[50],' ',z[100]);
    writeln(z.count);
    z.free;

    writeln; writeln('TStringFileStorage');
    s := TStringFileStorage.Create('storage1.dat');
    s[1] := 'arete';
    writeln(s[1],' ',s[2]);
    s[2] := 'ber';
    s[0] := 'fttt';
    s[50000] := 'dr';
    writeln(s[1],' ',s[2],' ',s[0],' ',s[50000]);
    writeln(s[3]);
    writeln(s.count);
    s.count := 100;
    writeln(s.count);
    s.free;
end.
