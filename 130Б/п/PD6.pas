program P1_7_1;
uses sysutils;
var s:string [100];
	i:DWord;
	s1:string;
	s2:char;
begin
	readln(s);
	readln(s2);
	s1:='';
	for i:=length(s) downto pos(s2,s)+1 do
	begin
		s1:=s1+s[i];
	end;
	delete(s,pos(s2,s)+1,length(s));
	s:=s+s1;
	writeln(s);
end.
