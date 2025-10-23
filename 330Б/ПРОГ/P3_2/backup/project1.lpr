program project1;

uses Unit1, Unit2, Unit3;

var io: TIntObj;
    ro: TRealObj;
    so: TStrObj;
    data: TClassicList;
begin
    data := TClassicList.Create();
    io := TIntObj.Create(20);
    ro := TRealObj.Create(10.2);
    so := TStrObj.Create('123');

    data.addLast(io);
    data.addLast(ro);
    data.addLast(so);

    data.showNode(io);
    data.showNode(ro);
    data.showNode(so);

    free(data);
    readln;
end.

