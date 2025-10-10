program PD7;
uses sysutils;
var f1: text;
	f2: file of real;
	f3: file of integer;
	f4: file of char;
	lol: array of DWord;
	i, n: DWord;
	neme, name: string;
begin
	randomize;
	readln(n);
	setlength(lol, n);
	readln(name);
	assign(f1, name);
	readln(neme);
	assign(f2, neme);
	readln(neme);
	assign(f3, neme);
	rewrite(f1);rewrite(f2);rewrite(f3);
	for i:=1 to n do
	begin
		lol[i]:=random(1000);
		writeln(lol[i]);
	end;
	for i:=1 to n do
	begin
		write(f2,lol[i]);
		write(f3,lol[i]);
		writeln(f1,lol[i]);
	end;
	
	close(f1);
	
	assign(f4, name);
	reset(f4);
	
	writeln;
	writeln('f1 text ',filesize(f4));
	writeln('f2 real ',filesize(f2));
	writeln('f3 integer ',filesize(f3));
	close(f2);close(f3);close(f4);
end.
