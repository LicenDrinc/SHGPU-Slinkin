program PD5;
var i,j,h,l,z,x:LongInt;
	m:array [1..5,1..5] of LongInt;
begin
	randomize;
	for i:=1 to 5 do
	begin
		for j:=1 to 5 do
		begin
			m[i,j]:=random(31)+5;
			if m[i,j]>=10 then write(m[i,j],' ')
			else write(m[i,j],'  ')
		end;
		writeln;
	end;
	writeln;
	h:=m[1,1]+m[2,2]+m[3,3]+m[4,4]+m[5,5];
	l:=m[1,5]+m[2,4]+m[3,3]+m[4,2]+m[5,1];
	if h>l then writeln(h,' = h > l = ',l)
	else writeln(l,' = l > h = ',h);
	writeln;
	writeln;
	x:=m[1,1];
	z:=m[1,5];
	m[1,1]:=z;
	m[1,5]:=x;
	x:=m[2,2];
	z:=m[2,4];
	m[2,2]:=z;
	m[2,4]:=x;
	x:=m[4,4];
	z:=m[4,2];
	m[4,4]:=z;
	m[4,2]:=x;
	x:=m[5,5];
	z:=m[5,1];
	m[5,5]:=z;
	m[5,1]:=x;
	for i:=1 to 5 do
	begin
		for j:=1 to 5 do
		begin
			if m[i,j]>=10 then write(m[i,j],' ')
			else write(m[i,j],'  ')
		end;
		writeln;
	end;
end.
