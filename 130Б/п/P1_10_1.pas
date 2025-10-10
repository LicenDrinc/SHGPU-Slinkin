program P1_10_1;uses sysutils;
type
chell = record
	n, l: string;
	g, d, m, y: DWord;
end;
sport = record
	n: string;
	m, a1, a2, a3: DWord;
end;
var c: array[1..10000] of chell;
	s: array[1..10000] of sport;
	y1, i, n1, mol, min1, min2 ,min3, mw, ggg, z, n2, m1: DWord;
begin
	min1:=300000;
	min2:=300000;
	min3:=300000;
	mw:=0;
	write('n: ');readln(n1);writeln;
	for i:=1 to n1 do
		with c[i] do
		begin
			write('name: ');readln(n);write('man=1 woman=0 ');readln(g);
			write('day: ');readln(d);write('monday: ');readln(m);
			write('year: ');readln(y);
			write('Place of Birth: ');readln(l);writeln;
			if g = 1 then mw:=mw+1;
			if min1>y then begin min1 := y; min2 := m; min3 := d; end;
			if (min1=y) and (min2>m) then begin min2 := m; min3 := d end;
			if (min1=y) and (min2=m) and (min3>d) then min3 := d;
		end;
	
	for i:=1 to n1 do
		with c[i] do
			if (min1=y) and (min2=m) and (min3=d) then mol:=i;
	
	writeln('mol: ',c[mol].n,' ',c[mol].g,' ',c[mol].d,'.',c[mol].m,'.',c[mol].y,' ',c[mol].l);
	writeln;
	writeln('man: ',mw,' woman: ',(n1-mw));
	writeln;
	
	for y1:=0 to 300000 do
	begin
		ggg:=0;
		for i:=1 to n1 do
			with c[i] do
				if y1=y then ggg:=ggg+1;
		if ggg>1 then
		begin
			writeln(y1,' ',ggg);
			for i:=1 to n1 do
				with c[i] do
					if y1=y then writeln(n,' ',l);
		end;
	end;
	
	
	z:=0;m1:=10000000;
	write('n: ');readln(n1);writeln;
	for i:=1 to n1 do
		with s[i] do
		begin
			write('name: ');readln(n);write('m: ');readln(m);
			write('N1: ');readln(a1);write('N2: ');readln(a2);
			write('N3: ');readln(a3);
			if (z<a1+a2+a3) or ((z=a1+a2+a3) and (m1>m)) then
			begin
				z:=a1+a2+a3;n2:=i;m1:=m;
			end;
		end;
		
	writeln;
	writeln(z,' ',s[n2].n,' ',s[n2].m,' ',s[n2].a1,' ',s[n2].a2,' ',s[n2].a3);
end.
