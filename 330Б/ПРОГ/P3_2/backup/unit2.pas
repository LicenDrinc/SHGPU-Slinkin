unit Unit2;

{$mode ObjFPC}{$H+}

interface

uses Classes, SysUtils, Unit1;

type
    PNode = ^TNode;
    TNode = record
        data: TObject;
        next: PNode;
    end;

    TClassicList = class(TInterfacedObject, IList)
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
            obj, posObj: PNode;
    end;

implementation

constructor TClassicList.Create;
begin
    inherited Create;
    obj := nil; posObj := nil;
end;
destructor TClassicList.Destroy;
begin
    destroyList;
end;

function TClassicList.addFirst(note: tobject): tobject;
var pn: PNode;
begin
    if (note <> nil) then
        exit(note);
    new(pn);
    pn^.data := note;
    pn^.next := obj;
    obj := pn;
    result := note;
end;
function TClassicList.addLast(node: tobject): tobject;
var pn, pn1: PNode;
begin
    if (node <> nil) then
        exit(node);
    new(pn1);
    pn1^.data := node;
    pn1^.next := nil;
    if (obj = nil) then
        obj := pn1
    else
    begin
        pn := obj;
        while (pn^.next <> nil) do
            pn := pn^.next;
        pn^.next := pn1;
    end;
    result := node;
end;

function TClassicList.deleteFirst: tobject;
begin
    result := tobject(nil);
end;
function TClassicList.deleteAfter(prevNode: tobject): tobject;
begin
    result := tobject(nil);
end;
function TClassicList.insertAfter(prevNode: tobject): tobject;
begin
    result := tobject(nil);
end;
procedure TClassicList.destroyList;
begin

end;

function TClassicList.first: tobject;
begin
    result := tobject(nil);
end;
function TClassicList.next: tobject;
begin
    result := tobject(nil);
end;
function TClassicList.last: tobject;
begin
    result := tobject(nil);
end;

procedure TClassicList.showNode(node: tobject);
begin
    if node is TIntObj then writeln(TIntObj(node).data)
    else if node is TRealObj then writeln(TRealObj(node).data:0:6)
    else if node is TStrObj then writeln(TStrObj(node).data)
    else writeln('none type');
end;

function TClassicList.compare(node1, node2: tobject): integer;
begin
    result := 0;
end;
function TClassicList.copyNode(node: tobject): tobject;
begin
    result := tobject(nil);
end;


end.

