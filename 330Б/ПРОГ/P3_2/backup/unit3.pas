unit Unit3;

{$mode ObjFPC}{$H+}

interface

uses Classes, SysUtils, Unit1;

type
    TArrayList = class(TInterfacedObject, IList)
        public
            function addFirst(note: tobject): tobject;
            function addLast(node: tobject): tobject;
            function deleteFirst: tobject;
            function deleteAfter(prevNode: tobject): tobject;
            function insertAfter(prevNode: tobject): tobject;
            function compare(node1, node2: tobject): integer;
            function first: tobject;
            function next: tobject;
            function last: tobject;
            procedure showNode(node: tobject);
            function copyNode(node: tobject): tobject;
            procedure destroyList;

            constructor Create;
            destructor Destroy;
        private
            arrObj: array of tobject;
    end;

implementation

constructor TArrayList.Create;
begin
    inherited Create;
    setLength(arrObj,0);
end;
destructor TArrayList.Destroy;
begin
    destroyList;
end;

function TArrayList.addFirst(note: tobject): tobject;
begin
    result := tobject(nil);
end;
function TArrayList.addLast(node: tobject): tobject;
begin
    result := tobject(nil);
end;

function TArrayList.deleteFirst: tobject;
begin
    result := tobject(nil);
end;
function TArrayList.deleteAfter(prevNode: tobject): tobject;
begin
    result := tobject(nil);
end;
function TArrayList.insertAfter(prevNode: tobject): tobject;
begin
    result := tobject(nil);
end;
procedure TArrayList.destroyList;
begin

end;

function TArrayList.first: tobject;
begin
    result := tobject(nil);
end;
function TArrayList.next: tobject;
begin
    result := tobject(nil);
end;
function TArrayList.last: tobject;
begin
    result := tobject(nil);
end;

procedure TArrayList.showNode(node: tobject);
begin

end;

function TArrayList.copyNode(node: tobject): tobject;
begin
    result := tobject(nil);
end;
function TArrayList.compare(node1, node2: tobject): integer;
begin
    result := 0;
end;

end.

