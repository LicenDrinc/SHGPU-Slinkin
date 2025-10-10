program project1;

uses unit1, Unit2, Unit3;

var x: TExtendedMemStorage;
    y: TInt64MemStorage;
    z: TByteFileStorage;
    s: TStringFileStorage;
    str: string;
    i: integer;
begin
    writeln('TExtendedMemStorage');
    x := TExtendedMemStorage.Create;
    x[2] := 1.2;
    writeln(x[0]:0:2);
    writeln(x[2]:0:2);
    writeln(x.count);
    x.free;

    writeln; writeln('TInt64MemStorage');
    y := TInt64MemStorage.Create;
    y[5] := 7;
    y[3] := 8;
    writeln(y[1]);
    writeln(y[3]);
    writeln(y[5]);
    writeln(y.count);
    y.free;

    writeln; writeln('TByteFileStorage');
    z := TByteFileStorage.Create('storage.dat');
    z[2] := 1;
    writeln(z[3]);
    writeln(z[2]);
    z[0] := 11;
    writeln(z[0]);
    z[50] := 123;
    writeln(z[50]);
    writeln(z[100]); 
    writeln(z[0]);
    writeln(z.count);
    z.free;

    writeln; writeln('TStringFileStorage');
    s := TStringFileStorage.Create('storage1.dat');
    s.dataS1 := 'werytry      0';
    writeln(s.dataS1);
    s[1] := 'a';
    writeln(s[1]);
    writeln(s[2]);
    s[2] := '1';
    writeln(s[1]);
    writeln(s[2]);
    writeln(s.dataS1); 
    s[10] := '1';
    writeln(s.dataS1);
    writeln(s.count);
    s.free;

    readln;
end.
