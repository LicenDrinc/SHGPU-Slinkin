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
	writeln('Good');
end;

function inSet(bSet:TLongSet; e:integer):boolean;
var iCount: integer;
	i: integer;
	j: byte;
begin
	iCount := Length(bSet);
	
	i := (e + 256) div 256;
	j := e + 256 - i * 256;
	
	if (iCount < i) then
	begin
		inSet:=false;
	end
	else
	begin
		inSet:=j in bSet[i-1];
	end;
end;

function sumSet(set1,set2:TLongSet):TLongSet; 
var iCount1, iCount2: integer;
	l: TLongSet;
	i: integer;
begin
	iCount1 := Length(set1);
	iCount2 := Length(set2);
	
	if (iCount1 >= iCount2) then
	begin
		setLength(l,iCount1);
		for i:=0 to iCount2-1 do
		begin
			l[i]:=set1[i]+set2[i];
		end;
		if (iCount1 <> iCount2) then
		begin
			for i:=iCount2 to iCount1-1 do
			begin
				l[i]:=l[i]+set1[i];
			end;
		end;
	end
	else
	begin
		setLength(l,iCount2);
		for i:=0 to iCount1-1 do
		begin
			l[i]:=set1[i]+set2[i];
		end;
		for i:=iCount1 to iCount2-1 do
		begin
			l[i]:=l[i]+set2[i];
		end;
	end;
	
	sumSet:=l;
end;

function subSet(set1,set2:TLongSet):TLongSet; 
var iCount1, iCount2: integer;
	l: TLongSet;
	i: integer;
begin
	iCount1 := Length(set1);
	iCount2 := Length(set2);
	
	if (iCount1 >= iCount2) then
	begin
		setLength(l,iCount1);
		for i:=0 to iCount2-1 do
		begin
			l[i]:=set1[i]-set2[i];
		end;
		if (iCount1 <> iCount2) then
		begin
			for i:=iCount2 to iCount1-1 do
			begin
				l[i]:=l[i]+set1[i];
			end;
		end;
	end
	else
	begin
		setLength(l,iCount2);
		for i:=0 to iCount1-1 do
		begin
			l[i]:=set2[i]-set1[i];
		end;
		for i:=iCount1 to iCount2-1 do
		begin
			l[i]:=l[i]+set2[i];
		end;
	end;
	
	subSet:=l;
end;

function mulSet(set1,set2:TLongSet):TLongSet; 
var iCount1, iCount2: integer;
	l: TLongSet;
	i: integer;
begin
	iCount1 := Length(set1);
	iCount2 := Length(set2);
	
	if (iCount1 >= iCount2) then
	begin
		setLength(l,iCount2);
		for i:=0 to iCount2-1 do
		begin
			l[i]:=set1[i]*set2[i];
		end;
	end
	else
	begin
		setLength(l,iCount1);
		for i:=0 to iCount1-1 do
		begin
			l[i]:=set2[i]*set1[i];
		end;
	end;
	
	mulSet:=l;
end;

procedure includeSet(var dstSet:TLongSet; e:integer);
var iCount: integer;
	i: integer;
	j: byte;
begin
	iCount := Length(dstSet);
	
	i := (e + 256) div 256;
	j := e + 256 - i * 256;
	
	if (iCount < i) then
	begin
		setLength(dstSet,i);
	end;
	
	dstSet[i - 1]:=dstSet[i - 1] + [j];
end;

procedure excludeSet(var dstSet:TLongSet; e:integer);
var iCount: integer;
	i: integer;
	j: byte;
begin
	iCount := Length(dstSet);
	
	i := (e + 256) div 256;
	j := e + 256 - i * 256;
	
	if (iCount < i) then
	begin
		exit;
	end;
	
	dstSet[i - 1]:=dstSet[i - 1] - [j];
end;

procedure writeSet(var bSet:TLongSet);
var i, i1, k1: integer;
	j, j1, j3: integer;
begin
	i:= Length(bSet);
	j:= 0;
	if (i<>0) then
	begin
		for j3:=255 downto 0 do
		begin
			if (j3 in bSet[i - 1]) then
			begin
				j := j3;
				break;
			end;
		end;
	end;
	
	for i1:=0 to i-1 do
	begin
		if (i1=i-1) then
		begin
			for j1:=0 to j do
			begin
				if (j1 in bSet[i1]) then
				begin
					k1:= i1*256 + j1;
					if (k1 < 1000) then
					begin
						write('0');
					end;
					if (k1 < 100) then
					begin
						write('0');
					end;
					if (k1 < 10) then
					begin
						write('0');
					end;
					write(k1,' ');
				end;
			end;
			writeln;
		end
		else
		begin
			for j1:=0 to 255 do
			begin
				if (j1 in bSet[i1]) then
				begin
					k1:= i1*256 + j1;
					if (k1 < 1000) then
					begin
						write('0');
					end;
					if (k1 < 100) then
					begin
						write('0');
					end;
					if (k1 < 10) then
					begin
						write('0');
					end;
					write(k1,' ');
				end;
			end;
			writeln;
		end;
	end;
end;

var l1, l2, lPlus, lMinus, lMultiply: TLongSet;
	k, k1, k2: integer;

begin
	while true do
	begin
		writeln('---');
		readln(k1);
		readln(k2);
		writeln('---');
		if (k1 = 0) then
		begin
			readln(k);
			if (k2 = 1) then
			begin
				l1:=createSet(k);
			end
			else if (k2 = 2) then
			begin
				l2:=createSet(k);
			end;
			writeln;
		end
		else if (k1 = 1) then
		begin
			
			if (k2 = 1) then
			begin
				writeSet(l1);
			end
			else if (k2 = 2) then
			begin
				writeSet(l2);
			end
			else if (k2 = 3) then
			begin
				writeSet(lPlus);
			end
			else if (k2 = 4) then
			begin
				writeSet(lMinus);
			end
			else if (k2 = 5) then
			begin
				writeSet(lMultiply);
			end;
			writeln;
		end
		else if (k1 = 2) then
		begin 
			
			if (k2 = 1) then
			begin
				writeln(getSize(l1));
			end
			else if (k2 = 2) then
			begin
				writeln(getSize(l2));
			end
			else if (k2 = 3) then
			begin
				writeln(getSize(lPlus));
			end
			else if (k2 = 4) then
			begin
				writeln(getSize(lMinus));
			end
			else if (k2 = 5) then
			begin
				writeln(getSize(lMultiply));
			end;
			writeln;
		end
		else if (k1 = 3) then
		begin 
			readln(k);
			if (k2 = 1) then
			begin
				setSize(l1,k);
			end
			else if (k2 = 2) then
			begin
				setSize(l2,k);
			end
			else if (k2 = 3) then
			begin
				setSize(lPlus,k);
			end
			else if (k2 = 4) then
			begin
				setSize(lMinus,k);
			end
			else if (k2 = 5) then
			begin
				setSize(lMultiply,k);
			end;
			writeln;
		end
		else if (k1 = 4) then
		begin
			readln(k);
			if (k2 = 1) then
			begin
				writeln(inSet(l1,k));
			end
			else if (k2 = 2) then
			begin
				writeln(inSet(l2,k));
			end
			else if (k2 = 3) then
			begin
				writeln(inSet(lPlus,k));
			end
			else if (k2 = 4) then
			begin
				writeln(inSet(lMinus,k));
			end
			else if (k2 = 5) then
			begin
				writeln(inSet(lMultiply,k));
			end;
			writeln;
		end
		else if (k1 = 5) then
		begin
			
			if (k2 = 1) then
			begin
				destroySet(l1);
			end
			else if (k2 = 2) then
			begin
				destroySet(l2);
			end
			else if (k2 = 3) then
			begin
				destroySet(lPlus);
			end
			else if (k2 = 4) then
			begin
				destroySet(lMinus);
			end
			else if (k2 = 5) then
			begin
				destroySet(lMultiply);
			end;
			writeln('----');
			writeln;
		end
		else if (k1 = 6) then
		begin
			
			if (k2 = 1) then
			begin
				l1:=sumSet(l1,l2);
			end
			else if (k2 = 2) then
			begin
				l2:=sumSet(l1,l2);
			end
			else if (k2 = 3) then
			begin
				lPlus:=sumSet(l1,l2);
			end;
			writeln;
		end
		else if (k1 = 7) then
		begin
			
			if (k2 = 1) then
			begin
				l1:=subSet(l1,l2);
			end
			else if (k2 = 2) then
			begin
				l2:=subSet(l1,l2);
			end
			else if (k2 = 3) then
			begin
				lMinus:=subSet(l1,l2);
			end;
			writeln;
		end
		else if (k1 = 8) then
		begin
			
			if (k2 = 1) then
			begin
				l1:=mulSet(l1,l2);
			end
			else if (k2 = 2) then
			begin
				l2:=mulSet(l1,l2);
			end
			else if (k2 = 3) then
			begin
				lMultiply:=mulSet(l1,l2);
			end;
			writeln;
		end
		else if (k1 = 9) then
		begin
			readln(k);
			if (k2 = 1) then
			begin
				includeSet(l1,k);
			end
			else if (k2 = 2) then
			begin
				includeSet(l2,k);
			end;
			writeln;
		end
		else if (k1 = 10) then
		begin
			readln(k);
			if (k2 = 1) then
			begin
				excludeSet(l1,k);
			end
			else if (k2 = 2) then
			begin
				excludeSet(l2,k);
			end;
			writeln;
		end
		else
		begin
			break;
		end;
	end;
end.
