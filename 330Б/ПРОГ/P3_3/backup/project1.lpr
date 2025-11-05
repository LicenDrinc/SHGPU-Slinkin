program project1;

uses Unit1, Unit2, Classes;

var human: TArrayHuman;
    fl: TFileStream;
    fl2: TFileStream;
    fl1: TArrayStream;
begin
    human := TArrayHuman.Create;
    fl := TFileStream.Create('3.txt', fmOpenReadWrite);
    fl1 := TArrayStream.Create;
    human.loadFromStream(fl1);
    human.loadWithReader(fl);
    fl.free;

    human.manualInputHuman;
    human.manualInputHuman;

    human.writeArrHuman('-----');

    fl := TFileStream.Create('3.txt', fmOpenReadWrite);
    human.saveToStream(fl1);
    human.saveWithWriter(fl);

    human.free;
    fl.free;
    fl1.free;
    readln;
end.

