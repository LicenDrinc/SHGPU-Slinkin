program P1_10_0;uses sysutils;
var i, n1, g1:DWord;
type
book = record
	n, a: string;
	z, z1: DWord;
	z3, z2: DWord;
	y: DWord;
end;
var b:array[1..100] of book;
begin
	randomize;
	writeln('n');readln(n1);writeln;
	writeln('g');readln(g1);writeln;
	for i:=1 to n1 do
	begin
		with b[i] do
		begin
			writeln(i);writeln;
			readln(n);readln(a);readln(y);writeln;
			z:=random(99)+100;z1:=random(999)+1000;z2:=random(9999)+10000;z3:=random(99999)+100000;
		end;
	end;
	for i:=1 to n1 do
		if b[i].y=g1 then writeln('>> ',b[i].n,' <<');
end.
