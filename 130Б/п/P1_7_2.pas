program P1_7_1;
uses sysutils;
var s11,s12,s21,s22,s31,s32,s33,s34:string;
	i,j,n,M:DWord;
begin
	readln(s11);
	s12:='1234567890';
	n:=0;
	for i:=1 to length(s11) do
	begin
		for j:=1 to length(s12) do
			if s11[i]=s12[j] then n:=n+1
	end;
	writeln(n);
	writeln;
	
	
	readln(s21);
	s22:=',.;:?!';
	for i:=1 to length(s21)*2 do
	begin
		for j:=1 to length(s22) do
		begin
			if (s21[i]=s22[j]) and (s21[i+1]<>' ') then insert(' ',s21,i+1)
		end;
	end;
	writeln(s21);
	writeln;
	
	
	randomize;
	s32:='qwertyuiopasdfghjklzxcvbnm';
	s33:='QWERTYUIOPASDFGHJKLZXCVBNM';	
	readln(M);
	s31:=s33[random(25)+1];
	for i:=1 to M do
	begin
		s31:=s31+s32[random(25)+1];
	end;
	writeln(s31);
	writeln;
	s34:='';
	for i:=M+1 downto 1 do
	begin
		s34:=s34+s31[i];
	end;
	writeln(s34);
end.
