program P1_9_1;
uses sysutils;
var f1: file of char;
	f5: file;
	f2, f3, f4: text;
	s11, s21, s22, s23: string;
	s12: char;
	h: Boolean;
	i, j: DWord;
begin
	write('open: ');
	readln(s21);
	assign(f1, s21);
	rewrite(f1);
	h := True;
	while h do
	begin
		readln(s11);
		for i := 1 to length(s11) do
			if (s11[i] = '5') and h then h := False
			else write(f1, s11[i]);
	end;
	close(f1);
	writeln;writeln;writeln;
	
	
	write('open: ');readln(s23);
	write('copy to: ');readln(s22);
	assign(f2, s23);assign(f3, s22);
	reset(f2);rewrite(f3);
	j := 0;
	if s21 = s22 then writeln('No')
	else
	begin
		while not Eof(f2) do
		begin
			j := j + 1;
			readln(f2 ,s11);
			writeln(s11);
			writeln(f3, s11);
		end;
		writeln;
		writeln('lines: ',j);
	end;
	close(f2);
	close(f3);
	writeln;writeln;writeln;
	
	
	write('open: ');readln(s23);
	write('copy to: ');readln(s22);
	assign(f5, s23);assign(f4, s22);
	reset(f5,sizeof(char));
	rewrite(f4);
	j := 0;
	if s21 = s22 then writeln('No')
	else
	begin
		while not Eof(f5) do
		begin
			j := j + 1;
			blockread(f5, s12, sizeof(char));
			write(f4, s12);
		end;
		writeln;
		writeln(j);
	end;
	close(f5);
	close(f4);
end.
