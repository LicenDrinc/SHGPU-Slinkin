program project1;

uses Unit1, Unit2, Classes;

var human, human1: TArrayHuman;
    fl: TFileStream;
    fl1: TMemoryStream;
    fl2: TArrayStream;
begin
    human := TArrayHuman.Create;

    human.manualInputHuman;
    human.manualInputHuman;
    human.manualInputHuman;
    human.manualInputHuman;
    human.manualInputHuman;
    writeln; human.writeArrHuman('=====');

    fl := TFileStream.Create('1.txt', fmCreate);
    human.saveTStream(fl); fl.free;
    fl := TFileStream.Create('1.txt', fmOpenRead);
    human1 := TArrayHuman.Create;
    human1.loadTStream(fl); fl.free;
    writeln; human1.writeArrHuman('-----');
    human1.free;

    fl := TFileStream.Create('2.txt', fmCreate);
    human.saveTWriter(fl); fl.free;
    fl := TFileStream.Create('2.txt', fmOpenRead);
    human1 := TArrayHuman.Create;
    human1.loadTReader(fl); fl.free;
    writeln; human1.writeArrHuman('+++++');
    human1.free;

    fl1 := TMemoryStream.Create;
    human.saveTStream(fl1);
    human1 := TArrayHuman.Create;
    human1.loadTStream(fl1);
    writeln; human1.writeArrHuman('/////');
    fl1.free; human1.free;

    fl2 := TArrayStream.Create;
    human.saveTStream(fl2);
    human1 := TArrayHuman.Create;
    human1.loadTStream(fl2);
    writeln; human1.writeArrHuman('!!!!!');
    fl2.free; human1.free;

    human.free;
    readln;
end.

