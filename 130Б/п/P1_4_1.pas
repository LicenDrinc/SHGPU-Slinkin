program P1_4_1;
var N,i,i2,i3:DWord;
	s,s1,i1,m,n1,n2:Int64;
begin
	s1:=-1;
	s:=0;
	write('Введите число ');
	readln(N);
	for i:=0 to N do
	begin
		writeln(i);
		s1:=s1+1;
		s:=s+s1;
	end;
	writeln('');
	writeln(s);
	
	i1:=0;
	m:=0;
	while i1<>3 do 
	begin
		write('Введите число ');
		readln(i1);
		if i1<>9 then m:=m+1;
	end;
	writeln(m);
	
	writeln('');
	n1:=1;
	n2:=1;
	writeln('  | 1| 2| 3| 4| 5| 6| 7| 8| 9|');
	for i2:=1 to 9 do 
	begin
		writeln('------------------------------');
		write(' ',n2,'|');
		for i3:=1 to 9 do 
		begin
			if (n2*n1)>=10 then write(n2*n1,'|') else write(' ',n2*n1,'|');
			n1:=n1+1;
		end;
		writeln('');
		n1:=1;
		n2:=n2+1;
	end;
end.
