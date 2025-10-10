program project1;

uses Unit1, Unit2;

function basicComp(a: integer): integer;
begin
    Result := a;
end;

var i, i1: TAbstractFinder;
    f: funComp;
    arr: TIntArray;
    j: integer;
begin
    f := @basicComp;
    writeln('line');
    i := TLineFinder.Create([1,2,3,4,5,6,7,8,9,10]);
    i.NewArray([0,0,0,0,0,0,1,1,18,48,47,64,8,748]);
    i.setCompare(f);
    writeln(i.isCorrect());
    writeln(i.findOne());
    arr := i.findAll();
    writeln();
    for j := 0 to length(arr)-1 do
        write(arr[j],' ');
     writeln();

    writeln('bin');
    i1 := TBinFinder.Create([1,2,3,4,5,6,7,8,9,10]);
    i1.NewArray([0,0,0,0,0,0,1,1,18,48,47,64,8,748]);
    //i1.NewArray([0,0,0,0,0,0,1,1,18,48,57,64,84,748]);
    i1.setCompare(f);
    writeln(i1.isCorrect());
    writeln(i1.findOne());
    arr := i1.findAll();
    writeln();
    for j := 0 to length(arr)-1 do
        write(arr[j],' ');
    writeln();

    i1.free; i.free;
    readln;
end.

