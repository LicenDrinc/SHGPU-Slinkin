unit Unit1;

{$mode ObjFPC}{$H+}

interface

uses Classes, SysUtils;

type
    IList = interface
        ['{2190A571-EDCA-4017-8D77-B2C693F84560}']
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
    end;

    TDataBase = class
        public
            function showData: Variant; virtual; abstract;
    end;

    generic TDataObj<T> = class(TDataBase)
        public
            data: T;
            function ShowData: Variant; override;
            constructor Create(i: T);
    end;

    TIntObj = specialize TDataObj<integer>;
    TRealObj = specialize TDataObj<real>;
    TStrObj = specialize TDataObj<string>;

implementation

function TDataObj.ShowData: Variant;
begin
  Result := data;
end;

constructor TDataObj.Create(i: T);
begin
    inherited Create; data := i;
end;

end.

