{$mode objfpc}
program P2_4;
uses sysutils, math, funcs, testFuncs;

var i1, i2, i3, i4, i5 : integer;
	j1, s1, s2, s3 : integer;
	j2, d : real;
	str : string;
begin
	writeln(validatedAll());
	writeln;
	
	if not(successFuncs) then
	begin
		exit;
	end;
	
	readln(i1); readln(i2);
	writeln;
	writeln(getMax(i1,i2));
	writeln;

	readln(i1); readln(i2); readln(i3);
	writeln;
	writeln(getMax(i1,i2,i3));
	writeln;

	readln(i1); readln(i2); readln(i3); readln(i4);
	writeln;
	writeln(getMax(i1,i2,i3,i4));
	writeln;

	readln(i1); readln(i2); readln(i3); readln(i4); readln(i5);
	writeln;
	writeln(getMax(i1,i2,i3,i4,i5));
	writeln;

	readln(d);
	getIntFrac(d, j1 ,j2);
	writeln(j1,' ',j2);
	writeln;

	readln(str);
	getStrChr(str, s1, s2, s3);
	writeln(s1,' ',s2,' ',s3);
	writeln;
end.
