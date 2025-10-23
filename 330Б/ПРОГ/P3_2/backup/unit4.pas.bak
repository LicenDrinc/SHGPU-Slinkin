unit Unit4;

{$mode ObjFPC}{$H+}

interface

uses Classes, SysUtils, Unit2, Unit3;

generic procedure LM<T, T1>(LResult: T; L: T1);
generic procedure LCM<T, T1>(LResult: T; L: T1);
generic procedure LS<T, T1>(LResult: T; L: T1; ASC:boolean);

procedure ListMerge(LResult: TClassicList; L: TClassicList);
procedure ListMerge(LResult: TClassicList; L: TArrayList);
procedure ListMerge(LResult: TArrayList; L: TClassicList);
procedure ListMerge(LResult: TArrayList; L: TArrayList);

procedure ListChessMerge(LResult: TClassicList; L: TClassicList);
procedure ListChessMerge(LResult: TClassicList; L: TArrayList);
procedure ListChessMerge(LResult: TArrayList; L: TClassicList);
procedure ListChessMerge(LResult: TArrayList; L: TArrayList);

procedure ListSort(LResult: TClassicList; L: TClassicList; ASC: boolean);
procedure ListSort(LResult: TClassicList; L: TArrayList; ASC: boolean);
procedure ListSort(LResult: TArrayList; L: TClassicList; ASC: boolean);
procedure ListSort(LResult: TArrayList; L: TArrayList; ASC: boolean);

implementation

generic procedure LM<T, T1>(LResult: T; L: T1);
begin
    LResult.addLast(L.copyNode(L.first));
    while (LResult.addLast(L.copyNode(L.next)) <> nil) do;
end;
procedure ListMerge(LResult: TClassicList; L: TClassicList);
begin specialize LM<TClassicList, TClassicList>(LResult, L); end;
procedure ListMerge(LResult: TClassicList; L: TArrayList);
begin specialize LM<TClassicList, TArrayList>(LResult, L); end;
procedure ListMerge(LResult: TArrayList; L: TClassicList);
begin specialize LM<TArrayList, TClassicList>(LResult, L); end;
procedure ListMerge(LResult: TArrayList; L: TArrayList);
begin specialize LM<TArrayList, TArrayList>(LResult, L); end;

generic procedure LCM<T, T1>(LResult: T; L: T1);
var o, o1, o2: tobject;
begin
    o := LResult.first; o1 := L.first;
    while (o1 <> nil) do
    begin
        LResult.insertAfter(o, L.copyNode(o1));
        o2 := LResult.next; if (o2 <> nil) then o := o2;
        o2 := LResult.next; if (o2 <> nil) then o := o2;
        o1 := L.next;
    end;
end;
procedure ListChessMerge(LResult: TClassicList; L: TClassicList);
begin specialize LCM<TClassicList, TClassicList>(LResult, L); end;
procedure ListChessMerge(LResult: TClassicList; L: TArrayList);
begin specialize LCM<TClassicList, TArrayList>(LResult, L); end;
procedure ListChessMerge(LResult: TArrayList; L: TClassicList);
begin specialize LCM<TArrayList, TClassicList>(LResult, L); end;
procedure ListChessMerge(LResult: TArrayList; L: TArrayList);
begin specialize LCM<TArrayList, TArrayList>(LResult, L); end;

generic procedure LS<T, T1>(LResult: T; L: T1; ASC:boolean);
var b0: boolean;
    k: integer;
    o1, o2, o3: tobject;
begin
    LResult.addLast(L.deleteFirst);
    while (LResult.addLast(L.deleteFirst) <> nil) do;
    b0 := true;
    while b0 do
    begin
        b0 := false; o3 := LResult.first; o1 := nil;
        while (o3 <> nil) do
        begin
            o2 := o3; o3 := LResult.next;
            if (o3 = nil) then break;
            k := LResult.compare(o2, o3);
            if (k = -2) then exit;
            if ((k = 1) and asc) or ((k = -1) and (not asc)) then
            begin
                b0 := true;
                if (o1 = nil) then LResult.deleteFirst
                else LResult.deleteAfter(o1);
                LResult.insertAfter(o3, o2);
            end;
            o1 := o2;
        end;
    end;
end;
procedure ListSort(LResult:TClassicList; L:TClassicList; ASC:boolean);
begin specialize LS<TClassicList, TClassicList>(LResult, L, ASC); end;
procedure ListSort(LResult:TClassicList; L:TArrayList; ASC:boolean);
begin specialize LS<TClassicList, TArrayList>(LResult, L, ASC); end;
procedure ListSort(LResult:TArrayList; L:TClassicList; ASC:boolean);
begin specialize LS<TArrayList, TClassicList>(LResult, L, ASC); end;
procedure ListSort(LResult:TArrayList; L:TArrayList; ASC:boolean);
begin specialize LS<TArrayList, TArrayList>(LResult, L, ASC); end;

end.

