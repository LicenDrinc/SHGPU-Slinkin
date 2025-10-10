{$R+}
program P2_2_1; uses sysutils;

type 
    TSingleSet=set of byte;
    TLongSet=array of TSingleSet;

function createSet(count:integer):TLongSet;
var l: TLongSet;
	i: integer;
begin
	i := (count + 255) div 256;
	setLength(l,i);
	createSet := l;
end;

procedure setSize(var dstSet:TLongSet; newCount:integer);
var i: integer;
begin
	i := (newCount + 255) div 256;
	setLength(dstSet,i);
end;

function getSize(bSet:TLongSet): integer;
begin
	getSize:=Length(bSet) * 256;
end;

procedure destroySet(var dstSet:TLongSet);
var l: TLongSet;
begin
	setLength(l,0);
	dstSet:=l;
end;

function inSet(bSet:TLongSet; e:integer):boolean;
var iCount: integer;
	i: integer;
	j: byte;
begin
	iCount := Length(bSet);
	
	i := e div 256;
	j := e - i * 256;
	
	if (iCount < i+1) then
	begin
		inSet:=false;
	end
	else
	begin
		inSet:=j in bSet[i];
	end;
end;

function sumSet(set1,set2:TLongSet):TLongSet; 
var iCount1, iCount2, iMax, flag : integer;
	l: TLongSet;
	i: integer;
begin
	flag := 0;
	
	iCount1 := Length(set1);
	iCount2 := Length(set2);
	
	if (iCount1 >= iCount2) then
	begin
		iMax := iCount1;
	end
	else
	begin
		iMax := iCount2;
	end;
	
	setLength(l,iMax);
	for i:=0 to iMax - 1 do
	begin
		l[i]:=[];
	end;
	for i:=0 to iCount1-1 do
	begin
		l[i]:=l[i]+set1[i];
	end;
	for i:=0 to iCount2-1 do
	begin
		l[i]:=l[i]+set2[i];
	end;
	
	for i := iMax - 1 downto 0 do
	begin
		if (l[i] <> []) then
		begin
			flag := 1;
			setSize(l, (i + 1) * 256);
			break
		end;
	end;
	
	if (flag = 0) then
	begin
		setSize(l, 0);
	end;
	sumSet:=l;
end;

function subSet(set1,set2:TLongSet):TLongSet; 
var iCount1, iCount2, iMax, flag : integer;
	l: TLongSet;
	i: integer;
begin
	flag := 0;
	
	iCount1 := Length(set1);
	iCount2 := Length(set2);
	
	if (iCount1 >= iCount2) then
	begin
		iMax := iCount1;
	end
	else
	begin
		iMax := iCount2;
	end;
	
	setLength(l,iMax);
	for i:=0 to iMax - 1 do
	begin
		l[i]:=[];
	end;
	for i:=0 to iCount1-1 do
	begin
		l[i]:=l[i]+set1[i];
	end;
	for i:=0 to iCount2-1 do
	begin
		l[i]:=l[i]-set2[i];
	end;
	
	for i := iMax - 1 downto 0 do
	begin
		if (l[i] <> []) then
		begin
			flag := 1;
			setSize(l, (i + 1) * 256);
			break
		end;
	end;
	
	if (flag = 0) then
	begin
		setSize(l, 0);
	end;
	subSet:=l;
end;

function mulSet(set1,set2:TLongSet):TLongSet; 
var iCount1, iCount2, iMax, flag : integer;
	l: TLongSet;
	i: integer;
begin
	flag := 0;
	
	iCount1 := Length(set1);
	iCount2 := Length(set2);
	
	if (iCount1 >= iCount2) then
	begin
		iMax := iCount1;
	end
	else
	begin
		iMax := iCount2;
	end;
	
	setLength(l,iMax);
	for i:=0 to iMax - 1 do
	begin
		l[i]:=[];
	end;
	for i:=0 to iCount1-1 do
	begin
		l[i]:=l[i]+set1[i];
	end;
	for i:=0 to iCount2-1 do
	begin
		l[i]:=l[i]*set2[i];
	end;
	for i:=iCount2 to iCount1 - 1 do
	begin
		l[i]:=[];
	end;
	
	for i := iMax - 1 downto 0 do
	begin
		if (l[i] <> []) then
		begin
			flag := 1;
			setSize(l, (i + 1) * 256);
			break
		end;
	end;
	
	if (flag = 0) then
	begin
		setSize(l, 0);
	end;
	mulSet:=l;
end;

procedure includeSet(var dstSet:TLongSet; e:integer);
var iCount: integer;
	i: integer;
	j: byte;
begin
	iCount := Length(dstSet);
	
	i := e div 256;
	j := e - i * 256;
	
	if (iCount < i+1) then
	begin
		setLength(dstSet,i+1);
	end;
	
	dstSet[i]:=dstSet[i] + [j];
end;

procedure excludeSet(var dstSet:TLongSet; e:integer);
var iCount: integer;
	i: integer;
	j: byte;
begin
	iCount := Length(dstSet);
	
	i := e div 256;
	j := e - i * 256;
	
	if (iCount < i+1) then
	begin
		exit;
	end;
	
	dstSet[i]:=dstSet[i] - [j];
end;

procedure writeSet(var bSet:TLongSet);
var i, k, j: integer;
begin
	for i:=0 to Length(bSet)-1 do
	begin
		for j:=0 to 255 do
		begin
			if (j in bSet[i]) then
			begin
				k:= i*256 + j;
				write(k,' ');
			end;
		end;
	end;
	writeln;
end;

var l1, l2, l3: TLongSet;

begin
	l1 := createSet(1000);
	l2 := createSet(1000);
	
	writeln('l1: ',getSize(l1));
	writeln('l2: ',getSize(l2));
	writeln;
	
	includeSet(l1,5000);
	includeSet(l1,255);
	includeSet(l1,256);
	includeSet(l1,0);
	
	includeSet(l2,70);
	includeSet(l2,300);
	includeSet(l2,255);
	includeSet(l2,0);
	includeSet(l2,5000);
	includeSet(l2,6000);
	
	writeln('l1: ',getSize(l1));
	writeln('l2: ',getSize(l2));
	writeln;
	
	writeln('l1');
	writeSet(l1);
	writeln;
	
	writeln('l2');
	writeSet(l2);
	writeln;
	
	writeln('255 в l1: ',inSet(l1,255));
	writeln('300 в l1: ',inSet(l1,300));
	writeln('1000 в l1: ',inSet(l1,1000));
	writeln('1025 в l1: ',inSet(l1,1025));
	writeln('2500 в l1: ',inSet(l1,2500));
	writeln('2500 в l1: ',inSet(l1,5000));
	writeln;
	
	l3 := sumSet(l1,l2);
	writeln('l1 + l2');
	writeln(getSize(l3));
	writeSet(l3);
	writeln;
	
	l3 := sumSet(l2,l1);
	writeln('l2 + l1');
	writeln(getSize(l3));
	writeSet(l3);
	writeln;
	
	l3 := subSet(l1,l2);
	writeln('l1 - l2');
	writeln(getSize(l3));
	writeSet(l3);
	writeln;
	
	l3 := subSet(l2,l1);
	writeln('l2 - l1');
	writeln(getSize(l3));
	writeSet(l3);
	writeln;
	
	l3 := mulSet(l1,l2);
	writeln('l1 * l2');
	writeln(getSize(l3));
	writeSet(l3);
	writeln;
	
	l3 := mulSet(l2,l1);
	writeln('l2 * l1');
	writeln(getSize(l3));
	writeSet(l3);
	writeln;
	
	setSize(l1,2555);
	writeln('l1: ',getSize(l1));
	writeSet(l1);
	writeln;
	
	setSize(l1,300);
	writeln('l1: ',getSize(l1));
	writeSet(l1);
	writeln;
	
	excludeSet(l1,0);
	writeln('l1: ',getSize(l1));
	writeSet(l1);
	writeln;
	
	destroySet(l1);
	destroySet(l2);
	destroySet(l3);
end.
