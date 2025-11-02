program project1;

uses Unit1;

var human: TArrayHuman;

begin
    human := TArrayHuman.Create;

    human.manualInputHuman;
    human.manualInputHuman;

    human.writeArrHuman('-----');

    human.free;
    readln;
end.
