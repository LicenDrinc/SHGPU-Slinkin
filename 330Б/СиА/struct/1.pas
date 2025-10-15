//uses heaptrc;
Type 
	PNode=^TNode;
	TNode=record
		key:integer;
		pnext:PNode;
	end;

var PHead:PNode=nil;
	PQ,pTMP:PNode;

BEGIN
	new(Phead);
	pHead^.key:=10;

	new(PQ);
	pQ^.key:=20;
	pQ^.pnext:=nil;

	pHead^.pnext:=pQ;

	new(PQ);
	pQ^.key:=30;
	pQ^.pnext:=nil;

	pHead^.pnext^.pnext:=pQ;

	new(PQ);
	pQ^.key:=1;
	pQ^.pnext:=nil;

	PQ^.pnext:=pHead;
	Phead:=PQ;

	pQ:=PHead;
	while pQ<>nil do begin
		writeln(pQ^.key);
		pQ:=pQ^.pnext;
	end;
	
//	writeln(pHead^.pnext^.pnext^.key);
			
	// ---------------
	pQ:=PHead;
	while pQ<>nil do begin
		pTMP:=pQ;
		pQ:=pQ^.pnext;
		dispose(pTMP);
	end;		
	
END.

