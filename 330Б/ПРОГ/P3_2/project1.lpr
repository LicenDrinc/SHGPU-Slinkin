program project1;

uses Unit1, Unit2, Unit3, Unit4;

var data, data1, data2: TClassicList;
    dataA, dataA1, dataA2: TArrayList;
    o: tobject;
    i: integer;
    //TClassicList
    //TArrayList
begin
    data := TClassicList.Create;
    data1 := TClassicList.Create;
    data2 := TClassicList.Create;
    dataA := TArrayList.Create;
    dataA1 := TArrayList.Create;
    dataA2 := TArrayList.Create;




    data.addFirst(TIntObj.Create(1));
    dataA.addFirst(TIntObj.Create(3));

    for i := 0 to 5 do begin
        data.addLast(data.copyNode(data.last));
        TIntObj(data.last).data := TIntObj(data.last).data + 1;
    end;
    for i := 0 to 5 do begin
        dataA.addLast(dataA.copyNode(dataA.last));
        TIntObj(dataA.last).data := TIntObj(dataA.last).data - 1;
    end;

    o := data.first;
    while (o <> nil) do
    begin data.showNode(o); o := data.next; end; writeln;
    o := dataA.first;
    while (o <> nil) do
    begin dataA.showNode(o); o := dataA.next; end; writeln;

    //ListMerge(data, dataA);
    //ListChessMerge(data, dataA);
    ListSort(data, dataA, true);

    o := data.first;
    while (o <> nil) do
    begin data.showNode(o); o := data.next; end; writeln;
    o := dataA.first;
    while (o <> nil) do
    begin dataA.showNode(o); o := dataA.next; end;

    dataA.free;
    dataA1.free;
    dataA2.free;
    data.free;
    data1.free;
    data2.free;
    //readln;
end.

