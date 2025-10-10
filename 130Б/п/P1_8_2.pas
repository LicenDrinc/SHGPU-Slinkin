program P1_8_2; uses sysutils;
var s11, s14: string;
	s12, s13, c: set of char;
	i, k, l, f1, f2, f3, f: DWord;
begin
	randomize;
	readln(s11);
	k:=0;l:=0;s13:=[];s14:='';
	s12:=['A','a','E','e','Y','y','U','u','I','i','O','o'];
	c:=['A'..'Z','a'..'z'];
	for i:=1 to length(s11) do
	begin
		if s11[i] in s12 then k:=k+1
		else if s11[i] in c then l:=l+1;
		if s11[i] in c then 
		begin
			if not(s11[i] in s13) then s14:=s14 + s11[i];
			s13:=[s11[i]]+s13;
		end;
	end;
	writeln;writeln;
	writeln(s14);writeln(k);writeln(l);
	writeln;writeln;
	
	f1:=random(5)+1;
	f2:=random(5)+1;
	f3:=random(5)+1;
	while f1 = f2 do f2:=random(5)+1;
	while (f1 = f3) or (f2 = f3) do f3:=random(5)+1;
	readln(f);
	if (f = f1) or (f = f2) or (f = f3) then writeln('Yes')
	else writeln('No');
	writeln(f1,' ', f2,' ', f3);
end.
