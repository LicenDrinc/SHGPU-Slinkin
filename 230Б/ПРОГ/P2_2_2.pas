uses sysutils;

type 
    TLongSet=bitpacked array[0..high(longint)] of boolean;
    PLongSet=^TLongSet;

procedure writeBitSet(var bSet:PLongSet);
var i : integer;
begin
	for i:=0 to MemSize(bSet) * 8 - 1 do
	begin
		write(integer(bSet[0][i]),'');
	end;
	writeln;
end;

procedure writeSet(var bSet:PLongSet);
var i : integer;
begin
	for i:=0 to MemSize(bSet) * 8 - 1 do
	begin
		if (bSet[0][i]) then
		begin
			write(i,' ');
		end;
	end;
	writeln;
end;

function createSet(count:integer):PLongSet;
var i: integer;
begin
	i := (count + 7) div 8;
	createSet := AllocMem(i);
end;

procedure setSize(var dstSet:PLongSet; newCount:integer);
var i, iOld, j: integer;
begin
	i := (newCount + 7) div 8;
	iOld := MemSize(dstSet);
	dstSet := ReAllocMem(dstSet,i);
	if (i - iOld > 0) then
	begin
		for j := iOld * 8 to i * 8 - 1 do
		begin
			dstSet[0][j] := false;
		end;
	end;
end;

function getSize(bSet:PLongSet): integer;
begin
	getSize := MemSize(bSet) * 8;
end;

procedure destroySet(var dstSet:PLongSet);
begin
	FreeMem(dstSet);
end;

function inSet(PSet:PLongSet; e:integer):boolean;
begin
	if (getSize(PSet) - 1 >= e) then
	begin
		inSet := PSet[0][e];
	end
	else
	begin
		inSet := false;
	end;
end;

function sumSet(set1,set2:PLongSet):PLongSet;
var i1, i2, iMax, j, j1, flag : integer;
label endFor;
begin
	flag := 0;
	
	i1 := getSize(set1);
	i2 := getSize(set2);
	
	if (i1 >= i2) then
	begin
		iMax := i1;
	end
	else
	begin
		iMax := i2;
	end;
	
	sumSet := createSet(iMax);
	
	for j := 0 to i1 - 1 do
	begin
		sumSet[0][j] := set1[0][j];
	end;
	for j := 0 to i2 - 1 do
	begin
		sumSet[0][j] := sumSet[0][j] or set2[0][j];
	end;
	
	for j := iMax div 8 - 1 downto 0 do
	begin
		for j1:= 0 to 7 do
		begin
			if (sumSet[0][j * 8 + j1]) then
			begin
				flag := 1;
				setSize(sumSet, j * 8 + j1 + 1);
				goto endFor;
			end;
		end;
	end;
	
	endFor:
	
	if (flag = 0) then
	begin
		setSize(sumSet, 0);
	end;
end;

function subSet(set1,set2:PLongSet):PLongSet;
var i1, i2, iMax, j, j1, flag : integer;
label endFor;
begin
	flag := 0;
	
	i1 := getSize(set1);
	i2 := getSize(set2);
	
	if (i1 >= i2) then
	begin
		iMax := i1;
	end
	else
	begin
		iMax := i2;
	end;
	
	subSet := createSet(iMax);
	
	for j := 0 to i1 - 1 do
	begin
		subSet[0][j] := set1[0][j];
	end;
	for j := 0 to i2 - 1 do
	begin
		if (set2[0][j]) then
		begin
			subSet[0][j] := false;
		end;
	end;
	
	for j := iMax div 8 - 1 downto 0 do
	begin
		for j1:= 0 to 7 do
		begin
			if (subSet[0][j * 8 + j1]) then
			begin
				flag := 1;
				setSize(subSet, j * 8 + j1 + 1);
				goto endFor;
			end;
		end;
	end;
	
	endFor:
	
	if (flag = 0) then
	begin
		setSize(subSet, 0);
	end;
end;

function mulSet(set1,set2:PLongSet):PLongSet;
var i1, i2, iMax, j, j1, flag : integer;
label endFor;
begin
	flag := 0;
	
	i1 := getSize(set1);
	i2 := getSize(set2);
	
	if (i1 >= i2) then
	begin
		iMax := i1;
	end
	else
	begin
		iMax := i2;
	end;
	
	mulSet := createSet(iMax);
	
	for j := 0 to i1 - 1 do
	begin
		mulSet[0][j] := set1[0][j];
	end;
	for j := 0 to i2 - 1 do
	begin
		mulSet[0][j] := mulSet[0][j] and set2[0][j];
	end;
	
	if (i1 > i2) then
	begin
		for j := i2 - 1 to i1 - 1 do
		begin
			mulSet[0][j] := false;
		end;
	end
	else if (i1 < i2) then
	begin
		for j := i1 - 1 to i2 - 1 do
		begin
			mulSet[0][j] := false;
		end;
	end;
	
	for j := iMax div 8 - 1 downto 0 do
	begin
		for j1:= 0 to 7 do
		begin
			if (mulSet[0][j * 8 + j1]) then
			begin
				flag := 1;
				setSize(mulSet, j * 8 + j1 + 1);
				writeln('--------',j * 8 + j1 + 1);
				goto endFor;
			end;
		end;
	end;
	
	endFor:
	
	if (flag = 0) then
	begin
		setSize(mulSet, 0);
	end;
end;

procedure includeSet(var dstSet:PLongSet; e:integer);
begin
	if (getSize(dstSet) - 1 >= e) then
	begin
		dstSet[0][e] := true;
	end
	else
	begin
		setSize(dstSet,e+1);
		dstSet[0][e] := true;
	end;
end;

procedure excludeSet(var dstSet:PLongSet; e:integer);
begin
	if (getSize(dstSet) - 1 >= e) then
	begin
		dstSet[0][e] := false;
	end;
end;

var l1, l2, l3 : PLongSet;

begin
	l1 := createSet(1000);
	l2 := createSet(1000);
	
	writeln('l1: ',getSize(l1));
	writeln('l2: ',getSize(l2));
	writeln;
	
	//includeSet(l1,5000);
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
	destroySet(l3);
	
	l3 := sumSet(l2,l1);
	writeln('l2 + l1');
	writeln(getSize(l3));
	writeSet(l3);
	writeln;
	destroySet(l3);
	
	l3 := subSet(l1,l2);
	writeln('l1 - l2');
	writeln(getSize(l3));
	writeSet(l3);
	writeln;
	destroySet(l3);
	
	l3 := subSet(l2,l1);
	writeln('l2 - l1');
	writeln(getSize(l3));
	writeSet(l3);
	writeln;
	destroySet(l3);
	
	l3 := mulSet(l1,l2);
	writeln('l1 * l2');
	writeln(getSize(l3));
	writeSet(l3);
	writeln;
	
	destroySet(l3);
	
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
