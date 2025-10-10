program P1_6_1;
var i,j,n,l,h:LongInt;
	m:array [1..5,1..7] of LongInt;
	m1:array [1..10,1..7] of LongInt;
	m2:array [1..7,1..6] of LongInt;
begin
	l:=10000;
	h:=0;
	randomize;
	n:=0;
	for i:=1 to 5 do
	begin
		for j:=1 to 7 do
		begin
			m[i,j]:=random(11)-5;
			if m[i,j]=0 then n:=n+1;
			if m[i,j]>=0 then write('+',m[i,j],' ')
			else write(m[i,j],' ')
		end;
		writeln;
	end;
	writeln(n);
	writeln;
	for i:=1 to 10 do
	begin
		for j:=1 to 7 do
		begin
			m1[i,j]:=random(76)-35;
			if (m1[i,j]>=0) and (m1[i,j]<10) then write('+',m1[i,j],'  ')
			else if m1[i,j]>=10 then write('+',m1[i,j],' ')
			else if m1[i,j]>-10 then write(m1[i,j],'  ')
			else write(m1[i,j],' ');
			if m1[i,j]<l then l:=m1[i,j];
		end;
		writeln;
	end;
	
	writeln;
	writeln;
	for i:=1 to 10 do
	begin
		for j:=1 to 7 do
		begin
			m1[i,j]:=m[i,j]+l;
			if (m1[i,j]>=0) and (m1[i,j]<10) then write('+',m1[i,j],'  ')
			else if m1[i,j]>=10 then write('+',m1[i,j],' ')
			else if m1[i,j]>-10 then write(m1[i,j],'  ')
			else write(m1[i,j],' ')
		end;
		writeln;
	end;
	
	writeln;
	writeln;
	
	for i:=1 to 7 do
	begin
		for j:=1 to 6 do
		begin
			m2[i,j]:=random(19)+4;
			if j mod 2 = 1 then h:=h+m2[i,j];
			if m2[i,j]>=10 then write(m2[i,j],' ')
			else write(m2[i,j],'  ')
		end;
		writeln;
	end;
	writeln(h);
end.
