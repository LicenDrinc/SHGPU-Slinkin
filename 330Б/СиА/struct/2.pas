{$mode objfpc}
uses heaptrc;
Type 
	PNode=^TNode;
	TNode=record
		key:integer;
		pnext:PNode;
	end;

TListFunc=function(p:pnode):boolean;

procedure ActionList(ph:pnode; func:TListFunc);
begin
	while ph<>nil do begin
		if not func(ph) then exit;
		ph:=ph^.pnext;
	end;
end;

function CreateNode(key:integer):PNode;
 begin
	new(result);
	result^.key:=key;
	result^.pnext:=nil;
 end;

function AddFirstNode(var PH:pnode; p:pnode):PNode;
 begin
	P^.pnext:=pH;
	Ph:=P;
	result:=p;
 end;

function AddLastNode(var PH:pnode; p:pnode):PNode;
	var pq:pnode;
 begin
	if ph=nil then exit(addFirstNode(ph,p));
	pq:=ph;
	while pQ^.pnext<>nil do pQ:=pQ^.pnext;
	pq^.pnext:=p;
	result:=p;
 end;

function outNode(p:pnode):boolean;
begin
	writeln(p^.key);
	result:=true;
end;	

procedure OutList(ph:pnode);
begin
	ActionList(ph,@outNode);	
{
 	while ph<>nil do begin
		writeln(ph^.key);
		ph:=ph^.pnext;
	end;
}
end;

procedure destroyList(var PH:PNode);
	var pq,ptmp:pnode;
begin
	pQ:=PH;
	while pQ<>nil do begin
		pTMP:=pQ;
		pQ:=pQ^.pnext;
		dispose(pTMP);
	end;
	PH:=nil;
end;

function deleteFirstNode(var Ph:Pnode):PNode;
begin
	result:=PH;
	if ph=nil then exit;
	ph:=PH^.pnext;
	result^.pnext:=nil;
end;


function insertNode(PPrev:Pnode; P:PNode):PNode;
begin
	result:=p;
	if PPrev=nil then exit;
	p^.pnext:=pprev^.pnext;
	pprev^.pnext:=p;
end;
	
{
procedure destroyList(var PH:PNode);
begin
	if ph=nil then exit;
	destroyList(ph^.pnext);
	dispose(ph);
	ph:=nil;
end;
}

function deleteNode(PPrev:Pnode):PNode;
begin
	if PPrev=nil then exit(nil);
	result:=PPrev^.pnext;
	if result=nil then exit(nil);
	pprev^.pnext:=result^.pnext;
	result^.pnext:=nil;
end;

var sumvar:integer=0;
function sum(p:pnode):boolean;
begin
 result:=true;
 sumvar+=p^.key;
end; 

var PHead:PNode=nil; p:pnode;


BEGIN
//	Phead:=CreateNode(10);

//	P:=insertNode(phead,CreateNode(0));
//	if phead=nil then dispose(p);
	if phead<>nil then 
		insertNode(phead,CreateNode(0));

	addFirstNode(phead,CreateNode(10));
	insertNode(phead,CreateNode(100));


	addLastNode(phead,CreateNode(20));
	addLastNode(phead,CreateNode(30));
	addFirstNode(phead,CreateNode(1));

	insertNode(phead^.pnext,CreateNode(0));

	sumvar:=0;
	actionList(phead,@sum);
	writeln('Сумма: ',sumvar);


	outList(PHead);
	writeln('-----');
	dispose(deleteFirstNode(pHead));
	outList(PHead);
	writeln('-----');	

	writeln('-----');
	dispose(deleteFirstNode(pHead));
	outList(PHead);
	writeln('-----');	





	writeln('-----');
	dispose(deleteFirstNode(pHead));
	outList(PHead);
	writeln('-----');	

	writeln('--++---');
	dispose(deleteNode(PHead));
	outList(PHead);
	writeln('--++---');



	writeln('-----');
	dispose(deleteFirstNode(pHead));
	outList(PHead);
	writeln('-----');	

	writeln('-----');
	dispose(deleteFirstNode(pHead));
	outList(PHead);
	writeln('-----');	

	writeln('-----');
	dispose(deleteFirstNode(pHead));
	outList(PHead);
	writeln('-----');	

	writeln('-----');
	dispose(deleteFirstNode(pHead));
	outList(PHead);
	writeln('-----');

	destroyList(PHead);
END.
