unit Unit3;

{$mode ObjFPC}{$H+}

interface

uses Classes, SysUtils, Unit1;

type
    PANode = ^TANode;
    TANode = record
        data: integer;
        next: PANode;
    end;

    TArrayList = class(TInterfacedObject, IList)
        private
            arrObj: array of tobject;
            obj, posObj: PANode;
            function nilArrObj: integer;
        public
            function addFirst(note: tobject): tobject;
            function addLast(node: tobject): tobject;
            function deleteFirst: tobject;
            function deleteAfter(prevNode: tobject): tobject;
            function insertAfter(prevNode, node: tobject): tobject;
            function compare(node1, node2: tobject): integer;
            function first: tobject;
            function next: tobject;
            function last: tobject;
            procedure showNode(node: tobject);
            function copyNode(node: tobject): tobject;
            procedure destroyList;

            procedure writeList;

            constructor Create;
            destructor Destroy; override;
    end;

implementation

constructor TArrayList.Create;
begin
    inherited Create;
    setLength(arrObj,0);
    obj := nil; posObj := nil;
end;
destructor TArrayList.Destroy;
begin
    destroyList;
end;

procedure TArrayList.writeList;
var o: tobject;
begin
    o := first;
    while (o <> nil) do
    begin showNode(o); o := next; end;
end;


function TArrayList.nilArrObj: integer;
var i: integer;
begin
   for i := 0 to length(arrObj) - 1 do
       if (arrObj[i] = nil) then exit(i);
   setLength(arrObj, length(arrObj) + 1);
   result := length(arrObj) - 1;
end;

function TArrayList.addFirst(note: tobject): tobject;
var pn: PANode;
begin
    if (note = nil) then exit(note);
    new(pn);
    pn^.data := nilArrObj;
    arrObj[pn^.data] := note;
    pn^.next := obj;
    obj := pn;
    result := note;
end;
function TArrayList.addLast(node: tobject): tobject;
var pn, pn1: PANode;
begin
    if (node = nil) then exit(node);
    new(pn1);
    pn1^.data := nilArrObj;
    arrObj[pn1^.data] := node;
    pn1^.next := nil;
    if (obj = nil) then obj := pn1
    else
    begin
        pn := obj;
        while (pn^.next <> nil) do pn := pn^.next;
        pn^.next := pn1;
    end;
    result := node;
end;
function TArrayList.insertAfter(prevNode, node: tobject): tobject;
var pn, pn1: PANode;
begin
    if (prevNode = nil) then exit(nil);
    if (node = nil) then exit(node);
    pn := obj;
    new(pn1);
    pn1^.data := nilArrObj;
    arrObj[pn1^.data] := node;
    while (arrObj[pn^.data] <> prevNode) and (pn <> nil) do
        pn := pn^.next;
    if (pn = nil) then exit(nil);
    pn1^.next := pn^.next;
    pn^.next := pn1;
    result := node;
end;

function TArrayList.deleteFirst: tobject;
var pn: PANode;
begin
    if (obj = nil) then exit(nil);
    pn := obj;
    obj := obj^.next;
    result := arrObj[pn^.data];
    arrObj[pn^.data] := nil;
    dispose(pn);
end;
function TArrayList.deleteAfter(prevNode: tobject): tobject;
var pn, pn1: PANode;
begin
    if (obj = nil) then exit(nil);
    if (prevNode = nil) then exit(nil);
    pn := obj;
    while (arrObj[pn^.data] <> prevNode) and (pn^.next <> nil) do
        pn := pn^.next;
    if (pn^.next = nil) then exit(nil);
    pn1 := pn^.next;
    result := arrObj[pn1^.data];
    arrObj[pn1^.data] := nil;
    pn^.next := pn1^.next;
    dispose(pn1);
end;
procedure TArrayList.destroyList;
var pn, pn1: PANode;
begin
    pn := obj;
    posObj := nil;
    while (pn <> nil) do
    begin
        pn1 := pn^.next;
        arrObj[pn^.data].free;
        dispose(pn);
        pn := pn1;
    end;
    setLength(arrObj, 0);
end;

function TArrayList.first: tobject;
begin
    if (obj = nil) then exit(nil);
    posObj := obj;
    result := arrObj[posObj^.data];
end;
function TArrayList.next: tobject;
begin
    if (obj = nil) then exit(nil);
    if (posObj = nil) then posObj := obj;
    if (posObj^.next = nil) then exit(nil);
    posObj := posObj^.next;
    result := arrObj[posObj^.data];
end;
function TArrayList.last: tobject;
var pn: PANode;
begin
    if (obj = nil) then exit(nil);
    if (posObj = nil) then posObj := obj;
    pn := posObj;
    while (pn^.next <> nil) do
        pn := pn^.next;
    posObj := pn;
    result := arrObj[posObj^.data];
end;

procedure TArrayList.showNode(node: tobject);
begin
    if node is TIntObj then writeln(TIntObj(node).data)
    else if node is TRealObj then writeln(TRealObj(node).data:0:6)
    else if node is TStrObj then writeln(TStrObj(node).data)
    else writeln('none type');
end;

function TArrayList.compare(node1, node2: tobject): integer;
var r1, r2: real;
    i1, i2: integer;
begin
    i1 := 0; i2 := 0;
    if node1 is TIntObj then r1 := TIntObj(node1).data
    else if node1 is TRealObj then r1 := TRealObj(node1).data
    else if node1 is TStrObj then Val(TStrObj(node1).data, r1, i1)
    else i1 := -1;
    if node2 is TIntObj then r2 := TIntObj(node2).data
    else if node2 is TRealObj then r2 := TRealObj(node2).data
    else if node2 is TStrObj then Val(TStrObj(node2).data, r2, i2)
    else i2 := -1;

    if (i1 <> 0) or (i2 <> 0) then exit(-2)
    else if (r1 - r2 > 0.0000001) then exit(1)
    else if (r1 - r2 < -0.0000001) then exit(-1);

    result := 0;
end;
function TArrayList.copyNode(node: tobject): tobject;
begin
    if node is TIntObj then exit(TIntObj.Create(TIntObj(node).data))
    else if node is TRealObj then exit(TRealObj.Create(TRealObj(node).data))
    else if node is TStrObj then exit(TStrObj.Create(TStrObj(node).data));
    result := nil;
end;

end.

