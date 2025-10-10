program P1_7_1;
uses sysutils;
var i,n,s24:DWord;
	s1,s21,s22,s23,s31,s32,s33:string;
begin
	readln(s1);
	n:=0;
	for i:=1 to length(s1) do
	begin
		if (s1[i]='i') or (s1[i]='k') then n:=n+1;
	end;
	writeln(n);
	
	
	readln(s21);
	readln(s22);
	s23:=s21+s22;
	s24:=StrToDWord(s21)+StrToDWord(s22);
	writeln(s23,' ',s24);
	
	
	readln(s31);
	readln(s32);
	readln(s33);
	Insert(s33,s31,pos(s32,s31));
	delete(s31,pos(s32,s31),length(s32));
	writeln(s31);
end.
