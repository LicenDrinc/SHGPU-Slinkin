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

            constructor Create;
            destructor Destroy; override;
        private
            arrObj: array of tobject;
            obj, posObj: PANode;
            pos: integer;
    end;

implementation

constructor TArrayList.Create;
begin
    inherited Create;
    setLength(arrObj,0); pos := 0;
    posObj := nil;
end;
destructor TArrayList.Destroy;
begin
    destroyList;
end;

function TArrayList.addFirst(note: tobject): tobject;
var i: integer;
    pn: PANode;
    b: boolean;
begin
    if (note = nil) then exit(note);
    new(pn); b := true;
    for i := 0 to length(arrObj) - 1 do
    begin
        if (arrObj[i] = nil) and (not b) then
        begin
            b := false;
            arrObj[i] := note;
            pn^.data := i;
        end;
    end;
    if (b) then
    begin
        setLength(arrObj, length(arrObj) + 1);
        arrObj[length(arrObj) - 1] := note;
        pn^.data := length(arrObj) - 1;
    end;
    pn^.next := obj;
    obj := pn;
    result := note;
end;
function TArrayList.addLast(node: tobject): tobject;
begin
    if (node = nil) then exit(nil);
    setLength(arrObj, length(arrObj) + 1);
    arrObj[length(arrObj) - 1] := node;
    result := node;
end;
function TArrayList.insertAfter(prevNode, node: tobject): tobject;
var i, i1: integer;
begin
    if (node = nil) then exit(nil);
    if (prevNode = nil) then exit(nil);
    i1 := -1;
    for i := 0 to length(arrObj) - 1 do
        if (arrObj[i] = prevNode) then i1 := i + 1;
    if (i1 = -1) then exit(nil);
    setLength(arrObj, length(arrObj) + 1);
    for i := length(arrObj) - 2 downto i1 do
        arrObj[i + 1] := arrObj[i];
    arrObj[i1] := node;
    result := node;
end;

function TArrayList.deleteFirst: tobject;
var i: integer;
begin
    if (length(arrObj) = 0) then exit(nil);
    result := arrObj[0];
    for i := 0 to length(arrObj) - 2 do
        arrObj[i] := arrObj[i+1];
    setLength(arrObj, length(arrObj) - 1);
end;
function TArrayList.deleteAfter(prevNode: tobject): tobject;
var i, j: integer;
begin
    if (prevNode = nil) then exit(nil);
    if (length(arrObj) = 0) then  exit(nil);
    j := -1;
    for i := 0 to length(arrObj) - 2 do
        if (arrObj[i] = prevNode) then j := i+1;
    if (j = -1) then exit(nil);
    result := arrObj[j];
    for i := j to length(arrObj) - 2 do
        arrObj[i] := arrObj[i+1];
    setLength(arrObj, length(arrObj) - 1);
end;
procedure TArrayList.destroyList;
var i: integer;
begin
    for i := 0 to length(arrObj)-1 do
        arrObj[i].free;
    setLength(arrObj, 0);
end;

function TArrayList.first: tobject;
begin
    if (length(arrObj) = 0) then exit(nil);
    pos := 0;
    result := arrObj[pos];
end;
function TArrayList.next: tobject;
begin
    if (length(arrObj) = 0) then exit(nil);
    if (length(arrObj) - 1 = pos) then exit(nil);
    pos := pos + 1;
    result := arrObj[pos];
end;
function TArrayList.last: tobject;
begin
    if (length(arrObj) = 0) then exit(nil);
    pos := length(arrObj) - 1;
    result := arrObj[pos];
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

