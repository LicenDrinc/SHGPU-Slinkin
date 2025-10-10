program P1_5_2;
var i,m,n1:DWord;
	n:array [1..10] of DWord;
begin
	m:=0;
	for i:=1 to 10 do
	begin
		readln(n[i]);
		if n[i]>m then
		begin
			m:=n[i];
			n1:=i;
		end;
	end;
	writeln;
	writeln(n1,' ',m);
end.
